# ARCHITECTURE
# Chapter 63
# Repository, SQLite & Persistence Architecture

Document ID

ARCH-063

Version

0.1

Status

FROZEN

Related EDR

EDR-068

Depends On

ARCH-023 Database Architecture

ARCH-062 Application Service Layer

ARCH-054 Test Data & Measurement Storage

ARCH-059 Audit Trail & Electronic Signature

ARCH-058 Security Architecture

---

# Purpose

This chapter defines the persistence architecture for the Universal Testing Machine software.

The persistence layer is responsible for reliable storage and retrieval of application data using SQLite while maintaining traceability, transactional integrity and compatibility with the WPF + MVVM + VB.NET + .NET Framework 4.8 x86 architecture.

---

# Technology

The primary persistence database is

```text
SQLite

Target environment

Visual Studio 2019

VB.NET

WPF

.NET Framework 4.8

x86

C# shall not be used in the application implementation.

Persistence Philosophy

The database is a persistence mechanism.

It shall not become the owner of business logic.

The architecture is

Application Service

↓

Repository

↓

Persistence Layer

↓

SQLite

↓

Database File
Responsibilities

The Persistence Layer SHALL

Store application entities
Retrieve application entities
Execute queries
Manage transactions
Maintain database integrity
Apply schema versioning
Support migrations
Support backup and restore
Preserve historical data
Support efficient measurement-data storage
SHALL NOT

The Persistence Layer shall not

Control machine motion
Interpret PLC registers
Calculate tensile properties
Decide PASS / FAIL independently
Authenticate users
Approve methods
Generate UI elements
Repository Pattern

Repositories provide an abstraction between Application Services and SQLite.

Example

ITestRepository

IMethodRepository

IMaterialRepository

ISpecimenRepository

IResultRepository

ICalibrationRepository

IAuditRepository

IReportRepository
Repository Responsibility

A repository answers questions such as

Load Test

Save Test

Find Method

List Materials

Load Result

It should not answer

Is this user authorized?

or

Should this test pass?
Repository Boundary
Application Service

↓

Repository Interface

↓

Repository Implementation

↓

SQLite Provider

↓

SQLite Database
SQLite Database

The application uses a local SQLite database.

Conceptually

Application Data

↓

UTM.db

The exact file location is configuration-controlled.

Database File

The database should be stored outside the application executable directory where practical.

Recommended concept

Application Folder

Data

└── UTM.db

The actual deployment path shall be configurable.

Database Connection

Connections shall be created through a centralized database connection mechanism.

ViewModels shall never create SQLite connections directly.

Connection Lifetime

Connections should normally be short-lived.

Conceptually

Open

↓

Execute

↓

Commit / Rollback

↓

Dispose

Long-lived idle database connections should be avoided unless required by the selected provider implementation.

Connection String

The connection string shall be centrally managed.

It should not be duplicated throughout the application.

SQLite Provider

The exact SQLite ADO.NET provider shall be selected according to

.NET Framework 4.8

x86

Visual Studio 2019

Deployment Requirements

The provider version must remain compatible with the target architecture.

x86 Constraint

Because the application is x86, the SQLite native provider, if used, must also be compatible with x86 deployment.

A mismatched x64 native SQLite component shall be treated as a deployment error.

Database Context

A lightweight database context may provide

Connection

Transaction

Command Creation

Schema Information

The context is an infrastructure component.

Database Context SHALL NOT

The database context shall not contain

Test Algorithms
Yield Detection
Motion Control
Acceptance Rules
UI Logic
Unit of Work

A Unit of Work coordinates multiple repository operations inside one transaction.

Example

Create Test

+

Create Specimen

+

Create Method Snapshot

↓

Commit
Transaction

A transaction should be used when several related database operations must either all succeed or all fail.

Transaction Example
BEGIN TRANSACTION

Create Test

Create Specimen

Create Method Snapshot

Create Initial Test State

COMMIT

If a critical operation fails

ROLLBACK
Transaction Boundary

Transaction boundaries shall normally be defined by the Application Service rather than by individual UI operations.

Read Operations

Read-only operations should not unnecessarily use explicit transactions.

Examples

Load Method

Load Material

Search Tests

Load Report
Write Operations

Write operations requiring consistency should use transactions.

Examples

Create Test

Finalize Test

Approve Method

Approve Calibration

Override Result
Database Schema Version

The database shall have an explicit schema version.

Example

Schema Version = 1.1

The schema version is separate from the application version.

Schema Metadata

The database should contain a schema metadata record.

Conceptually

SchemaInfo

Version

AppliedAt
Migration

Database schema changes shall be implemented through controlled migrations.

Example

Database 1.0

↓

Migration

↓

Database 1.1
Migration Rules

A migration shall

Have a unique version
Be deterministic
Be recorded
Be tested
Preserve existing data where required
Migration Failure

If migration fails

Migration Started

↓

Migration Failed

↓

Transaction Rollback

↓

Database Remains at Previous Version

The application shall not falsely report a successful migration.

Startup Migration

On application startup

Open Database

↓

Read Schema Version

↓

Compare Required Version

↓

Apply Pending Migrations

↓

Validate Schema

↓

Start Application
Unsupported Database Version

If the database version is newer than the application supports

Database Version > Supported Version

↓

Do Not Modify Database

↓

Display Compatibility Error
Database Integrity

SQLite integrity should be checked where appropriate.

Possible checks

PRAGMA integrity_check

The exact operational policy is defined by the deployment and recovery requirements.

Foreign Keys

Foreign-key enforcement should be enabled for normal application database connections.

This protects relationships such as

Test

↓

Specimen

and

Test

↓

Method Version
Referential Integrity

The database shall protect important relationships.

Examples

Test → Method

Test → Material

Test → Calibration

Result → Test

Report → Test
Historical References

Historical objects should not be physically deleted if doing so would destroy traceability.

Soft Delete

Where appropriate, records may use a status such as

Active

Archived

Disabled

rather than physical deletion.

Test Repository

ITestRepository manages Test Session persistence.

Operations may include

Create

Load

Update State

Finalize

Search

List

Archive
Test Snapshot

A completed Test Session should preserve the relevant configuration snapshot.

Examples

Method Version

Material Version

Calibration Version

Geometry

Units

Standard Revision

This prevents later library modifications from changing historical meaning.

Method Repository

IMethodRepository manages

Method

Method Version

Method Status

Method Approval
Method Version Persistence

A Method Version should be immutable after approval.

An edited method becomes a new version.

Material Repository

IMaterialRepository stores

Material

Material Version

Grade

Standard Reference

Requirements
Specimen Repository

ISpecimenRepository stores specimen information associated with a Test Session.

Result Repository

IResultRepository stores calculated results.

Examples

Maximum Force

UTS

Yield

Rp0.2

Young's Modulus

Elongation

Break
Result Versioning

Where recalculation or override is allowed, the database shall preserve the relationship between versions.

Conceptually

Result v1

↓

Recalculation

↓

Result v2
Original Result Preservation

The original automatic result shall not be overwritten silently.

Acceptance Repository

Acceptance results should be persisted separately or in a clearly identifiable result structure.

Example

Acceptance Result

Status

Requirement

Actual Value

Limit

Evaluation Version
Calibration Repository

ICalibrationRepository manages

Calibration

Calibration Points

Calibration Result

Calibration Status

Calibration Approval
Calibration Data

Multiple calibration points may be stored.

Example

Reference Load

Measured Load

Corrected Value

Error

Point Order
Audit Repository

IAuditRepository stores immutable audit events.

Operations include

InsertEvent

FindEvents

SearchEvents

ExportEvents

Normal Update and Delete operations shall not be exposed.

Signature Repository

Electronic signatures may be stored separately or as part of a controlled Audit / Signature subsystem.

A signature shall reference

User

Object

Object Version

Meaning

Timestamp
Report Repository

Reports may store

Report ID

Test ID

Report Version

Template

Generated Date

Status

Approval
Measurement Data

Raw measurement data can become significantly larger than normal application records.

The persistence architecture shall therefore distinguish

Metadata

vs

Measurement Samples
Measurement Metadata

Metadata includes

Test ID

Channel

Unit

Sample Rate

Start Time

End Time

Number of Samples
Measurement Samples

Typical channels

Load

Crosshead Position

Extensometer

Time

Additional channels may be supported.

Measurement Storage

Measurement data may be stored in a dedicated table structure rather than embedding large serialized blobs into ordinary Test records.

Conceptual Structure
Test

↓

Measurement Dataset

↓

Measurement Channel

↓

Measurement Samples
Measurement Dataset

A Measurement Dataset should contain

Dataset ID

Test ID

Acquisition Start

Acquisition End

Sample Rate

Status
Measurement Channel

A channel should contain

Channel ID

Dataset ID

Channel Name

Unit

Source

Sequence
Sample Storage

Each sample may contain

Sample Index

Timestamp / Relative Time

Value
Multi-Channel Synchronization

Channels should share a common sample index or time reference where the acquisition architecture provides synchronized sampling.

Large Dataset Strategy

For large tests, the application should avoid loading the complete dataset into memory unnecessarily.

Possible approach

Database

↓

Chunked Read

↓

Graph Downsampling

↓

Visualization
Graph Persistence

The Graph Engine may generate reduced datasets for visualization.

These are derived representations.

Raw measurement data remains authoritative.

Raw vs Derived Data
Raw Measurement

↓

Authoritative
Downsampled Curve

↓

Derived
Engineering Result

↓

Derived
Data Integrity

The system should be able to identify whether a measurement dataset is

Acquiring

Complete

Interrupted

Invalid

Archived
Interrupted Dataset

If acquisition terminates unexpectedly

Dataset Status = Interrupted

It shall not automatically be treated as a valid completed dataset.

Test Completion Persistence

Test completion should follow

Dataset Complete

↓

Dataset Valid

↓

Calculation Complete

↓

Acceptance Complete

↓

Test Completed
Database Constraints

Database constraints should enforce basic structural integrity.

Examples

NOT NULL

UNIQUE

FOREIGN KEY

CHECK

Business rules remain in the application/domain layer.

Unique Identifiers

Entities should use stable unique identifiers.

Examples

TestId

MethodId

MethodVersionId

MaterialId

ResultId

CalibrationId

ReportId

AuditEventId
GUID vs Integer IDs

The final implementation may use GUIDs or integer keys according to the database schema defined in the project.

The chosen strategy shall remain consistent across related entities.

Human-Readable Numbers

A Test may also have a human-readable laboratory number.

Example

Test ID

=

Internal Identifier
Acceptance Number

=

Laboratory Identifier

These concepts shall not be confused.

Date Storage

Dates should be stored in a consistent machine-readable representation.

UTC timestamps should be preferred for system event timestamps.

Decimal Values

Engineering values shall preserve adequate precision.

The database shall not unnecessarily round values that are required for later calculations.

Units

Stored engineering data shall include or be associated with explicit units.

Example

Force → kN

Stress → MPa

Stroke → mm

Speed → mm/min
Unit Conversion

Unit conversion should occur through the Unit Service / Domain Layer.

Repositories store the defined representation and do not perform arbitrary UI-specific conversions.

CSV Export

CSV export is an application-level operation.

Report / Export Service

↓

Repository

↓

Data

↓

CSV Writer

The repository shall not create CSV files directly.

XML Export

XML export follows the same separation.

Application Service

↓

Repository

↓

DTO

↓

XML Serializer
Import

Imported data shall pass through validation before persistence.

File

↓

Parser

↓

DTO

↓

Validation

↓

Application Service

↓

Repository

↓

SQLite
Import Failure

Invalid imported data shall not partially modify controlled records unless the operation explicitly supports transactional partial import.

Backup

The application shall support controlled database backup.

A backup should contain

SQLite Database

Schema Version

Application Compatibility Information

where required.

Backup During Active Test

Database backup shall not corrupt an active Test Session.

The implementation shall use a safe SQLite backup/copy mechanism appropriate to the provider and deployment.

Restore

Restore shall be an administrative operation.

Workflow

Select Backup

↓

Validate Backup

↓

Check Compatibility

↓

Backup Current Database

↓

Restore

↓

Integrity Check

↓

Application Restart if Required
Restore Audit

Restore operations shall themselves be audited.

Database Locking

SQLite locking behavior shall be respected.

The application should avoid unnecessary concurrent writes.

Write Serialization

Critical writes may be serialized through an application persistence mechanism where required.

Concurrency

The system is primarily a local laboratory application.

Concurrent writers are expected to be limited.

Nevertheless, repository operations shall be designed to handle expected SQLite locking conditions safely.

Database Error Handling

Examples

Database Locked

Database Corrupt

Constraint Violation

Connection Failure

Migration Failure

Disk Full

These errors shall be converted into controlled application-level errors.

Disk Space

The application should monitor available storage because measurement datasets can become large.

Low disk space should generate a warning before a critical failure occurs where practical.

Storage Monitoring

Possible statuses

Normal

Warning

Critical
Data Retention

Retention policies shall distinguish between

Active Data

Historical Test Data

Audit Data

Measurement Data

Reports

Backups

Retention shall follow laboratory policy.

Archiving

Large historical datasets may be archived.

Archiving shall preserve the relationship between

Test

Measurement Dataset

Results

Reports

Audit
Archive Integrity

Archived data must remain identifiable as historical and must not be accidentally treated as current operational data.

Database Security

The SQLite database file shall be protected through operating-system permissions and deployment security.

Application-level authorization remains necessary.

SQLite Encryption

If database encryption is required by deployment policy, the selected SQLite provider / encryption mechanism must be explicitly approved and compatible with

.NET Framework 4.8

x86

Backup

Restore

Deployment

Encryption shall not be assumed merely because SQLite is being used.

Database Migration Testing

Every migration shall be tested against representative existing databases.

Minimum scenarios

Fresh Database

Previous Version

Typical Production Database

Large Measurement Dataset

Existing Audit Records
Repository Testing

Repository tests should verify

Insert

Read

Update

Transaction

Rollback

Foreign Key

Versioning

Search

Archive
Persistence Integration Tests

Integration tests should run against a real SQLite database rather than only mocks.

Test Database

Automated tests should use an isolated temporary database.

Production data must never be used for automated tests.

Repository Mocking

Unit tests for Application Services may use repository interfaces with mock implementations.

This keeps Service tests independent from SQLite.

Performance

Persistence performance must be measured for

Test Creation

Live / Incremental Persistence

Final Dataset Storage

Result Persistence

Historical Search

Report Generation
Large Test Search

Historical Test search should use indexed fields such as

Test Number

Acceptance Number

Date

Customer

Project

Material

Method
Indexing

Indexes should be added according to actual query patterns.

Potential indexes include

Test.AcceptanceNumber

Test.CreatedAt

Test.Customer

Test.MethodVersionId

Result.TestId

Audit.Timestamp

Audit.UserId

Audit.ObjectId

Indexes shall not be added blindly because excessive indexing increases write cost.

Database Schema Ownership

The database schema is owned by the Persistence Architecture.

Business meaning is owned by the Domain / Application layers.

Persistence DTOs

Persistence-specific DTOs may be used when database structures differ from Domain Models.

This prevents SQLite schema details from leaking into the Domain Layer.

Mapping

Conceptually

SQLite Row

↓

Persistence DTO

↓

Domain Entity

↓

Application DTO

↓

ViewModel
No Database Entities in WPF

WPF Views and ViewModels shall not directly expose SQLite row objects.

Repository Query Rule

Repositories should return domain-oriented or persistence-mapped objects appropriate to their interface.

They should not expose raw SQLite commands or connections.

SQL Location

SQL statements, when used, belong in the Persistence implementation.

They shall not be embedded in

ViewModel

View

Domain Service

Application Service
SQL Parameterization

All variable SQL values shall use parameterized commands.

String concatenation shall not be used for user-controlled SQL values.

Database Initialization

Initial database creation shall use the same controlled schema definition used by migrations.

Seed Data

System seed data may include

Default Units

Default Permissions

Default Roles

System Configuration

Seed data shall be version-controlled and deterministic.

Default Administrator

If a default administrative account is created during installation, its credentials and first-login behavior shall follow the Security Architecture.

Hard-coded permanent administrator credentials are forbidden.

Persistence and Audit

Critical persistence operations shall be auditable through the Audit Service.

The Repository itself should not invent business audit semantics.

Persistence and Electronic Signature

Signature records must reference persistent object versions.

If the object changes, the signature must no longer appear as an approval of the new version.

Failure Recovery

The persistence architecture shall favor

Atomicity

Consistency

Traceability

Recoverability

over convenience.

Design Constraints

Persistence SHALL NOT

Access PLC
Control Servo
Implement Test State Machine
Calculate Yield
Calculate Young's Modulus
Decide PASS / FAIL
Authenticate Users
Modify Audit History
Modify Signed Historical Objects
Architectural Decision (FROZEN)

SQLite is the primary local persistence database.

All database access is isolated behind Repository and Persistence interfaces.

Application Services define transaction boundaries.

Schema versions are explicit and migrations are controlled.

Historical Test, Method, Calibration, Result, Report and Audit information shall remain traceable and shall not be silently destroyed by normal editing operations.

Large measurement datasets shall be separated from ordinary metadata and shall support efficient storage and retrieval.

The persistence layer shall remain independent of WPF, machine hardware and engineering algorithms.

The implementation shall remain compatible with VB.NET, WPF, .NET Framework 4.8 and x86 deployment.

This decision is permanent.

Next Chapter

ARCH-064

Hardware Abstraction Layer & Machine Communication Architecture

This chapter will define

HAL
PLC Communication
Fatek Communication Server
Autograph_SVR
VS20NL-P1
DriveView
Machine State
Motion Commands
Digital Inputs
Digital Outputs
Register Mapping
Communication Errors
Watchdog
Simulation Adapter
Hardware Independence
Safety Boundaries
Crosshead Control
Speed Control
Load Cell / Extensometer Acquisition
End of Chapter