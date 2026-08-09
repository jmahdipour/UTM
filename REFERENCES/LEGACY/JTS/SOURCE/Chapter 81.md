# ARCHITECTURE
# Chapter 81
# Complete SQLite Schema SQL v1.1, Tables, Keys, Constraints, Indexes, Triggers, Seed Data & Migrations

Document ID

ARCH-081

Version

0.1

Status

FROZEN

Related EDR

EDR-086

Depends On

ARCH-080 SQLite Database Architecture

ARCH-079 Data Acquisition Architecture

---

# Purpose

This chapter defines the concrete SQLite Schema v1.1.

Unlike ARCH-080, which defined the logical database architecture, this chapter defines the actual relational structure required by the application.

The objective is to provide a deterministic schema that can be implemented directly in the VB.NET / .NET Framework 4.8 x86 application.

---

# Database Schema Version

```text
1.1
SQL Compatibility

The SQL must remain compatible with the selected SQLite provider used by the application.

The schema must not depend on SQL Server, PostgreSQL or MySQL-specific syntax.

Database Initialization

The database initialization sequence is

Open Connection

↓

PRAGMA foreign_keys = ON

↓

Create SchemaInfo

↓

Read SchemaVersion

↓

Create / Upgrade Schema

↓

Create Indexes

↓

Create Triggers

↓

Insert Seed Data

↓

Validate Database

↓

Ready
Required SQLite PRAGMA

At connection initialization:

PRAGMA foreign_keys = ON;
Journal Mode

Production deployment may use:

PRAGMA journal_mode = WAL;

The selected mode must be verified on the target installation.

Synchronous Mode

Recommended durability-oriented configuration:

PRAGMA synchronous = FULL;

The production value may be adjusted only after acquisition-performance and durability validation.

Busy Timeout

A controlled timeout may be configured:

PRAGMA busy_timeout = 5000;
Integrity Check

Manual diagnostic command:

PRAGMA integrity_check;

Expected successful result:

ok
SchemaInfo
CREATE TABLE IF NOT EXISTS SchemaInfo
(
    SchemaVersion TEXT NOT NULL,
    ProductVersion TEXT,
    CreatedAtUtc TEXT NOT NULL,
    UpdatedAtUtc TEXT NOT NULL
);
SchemaInfo Rule

Exactly one logical SchemaInfo record shall exist.

SchemaMigrations
CREATE TABLE IF NOT EXISTS SchemaMigrations
(
    MigrationId TEXT NOT NULL PRIMARY KEY,
    Version TEXT NOT NULL UNIQUE,
    Name TEXT NOT NULL,
    Checksum TEXT,
    AppliedAtUtc TEXT NOT NULL
);
Migration Identity

Example:

MigrationId = 001_INITIAL_SCHEMA
Version = 1.0
Users
CREATE TABLE IF NOT EXISTS Users
(
    UserId TEXT NOT NULL PRIMARY KEY,
    Username TEXT NOT NULL UNIQUE,
    DisplayName TEXT NOT NULL,
    PasswordHash TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1,
    CreatedAtUtc TEXT NOT NULL,
    LastLoginAtUtc TEXT
);
User Rules
Username must be unique.

Inactive users cannot authenticate.

PasswordHash must never contain plaintext passwords.
Roles
CREATE TABLE IF NOT EXISTS Roles
(
    RoleId TEXT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL UNIQUE,
    Description TEXT,
    IsSystemRole INTEGER NOT NULL DEFAULT 0
);
UserRoles
CREATE TABLE IF NOT EXISTS UserRoles
(
    UserId TEXT NOT NULL,
    RoleId TEXT NOT NULL,

    PRIMARY KEY
    (
        UserId,
        RoleId
    ),

    FOREIGN KEY
    (
        UserId
    )
    REFERENCES Users(UserId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        RoleId
    )
    REFERENCES Roles(RoleId)
    ON DELETE RESTRICT
);
Customers
CREATE TABLE IF NOT EXISTS Customers
(
    CustomerId TEXT NOT NULL PRIMARY KEY,
    CustomerCode TEXT UNIQUE,
    Name TEXT NOT NULL,
    CompanyName TEXT,
    Phone TEXT,
    Email TEXT,
    Address TEXT,
    Notes TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1,
    CreatedAtUtc TEXT NOT NULL,
    UpdatedAtUtc TEXT NOT NULL
);
Customers Index
CREATE INDEX IF NOT EXISTS IX_Customers_Name
ON Customers(Name);
Projects
CREATE TABLE IF NOT EXISTS Projects
(
    ProjectId TEXT NOT NULL PRIMARY KEY,
    ProjectCode TEXT UNIQUE,
    CustomerId TEXT,
    Name TEXT NOT NULL,
    Description TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1,
    CreatedAtUtc TEXT NOT NULL,
    UpdatedAtUtc TEXT NOT NULL,

    FOREIGN KEY
    (
        CustomerId
    )
    REFERENCES Customers(CustomerId)
    ON DELETE RESTRICT
);
Projects Indexes
CREATE INDEX IF NOT EXISTS IX_Projects_CustomerId
ON Projects(CustomerId);

CREATE INDEX IF NOT EXISTS IX_Projects_Name
ON Projects(Name);
Specimens
CREATE TABLE IF NOT EXISTS Specimens
(
    SpecimenId TEXT NOT NULL PRIMARY KEY,
    SpecimenCode TEXT,
    Name TEXT NOT NULL,
    Material TEXT,
    Description TEXT,

    GeometryType TEXT NOT NULL,

    Diameter REAL,
    Width REAL,
    Height REAL,

    OuterDiameter REAL,
    Thickness REAL,

    GaugeLength REAL,
    InitialLength REAL,

    CrossSectionArea REAL,

    CreatedAtUtc TEXT NOT NULL,
    UpdatedAtUtc TEXT NOT NULL
);
GeometryType

Supported conceptual values:

ROUND

RECTANGLE

PIPE

SQUARE

CUSTOM
Specimen Validation

The application layer shall validate which geometry fields are required for each GeometryType.

The database stores the resulting snapshot values.

Methods
CREATE TABLE IF NOT EXISTS Methods
(
    MethodId TEXT NOT NULL PRIMARY KEY,
    MethodCode TEXT NOT NULL UNIQUE,
    Name TEXT NOT NULL,
    Standard TEXT,
    Description TEXT,
    Status TEXT NOT NULL DEFAULT 'Draft',
    CurrentVersionId TEXT,
    CreatedAtUtc TEXT NOT NULL,
    UpdatedAtUtc TEXT NOT NULL
);
Method Versions
CREATE TABLE IF NOT EXISTS MethodVersions
(
    MethodVersionId TEXT NOT NULL PRIMARY KEY,
    MethodId TEXT NOT NULL,

    VersionNumber INTEGER NOT NULL,

    Standard TEXT,
    ControllerType TEXT,

    LoadCellId TEXT,
    ExtensometerId TEXT,

    SpeedMode TEXT,
    SpeedValue REAL,

    ClutchMode TEXT,

    PreloadEnabled INTEGER NOT NULL DEFAULT 0,

    CycleMode TEXT,

    Status TEXT NOT NULL DEFAULT 'Draft',

    CreatedAtUtc TEXT NOT NULL,
    CreatedBy TEXT,

    ApprovedAtUtc TEXT,
    ApprovedBy TEXT,

    UNIQUE
    (
        MethodId,
        VersionNumber
    ),

    FOREIGN KEY
    (
        MethodId
    )
    REFERENCES Methods(MethodId)
    ON DELETE RESTRICT
);
Method Current Version

Because Methods reference MethodVersions and MethodVersions reference Methods, the CurrentVersionId relationship should be established after both tables exist.

CREATE INDEX IF NOT EXISTS IX_MethodVersions_MethodId
ON MethodVersions(MethodId);
Method Parameters
CREATE TABLE IF NOT EXISTS MethodParameters
(
    MethodParameterId TEXT NOT NULL PRIMARY KEY,

    MethodVersionId TEXT NOT NULL,

    ParameterName TEXT NOT NULL,
    ParameterValue TEXT,
    ValueType TEXT,
    Unit TEXT,

    FOREIGN KEY
    (
        MethodVersionId
    )
    REFERENCES MethodVersions(MethodVersionId)
    ON DELETE RESTRICT,

    UNIQUE
    (
        MethodVersionId,
        ParameterName
    )
);
Method Parameter Example
YieldOffset

0.2

%

Sensors
CREATE TABLE IF NOT EXISTS Sensors
(
    SensorId TEXT NOT NULL PRIMARY KEY,

    SensorCode TEXT NOT NULL UNIQUE,

    Name TEXT NOT NULL,

    SensorType TEXT NOT NULL,

    SerialNumber TEXT,

    Unit TEXT,

    Capacity REAL,

    Status TEXT NOT NULL DEFAULT 'Active',

    CreatedAtUtc TEXT NOT NULL,

    UpdatedAtUtc TEXT NOT NULL
);
Sensor Types
LoadCell

Extensometer

Encoder

Displacement

Temperature

Pressure

Custom
LoadCells
CREATE TABLE IF NOT EXISTS LoadCells
(
    LoadCellId TEXT NOT NULL PRIMARY KEY,

    SensorId TEXT NOT NULL UNIQUE,

    Capacity REAL NOT NULL,

    Unit TEXT NOT NULL,

    Manufacturer TEXT,

    Model TEXT,

    SerialNumber TEXT,

    ReferenceType TEXT,

    IsActive INTEGER NOT NULL DEFAULT 1,

    FOREIGN KEY
    (
        SensorId
    )
    REFERENCES Sensors(SensorId)
    ON DELETE RESTRICT
);
Load Cell Capacities

Supported machine configurations include:

25 ton

10 ton

2 ton

500 kg

100 kg

The database must not hard-code these values as the only possible capacities.

Extensometers
CREATE TABLE IF NOT EXISTS Extensometers
(
    ExtensometerId TEXT NOT NULL PRIMARY KEY,

    SensorId TEXT NOT NULL UNIQUE,

    GaugeLength REAL,

    Travel REAL,

    Resolution REAL,

    Manufacturer TEXT,

    Model TEXT,

    SerialNumber TEXT,

    IsActive INTEGER NOT NULL DEFAULT 1,

    FOREIGN KEY
    (
        SensorId
    )
    REFERENCES Sensors(SensorId)
    ON DELETE RESTRICT
);
Calibration Sessions
CREATE TABLE IF NOT EXISTS CalibrationSessions
(
    CalibrationSessionId TEXT NOT NULL PRIMARY KEY,

    SensorId TEXT NOT NULL,

    ReferenceSensorId TEXT,

    CalibrationDateUtc TEXT NOT NULL,

    OperatorId TEXT,

    Status TEXT NOT NULL DEFAULT 'Draft',

    Notes TEXT,

    CreatedAtUtc TEXT NOT NULL,

    FOREIGN KEY
    (
        SensorId
    )
    REFERENCES Sensors(SensorId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        ReferenceSensorId
    )
    REFERENCES Sensors(SensorId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        OperatorId
    )
    REFERENCES Users(UserId)
    ON DELETE RESTRICT
);
Calibration Points
CREATE TABLE IF NOT EXISTS CalibrationPoints
(
    CalibrationPointId TEXT NOT NULL PRIMARY KEY,

    CalibrationSessionId TEXT NOT NULL,

    PointIndex INTEGER NOT NULL,

    ReferenceValue REAL NOT NULL,

    RawValue REAL NOT NULL,

    CalculatedValue REAL,

    Deviation REAL,

    FOREIGN KEY
    (
        CalibrationSessionId
    )
    REFERENCES CalibrationSessions(CalibrationSessionId)
    ON DELETE RESTRICT,

    UNIQUE
    (
        CalibrationSessionId,
        PointIndex
    )
);
Calibration Point Ordering

PointIndex starts at:

1

and increases monotonically.

Tests
CREATE TABLE IF NOT EXISTS Tests
(
    TestId TEXT NOT NULL PRIMARY KEY,

    AcceptanceNumber TEXT NOT NULL UNIQUE,

    CustomerId TEXT,

    ProjectId TEXT,

    SpecimenId TEXT,

    TestDateUtc TEXT NOT NULL,

    Name TEXT,

    Description TEXT,

    Status TEXT NOT NULL,

    CompletionReason TEXT,

    CreatedBy TEXT,

    CreatedAtUtc TEXT NOT NULL,

    StartedAtUtc TEXT,

    CompletedAtUtc TEXT,

    DeletedAtUtc TEXT,

    IsDeleted INTEGER NOT NULL DEFAULT 0,

    FOREIGN KEY
    (
        CustomerId
    )
    REFERENCES Customers(CustomerId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        ProjectId
    )
    REFERENCES Projects(ProjectId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        SpecimenId
    )
    REFERENCES Specimens(SpecimenId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        CreatedBy
    )
    REFERENCES Users(UserId)
    ON DELETE RESTRICT
);
Tests Indexes
CREATE INDEX IF NOT EXISTS IX_Tests_TestDateUtc
ON Tests(TestDateUtc);

CREATE INDEX IF NOT EXISTS IX_Tests_CustomerId
ON Tests(CustomerId);

CREATE INDEX IF NOT EXISTS IX_Tests_ProjectId
ON Tests(ProjectId);

CREATE INDEX IF NOT EXISTS IX_Tests_Status
ON Tests(Status);

CREATE INDEX IF NOT EXISTS IX_Tests_IsDeleted
ON Tests(IsDeleted);
Test Method Snapshot
CREATE TABLE IF NOT EXISTS TestMethodSnapshots
(
    TestMethodSnapshotId TEXT NOT NULL PRIMARY KEY,

    TestId TEXT NOT NULL UNIQUE,

    MethodId TEXT,

    MethodVersionId TEXT,

    SnapshotJson TEXT NOT NULL,

    CreatedAtUtc TEXT NOT NULL,

    FOREIGN KEY
    (
        TestId
    )
    REFERENCES Tests(TestId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        MethodId
    )
    REFERENCES Methods(MethodId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        MethodVersionId
    )
    REFERENCES MethodVersions(MethodVersionId)
    ON DELETE RESTRICT
);
Snapshot Rule

SnapshotJson is immutable after Test execution begins.

Test Calibration Snapshot
CREATE TABLE IF NOT EXISTS TestCalibrationSnapshots
(
    TestCalibrationSnapshotId TEXT NOT NULL PRIMARY KEY,

    TestId TEXT NOT NULL,

    SensorId TEXT NOT NULL,

    CalibrationSessionId TEXT,

    CalibrationVersion TEXT,

    SnapshotJson TEXT NOT NULL,

    CreatedAtUtc TEXT NOT NULL,

    FOREIGN KEY
    (
        TestId
    )
    REFERENCES Tests(TestId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        SensorId
    )
    REFERENCES Sensors(SensorId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        CalibrationSessionId
    )
    REFERENCES CalibrationSessions(CalibrationSessionId)
    ON DELETE RESTRICT
);
Calibration Snapshot Index
CREATE INDEX IF NOT EXISTS IX_TestCalibrationSnapshots_TestId
ON TestCalibrationSnapshots(TestId);
Test Acquisition Snapshot
CREATE TABLE IF NOT EXISTS TestAcquisitionSnapshots
(
    TestAcquisitionSnapshotId TEXT NOT NULL PRIMARY KEY,

    TestId TEXT NOT NULL UNIQUE,

    SampleRate REAL NOT NULL,

    ChannelsJson TEXT NOT NULL,

    AdapterType TEXT NOT NULL,

    BufferSize INTEGER,

    BatchSize INTEGER,

    ProcessingPolicyJson TEXT,

    CreatedAtUtc TEXT NOT NULL,

    FOREIGN KEY
    (
        TestId
    )
    REFERENCES Tests(TestId)
    ON DELETE RESTRICT
);
Test Samples
CREATE TABLE IF NOT EXISTS TestSamples
(
    SampleId INTEGER PRIMARY KEY AUTOINCREMENT,

    TestId TEXT NOT NULL,

    Sequence INTEGER NOT NULL,

    TimestampUtc TEXT NOT NULL,

    ElapsedMilliseconds INTEGER NOT NULL,

    ForceRaw REAL,

    ExtensionRaw REAL,

    DisplacementRaw REAL,

    SpeedRaw REAL,

    QualityFlags INTEGER NOT NULL DEFAULT 0,

    FOREIGN KEY
    (
        TestId
    )
    REFERENCES Tests(TestId)
    ON DELETE RESTRICT,

    UNIQUE
    (
        TestId,
        Sequence
    )
);
TestSamples Index
CREATE INDEX IF NOT EXISTS IX_TestSamples_TestId_Sequence
ON TestSamples(TestId, Sequence);
TestSamples Timestamp Index

Only create this if required by actual query patterns.

CREATE INDEX IF NOT EXISTS IX_TestSamples_TestId_Time
ON TestSamples(TestId, TimestampUtc);
Performance Rule

Additional indexes on TestSamples should not be added without benchmarking write performance.

Test Sample Channel Values
CREATE TABLE IF NOT EXISTS TestSampleChannelValues
(
    SampleChannelValueId INTEGER PRIMARY KEY AUTOINCREMENT,

    SampleId INTEGER NOT NULL,

    ChannelId TEXT NOT NULL,

    RawValue REAL,

    ProcessedValue REAL,

    QualityFlags INTEGER NOT NULL DEFAULT 0,

    FOREIGN KEY
    (
        SampleId
    )
    REFERENCES TestSamples(SampleId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        ChannelId
    )
    REFERENCES Sensors(SensorId)
    ON DELETE RESTRICT,

    UNIQUE
    (
        SampleId,
        ChannelId
    )
);
Channel Value Index
CREATE INDEX IF NOT EXISTS IX_TestSampleChannelValues_SampleId
ON TestSampleChannelValues(SampleId);

CREATE INDEX IF NOT EXISTS IX_TestSampleChannelValues_ChannelId
ON TestSampleChannelValues(ChannelId);
Test Events
CREATE TABLE IF NOT EXISTS TestEvents
(
    EventId TEXT NOT NULL PRIMARY KEY,

    TestId TEXT NOT NULL,

    Sequence INTEGER NOT NULL,

    TimestampUtc TEXT NOT NULL,

    State TEXT,

    EventType TEXT NOT NULL,

    Severity TEXT NOT NULL,

    Source TEXT,

    OperatorId TEXT,

    Message TEXT,

    PayloadJson TEXT,

    FOREIGN KEY
    (
        TestId
    )
    REFERENCES Tests(TestId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        OperatorId
    )
    REFERENCES Users(UserId)
    ON DELETE RESTRICT,

    UNIQUE
    (
        TestId,
        Sequence
    )
);
Test Event Index
CREATE INDEX IF NOT EXISTS IX_TestEvents_TestId_Sequence
ON TestEvents(TestId, Sequence);
Test Results
CREATE TABLE IF NOT EXISTS TestResults
(
    TestResultId TEXT NOT NULL PRIMARY KEY,

    TestId TEXT NOT NULL,

    ResultVersion INTEGER NOT NULL,

    CalculationVersion TEXT NOT NULL,

    CalculatedAtUtc TEXT NOT NULL,

    Status TEXT NOT NULL,

    IsCurrent INTEGER NOT NULL DEFAULT 1,

    FOREIGN KEY
    (
        TestId
    )
    REFERENCES Tests(TestId)
    ON DELETE RESTRICT,

    UNIQUE
    (
        TestId,
        ResultVersion
    )
);
Current Result

Only one TestResult should normally have

IsCurrent = 1

for each Test.

Current Result Index

SQLite partial index may be used:

CREATE UNIQUE INDEX IF NOT EXISTS UX_TestResults_Current
ON TestResults(TestId)
WHERE IsCurrent = 1;
Result Values
CREATE TABLE IF NOT EXISTS TestResultValues
(
    TestResultValueId INTEGER PRIMARY KEY AUTOINCREMENT,

    TestResultId TEXT NOT NULL,

    ResultCode TEXT NOT NULL,

    ResultName TEXT NOT NULL,

    Value REAL,

    Unit TEXT,

    DisplayValue TEXT,

    Quality TEXT,

    FOREIGN KEY
    (
        TestResultId
    )
    REFERENCES TestResults(TestResultId)
    ON DELETE RESTRICT,

    UNIQUE
    (
        TestResultId,
        ResultCode
    )
);
Result Examples
MAX_FORCE

YIELD_RP02

YIELD_RP01

YIELD_RT05

E_MODULUS

BREAK_FORCE

BREAK_STRAIN

ULTIMATE_TENSILE_STRENGTH

ELONGATION
Reports
CREATE TABLE IF NOT EXISTS Reports
(
    ReportId TEXT NOT NULL PRIMARY KEY,

    TestId TEXT NOT NULL,

    ReportType TEXT NOT NULL,

    TemplateVersion TEXT NOT NULL,

    CalculationVersion TEXT,

    FilePath TEXT,

    FileHash TEXT,

    GeneratedAtUtc TEXT NOT NULL,

    GeneratedBy TEXT,

    Status TEXT NOT NULL,

    FOREIGN KEY
    (
        TestId
    )
    REFERENCES Tests(TestId)
    ON DELETE RESTRICT,

    FOREIGN KEY
    (
        GeneratedBy
    )
    REFERENCES Users(UserId)
    ON DELETE RESTRICT
);
Report Index
CREATE INDEX IF NOT EXISTS IX_Reports_TestId
ON Reports(TestId);
Audit Logs
CREATE TABLE IF NOT EXISTS AuditLogs
(
    AuditLogId INTEGER PRIMARY KEY AUTOINCREMENT,

    TimestampUtc TEXT NOT NULL,

    UserId TEXT,

    Action TEXT NOT NULL,

    EntityType TEXT NOT NULL,

    EntityId TEXT,

    OldValueJson TEXT,

    NewValueJson TEXT,

    Reason TEXT,

    FOREIGN KEY
    (
        UserId
    )
    REFERENCES Users(UserId)
    ON DELETE RESTRICT
);
Audit Index
CREATE INDEX IF NOT EXISTS IX_AuditLogs_Entity
ON AuditLogs(EntityType, EntityId);

CREATE INDEX IF NOT EXISTS IX_AuditLogs_User
ON AuditLogs(UserId);

CREATE INDEX IF NOT EXISTS IX_AuditLogs_Time
ON AuditLogs(TimestampUtc);
Application Settings
CREATE TABLE IF NOT EXISTS ApplicationSettings
(
    SettingKey TEXT NOT NULL PRIMARY KEY,

    SettingValue TEXT,

    ValueType TEXT,

    UpdatedAtUtc TEXT NOT NULL,

    UpdatedBy TEXT,

    FOREIGN KEY
    (
        UpdatedBy
    )
    REFERENCES Users(UserId)
    ON DELETE RESTRICT
);
Machine Settings
CREATE TABLE IF NOT EXISTS MachineSettings
(
    MachineSettingId TEXT NOT NULL PRIMARY KEY,

    SettingKey TEXT NOT NULL UNIQUE,

    SettingValue TEXT,

    Unit TEXT,

    UpdatedAtUtc TEXT NOT NULL,

    UpdatedBy TEXT,

    FOREIGN KEY
    (
        UpdatedBy
    )
    REFERENCES Users(UserId)
    ON DELETE RESTRICT
);
Method Current Version Relationship

After MethodVersions exists:

CREATE INDEX IF NOT EXISTS IX_Methods_CurrentVersion
ON Methods(CurrentVersionId);

The application must verify that CurrentVersionId belongs to the same MethodId.

Seed Roles

Recommended initial roles:

Administrator

Engineer

Operator

Viewer
Seed SQL
INSERT OR IGNORE INTO Roles
(
    RoleId,
    Name,
    Description,
    IsSystemRole
)
VALUES
(
    'ROLE_ADMIN',
    'Administrator',
    'Full system administration',
    1
);

INSERT OR IGNORE INTO Roles
(
    RoleId,
    Name,
    Description,
    IsSystemRole
)
VALUES
(
    'ROLE_ENGINEER',
    'Engineer',
    'Engineering and method configuration',
    1
);

INSERT OR IGNORE INTO Roles
(
    RoleId,
    Name,
    Description,
    IsSystemRole
)
VALUES
(
    'ROLE_OPERATOR',
    'Operator',
    'Machine operation and test execution',
    1
);

INSERT OR IGNORE INTO Roles
(
    RoleId,
    Name,
    Description,
    IsSystemRole
)
VALUES
(
    'ROLE_VIEWER',
    'Viewer',
    'Read-only access',
    1
);
Default Settings
INSERT OR IGNORE INTO ApplicationSettings
(
    SettingKey,
    SettingValue,
    ValueType,
    UpdatedAtUtc
)
VALUES
(
    'Language',
    'en-US',
    'String',
    '1970-01-01T00:00:00Z'
);
Default UI Settings
INSERT OR IGNORE INTO ApplicationSettings
(
    SettingKey,
    SettingValue,
    ValueType,
    UpdatedAtUtc
)
VALUES
(
    'Theme',
    'Default',
    'String',
    '1970-01-01T00:00:00Z'
);
Default Graph Rate
INSERT OR IGNORE INTO ApplicationSettings
(
    SettingKey,
    SettingValue,
    ValueType,
    UpdatedAtUtc
)
VALUES
(
    'GraphRefreshRate',
    '30',
    'Integer',
    '1970-01-01T00:00:00Z'
);
Default Database Version

After initialization:

INSERT INTO SchemaInfo
(
    SchemaVersion,
    ProductVersion,
    CreatedAtUtc,
    UpdatedAtUtc
)
VALUES
(
    '1.1',
    '1.0.0',
    '2026-01-01T00:00:00Z',
    '2026-01-01T00:00:00Z'
);

The actual application should use runtime UTC timestamps rather than the illustrative timestamp above.

Trigger: Updated Test Result

When creating a new current result, previous current results must be cleared.

A controlled transaction is preferred at the service layer.

A trigger may additionally enforce the invariant.

Trigger
CREATE TRIGGER IF NOT EXISTS TR_TestResults_Current
AFTER INSERT ON TestResults
WHEN NEW.IsCurrent = 1
BEGIN

    UPDATE TestResults
    SET IsCurrent = 0
    WHERE TestId = NEW.TestId
      AND TestResultId <> NEW.TestResultId
      AND IsCurrent = 1;

END;
Trigger: Prevent Sample Modification

Measurement samples should be immutable after insertion.

UPDATE Protection
CREATE TRIGGER IF NOT EXISTS TR_TestSamples_NoUpdate
BEFORE UPDATE ON TestSamples
BEGIN
    SELECT RAISE
    (
        ABORT,
        'TestSamples are immutable'
    );
END;
DELETE Protection
CREATE TRIGGER IF NOT EXISTS TR_TestSamples_NoDelete
BEFORE DELETE ON TestSamples
BEGIN
    SELECT RAISE
    (
        ABORT,
        'TestSamples cannot be deleted'
    );
END;
Channel Sample Immutability
CREATE TRIGGER IF NOT EXISTS TR_TestSampleChannelValues_NoUpdate
BEFORE UPDATE ON TestSampleChannelValues
BEGIN
    SELECT RAISE
    (
        ABORT,
        'TestSampleChannelValues are immutable'
    );
END;
Channel Sample Delete Protection
CREATE TRIGGER IF NOT EXISTS TR_TestSampleChannelValues_NoDelete
BEFORE DELETE ON TestSampleChannelValues
BEGIN
    SELECT RAISE
    (
        ABORT,
        'TestSampleChannelValues cannot be deleted'
    );
END;
Event Immutability

Test Events represent traceability and should be immutable.

CREATE TRIGGER IF NOT EXISTS TR_TestEvents_NoUpdate
BEFORE UPDATE ON TestEvents
BEGIN
    SELECT RAISE
    (
        ABORT,
        'TestEvents are immutable'
    );
END;
Event Delete Protection
CREATE TRIGGER IF NOT EXISTS TR_TestEvents_NoDelete
BEFORE DELETE ON TestEvents
BEGIN
    SELECT RAISE
    (
        ABORT,
        'TestEvents cannot be deleted'
    );
END;
Calibration Point Protection

Completed calibration points should not be modified.

The application may allow editing while CalibrationSession.Status = Draft.

After completion:

Completed

↓

Immutable
Test Result Protection

Historical TestResults should not be modified after finalization.

A controlled recalculation should create a new ResultVersion.

Audit Trigger Strategy

Critical changes may be audited by application services rather than generic SQLite triggers.

This is preferred because the application knows the authenticated user and reason for change.

Migration 001

Migration 001 creates the initial database.

Conceptually:

001_INITIAL_SCHEMA

Operations:

Create SchemaInfo

Create SchemaMigrations

Create Users

Create Roles

Create UserRoles

Create Customers

Create Projects

Create Specimens

Create Methods

Create MethodVersions

Create MethodParameters

Create Sensors

Create LoadCells

Create Extensometers

Create CalibrationSessions

Create CalibrationPoints

Create Tests

Create TestMethodSnapshots

Create TestCalibrationSnapshots

Create TestAcquisitionSnapshots

Create TestSamples

Create TestSampleChannelValues

Create TestEvents

Create TestResults

Create TestResultValues

Create Reports

Create AuditLogs

Create ApplicationSettings

Create MachineSettings

Create Indexes

Create Triggers

Seed Roles
Migration 001 Registration
INSERT INTO SchemaMigrations
(
    MigrationId,
    Version,
    Name,
    AppliedAtUtc
)
VALUES
(
    '001_INITIAL_SCHEMA',
    '1.0',
    'Initial Schema',
    CURRENT_TIMESTAMP
);
Migration 002

Migration 002 upgrades schema 1.0 to 1.1.

Recommended purpose:

Add Processing Version

Add Acquisition Snapshot

Add Result Versioning

Add Audit Improvements

Add Additional Measurement Quality Fields
Migration 002 Example
ALTER TABLE TestResults
ADD COLUMN CalculationVersion TEXT;

If CalculationVersion already exists in the baseline schema, this statement must not be executed.

The actual migration engine must know the exact source schema.

Important Migration Rule

Migration scripts must be written against a specific previous schema.

They must never assume an unknown database state.

Migration 003

Future migration example:

003_ADD_TEMPERATURE_CHANNEL

This demonstrates how future schema expansion is handled without modifying historical migrations.

Migration Immutability

Once a migration is released, its SQL must not be edited.

If correction is required:

New Migration

must be created.

Migration Checksums

The application may calculate SHA-256 checksums for migration files.

Example
Migration

001_INITIAL_SCHEMA

Checksum

A1B2C3...
Migration Execution Algorithm
Load Current Schema Version

↓

Load Available Migrations

↓

Sort By Version

↓

For Each Unapplied Migration

    BEGIN TRANSACTION

    Execute Migration

    Register Migration

    Update SchemaInfo

    COMMIT

↓

Validate Schema
Migration Failure Algorithm
BEGIN

↓

Execute

↓

Error

↓

ROLLBACK

↓

Log Error

↓

Application Safe Mode
Schema Validation

Required tables can be checked using:

SELECT name
FROM sqlite_master
WHERE type = 'table';
Required Table Validation

Expected minimum:

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
Required Index Validation

Indexes may be inspected with:

SELECT name
FROM sqlite_master
WHERE type = 'index';
Required Trigger Validation

Triggers may be inspected with:

SELECT name
FROM sqlite_master
WHERE type = 'trigger';
Database Integrity Validation

Final startup check:

PRAGMA integrity_check;

Expected:

ok
Foreign Key Validation
PRAGMA foreign_key_check;

Expected:

No rows
Schema v1.1 Entity Relationship
Users
 |
 +---- Roles
 |
 +---- AuditLogs
 |
 +---- TestEvents
 |
 +---- Tests
        |
        +---- TestSamples
        |       |
        |       +---- TestSampleChannelValues
        |
        +---- TestEvents
        |
        +---- TestResults
        |       |
        |       +---- TestResultValues
        |
        +---- Reports
        |
        +---- TestMethodSnapshots
        |
        +---- TestCalibrationSnapshots
        |
        +---- TestAcquisitionSnapshots
Method Relationship
Methods

↓

MethodVersions

↓

MethodParameters
Sensor Relationship
Sensors

├── LoadCells
│
└── Extensometers
Calibration Relationship
Sensors

↓

CalibrationSessions

↓

CalibrationPoints
Customer Relationship
Customers

↓

Projects

↓

Tests
Specimen Relationship
Specimens

↓

Tests
Result Relationship
Tests

↓

TestResults

↓

TestResultValues
Report Relationship
Tests

↓

Reports
Database Lifecycle
Create

↓

Configure

↓

Migrate

↓

Validate

↓

Operate

↓

Backup

↓

Archive

↓

Restore
Data Lifecycle
Draft

↓

Test Created

↓

Snapshot

↓

Acquisition

↓

Persistence

↓

Results

↓

Report

↓

Archive
Immutable Data

The following should be immutable after finalization:

TestSamples

TestSampleChannelValues

TestEvents

MethodSnapshot

CalibrationSnapshot

AcquisitionSnapshot
Versioned Data

The following are versioned:

Methods

MethodVersions

TestResults

Reports

Calculations
Audited Data

The following require audit:

Calibration

Methods

Users

Settings

Test Metadata Changes

Result Recalculation

Deletion

Restore
Database Error Codes

Recommended application-level codes:

DB-001

ConnectionFailure

DB-002

MigrationFailure

DB-003

IntegrityFailure

DB-004

WriteFailure

DB-005

ReadFailure

DB-006

TransactionFailure

DB-007

BackupFailure

DB-008

RestoreFailure

DB-009

DiskSpaceLow

DB-010

DatabaseLocked
Database Lock Handling

SQLite lock errors may be retried for a bounded period.

The application must not retry indefinitely.

Lock During Active Acquisition

Database locking must never silently cause raw sample loss.

Recommended Recovery
Detect Lock

↓

Retry

↓

If Persistent

↓

Raise Database Fault

↓

Preserve / Flush Data

↓

Apply Test Safety Policy
Database Performance Baseline

The implementation must be benchmarked using realistic acquisition loads.

Example:

100 Hz

500 Hz

1000 Hz

with representative Test duration.

Example Stress Test
1000 Hz

60 minutes

≈ 3,600,000 samples

The system must remain responsive and maintain data integrity.

Long Test

Example:

1000 Hz

2 hours

≈ 7,200,000 samples

The database architecture must be validated against realistic storage requirements.

Sample Storage Estimate

Actual storage depends on SQLite encoding, indexes and additional channels.

Therefore storage requirements shall be measured rather than assumed.

Database File Monitoring

The application may display:

Database Size

Free Disk Space

Estimated Test Storage

Backup Status
Acceptance Criteria

ARCH-081 is accepted when

Complete SQLite Schema v1.1 is defined.

SchemaInfo exists.

SchemaMigrations exists.

Users table exists.

Roles table exists.

UserRoles table exists.

Customers table exists.

Projects table exists.

Specimens table exists.

Methods table exists.

MethodVersions table exists.

MethodParameters table exists.

Sensors table exists.

LoadCells table exists.

Extensometers table exists.

CalibrationSessions table exists.

CalibrationPoints table exists.

Tests table exists.

TestMethodSnapshots table exists.

TestCalibrationSnapshots table exists.

TestAcquisitionSnapshots table exists.

TestSamples table exists.

TestSampleChannelValues table exists.

TestEvents table exists.

TestResults table exists.

TestResultValues table exists.

Reports table exists.

AuditLogs table exists.

ApplicationSettings table exists.

MachineSettings table exists.

Foreign keys are defined.

Important indexes are defined.

Sample sequence uniqueness is enforced.

Event sequence uniqueness is enforced.

Result version uniqueness is enforced.

Current result uniqueness is enforced.

Measurement samples cannot be updated.

Measurement samples cannot be deleted.

Test events cannot be updated.

Test events cannot be deleted.

Database migrations are versioned.

Migration checksums are supported.

Migration failures roll back.

Database integrity check is supported.

Foreign-key integrity check is supported.

Backup is supported.

Restore is supported.

Disk-space monitoring is supported.

Database lock handling is bounded.

x86 compatibility is preserved.

.NET Framework 4.8 compatibility is preserved.

VB.NET compatibility is preserved.

Architectural Decision (FROZEN)

Schema v1.1 is the authoritative relational structure for the application database.

High-frequency samples use integer primary keys with a unique (TestId, Sequence) constraint.

Raw measurement samples are immutable.

Test Events are immutable.

Method, Calibration and Acquisition configurations used by a Test are preserved through immutable snapshots.

Results are versioned rather than overwritten.

The database uses foreign-key enforcement.

Migration history is immutable and version-controlled.

Database integrity must be validated during startup and recovery.

The application data layer is responsible for all SQLite access.

The domain layer must not depend on SQLite-specific classes.

The schema is designed for VB.NET, WPF, .NET Framework 4.8 and x86 deployment.

This decision is permanent.

Next Chapter

ARCH-082

VB.NET SQLite Infrastructure Layer, DatabaseConnectionFactory, MigrationService, Repository Base, Unit of Work, Transaction Manager, Async Database Writer, Sample Batch Insert, Error Handling & .NET Framework 4.8 x86 Implementation

This chapter will define

VB.NET project structure
SQLite provider integration
DatabaseConnectionFactory
SQLiteConnection configuration
PRAGMA initialization
MigrationService
MigrationRunner
SchemaValidator
DatabaseIntegrityService
RepositoryBase
UnitOfWork
TransactionManager
TestRepository
TestSampleRepository
MethodRepository
CalibrationRepository
ResultRepository
AuditRepository
AsyncSampleWriter
Batch Insert
Queue Integration
Retry Policy
Database Error Mapping
Cancellation
Disposal
Thread Safety
x86 deployment
.NET Framework 4.8 implementation