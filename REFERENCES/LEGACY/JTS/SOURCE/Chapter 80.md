# ARCHITECTURE
# Chapter 80
# SQLite Database Architecture, Schema v1.1, Repository Layer, Transactions, Migration, Audit, Backup & Recovery

Document ID

ARCH-080

Version

0.1

Status

FROZEN

Related EDR

EDR-085

Depends On

ARCH-076 Calibration Architecture

ARCH-077 Method Engine Architecture

ARCH-078 Test Execution State Machine

ARCH-079 Data Acquisition Architecture

---

# Purpose

This chapter defines the SQLite database architecture for the Universal Testing Machine software.

The database shall provide persistent storage for

```text
Tests

Test Samples

Methods

Method Versions

Calibration

Sensors

Load Cells

Extensometers

Specimens

Customers

Projects

Results

Reports

Events

Audit Records

Users

Application Settings

Database Migrations
Core Database Principle

SQLite is the authoritative local persistence layer.

WPF / MVVM

↓

Application Services

↓

Repositories

↓

SQLite


The UI must never directly manipulate SQLite tables.

Database Technology

Target database

SQLite

Target application

VB.NET

WPF

.NET Framework 4.8

x86
Database File

Recommended database filename

UTM.db
Database Location

The database location shall be configurable.

Recommended default

<ApplicationData>\UniversalTestingMachine\UTM.db
Database Separation

Application configuration and Test measurement data should preferably be stored in the same logical database schema unless deployment requirements require separation.

Database Schema Version

Current schema

1.1
Schema Version Table
SchemaInfo

Recommended fields

SchemaVersion
ProductVersion
CreatedAtUtc
UpdatedAtUtc
Migration Principle

Database changes shall be implemented through versioned migrations.

Migration Example
1.0

↓

Migration 1.1

↓

1.1
No Manual Schema Changes

Production schema modifications must not rely on manually editing SQLite tables.

Migration History

Table

SchemaMigrations

Fields

MigrationId
Version
Name
AppliedAtUtc
Checksum
Migration Transaction

Every migration should execute inside a transaction where SQLite permits.

Migration Failure

If migration fails

ROLLBACK

and the database must remain at the previous valid schema version.

Startup Database Flow
Application Start

↓

Open Database

↓

Check Schema

↓

Run Required Migrations

↓

Validate Schema

↓

Enable Application
Database Validation

Startup validation should verify

Schema Version

Required Tables

Required Indexes

Foreign Keys

Database Integrity
SQLite PRAGMA

Recommended initialization includes

foreign_keys = ON
WAL

Write-Ahead Logging may be enabled for the deployment configuration.

Purpose

Concurrent Reads

Improved Read/Write Behavior

The final journal configuration must be validated on the target machine.

Synchronous Mode

Durability-sensitive Test data should use an appropriate SQLite synchronous setting.

The final production setting shall prioritize measurement integrity.

Connection Management

Database connections shall be managed by the data layer.

UI Connection

The WPF UI must not maintain an uncontrolled global SQLite connection.

Repository Connection

Repositories may obtain connections through a centralized DatabaseConnectionFactory.

Conceptual Interface
IDatabaseConnectionFactory
Responsibilities
CreateConnection()

ConfigureConnection()

ValidateConnection()

DisposeConnection()
Repository Pattern

The application shall use repositories or equivalent data-access services.

Examples
ITestRepository

ITestSampleRepository

IMethodRepository

ICalibrationRepository

ISensorRepository

ICustomerRepository

IReportRepository

IAuditRepository
Service vs Repository

Repository responsibilities

Persistence

Queries

Inserts

Updates

Deletes

Service responsibilities

Business Rules

Validation

Workflow

Coordination
Example
TestService

↓

ITestRepository

↓

SQLite
Unit of Work

A Unit of Work may be used for operations that modify multiple related records atomically.

Example

Creating a Test may require

Test

Method Snapshot

Calibration Snapshot

Acquisition Snapshot

Event

These should be committed atomically.

Transaction Example
BEGIN

Insert Test

Insert Method Snapshot

Insert Calibration Snapshot

Insert Acquisition Snapshot

Insert Event

COMMIT
Rollback

If any operation fails

ROLLBACK
Database Constraints

Database constraints should protect data integrity.

Primary Keys

Each major entity should have a unique primary key.

Recommended IDs

INTEGER PRIMARY KEY

or

TEXT GUID

depending on entity requirements.

Recommended Identity Strategy

Use stable GUID/Text IDs for major domain entities where distributed import/export may be required.

Examples

TestId

MethodId

CalibrationId

SensorId

ReportId
Integer IDs

High-volume sample rows may use integer primary keys for storage efficiency.

Sample Primary Key

Recommended

SampleId INTEGER PRIMARY KEY

with

(TestId, Sequence)

unique constraint.

Foreign Keys

Foreign keys shall be enabled.

Example
TestSamples.TestId

→

Tests.TestId
Referential Integrity

A Sample must not reference a non-existent Test.

Delete Rules

High-value historical data should generally use restricted deletion.

Test Deletion

Deleting a Test should normally require explicit administrative authorization.

Cascade Deletion

Cascade deletion of measurement samples must be used carefully.

Recommended Policy

Prefer

Soft Delete / Archive

for completed Tests.

Hard Delete

Hard deletion should be restricted to administrative maintenance or controlled data-retention workflows.

Audit Requirement

Any destructive operation must be audited.

Core Tables

Schema v1.1 shall contain at least the following logical tables.

SchemaInfo

SchemaMigrations

Users

Roles

UserRoles

Customers

Projects

Specimens

Methods

MethodVersions

MethodParameters

Sensors

LoadCells

Extensometers

CalibrationSessions

CalibrationPoints

Tests

TestMethodSnapshots

TestCalibrationSnapshots

TestAcquisitionSnapshots

TestSamples

TestEvents

TestResults

TestResultValues

Reports

AuditLogs

ApplicationSettings
Schema Diagram
Customers
   |
   v
Projects
   |
   v
Tests
 |  |  |  \
 |  |  |   \
 |  |  |    v
 |  |  |   TestEvents
 |  |  |
 |  |  v
 |  | TestResults
 |  |
 |  v
 | TestSamples
 |
 +--> MethodSnapshot
 |
 +--> CalibrationSnapshot
 |
 +--> AcquisitionSnapshot
Customers

Table

Customers

Purpose

Store customer information.

Customers Fields
CustomerId
CustomerCode
Name
CompanyName
Phone
Email
Address
Notes
IsActive
CreatedAtUtc
UpdatedAtUtc
Customer Code

CustomerCode should be unique when populated.

Projects

Table

Projects

Fields

ProjectId
ProjectCode
CustomerId
Name
Description
CreatedAtUtc
UpdatedAtUtc
IsActive
Project Relationship
Customer

1

↓

N

Projects
Specimens

Table

Specimens

Purpose

Store specimen definitions.

Specimen Fields
SpecimenId
SpecimenCode
Name
Material
Description
CreatedAtUtc
UpdatedAtUtc
Specimen Geometry

Geometry may be stored in normalized fields or JSON depending on complexity.

Geometry Fields

Possible fields

GeometryType
Diameter
Width
Height
OuterDiameter
Thickness
GaugeLength
InitialLength
CrossSectionArea
Geometry Snapshot

The Test must preserve the geometry actually used.

Methods

Table

Methods

A Method represents the logical testing procedure.

Method Fields
MethodId
MethodCode
Name
Standard
Description
Status
CurrentVersionId
CreatedAtUtc
UpdatedAtUtc
Method Version

Table

MethodVersions

Purpose

Immutable versions of a Method.

Method Version Fields
MethodVersionId
MethodId
VersionNumber
Standard
ControllerType
LoadCellId
ExtensometerId
SpeedMode
SpeedValue
ClutchMode
PreloadEnabled
CycleMode
CreatedAtUtc
CreatedBy
ApprovedAtUtc
ApprovedBy
Status
Method Immutability

Once a Method Version is used by a Test, it must never be modified.

Method Parameters

Table

MethodParameters

Possible fields

MethodParameterId
MethodVersionId
ParameterName
ParameterValue
ValueType
Unit
Why Parameter Table

Allows Method extensions without constantly changing the database schema.

Parameter Example
ParameterName = YieldOffset

ParameterValue = 0.2

Unit = %
Sensors

Table

Sensors

Fields

SensorId
SensorCode
Name
SensorType
SerialNumber
Unit
Capacity
Status
CreatedAtUtc
UpdatedAtUtc
Sensor Types

Examples

LoadCell

Extensometer

Encoder

Displacement

Temperature

Pressure
LoadCells

Table

LoadCells

Fields

LoadCellId
SensorId
Capacity
Unit
Manufacturer
Model
SerialNumber
ReferenceType
IsActive
Current Load Cells

The system supports

25 ton

10 ton

2 ton

500 kg

100 kg
Extensometers

Table

Extensometers

Fields

ExtensometerId
SensorId
GaugeLength
Travel
Resolution
Manufacturer
Model
SerialNumber
IsActive
Calibration Sessions

Table

CalibrationSessions

Purpose

Store calibration operations separately from Test execution.

Calibration Fields
CalibrationSessionId
SensorId
ReferenceSensorId
CalibrationDateUtc
OperatorId
Status
Notes
CreatedAtUtc
Calibration Points

Table

CalibrationPoints

Fields

CalibrationPointId
CalibrationSessionId
PointIndex
ReferenceValue
RawValue
CalculatedValue
Deviation
Calibration Separation

Calibration is not part of the Test execution lifecycle.

Calibration Snapshot

When a Test starts, the effective calibration must be copied into

TestCalibrationSnapshots
Test Table

Table

Tests

This is the central domain table.

Test Fields
TestId
AcceptanceNumber
CustomerId
ProjectId
SpecimenId
TestDateUtc
Name
Description
Status
CompletionReason
CreatedBy
CreatedAtUtc
StartedAtUtc
CompletedAtUtc
DeletedAtUtc
IsDeleted
Acceptance Number

AcceptanceNumber should be unique where required by the laboratory workflow.

Test Status

Possible persisted values

Created

Preparing

Ready

Preload

Running

Hold

Paused

Stopping

Complete

Fault

Aborted
Completion Reason

Examples

Normal

BreakDetected

OperatorStop

OperatorAbort

SafetyFault

ControllerFault

SensorFault

ApplicationCrash

Unknown
Test Method Snapshot

Table

TestMethodSnapshots

Purpose

Preserve the exact Method configuration used.

Fields
TestMethodSnapshotId
TestId
MethodId
MethodVersionId
SnapshotJson
CreatedAtUtc
Why Snapshot JSON

Complex Method configuration can be preserved exactly even if the normalized Method schema evolves.

Test Calibration Snapshot

Table

TestCalibrationSnapshots

Fields

TestCalibrationSnapshotId
TestId
SensorId
CalibrationSessionId
CalibrationVersion
SnapshotJson
CreatedAtUtc
Test Acquisition Snapshot

Table

TestAcquisitionSnapshots

Fields

TestAcquisitionSnapshotId
TestId
SampleRate
ChannelsJson
AdapterType
BufferSize
BatchSize
ProcessingPolicyJson
CreatedAtUtc
Test Samples

Table

TestSamples

This table can become the largest table in the database.

TestSamples Fields
SampleId
TestId
Sequence
TimestampUtc
ElapsedMilliseconds
ForceRaw
ExtensionRaw
DisplacementRaw
SpeedRaw
QualityFlags
Additional Values

Additional configurable channels may be stored separately.

Test Sample Channels

Optional table

TestSampleChannelValues

Fields

SampleChannelValueId
SampleId
ChannelId
RawValue
ProcessedValue
QualityFlags
Hybrid Sample Architecture

Recommended

TestSamples

+

TestSampleChannelValues
Core Fixed Columns

Use fixed columns for high-frequency core channels.

Additional Channels

Use the secondary table for configurable channels.

Test Events

Table

TestEvents

Fields

EventId
TestId
Sequence
TimestampUtc
State
EventType
Severity
Source
OperatorId
Message
PayloadJson
Event Sequence

Unique per Test.

Test Results

Table

TestResults

Fields

TestResultId
TestId
CalculationVersion
CalculatedAtUtc
Status
Result Values

Table

TestResultValues

Fields

TestResultValueId
TestResultId
ResultCode
ResultName
Value
Unit
DisplayValue
Quality
Result Examples
MaximumForce

YieldRp02

YoungsModulus

BreakForce

BreakStrain

UltimateTensileStrength

Elongation
Result Code

ResultCode should be stable.

Example

MAX_FORCE

YIELD_RP02

E_MODULUS

BREAK_FORCE
Reports

Table

Reports

Fields

ReportId
TestId
ReportType
TemplateVersion
FilePath
GeneratedAtUtc
GeneratedBy
Status
Report Integrity

Generated reports may store a checksum.

Report Checksum

Recommended

SHA-256
Audit Logs

Table

AuditLogs

Fields

AuditLogId
TimestampUtc
UserId
Action
EntityType
EntityId
OldValueJson
NewValueJson
Reason
Audit Scope

Audit at minimum

Method Changes

Calibration Changes

Test Deletion

Result Recalculation

Report Generation

Settings Changes

User Changes
Users

Table

Users

Fields

UserId
Username
DisplayName
PasswordHash
IsActive
CreatedAtUtc
LastLoginAtUtc
Password Storage

Passwords must never be stored as plaintext.

Roles

Table

Roles

Examples

Administrator

Engineer

Operator

Viewer
User Roles

Table

UserRoles

Fields

UserId
RoleId
Application Settings

Table

ApplicationSettings

Fields

SettingKey
SettingValue
ValueType
UpdatedAtUtc
UpdatedBy
Settings Examples
Language

Theme

DefaultUnit

DatabasePath

DefaultSampleRate

GraphRefreshRate

AutoBackupEnabled
Machine Configuration

Machine-specific configuration should be separated from Test data.

Machine Settings

Possible table

MachineSettings

Fields

MachineSettingId
Key
Value
Unit
UpdatedAtUtc
Unique Constraints

Recommended unique constraints

CustomerCode

ProjectCode

MethodCode

SensorCode

AcceptanceNumber

(TestId, Sequence)

(TestId, EventSequence)
Indexes

High-value indexes should include

Tests.AcceptanceNumber

Tests.CustomerId

Tests.ProjectId

Tests.TestDateUtc

TestSamples.TestId

TestSamples(TestId, Sequence)

TestEvents(TestId, Sequence)

TestResults.TestId

AuditLogs(EntityType, EntityId)

CalibrationSessions.SensorId
Sample Index Strategy

Do not create excessive indexes on TestSamples.

High-frequency data tables must prioritize write performance.

TestSamples Primary Access

Primary query

WHERE TestId = ?
ORDER BY Sequence

must be optimized.

Test Events Query

Primary query

WHERE TestId = ?
ORDER BY Sequence
Soft Delete

Tables containing historical business data may use

IsDeleted

DeletedAtUtc
Soft Delete Principle

Soft deletion preserves traceability.

Hard Delete

Hard deletion should require

Administrator

Reason

Audit Record
Backup

The application should provide database backup functionality.

Backup Types

Possible

Manual Backup

Automatic Backup

Pre-Migration Backup

Pre-Delete Backup
Backup Filename

Example

UTM_2026-08-02_083015.db
Backup Location

Configurable.

Prefer a location outside the primary database directory.

Backup Verification

A backup should be validated after creation.

Integrity Check

SQLite integrity checks should be available.

Conceptually

PRAGMA integrity_check;
Quick Check

A lightweight check may also be available where appropriate.

Restore

Restore must not silently overwrite the active database.

Restore Workflow
Select Backup

↓

Validate Backup

↓

Create Recovery Copy

↓

Stop Services

↓

Replace Database

↓

Validate Schema

↓

Restart
Restore Audit

Restore operations must be logged.

Database Corruption

If corruption is detected

Application

↓

Read-Only / Safe Mode

↓

Notify Operator

↓

Attempt Recovery Procedure

The application must not continue normal Test execution against an unverified database.

Database Failure During Active Test

If SQLite fails during an active Test, the Test Execution Engine must apply the policy defined in ARCH-079.

Preferred Safety

If data integrity cannot be guaranteed

Controlled Machine Stop

should be considered.

Database Recovery After Crash

SQLite transaction recovery should be allowed to complete before application schema validation.

Backup Before Migration

For major schema migrations

Backup

↓

Migration

↓

Validation
Migration Versioning

Migration files should be deterministic.

Example

001_InitialSchema.sql

002_AddCalibrationVersion.sql

003_AddTestAcquisitionSnapshot.sql
Migration Registry

The database records which migrations have already been applied.

No Duplicate Migration

An already-applied migration must not execute again.

Migration Checksum

The checksum detects unauthorized modification of migration definitions.

Repository Error Handling

Database exceptions must be translated into domain/data-layer errors.

Example
SQLiteException

↓

DatabaseWriteException

rather than exposing SQLite implementation details to ViewModels.

Repository Transactions

Repositories should expose transaction support through a Unit of Work or transaction abstraction.

Example
Using unit = database.BeginUnitOfWork()

    testRepository.Insert(test)
    eventRepository.Insert(event)

    unit.Commit()
Repository Rules

Repositories must not contain UI logic.

Repository Rules

Repositories must not contain WPF dependencies.

Repository Rules

Repositories must not control hardware.

Database Service Layer

Recommended

DatabaseService

ConnectionFactory

MigrationService

BackupService

IntegrityService
Architecture
+-----------------------+
| ViewModels            |
+-----------+-----------+
            |
            v
+-----------------------+
| Application Services  |
+-----------+-----------+
            |
            v
+-----------------------+
| Repositories          |
+-----------+-----------+
            |
            v
+-----------------------+
| SQLite Infrastructure |
+-----------------------+
Domain Separation

Domain models must not depend directly on SQLite classes.

SQLite Isolation

The following should remain inside Infrastructure

SQLiteConnection

SQLiteCommand

SQLiteDataReader

SQLiteTransaction
Domain Model

The domain model uses

Test

Method

Calibration

MeasurementSample

TestResult
Mapping

Database entities are mapped to domain models.

Example
SQLite Row

↓

TestRecord

↓

Test Domain Model
JSON Snapshot

JSON snapshots should contain schema/version metadata.

Example conceptual structure

{
    "schemaVersion": 1,
    "methodVersion": 7,
    "standard": "ISO 6892-1",
    "parameters": {}
}
Snapshot Immutability

Once a snapshot is stored for a Test it must not be modified.

Audit and Snapshot

Snapshot data provides reconstruction.

Audit data provides change history.

Both are required for strong traceability.

Test Identity

TestId must remain immutable for the lifetime of the Test.

Acceptance Number

Changing AcceptanceNumber after Test execution should be audited.

Customer Changes

Changing customer/project association after Test completion should be audited.

Test Metadata vs Measurement Data

Metadata may have controlled edits.

Measurement data is immutable after acquisition.

Result Recalculation

Recalculation creates a new TestResult record rather than overwriting the historical result.

Result Versioning

Example

Result Version 1

↓

Result Version 2

Both remain traceable.

Current Result

Tests may reference the current active result version.

Historical Results

Previous results remain preserved.

Report Versioning

Reports should identify

TemplateVersion

CalculationVersion

GeneratedAt
Database Performance

Performance requirements are especially important for

TestSamples

TestSampleChannelValues

TestEvents
High-Volume Table Rule

Do not store redundant text fields in every sample row.

Example

Avoid repeating

TestName

CustomerName

MethodName

in every TestSamples row.

TestId Reference

Use

TestId

instead.

Compression

SQLite database compression is not part of normal runtime acquisition.

Compression may be applied during archive/export.

Archive Package

Optional archive package may contain

Test Metadata

Database Extract

CSV

XML

PDF Report
Database Security

The SQLite file should be protected by filesystem permissions.

SQLite Encryption

If required by deployment/security requirements, an encryption-capable SQLite implementation may be considered.

The application architecture must isolate this behind the database infrastructure layer.

No Encryption Dependency in Domain

Domain and application services must not depend on a specific SQLite encryption implementation.

x86 Requirement

The selected SQLite provider must be compatible with

.NET Framework 4.8

x86
Provider Isolation

The SQLite provider must be isolated behind the infrastructure layer so it can be replaced without changing domain logic.

Database Testing

The database layer requires

Unit Tests

Integration Tests

Migration Tests

Performance Tests

Recovery Tests
Migration Test

Each migration must be tested from the previous schema version.

Recovery Test

Test scenarios should include

Application Crash

Database Lock

Write Failure

Disk Full

Corrupt Backup
Disk Full

Disk-full conditions must be detected.

Disk Full During Test

The application must not silently discard measurement data.

A controlled stop / fault policy must be invoked.

Database Size Monitoring

The application may monitor free disk space.

Low Disk Warning

A configurable warning threshold should be available.

Critical Disk Threshold

A critical threshold may trigger controlled Test termination if continued acquisition cannot be safely persisted.

Database Maintenance

Maintenance operations should not run while an active Test is controlling the machine unless explicitly designed for safe operation.

Vacuum

VACUUM should not be executed during an active Test.

Integrity Check

Integrity checks should preferably be performed when the machine is idle.

Backup During Test

Backup of an active database must use a safe SQLite-supported mechanism.

A raw file copy while writes are occurring must not be treated as universally safe.

Database Initialization

First application startup

Create Database

↓

Initialize Schema

↓

Insert SchemaInfo

↓

Insert Default Settings

↓

Create Default Roles
Default Roles

At minimum

Administrator

Operator

Viewer
Default User

If a default administrative user is created during installation, its credentials must be securely provisioned and must not use a universal hard-coded password.

Database Audit

Database infrastructure errors should be logged separately from Test Events where appropriate.

Application Log vs Test Event
Application Log

=

Software diagnostics
Test Event

=

Test execution traceability
Both Are Required

A database exception may belong to the Application Log and also create a Test Event if it affects an active Test.

Acceptance Criteria

ARCH-080 is accepted when

SQLite is the primary local persistence layer.

Schema version 1.1 is defined.

SchemaInfo exists.

SchemaMigrations exists.

Versioned migrations are supported.

Migration failures roll back.

Database schema is validated at startup.

Foreign keys are enabled.

WAL configuration is supported where deployed.

Connection management is centralized.

Repositories are used.

UI does not directly access SQLite.

Business services are separated from repositories.

Transactions are supported.

Unit of Work is supported where required.

Customers are stored.

Projects are stored.

Specimens are stored.

Methods are stored.

Method versions are immutable.

Method parameters are stored.

Sensors are stored.

Load cells are stored.

Extensometers are stored.

Calibration sessions are stored.

Calibration points are stored.

Tests are stored.

Method snapshots are stored.

Calibration snapshots are stored.

Acquisition snapshots are stored.

Test samples are stored.

Sample sequence is unique per Test.

Test events are stored.

Test results are versioned.

Result values are stored.

Reports are stored.

Audit logs are stored.

Users are stored.

Roles are stored.

User roles are stored.

Application settings are stored.

Important indexes are defined.

High-frequency tables avoid unnecessary indexes.

Soft deletion is supported where appropriate.

Hard deletion is restricted.

Destructive operations are audited.

Database backups are supported.

Backup validation is supported.

Restore is supported.

Integrity checking is supported.

Migration backup is supported.

Database corruption is detected.

Disk-full conditions are detected.

Database failure during active Test has a defined safety response.

Test snapshots are immutable.

Historical results are preserved.

Result recalculation is versioned.

Reports are traceable to calculation versions.

SQLite implementation is compatible with x86.

SQLite implementation is compatible with .NET Framework 4.8.

SQLite implementation is isolated from the domain layer.

Architectural Decision (FROZEN)

SQLite shall be the authoritative local persistence layer for the application.

Schema version 1.1 shall be managed exclusively through versioned migrations.

The UI shall never directly access SQLite.

All persistence shall pass through the Infrastructure / Repository layer.

High-frequency measurement storage shall be optimized for sequential writes and Test-based retrieval.

Method, Calibration, Acquisition and Processing snapshots shall be preserved with each Test.

Raw measurement data shall remain immutable.

Historical results shall not be overwritten by recalculation.

Destructive operations shall be permission-controlled and audited.

Database failures affecting an active physical Test shall be treated as execution/data-integrity events and shall follow the safety policy defined by the Test Execution Engine.

The database provider shall remain replaceable at the Infrastructure boundary.

The schema shall remain compatible with VB.NET, WPF, .NET Framework 4.8 and x86 deployment.

This decision is permanent.

Next Chapter

ARCH-081

Complete SQLite Schema SQL v1.1, CREATE TABLE Definitions, Foreign Keys, Indexes, Constraints, Triggers, Seed Data, Migration 001, Migration 002, Migration 003 & Database Initialization

This chapter will define

Exact SQL
PRAGMA Configuration
SchemaInfo
SchemaMigrations
Users
Roles
UserRoles
Customers
Projects
Specimens
Methods
MethodVersions
MethodParameters
Sensors
LoadCells
Extensometers
CalibrationSessions
CalibrationPoints
Tests
TestMethodSnapshots
TestCalibrationSnapshots
TestAcquisitionSnapshots
TestSamples
TestSampleChannelValues
TestEvents
TestResults
TestResultValues
Reports
AuditLogs
ApplicationSettings
MachineSettings
Indexes
Unique Constraints
Foreign Keys
Triggers
Seed Data
Migration Scripts
Integrity Checks