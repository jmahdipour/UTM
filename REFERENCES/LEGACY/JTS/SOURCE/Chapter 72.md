# ARCHITECTURE
# Chapter 72
# Application Services, Domain Services, Repository Coordination & Three-Layer Architecture

Document ID

ARCH-072

Version

0.1

Status

FROZEN

Related EDR

EDR-077

Depends On

ARCH-053 Test Execution Architecture

ARCH-067 Engineering Data Model

ARCH-068 Method Engine

ARCH-069 Machine Controller

ARCH-070 WPF HMI

ARCH-071 SQLite Database Architecture

---

# Purpose

This chapter defines the application-service architecture and the three-layer structure of the Universal Testing Machine software.

The architecture must provide a clear separation between

```text
UI

Application Logic

Engineering Domain Logic

Infrastructure

Hardware

Database

The primary objective is to prevent hardware, database and UI concerns from becoming coupled.

Architectural Model

The production application follows

+---------------------------------------------------------+
| Presentation Layer                                      |
|                                                         |
| WPF + MVVM                                              |
+----------------------------+----------------------------+
                             |
                             v
+---------------------------------------------------------+
| Application Layer                                       |
|                                                         |
| Test Services                                           |
| Method Services                                         |
| Report Services                                         |
| Calibration Services                                    |
| Machine Services                                        |
+----------------------------+----------------------------+
                             |
                             v
+---------------------------------------------------------+
| Domain Layer                                            |
|                                                         |
| Test Model                                              |
| Method Model                                            |
| Measurement Model                                       |
| Result Model                                            |
| Engineering Rules                                       |
+----------------------------+----------------------------+
                             |
                             v
+---------------------------------------------------------+
| Infrastructure Layer                                    |
|                                                         |
| SQLite                                                  |
| Fatek / PLC                                             |
| Drive                                                   |
| File System                                             |
| Logging                                                 |
+---------------------------------------------------------+
Layer Terminology

The architecture uses four logical layers.

Presentation

Application

Domain

Infrastructure

The first three constitute the primary application architecture, while Infrastructure provides external implementations.

Dependency Direction

Dependencies shall flow inward.

Presentation
    |
    v
Application
    |
    v
Domain

Infrastructure
    |
    +---- implements Application / Domain interfaces
Forbidden Dependency

The following architecture is prohibited.

View
 |
 +----> SQLite
 |
 +----> PLC
 |
 +----> Fatek
 |
 +----> Drive
Presentation Layer

The Presentation Layer is responsible for

Display

User Input

Commands

Navigation

Formatting

Visualization

Status
Presentation Technologies
WPF

MVVM

VB.NET

.NET Framework 4.8

x86
Presentation Components

Recommended structure

Presentation
|
+-- Views
|
+-- ViewModels
|
+-- Commands
|
+-- Converters
|
+-- Controls
|
+-- Themes
|
+-- Resources
View Responsibility

Views define

Layout

Bindings

Templates

Visual States

Styles

Views do not implement engineering algorithms.

ViewModel Responsibility

ViewModels coordinate user interaction with application services.

ViewModel Example
TestViewModel
    |
    +-- TestService
    +-- MachineService
    +-- MethodService
    +-- GraphService
Application Layer

The Application Layer coordinates complete business operations.

It answers questions such as

How is a Test started?

How is a Method loaded?

How is a Test completed?

How are results persisted?

How is a report generated?
Application Layer Does Not

The Application Layer should not contain low-level PLC protocol implementation.

Application Services

Baseline services

ITestService

IMethodService

IMachineService

IMeasurementService

IResultService

IReportService

ICalibrationService

IMaterialService

IUserService

IAuditService
Test Service

The Test Service is the central coordinator of Test execution.

ITestService

Conceptual operations

CreateTest()

LoadTest()

ValidateTest()

PrepareTest()

StartTest()

HoldTest()

ResumeTest()

StopTest()

AbortTest()

CompleteTest()

GetTestResults()
Create Test

The Test Service creates a new Test session.

Workflow

Create Test

↓

Assign TestId

↓

Enter Metadata

↓

Select Method

↓

Select Material

↓

Add Specimen

↓

Validate
Prepare Test

Preparation verifies

Method

Machine

Sensors

Specimen

Calibration

Controller

Safety State
Prepare Test Result

Possible result

Ready

or

NotReady

with detailed validation messages.

Start Test

StartTest shall not simply send a Start command to the controller.

It must execute the complete application workflow.

Validate

↓

Snapshot Configuration

↓

Initialize Acquisition

↓

Initialize Result Engine

↓

Set Controller State

↓

Start Motion / Test

↓

Set Test State = Running
Hold Test

Hold shall

Request Controlled Hold

↓

Confirm Controller State

↓

Pause Applicable Acquisition Processing

↓

Set Test State = Holding
Resume Test

If supported

Validate Resume Conditions

↓

Release Hold

↓

Set Test State = Running
Stop Test

Normal stop

Request Controlled Stop

↓

Wait for Controller Confirmation

↓

Finalize Acquisition

↓

Calculate Results

↓

Persist Test

↓

Set Completed / Stopped State
Abort Test

Abort is different from normal completion.

Abort Request

↓

Stop Motion

↓

Terminate Acquisition

↓

Preserve Available Data

↓

Record Abort Event

↓

Set Test State = Aborted
Test Completion

The Test Service coordinates

Acquisition

Detection

Calculation

Persistence

Report Availability
Method Service

The Method Service manages Test Methods and Method Versions.

IMethodService

Conceptual operations

GetActiveMethods()

GetMethod()

GetMethodVersion()

CreateMethod()

CreateMethodVersion()

ValidateMethod()

ApproveMethodVersion()

DeactivateMethod()
Method Validation

Validation occurs before a Method can be executed.

Method Validation Categories
Required Fields

Engineering Values

Sensor Compatibility

Machine Compatibility

Standard Compatibility

Speed Limits

Load Cell Capacity

Extensometer Compatibility
Machine Service

The Machine Service provides the application-level abstraction over the physical machine.

IMachineService

Conceptual operations

Connect()

Disconnect()

GetStatus()

ResetFault()

Prepare()

StartMotion()

StopMotion()

Hold()

Resume()

JogUp()

JogDown()

StopJog()
Machine Service Boundary

The Machine Service does not know whether the underlying implementation is

Fatek

Simulation

Another Controller
Controller Interface

Conceptually

IMachineController
Implementations
FatekMachineController

SimulationMachineController
Controller Dependency
MachineService
      |
      v
IMachineController
      |
      +----> FatekMachineController
      |
      +----> SimulationMachineController
Measurement Service

The Measurement Service manages acquisition and engineering-value normalization.

IMeasurementService

Conceptual operations

StartAcquisition()

StopAcquisition()

GetLatestMeasurement()

Subscribe()

GetMeasurementBuffer()
Measurement Flow
Hardware

↓

Controller

↓

Acquisition Service

↓

Measurement Normalizer

↓

Measurement Buffer

↓

Application

↓

Persistence Worker

↓

SQLite
Acquisition Independence

The measurement acquisition frequency must not be dictated by the WPF rendering frequency.

Result Service

The Result Service calculates and manages Test results.

IResultService

Conceptual operations

Initialize()

ProcessMeasurement()

DetectYield()

DetectMaximum()

DetectBreak()

CalculateYoungsModulus()

CalculateElongation()

CalculateFinalResults()

ValidateResults()
Standard-Specific Calculations

The Result Service may delegate calculations to standard-specific engines.

Example

ISO6892ResultEngine

ASTME8ResultEngine

ASTME111ResultEngine
Calculation Architecture
IResultService
       |
       v
IStandardResultEngine
       |
       +---- ISO6892
       +---- ASTME8
       +---- ASTME111
Result Engine Principle

The Result Engine receives normalized engineering data.

It should not read PLC registers directly.

Yield Detection

The yield detection engine may support

Rp0.2

Rp0.1

Rt0.5

ReH

ReL

according to the active Method and Standard.

Young's Modulus

Young's modulus calculation shall be implemented through the applicable calculation engine.

For ASTM E111, the result engine must use the defined stress-strain region and calculation procedure configured for that Method.

Report Service

The Report Service converts Test results into a report.

IReportService

Conceptual operations

Generate()

Preview()

Save()

GetReport()

ExportPdf()

ExportCsv()

ExportXml()
Report Flow
Completed Test

↓

Results

↓

Report Model

↓

Template

↓

Renderer

↓

PDF / Other Output
Report Does Not Recalculate

The report layer should consume validated Test results.

It must not independently recalculate engineering results in a way that could produce different values.

Export Service

CSV/XML export shall use the normalized Test model.

Export Consistency

Exported data must correspond to the same historical Test snapshot used for the report.

Calibration Service

Calibration remains independent from normal Test execution.

ICalibrationService

Conceptual operations

CreateCalibrationSession()

AddCalibrationPoint()

CalculateCalibration()

ValidateCalibration()

ApproveCalibration()

GetCurrentCalibration()

GetCalibrationHistory()
Calibration Workflow
Select Sensor

↓

Select Reference

↓

Collect Points

↓

Calculate Curve

↓

Validate

↓

Approve

↓

Activate
Calibration and Test Separation

The Test Service must consume calibration information.

It must not modify calibration.

Material Service

The Material Service manages the Material Library.

IMaterialService

Conceptual operations

GetMaterials()

GetMaterial()

CreateMaterial()

UpdateMaterial()

DeactivateMaterial()
User Service

The User Service manages authentication and authorization.

IUserService

Conceptual operations

Login()

Logout()

GetCurrentUser()

HasPermission()

CreateUser()

DeactivateUser()
Authorization

Permission checks must occur at the service boundary.

Audit Service

The Audit Service records traceable actions.

IAuditService

Conceptual operations

Write()

RecordTestStart()

RecordTestCompletion()

RecordMethodChange()

RecordCalibration()

RecordConfigurationChange()
Service Coordination

A complex operation should be coordinated by one application service.

Example

ITestService.StartTest()

rather than requiring the ViewModel to call

MachineService

MeasurementService

ResultService

AuditService

independently.

Why

This prevents the UI from becoming the business-process coordinator.

Start Test Coordination

Conceptually

TestService.StartTest()

    |
    +--> Validate Test
    |
    +--> MethodService.Validate
    |
    +--> MachineService.Prepare
    |
    +--> MeasurementService.Start
    |
    +--> ResultService.Initialize
    |
    +--> AuditService.Record
    |
    +--> MachineService.Start
Completion Coordination
TestService.CompleteTest()

    |
    +--> Stop Acquisition
    |
    +--> Finalize Result Engine
    |
    +--> Calculate Final Results
    |
    +--> Validate Results
    |
    +--> Persist Test
    |
    +--> Audit
Transaction Boundary

The application service determines the logical transaction boundary.

Persistence Transaction

Example

Complete Test

↓

Begin Database Transaction

↓

Update Test

↓

Insert Result

↓

Insert Metrics

↓

Insert Events

↓

Insert Audit

↓

Commit
Hardware Transaction

Hardware operations are not database transactions.

They require state confirmation and error handling.

Hardware Failure During Start

Example

Machine Prepare

↓

Failure

↓

Do Not Start Acquisition

↓

Set Test State = Fault

↓

Record Event
Acquisition Failure

If acquisition is lost during Test

Detection

↓

Controlled Stop

↓

Preserve Available Data

↓

Record Fault

↓

Finalize Test as Fault / Aborted
Service Error Model

Application services should return structured results or throw controlled application exceptions.

Exception Categories

Example

ValidationException

MachineException

MeasurementException

CalculationException

PersistenceException

ReportException

AuthorizationException
Engineering Validation Error

Example

InvalidGaugeLengthException
Machine Error

Example

MachineNotReadyException
ControllerCommunicationException
DriveFaultException
Persistence Error

Example

DatabaseUnavailableException
DatabaseMigrationException
Error Translation

Infrastructure exceptions must be translated at the Infrastructure/Application boundary.

Logging

Exceptions must be logged with sufficient technical context.

Operator Message

Technical exception details should not necessarily be shown directly to the operator.

Example

Technical

SQLite error code 5

Operator message

The Test data could not be saved because the database is busy.

The Test data has been preserved in the current session.
Validation Pipeline

A Test must pass validation before execution.

Test Validation

↓

Method Validation

↓

Machine Validation

↓

Sensor Validation

↓

Specimen Validation

↓

Safety Validation

↓

READY
Validation Result

A validation result should contain

IsValid

Errors

Warnings
Warning vs Error

Warning

Can continue

Error

Cannot continue
Example Warning
Extensometer is not selected.

The Test may continue only if the Method permits crosshead-based strain.
Example Error
25 ton load cell is required by the Method but is not available.
Command Pipeline

UI commands should follow

User Action

↓

Command

↓

ViewModel

↓

Application Service

↓

Validation

↓

Operation

↓

State Update

↓

UI Notification
Event Pipeline

Important runtime events should follow

Hardware / Domain Event

↓

Application Event

↓

ViewModel Notification

↓

UI
Example
YieldDetected

↓

ResultService

↓

TestViewModel

↓

Graph Marker
Event Bus

A lightweight application event mechanism may be used.

It must not become an uncontrolled global dependency.

Preferred Events

Events should represent meaningful application concepts.

Examples

TestStartedEvent

TestHeldEvent

TestCompletedEvent

MeasurementUpdatedEvent

YieldDetectedEvent

MachineFaultEvent
Event Payload

Example

YieldDetectedEvent

TestId

SpecimenId

Force

Stress

Strain

Timestamp
Threading Model

The application has several logical execution contexts.

UI Thread

Acquisition Thread

Persistence Worker

Background Calculation

Report Worker
UI Thread

Responsible only for UI work.

Acquisition Thread

Responsible for receiving measurement data.

Persistence Worker

Responsible for database writes.

Calculation Worker

May perform expensive calculations asynchronously when appropriate.

Report Worker

May generate reports without blocking the UI.

Thread Safety

Shared mutable state must be controlled.

Measurement Buffer

The measurement buffer must be thread-safe.

Recommended Pattern
Producer

↓

Concurrent / synchronized buffer

↓

Consumer
Backpressure

If the persistence worker falls behind, the application must detect the condition.

Backpressure Policy

The system should not silently discard engineering data.

Persistence Queue

A controlled queue may be used.

Measurement

↓

Queue

↓

Batch Writer

↓

SQLite
Queue Failure

If the queue cannot accept data, the system must trigger a controlled fault condition rather than silently continuing.

Application State

A centralized application state model should be used.

State Components
MachineState

TestState

ConnectionState

UserState

AcquisitionState
State Combination

Example

Machine = Ready

Connection = Connected

Test = Ready

Acquisition = Stopped

allows

Start Test
Invalid Combination
Machine = Fault

Test = Ready

must still prevent Start.

State Authority

The machine controller is authoritative for actual machine state.

The application maintains a synchronized representation.

Test State Authority

The Test Service is authoritative for application Test lifecycle state.

Measurement State Authority

The Measurement Service is authoritative for acquisition state.

Synchronization

The application must reconcile unexpected controller states.

Example

If the drive reports Stop while the application believes the Test is Running

Controller Event

↓

MachineService

↓

TestService

↓

Test State Reconciliation

↓

Event / Alarm
Dependency Injection

Services shall receive dependencies through constructors.

Example

Conceptually

TestService(
    ITestRepository,
    IMethodService,
    IMachineService,
    IMeasurementService,
    IResultService,
    IAuditService
)
No Service Locator

A hidden global Service Locator should not be the primary dependency mechanism.

Composition Root

All concrete service implementations should be assembled in one composition root.

Composition Root

Conceptually

Application Startup

↓

Register Services

↓

Register Repositories

↓

Register Controller

↓

Register Database

↓

Create MainWindow
Hardware Selection

The machine controller implementation should be selected through configuration.

Example

ControllerMode = Fatek

or

ControllerMode = Simulation
Production Configuration

Production shall select the physical machine implementation.

Development Configuration

Development may select simulation.

Simulation

Simulation must expose the same interface as the production controller.

Testability

This enables unit testing of the application layer without physical hardware.

Unit Test Example
Given

Machine = Ready

Method = Valid

Specimen = Valid

Calibration = Valid

When

StartTest()

Then

TestState = Running
Failure Test
Given

Machine = Fault

When

StartTest()

Then

Start is rejected
Method Compatibility Test
Given

Method requires 25T load cell

Machine has 10T load cell

When

ValidateTest()

Then

Validation fails
Persistence Test
Complete Test

↓

Repository Save

↓

Database contains Test

↓

Database contains Result

↓

Database contains Metrics
Integration Test

Hardware integration tests shall use

SimulationController

where physical hardware is unavailable.

Physical Integration

Physical machine testing shall be a separate controlled test category.

Service Naming

Names should describe business responsibilities.

Preferred

TestService

rather than

Manager
Helper
Utility
Manager Restriction

Generic classes named

Manager

Helper

Handler

should not become catch-all business components.

Domain Services

Domain services contain engineering rules that do not naturally belong to one entity.

Examples

YieldDetectionService

StressCalculationService

StrainCalculationService

YoungsModulusService

SpecimenGeometryService
Domain Service Example
SpecimenGeometryService

CalculateArea()

CalculateStress()

ValidateGeometry()
Separation

Domain services do not access WPF or SQLite.

Domain Calculation Flow
Measurement

+

Specimen Geometry

↓

StressCalculationService

↓

Stress
Result Calculation Flow
Measurement Dataset

+

Method Parameters

+

Standard

↓

Result Engine

↓

Result Metrics
Repository vs Domain

Repositories answer

What is stored?

Domain services answer

What does the engineering data mean?

Application services answer

What operation should happen?

Presentation answers

How does the operator interact with it?
Service Boundary Example
Operator clicks Start

↓

TestViewModel

↓

ITestService.StartTest()

↓

Validation

↓

MachineService

↓

MeasurementService

↓

ResultService

↓

MachineController

↓

Physical Machine
No Shortcut

The ViewModel must not bypass TestService and call MachineController directly for automatic Test execution.

JOG Exception

JOG is a direct operational command but still must pass through the Machine/Application service boundary.

JogViewModel

↓

IMachineService.JogUp()

↓

IMachineController.JogUp()
JOG Safety

The Machine Service must enforce

Connection

Machine Ready

No Automatic Test

No Emergency Stop

No Drive Fault

Interlock

before allowing JOG.

Report Independence

Report generation shall not modify Test engineering results.

Calibration Independence

Calibration approval shall not modify historical Test measurements.

Material Independence

Changing a Material Library record must not alter historical Test snapshots.

Method Independence

Creating a new Method Version must not modify existing Tests.

Service Lifecycle

Recommended service lifetimes

Application-wide

Test-session

Operation-scoped
Application-wide

Examples

Logging

Configuration

Database Factory
Test-session

Examples

TestService

MeasurementSession

ResultEngine
Operation-scoped

Examples

ReportGeneration

ExportOperation

DatabaseTransaction
Resource Disposal

Hardware communication objects, database connections and file streams must be disposed correctly.

Shutdown

Application shutdown shall follow

Stop Test if Required

↓

Stop Acquisition

↓

Stop Background Workers

↓

Disconnect Controller

↓

Flush Logs

↓

Close Database
Unsafe Shutdown

The application must warn before exiting while

Test Running

Machine Moving

Unsaved Test
Recovery

If the application crashes during a Test, the next startup should detect an incomplete session where possible.

Recovery Record

A Test left in

Running

at crash time may be reconciled as

Interrupted

or

Aborted

according to the recovery policy.

Data Preservation

Available measurements should be preserved whenever possible.

Audit on Recovery

Recovery should create an AuditLog entry.

Acceptance Criteria

ARCH-072 is accepted when

Presentation Layer is isolated.

Application Layer is defined.

Domain Layer is defined.

Infrastructure Layer is isolated.

Dependencies flow inward.

ViewModels do not directly access hardware.

ViewModels do not directly access SQLite.

TestService coordinates Test execution.

MethodService manages Method versions.

MachineService abstracts machine control.

MeasurementService abstracts acquisition.

ResultService manages engineering calculations.

ReportService manages report generation.

CalibrationService remains independent.

MaterialService manages Material Library.

UserService manages permissions.

AuditService provides traceability.

Application transactions are coordinated centrally.

Hardware errors are translated.

Database errors are translated.

Validation occurs before Test execution.

Threading responsibilities are separated.

Measurement buffering is defined.

Persistence workers are defined.

Simulation controller is supported.

Dependency injection is supported.

Physical hardware is replaceable by simulation.

JOG passes through the Machine Service.

Shutdown sequence is controlled.

Crash recovery is defined.

Historical data remains immutable.

Architectural Decision (FROZEN)

The application shall use a layered architecture consisting of Presentation, Application, Domain and Infrastructure layers.

Application Services shall coordinate complete business operations.

The Test Service is the primary coordinator of the Test lifecycle.

Machine control shall be accessed only through the Machine Service and controller abstraction.

Measurement acquisition shall remain independent from WPF rendering.

Engineering calculations shall remain in Domain / Result services.

SQLite access shall remain in Infrastructure repositories.

The UI shall never become the owner of business workflows.

Dependency Injection shall be used to assemble services and implementations.

The physical machine controller shall be replaceable by a simulation controller without changing the Presentation Layer.

JOG shall remain available through the Machine Service while respecting all safety and machine-state constraints.

Historical engineering data shall remain immutable.

This decision is permanent.

Next Chapter

ARCH-073

Detailed Test Lifecycle State Machine, Start/Stop/Hold/Abort Logic & Failure Recovery

This chapter will define

Test States
State Transitions
Entry Conditions
Exit Conditions
Start Sequence
Preload
Hold
Resume
Stop
Abort
Emergency Stop
Drive Fault
PLC Communication Loss
Sensor Failure
Extensometer Failure
Load Cell Failure
Limit Detection
Break Detection
Yield Detection
Completion Criteria
Recovery
Crash Recovery
State Persistence
Event Ordering
State Validation
Safety Interlocks
State Transition Table
Failure Matrix
Operator Messages
Test Finalization
End of Chapter