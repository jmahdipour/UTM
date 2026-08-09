# ARCHITECTURE
# Chapter 62
# Application Service Layer & Domain Service Architecture

Document ID

ARCH-062

Version

0.1

Status

FROZEN

Related EDR

EDR-067

Depends On

ARCH-023 Database Architecture

ARCH-045 Communication Architecture

ARCH-053 Test Execution Architecture

ARCH-056 Engineering Detection & Mechanical Property Algorithms

ARCH-058 User, Role, Security & Authorization

ARCH-060 WPF / MVVM UI Architecture

ARCH-061 Navigation & Operator Workflow

---

# Purpose

This chapter defines the Application Service and Domain Service architecture for the Universal Testing Machine software.

The Service Layer provides the controlled boundary between

```text
UI

↓

Application Services

↓

Domain Services

↓

Repositories / Hardware Services

It prevents ViewModels from directly accessing databases, hardware, calculations or other infrastructure components.

Philosophy

The Service Layer is the application orchestration boundary.

It coordinates operations but does not become a replacement for the Domain Model.

The architecture separates

Application Service

↓

What operation should happen?

from

Domain Service

↓

How is domain behavior performed?

and

Repository / Infrastructure

↓

Where is data or hardware accessed?
Architecture
+--------------------------------------------------+
|                    WPF UI                        |
+--------------------------------------------------+
                       |
                       v
+--------------------------------------------------+
|              Application Services               |
+--------------------------------------------------+
                       |
                       v
+--------------------------------------------------+
|                Domain Services                  |
+--------------------------------------------------+
             |                         |
             v                         v
+-----------------------+   +---------------------+
|     Repositories      |   | Hardware Services   |
+-----------------------+   +---------------------+
             |                         |
             v                         v
        SQLite DB                 HAL / PLC / DAQ
Responsibilities

Application Services SHALL

Coordinate application operations
Validate authorization
Manage transactions
Coordinate repositories
Coordinate domain services
Publish application events
Create Audit Events
Return application-level results

Domain Services SHALL

Implement domain behavior
Perform engineering/business rules
Remain independent from WPF
Remain independent from SQLite
Remain independent from specific hardware
SHALL NOT

Application Services SHALL NOT

Contain WPF controls
Access XAML
Manipulate UI elements
Implement SQL
Contain raw PLC register logic

Domain Services SHALL NOT

Depend on WPF
Depend on ViewModels
Depend on SQLite-specific APIs
Directly manipulate UI
Service Categories

The initial service architecture includes

TestService

MethodService

MaterialService

SpecimenService

MeasurementService

MotionService

CalculationService

AcceptanceService

CalibrationService

ReportService

AuditService

SecurityService

StandardsService

ConfigurationService
Service Interfaces

Services shall normally be accessed through interfaces.

Examples

ITestService

IMethodService

IMaterialService

ISpecimenService

IMeasurementService

IMotionService

ICalculationService

IAcceptanceService

ICalibrationService

IReportService

IAuditService

ISecurityService

IStandardsService

IConfigurationService
Dependency Direction

The preferred dependency direction is

UI

↓

Application Services

↓

Domain Services

↓

Domain Models

↓

Interfaces

Infrastructure implements the interfaces.

Infrastructure Dependency

Concrete infrastructure dependencies are introduced at the Composition Root.

Example

IMotionService

↓

MotionService

↓

IMotionController

↓

LS VS20NL-P1 Adapter

The application service does not know the implementation details of the drive.

Application Service Example

Conceptually

StartTest()

↓

Authorize User

↓

Validate Method

↓

Validate Specimen

↓

Validate Machine

↓

Create Test Session

↓

Initialize Runtime

↓

Start Execution

The service coordinates these operations.

Application Service Contract

A service method should expose an explicit application-level contract.

Example concept

StartTest(
    TestRequest
)

returns

TestStartResult
Request Objects

Complex operations should use request objects.

Example

StartTestRequest

TestId

MethodId

SpecimenId

UserId

This prevents long parameter lists.

Result Objects

Service operations should return structured results.

Example

ServiceResult

Success

ErrorCode

Message

Data
Error Model

Errors should use controlled application error codes.

Examples

METHOD_NOT_FOUND

METHOD_NOT_APPROVED

SPECIMEN_INVALID

MACHINE_NOT_READY

SENSOR_NOT_AVAILABLE

CALCULATION_FAILED

UNAUTHORIZED

DATABASE_ERROR
Exceptions

Exceptions should be reserved for exceptional failures.

Expected validation failures should preferably be represented by structured service results.

Authorization Boundary

Protected application operations shall verify authorization.

Example

Result Override

↓

SecurityService

↓

Permission Check

↓

ResultService

The ViewModel shall not be trusted as the authorization boundary.

Audit Boundary

Important operations shall generate Audit Events at the application-service boundary.

Example

MethodService.Approve()

↓

Approval

↓

AuditService.Record()
Transaction Boundary

Application Services should define transaction boundaries for multi-step database operations.

Example

Create Test

↓

Create Test Session

↓

Create Specimen

↓

Create Method Snapshot

↓

Commit

If a critical operation fails, the transaction should be rolled back where appropriate.

Hardware Transaction

Hardware operations are not database transactions.

A service must not assume

Database Transaction

=

Machine Transaction

Machine state must be coordinated through the Runtime and Hardware Services.

Test Service

ITestService is responsible for application-level Test Session operations.

Typical operations

CreateTest

LoadTest

ValidateTest

StartTest

PauseTest

ResumeTest

StopTest

AbortTest

FinalizeTest

LoadTestHistory
Test Service Workflow
CreateTest

↓

Validate

↓

Prepare

↓

Start

↓

Running

↓

Finalize

↓

Calculate

↓

Evaluate

↓

Complete
Method Service

IMethodService manages Method lifecycle.

Operations

CreateMethod

LoadMethod

EditMethod

ValidateMethod

ApproveMethod

ActivateMethod

DuplicateMethod

ArchiveMethod

ListMethods
Method Versioning

Editing an Active Method shall create a new Method Version.

The Service Layer prevents silent modification of active versions.

Material Service

IMaterialService manages Material Library operations.

Operations

CreateMaterial

EditMaterial

LoadMaterial

CreateMaterialVersion

ArchiveMaterial

SearchMaterials
Specimen Service

ISpecimenService handles specimen definitions.

Operations

CreateSpecimen

ValidateGeometry

CalculateInitialArea

CalculateGeometry

ValidateGaugeLength
Measurement Service

IMeasurementService manages measurement streams and finalized datasets.

Operations may include

StartAcquisition

StopAcquisition

ReadLiveValues

FinalizeDataset

LoadDataset

ValidateDataset

The service does not directly access WPF.

Live Measurement Architecture
DAQ

↓

Hardware Adapter

↓

Measurement Service

↓

Measurement Stream

↓

Test Runtime

↓

UI Subscriber
Motion Service

IMotionService provides controlled machine motion operations.

Examples

JogForward

JogReverse

Stop

MoveToPosition

SetSpeed

GetMotionState
Motion Service Boundary

The Motion Service does not expose raw PLC register operations to the UI.

The UI requests a domain-level operation.

Example

JogForward(speed)

rather than

WriteRegister(...)
Calculation Service

ICalculationService coordinates mechanical-property calculation.

Operations

CalculateResults

RecalculateResults

CalculateProperty

ValidateCalculation
Calculation Service Workflow
Final Dataset

↓

Load Geometry

↓

Load Method

↓

Load Standard Revision

↓

Select Algorithms

↓

Calculate

↓

Validate

↓

Persist Results

↓

Audit
Calculation Isolation

Calculation algorithms remain independent components.

Example

ICalculationService

↓

YieldAlgorithm

YoungsModulusAlgorithm

UTSAlgorithm

ElongationAlgorithm

BreakDetectionAlgorithm
Acceptance Service

IAcceptanceService evaluates finalized engineering results against configured requirements.

Operations

Evaluate

LoadAcceptanceProfile

ValidateAcceptance

GetAcceptanceResult
Acceptance Separation

The Acceptance Service does not recalculate engineering properties.

Calculation

↓

Mechanical Results

↓

Acceptance

↓

PASS / FAIL / WARNING
Calibration Service

ICalibrationService manages calibration workflows.

Operations

CreateCalibration

LoadCalibration

AddCalibrationPoint

CalculateCalibration

ValidateCalibration

ApproveCalibration

ActivateCalibration
Calibration Separation

Calibration shall remain separate from normal Test Execution.

A Test references an approved calibration state.

Standards Service

IStandardsService manages controlled Standard metadata.

Operations

LoadStandard

LoadRevision

ListStandards

ValidateRevision

LoadRequirement

GetComplianceMapping
Standards Integrity

The Standards Service shall not invent requirements.

Controlled Standard metadata must originate from authorized sources.

Report Service

IReportService coordinates report generation.

Operations

GenerateReport

PreviewReport

ExportReport

PrintReport

ApproveReport

The Report Service consumes finalized Results.

Report Calculation Rule

The Report Service shall not independently recalculate engineering properties.

Calculation Service

↓

Final Results

↓

Report Service
Audit Service

IAuditService provides controlled audit operations.

Operations

RecordEvent

RecordChange

RecordApproval

RecordSignature

SearchAudit

ExportAudit
Security Service

ISecurityService provides

Authenticate

Authorize

GetCurrentUser

ValidateSession

RequirePermission

SignIn

SignOut
Configuration Service

IConfigurationService manages application configuration.

Operations

GetSetting

SetSetting

ValidateSetting

LoadConfiguration

SaveConfiguration

Critical configuration changes shall be permission-controlled and audited.

Service Composition

Services may depend on other service interfaces.

Example

TestService

↓

IMethodService

ISpecimenService

IMeasurementService

IMotionService

ICalculationService

IAcceptanceService

IAuditService
Circular Dependency Rule

Services shall not create circular dependencies.

Invalid example

TestService
    ↓
MethodService
    ↓
TestService

Shared domain behavior should be moved to a suitable Domain Service.

Domain Service

A Domain Service contains behavior that does not naturally belong to one entity.

Examples

GeometryCalculationService

YieldDetectionService

ComplianceValidationService

TestReadinessService
Geometry Domain Service

Responsible for geometry mathematics.

Examples

RoundArea

PipeArea

FlatArea

SquareArea

CustomArea
Test Readiness Domain Service

Determines whether required domain conditions are satisfied.

Example

Machine Ready

+

Method Valid

+

Specimen Valid

+

Sensors Available

=

Test Ready
Compliance Domain Service

Determines whether a Method configuration satisfies its configured Standard requirements.

It does not invent normative requirements.

Result Domain Service

Coordinates engineering result consistency.

It may validate

Fmax

UTS

Yield

Elongation

Break

relationships without becoming the individual calculation algorithms.

Repository Boundary

Application Services use repositories through interfaces.

Example

IMethodRepository

ITestRepository

IMaterialRepository

IResultRepository

IAuditRepository
Repository Rule

Repositories SHALL

Load data
Save data
Query data
Delete only where permitted

Repositories SHALL NOT

Decide authorization
Control machine motion
Implement UI behavior
Decide test acceptance
Hardware Repository Separation

Hardware interfaces are not treated as database repositories.

They belong to the Hardware / Infrastructure layer.

Unit of Work

A Unit of Work may be used for operations involving multiple repositories.

Example

ITestRepository

+

ISpecimenRepository

+

IMethodSnapshotRepository

↓

UnitOfWork

↓

Commit
Caching

Services may use caching for relatively static data.

Candidates

Standards

Method Definitions

Material Library

Configuration

Live measurement data should not be treated as ordinary application cache data.

Service Lifetime

Recommended conceptual lifetimes

Application Services

Application Scoped

Runtime Services

Application / Test Session Scoped
Repositories

Application Scoped or Transaction Scoped
ViewModels

Workspace Scoped

Exact lifetime management is defined by the Dependency Injection implementation.

Dependency Injection

The Composition Root registers

Interfaces

↓

Implementations

Example concept

ITestService
    →
TestService

IMethodService
    →
MethodService

IMotionService
    →
MotionService
Testability

Services shall be testable using mock or simulated dependencies.

Example

ITestService

↓

FakeMotionService

FakeMeasurementService

FakeRepository

This allows automated testing without the physical machine.

Simulation

The same application-service interfaces should work with

Real Hardware

Simulation Hardware

Test Doubles
Service Events

Application services may publish domain/application events.

Examples

TestStarted

TestPaused

TestCompleted

ResultCalculated

MethodApproved

CalibrationApproved
Event Rule

Events communicate that something happened.

Commands request that something happen.

The architecture shall not confuse the two.

Example

Command

StartTest

Event

TestStarted
Event Subscribers

Possible subscribers

UI

Audit Service

Notification Service

Report Service

Monitoring

Subscribers shall not alter the original event meaning.

Service Error Propagation

Errors should move upward in a controlled manner.

Infrastructure Error

↓

Domain / Hardware Error

↓

Application Service Error

↓

ViewModel

↓

User Message

Internal stack traces shall not be shown directly to normal operators.

Logging

Application Services may write diagnostic logs.

Audit records remain separate from technical logs.

Diagnostic Log

≠

Audit Trail
Critical Operation Handling

For critical operations such as

StartTest

StopTest

ResultOverride

MethodApprove

CalibrationApprove

the service should use an explicit workflow rather than a sequence of UI-side calls.

Example: StartTest
StartTestRequest

↓

Authorize

↓

Load Method

↓

Validate Method

↓

Load Specimen

↓

Validate Geometry

↓

Check Machine State

↓

Check Sensors

↓

Create Test Session

↓

Initialize Runtime

↓

Audit

↓

Start Motion / Acquisition

↓

Publish TestStarted
Example: FinalizeTest
Stop Acquisition

↓

Finalize Dataset

↓

Validate Dataset

↓

Calculate Results

↓

Validate Results

↓

Evaluate Acceptance

↓

Persist Results

↓

Persist Acceptance

↓

Audit

↓

Publish TestCompleted
Transaction and Failure

If Calculation succeeds but Acceptance persistence fails, the application shall not falsely report the Test as fully completed.

The finalization state must represent the actual persistence state.

Partial Completion

The system may use intermediate states such as

Finalizing

Calculating

Evaluating

Persisting

Completed

CompletionFailed

This provides better recovery behavior.

Service Security

Every service that exposes privileged functionality must perform its own authorization or receive an already validated authorization context from the Application Service boundary.

Service Audit

Critical operations should produce Audit Events only after the relevant operation has passed the appropriate validation stage.

Where required, attempted unauthorized operations may also be audited.

Performance

Services shall avoid unnecessary copying of large measurement datasets.

For large test data

Stream

↓

Process

↓

Persist

should be preferred where practical.

Threading

Application Services may execute asynchronous operations where supported by the .NET Framework 4.8 implementation.

UI-bound operations must return control to the UI thread appropriately.

Thread Safety

Runtime services handling

DAQ

Motion

Test State

Live Measurements

must define their thread-safety behavior explicitly.

Service Contract Versioning

Public service contracts should remain stable.

Breaking changes require a controlled application version update.

Service Naming

Service names should describe business capability.

Preferred

TestService
CalculationService
MethodService

Avoid vague names such as

Manager
Helper
Utility
CommonService

unless the responsibility is genuinely generic.

Service Directory

Recommended project structure

Application
│
├── Services
│   ├── Test
│   ├── Methods
│   ├── Materials
│   ├── Specimens
│   ├── Measurement
│   ├── Calculation
│   ├── Acceptance
│   ├── Calibration
│   ├── Reports
│   ├── Standards
│   ├── Security
│   ├── Audit
│   └── Configuration
│
├── Contracts
│
└── DTOs
Domain Directory
Domain
│
├── Entities
├── ValueObjects
├── Services
├── Algorithms
├── Rules
└── Events
Infrastructure Directory
Infrastructure
│
├── Persistence
├── Hardware
├── Communication
├── Reporting
├── Security
└── Logging
Dependency Direction

The preferred dependency graph is

Presentation
      ↓
Application
      ↓
Domain
      ↑
Infrastructure

Infrastructure implements interfaces defined by Application / Domain where appropriate.

Forbidden Dependency

The following dependency is forbidden

Domain

↓

WPF

Also forbidden

ViewModel

↓

SQLiteConnection

and

ViewModel

↓

PLC Register
Architectural Decision (FROZEN)

Application Services form the controlled orchestration boundary between the WPF UI and the underlying domain, persistence and hardware layers.

Domain Services contain reusable business and engineering behavior independent of WPF, SQLite and specific hardware.

Repositories provide persistence access.

Hardware Services provide machine access.

Authorization and Audit are enforced at controlled service boundaries.

No ViewModel shall directly access the database or machine hardware.

No Domain Service shall depend on WPF.

No service shall expose raw PLC register manipulation as an operator-level application operation.

This decision is permanent.

Next Chapter

ARCH-063

Repository, SQLite & Persistence Architecture

This chapter will define

Repository Pattern
SQLite
Database Context
Connection Management
Transactions
Unit of Work
Schema Versioning
Migrations
Test Repository
Method Repository
Material Repository
Result Repository
Audit Repository
Calibration Repository
Large Measurement Data Storage
CSV/XML Interchange
Backup
Restore
Data Integrity
End of Chapter