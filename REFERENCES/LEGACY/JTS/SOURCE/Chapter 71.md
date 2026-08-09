# ARCHITECTURE
# Chapter 71
# SQLite Database Architecture, Schema v1.1, Repository Layer & Data Persistence

Document ID

ARCH-071

Version

0.1

Status

FROZEN

Related EDR

EDR-076

Depends On

ARCH-053 Test Execution Architecture

ARCH-067 Engineering Data Model

ARCH-068 Method Engine

ARCH-069 Machine Controller

ARCH-070 WPF HMI

---

# Purpose

This chapter defines the persistent data architecture for the Universal Testing Machine application.

The database technology is permanently defined as

```text
SQLite

with a schema identified as

Schema v1.1

The database shall support the complete lifecycle of

Methods

Method Versions

Tests

Specimens

Materials

Measurements

Results

Reports

Calibration

Machine Configuration

Users

Audit Records
Core Principle

The database stores persistent engineering information.

It does not become the owner of real-time hardware communication or Test execution state.

The architecture is

WPF HMI
    |
    v
Application Services
    |
    v
Domain
    |
    v
Repositories
    |
    v
SQLite
Technology Constraint

The production application shall use

SQLite

VB.NET

WPF

.NET Framework 4.8

x86

Visual Studio 2019
C# Restriction

No C# production source code shall be introduced into the application.

Database Provider

The SQLite provider must be compatible with

.NET Framework 4.8

x86

The exact provider package shall be selected according to deployment compatibility and shall be fixed in the project dependency manifest.

Database File

The application shall use a dedicated SQLite database file.

Recommended conceptual name

UTM.db

The actual deployed filename may be configured.

Database Location

The database should not normally be stored inside the executable directory.

Recommended structure

Application
|
+-- Data
|   |
|   +-- UTM.db
|
+-- Logs
|
+-- Reports
|
+-- Exports
|
+-- Config
Separation of Data

The following categories shall remain conceptually separated.

Persistent Database

Configuration Files

Raw Test Data

Generated Reports

Application Logs
Database Responsibility

SQLite stores

Master Data

Configuration Snapshots

Test Metadata

Test Results

Method Definitions

Audit Information
Database Does Not Own

SQLite does not directly control

PLC

Drive

Motor

Real-Time Acquisition

JOG

Motion
SQLite Pragmas

The application should configure SQLite appropriately at connection initialization.

Recommended concepts

foreign_keys = ON

busy_timeout = configured value

Additional pragmas shall be validated against the deployed SQLite provider.

Foreign Keys

Foreign-key enforcement shall be enabled.

Transaction Principle

Operations that modify multiple related records shall use a transaction.

Example

Saving a completed Test may require

Test

+

Specimen

+

Result

+

Report Metadata

+

Audit Entry

These changes should be committed atomically where appropriate.

Atomicity

Either the complete logical operation succeeds or the transaction is rolled back.

Schema Version

The database must contain an explicit schema version.

Recommended table

SchemaInfo
SchemaInfo

Conceptual fields

SchemaVersion

CreatedAt

UpdatedAt
Current Schema
SchemaVersion = 1.1
Migration

Database upgrades shall use explicit migrations.

Migration Rule

The application must never silently alter production tables without a migration step.

Migration Sequence

Conceptually

Read Current Version

↓

Compare Target Version

↓

Apply Migration 1.x

↓

Validate

↓

Update Schema Version
Migration Transaction

Each migration should execute inside a transaction where SQLite permits the required operation safely.

Migration Failure

If a migration fails

Rollback

↓

Keep Previous Schema Version

↓

Report Database Error
Database Initialization

Startup sequence

Application Start

↓

Open Database

↓

Check Schema

↓

Run Required Migrations

↓

Validate Integrity

↓

Initialize Repositories
Database Integrity

The application may perform an integrity check during startup or maintenance operations.

Backup

The database must support controlled backup.

Backup Rule

Backup shall be performed before schema migration.

Backup Naming

Example

UTM_2026-08-08_103000.db
Backup During Running Test

Database backup shall not interfere with active Test acquisition.

The preferred backup policy is to avoid unsafe file-copy operations against an actively changing database.

Restore

Restore shall be an explicit administrative operation.

Restore Protection

The application should require confirmation before replacing the active database.

Database Layer

The application uses a repository abstraction.

ITestRepository

IMethodRepository

IMaterialRepository

ISpecimenRepository

IResultRepository

IReportRepository

ICalibrationRepository

IUserRepository

IAuditRepository
Repository Responsibility

A repository is responsible for persistent data access.

It should not contain

PLC Logic

Motion Logic

UI Logic

Graph Rendering
Service Responsibility

Application services orchestrate repositories.

Example

TestService

↓

TestRepository

SpecimenRepository

ResultRepository

AuditRepository
SQL Boundary

SQL statements shall remain inside the data-access layer.

No SQL in ViewModel

Incorrect

ViewModel

↓

SQLiteConnection

↓

SELECT ...

Correct

ViewModel

↓

TestService

↓

ITestRepository

↓

SQLite
Connection Management

Connections should be short-lived and scoped to operations.

Connection Sharing

A global long-lived SQLite connection should not be used as the general application pattern.

Connection Factory

Recommended abstraction

ISqliteConnectionFactory
Repository Unit of Work

For multi-repository transactions, a Unit of Work abstraction may be used.

Conceptually

IUnitOfWork

BeginTransaction()

Commit()

Rollback()
Schema v1.1 Tables

The baseline schema contains the following logical tables.

SchemaInfo

Users

AuditLog

Methods

MethodVersions

Materials

MachineConfigurations

ControllerMappings

LoadCells

Extensometers

CalibrationSessions

CalibrationPoints

Tests

TestSpecimens

Measurements

TestEvents

TestResults

ResultMetrics

Reports

ReportItems
Schema Design Principle

Master definitions and historical Test snapshots shall not be confused.

Historical Immutability

A completed Test must retain the configuration used when the Test was executed.

Changing a current Method must not modify historical Test results.

Method Versioning

This is achieved through Method Versions.

Users Table

Conceptual purpose

Stores application users.

Fields

UserId

Username

DisplayName

Role

PasswordHash

IsActive

CreatedAt

UpdatedAt
UserId

Primary key.

Username

Must be unique.

Role

Example values

Operator

Engineer

Administrator
IsActive

Allows a user to be disabled without deleting historical records.

Password Storage

Plain-text passwords shall never be stored.

AuditLog

Purpose

Records important user and system actions.

Fields

AuditId

UserId

Action

EntityType

EntityId

Details

CreatedAt
Audit Examples
MethodCreated

MethodModified

TestStarted

TestStopped

TestAborted

CalibrationCreated

ConfigurationChanged

FaultReset
Audit Immutability

Audit records shall not normally be edited or deleted through the application.

Methods

Purpose

Stores logical Test Method definitions.

Fields

MethodId

MethodCode

Name

Description

Standard

IsActive

CurrentVersionId

CreatedAt

UpdatedAt
MethodCode

Unique identifier visible to the application.

Example

ISO6892-1-TENSION-25T
Method Version

A Method is a logical entity.

Its actual parameters are stored in MethodVersions.

MethodVersions

Fields

MethodVersionId

MethodId

VersionNumber

MethodData

CreatedAt

CreatedBy

IsApproved
MethodData

The architecture may store normalized method parameters in dedicated columns or a controlled serialized representation.

For engineering-critical values, important parameters should remain queryable and validated.

Recommended Approach

Core method properties should use explicit relational fields.

Complex extension parameters may use a serialized configuration payload.

Method Version Example
Method

ISO6892-1-TENSION

Version 3
Method Immutability

Once a Method Version has been used by a Test, it must not be modified.

A new version must be created.

Version Sequence

Example

Version 1

Version 2

Version 3
Current Method

The Method record references the currently active Method Version.

Material Table

Purpose

Stores material library definitions.

Fields

MaterialId

MaterialCode

Name

Grade

Standard

Description

IsActive

CreatedAt

UpdatedAt
Material Example
MaterialCode = REBAR-A3

Name = Reinforcing Steel

Grade = A3
Material Snapshot

When a Test starts, the relevant material information shall be captured in the Test snapshot.

MachineConfigurations

Purpose

Stores machine configuration profiles.

Fields

MachineConfigurationId

Name

MachineModel

SerialNumber

MaximumSpeed

MaximumForce

PositionUnits

ForceUnits

DefaultClutch

CreatedAt

UpdatedAt

IsActive
Machine Model

The deployed system is associated with the Shimadzu universal testing machine project.

Drive Information

Machine configuration may include

DriveModel

ControllerModel

CommunicationMode
ControllerMappings

Purpose

Stores hardware mapping information.

Fields

MappingId

MachineConfigurationId

Name

Address

DataType

Direction

Description

IsEnabled
Mapping Version

Controller mappings should be versioned or associated with a machine configuration revision.

LoadCells

Purpose

Stores configured load-cell definitions.

Fields

LoadCellId

Name

Capacity

Unit

SerialNumber

CalibrationId

IsActive
Load Cell Examples

The current machine context includes

25 ton

10 ton

2 ton

500 kg

100 kg
Load Cell Capacity

Capacity must be represented as an engineering quantity with a defined unit.

Extensometers

Fields

ExtensometerId

Name

GaugeLength

Range

SerialNumber

IsActive
Current Extensometer Context

The machine configuration includes extensometer variants associated with

100 mm

50 mm

25 mm

where applicable.

Calibration Sessions

Calibration is separate from Test execution.

Fields

CalibrationSessionId

SensorType

SensorId

ReferenceSensorId

CalibrationDate

OperatorId

Status

Notes
Calibration Principle

Calibration shall never become part of the Test execution workflow itself.

Calibration Points

Fields

CalibrationPointId

CalibrationSessionId

PointIndex

ReferenceValue

MeasuredValue

CorrectionValue
Calibration Curve

The calibration subsystem may calculate the final calibration relationship from these points.

Calibration Version

A Test must retain the calibration reference used at execution time.

Tests

The Tests table is the central Test-session entity.

Fields

TestId

AcceptanceNumber

CustomerName

ProjectName

TestDate

OperatorId

MethodVersionId

MaterialId

MachineConfigurationId

Status

CreatedAt

CompletedAt
Acceptance Number

The Acceptance Number is an important Test identifier.

It may be unique according to laboratory policy.

Test Status

Possible values

Draft

Ready

Running

Holding

Stopping

Completed

Aborted

Fault

EmergencyStopped
Test Snapshot

At Test execution the application shall preserve

Method Version

Material

Machine Configuration

Sensor Configuration

Relevant Calibration References
Why Snapshotting Is Required

Example

2026 Test

Method Version 3

Later

Method Version 4

Historical Test must continue to show Version 3.

TestSpecimens

A Test may contain one or more specimens.

Fields

TestSpecimenId

TestId

SpecimenNumber

SpecimenName

GeometryType

Diameter

Width

Thickness

OuterDiameter

InnerDiameter

GaugeLength

InitialArea

InitialGaugeLength

MaterialId

Notes
Geometry Types

Supported baseline geometry

Round

Square

Rectangle

Pipe

Custom
Round Specimen

Required parameters may include

Diameter

GaugeLength
Square Specimen

Required parameters

Width

GaugeLength
Rectangle

Required parameters

Width

Thickness

GaugeLength
Pipe

Required parameters

OuterDiameter

Thickness

GaugeLength
Custom

Custom geometry may store a validated calculated area.

Initial Area

The initial cross-sectional area must be preserved.

Initial Gauge Length

The initial gauge length must be preserved.

Engineering Snapshot

These values must not change after the Test becomes historical.

Measurements

Purpose

Stores acquired engineering measurement samples.

Fields

MeasurementId

TestId

TestSpecimenId

SequenceNumber

Timestamp

Force

Position

Extension

Stress

Strain

Speed

Quality
Measurement Sequence

SequenceNumber should be monotonically increasing within a Test stream.

Timestamp

Measurement timestamps must follow the acquisition architecture.

Force

Engineering force value.

Position

Crosshead / position value.

Extension

Extensometer-derived extension where available.

Stress

Calculated stress where the Test geometry allows it.

Strain

Calculated engineering strain where applicable.

Speed

Measured or calculated crosshead speed where available.

Quality

Example

Valid

Invalid

Stale

OutOfRange
Raw vs Engineering Data

The baseline schema focuses on normalized engineering measurements.

If raw sensor values must be retained, the schema may include an additional raw-data storage mechanism without changing the engineering Measurement contract.

Measurement Volume

Tensile Tests may produce large datasets.

Therefore measurement insertion must be optimized.

Batch Insert

The acquisition subsystem should support buffered batch insertion rather than performing an individual database transaction for every sample.

Measurement Transaction Strategy

A practical pattern is

Acquire Samples

↓

Buffer

↓

Batch Insert

↓

Commit

with a bounded buffer.

Data Loss Protection

The buffering policy must be designed so that a process crash does not silently discard large amounts of Test data.

Test Events

Purpose

Stores important events during Test execution.

Fields

TestEventId

TestId

Timestamp

EventType

Value

Message
Event Examples
TestStarted

PreloadReached

YieldDetected

MaximumForceDetected

BreakDetected

ExtensometerRemoved

LimitReached

FaultOccurred

TestStopped
Test Results

Purpose

Stores final Test-level result information.

Fields

TestResultId

TestId

FinalStatus

MaximumForce

YieldForce

YieldStress

BreakForce

FinalExtension

FinalStrain

YoungsModulus

CreatedAt
Result Metrics

Because standards can require different calculated metrics, flexible result metrics may be stored separately.

Fields

ResultMetricId

TestResultId

MetricCode

MetricName

Value

Unit

Status
Metric Examples
Rp0.2

Rp0.1

Rt0.5

Rm

ReH

ReL

YoungsModulus

ElongationAtBreak
Standard-Specific Results

The ResultMetric system allows different Standards to produce different result sets without modifying the core Test table.

Report Table

Fields

ReportId

TestId

ReportType

TemplateVersion

GeneratedAt

GeneratedBy

FilePath

Status
Report Immutability

A finalized report should be treated as historical output.

Report Regeneration

If report templates change, the generated report may be regenerated as a new report version rather than silently replacing historical output.

Report Items

Optional structured report information may be stored.

Fields

ReportItemId

ReportId

Section

ItemName

Value

Unit
File Storage

Large generated report files should normally remain in the filesystem rather than being stored as SQLite BLOBs.

SQLite stores metadata and file references.

File Path

Example

Reports\
2026\
08\
Acceptance-00125.pdf
Relative Paths

Prefer storing relative paths rather than machine-specific absolute paths where possible.

Export

CSV and XML export files are external artifacts.

The database may retain export metadata if required.

Database Indexes

Indexes shall be created for frequent lookup paths.

Recommended indexes

Tests.AcceptanceNumber

Tests.TestDate

Tests.OperatorId

Tests.MethodVersionId

TestSpecimens.TestId

Measurements.TestId

Measurements.TestSpecimenId

TestEvents.TestId

TestResults.TestId

ResultMetrics.TestResultId

AuditLog.CreatedAt
Unique Constraints

Examples

Users.Username

Methods.MethodCode

MethodVersions(MethodId, VersionNumber)
Foreign-Key Constraints

Relationships must be enforced.

Example

Tests.MethodVersionId

↓

MethodVersions.MethodVersionId
Delete Policy

Historical engineering data shall not be casually deleted.

Soft Delete

Master records such as

Methods

Materials

Users

MachineConfigurations

should generally use

IsActive

rather than physical deletion.

Historical Tests

Completed Tests should normally never be physically deleted through normal operator functions.

Archive

If archival is required, it should be a controlled administrative operation.

Test Data Retention

Retention policy shall be configurable according to laboratory requirements and applicable quality procedures.

ISO 17025 Context

The database architecture shall support traceability.

Important Test information must remain linked to

Operator

Method Version

Machine Configuration

Calibration Reference

Test Time

Results
Traceability Chain
Test

↓

Method Version

↓

Machine Configuration

↓

Sensor / Calibration Reference

↓

Measurements

↓

Calculations

↓

Results

↓

Report
Calibration Traceability

A result involving a calibrated sensor must be traceable to the calibration reference used.

Method Traceability

The report should be able to identify the exact Method Version.

Machine Traceability

The report should be able to identify the machine configuration used.

Operator Traceability

The report should identify the operator associated with the Test.

Auditability

Important changes must generate AuditLog entries.

Repository Transactions

Example Test completion

Begin Transaction

Save Test Status

Save Test Results

Save Result Metrics

Save Test Events

Save Report Metadata

Save Audit Entry

Commit
Rollback

If any required operation fails

Rollback

must occur.

Database Error

Database errors must be converted into application-level errors.

Example

Instead of exposing

SQLiteException

the service may expose

TestPersistenceException

with an explanatory message.

Busy Database

If SQLite reports a busy / locked condition, the application should use a controlled timeout and retry strategy where safe.

Unsafe Retry

Transactions that may duplicate engineering records must not be blindly retried.

Repository Thread Safety

Repositories must be safe for the application's intended concurrency model.

Real-Time Acquisition

Real-time acquisition shall not depend on synchronous UI database operations.

Acquisition Architecture
Hardware

↓

Acquisition Service

↓

Measurement Buffer

↓

Persistence Worker

↓

SQLite
UI Architecture

The UI reads Test state through application services.

It should not continuously query SQLite for every live measurement.

Completed Test Loading

Historical Tests may be loaded from SQLite into domain models.

Pagination

Large Test histories should support pagination.

Search

Test search should support at least

Acceptance Number

Customer

Project

Date Range

Method

Material
Search Query

Search logic belongs in repository / service layers.

Database Normalization

The schema should remain normalized for master entities and relationships.

Denormalization

Controlled denormalization may be used for performance or historical snapshots when justified.

Snapshot Fields

Examples

MethodNameSnapshot

StandardSnapshot

MachineNameSnapshot

LoadCellSnapshot

may be stored with a Test if needed to preserve historical display values even when master records later become inactive.

Snapshot Rule

Snapshot fields are historical data.

They must not be automatically synchronized with current master data.

Method JSON

If complex Method configuration is serialized, it must include its own version identifier.

Example

MethodSchemaVersion = 1
Validation

Before saving a Method Version

Schema Valid

AND

Engineering Parameters Valid

AND

Machine Compatibility Valid

must be confirmed.

Database Validation

Repositories shall validate required fields before insert/update.

Nullability

Fields that are mandatory for a given entity must not silently accept NULL.

Conditional fields may remain nullable when geometry or Method type makes them irrelevant.

Units

Database engineering values must have a defined unit policy.

Unit Storage

The preferred approach is to store normalized engineering units.

Examples

Force = kN

Stress = MPa

Position = mm

Extension = mm

Speed = mm/min

The exact canonical units are defined by the Engineering Data Model.

Unit Conversion

Display conversion is performed outside the database.

Precision

SQLite numeric values shall be stored with sufficient precision for engineering calculations.

The application shall not prematurely round values before persistence.

Display Rounding

Rounding belongs to presentation / report formatting.

Calculation Precision

Result calculations shall use the unrounded engineering values.

Database Encryption

SQLite encryption is not part of the baseline Schema v1.1 requirement.

If encryption becomes mandatory, the selected SQLite provider and deployment architecture must be evaluated separately.

Database Security

Application-level permissions must control who may perform

Method Changes

Calibration Changes

Configuration Changes

Data Deletion

Database Restore
Backup Verification

A backup should be verified after creation where practical.

Restore Verification

A restored database should undergo

Schema Check

Integrity Check

Application Compatibility Check

before being accepted as production data.

Database Upgrade

Application startup shall reject an unsupported future database version.

Example

Database Version = 2.0

Application Supports = 1.1

Result

UnsupportedDatabaseVersion

rather than destructive downgrade.

Downgrade

Automatic schema downgrade is not supported.

Version Compatibility

Each application build should declare the maximum database schema version it supports.

Database Repository Structure

Recommended project structure

Data
|
+-- Database
|   |
|   +-- DatabaseInitializer.vb
|   +-- SchemaInfoRepository.vb
|   +-- MigrationRunner.vb
|   +-- Migrations
|
+-- Repositories
|   |
|   +-- TestRepository.vb
|   +-- MethodRepository.vb
|   +-- MaterialRepository.vb
|   +-- ResultRepository.vb
|   +-- CalibrationRepository.vb
|   +-- UserRepository.vb
|   +-- AuditRepository.vb
|
+-- Infrastructure
    |
    +-- SqliteConnectionFactory.vb
    +-- UnitOfWork.vb
Domain Separation

The domain model must not depend directly on SQLite classes.

Example

Incorrect

TestEntity

inherits SQLite...

Correct

Test

Domain Model

with repository mapping

SQLite Row

↓

Test Domain Object
Mapping Layer

Database DTOs may be used where useful.

Conceptually

TestRecord

↓

TestMapper

↓

Test
DTO Principle

DTOs are persistence structures.

Domain objects represent engineering concepts.

Repository Contract

Example

ITestRepository

GetById()

GetByAcceptanceNumber()

Search()

Insert()

UpdateStatus()

SaveResults()
Method Repository

Example

IMethodRepository

GetActiveMethods()

GetById()

GetCurrentVersion()

GetVersion()

Create()

CreateVersion()

ApproveVersion()
Material Repository

Example

IMaterialRepository

GetActiveMaterials()

GetById()

Create()

Update()

Deactivate()
Calibration Repository

Example

ICalibrationRepository

CreateSession()

AddPoint()

CompleteSession()

GetCurrentCalibration()

GetHistory()
Audit Repository

Example

IAuditRepository

Write()

GetByEntity()

GetByDateRange()
Report Repository

Example

IReportRepository

Create()

GetByTestId()

GetLatest()

ListVersions()
Schema v1.1 Compatibility

All repositories must target Schema v1.1.

Acceptance Criteria

ARCH-071 is accepted when

SQLite is the production database.

Schema version is explicitly tracked.

Current schema is v1.1.

Migration mechanism exists.

Foreign keys are enforced.

Transactions are supported.

Repository layer isolates SQL.

ViewModels do not access SQLite directly.

Methods are versioned.

Historical Method Versions are immutable.

Tests retain Method Version references.

Tests retain machine configuration references.

Calibration is traceable.

Load Cells are represented.

Extensometers are represented.

Specimen geometry is persisted.

Measurements are persisted.

Test events are persisted.

Results are persisted.

Result metrics are extensible.

Reports are traceable.

Users are persisted.

Audit records are persisted.

Master records use controlled deactivation.

Historical Tests are protected from accidental deletion.

Large report files remain external to SQLite.

Backup and restore are defined.

Database upgrades use migrations.

Future unsupported database versions are rejected.

Engineering values are stored with adequate precision.

Display rounding is separated from persistence.

Architectural Decision (FROZEN)

SQLite is the sole baseline persistent relational database for the application.

Schema v1.1 is the current baseline.

All database access is isolated behind repositories and application services.

The WPF/MVVM layer shall never execute SQL directly.

Method definitions are versioned and historical versions are immutable once referenced by a Test.

Completed Test data is historically traceable to the Method Version, Machine Configuration, Operator and Calibration references used during execution.

Real-time acquisition shall use buffering and controlled persistence rather than synchronous UI database writes.

Engineering values shall be stored with sufficient precision and shall not be prematurely rounded.

Master records shall normally be deactivated rather than physically deleted.

Reports are stored as external files with database metadata and references.

Database migration, backup, restore and integrity validation are mandatory architectural capabilities.

No future schema may silently overwrite or reinterpret historical Test data.

This decision is permanent.

Next Chapter

ARCH-072

Application Services, Domain Services, Repository Coordination & Three-Layer Architecture

This chapter will define

Presentation Layer
Application Layer
Domain Layer
Infrastructure Layer
Service Contracts
Dependency Direction
Dependency Injection
Test Service
Method Service
Machine Service
Measurement Service
Result Service
Report Service
Calibration Service
Material Service
User Service
Audit Service
Transaction Coordination
Error Handling
Validation Pipeline
Command Pipeline
Event Pipeline
Service Lifetimes
Async Operations
Threading
Background Workers
Persistence Workers
Test Lifecycle Coordination
Hardware/Application Boundary
Unit Testing Boundary
Integration Testing Boundary
End of Chapter