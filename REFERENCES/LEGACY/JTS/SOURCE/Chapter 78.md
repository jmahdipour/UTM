# ARCHITECTURE
# Chapter 78
# Test Execution State Machine, Test Lifecycle, Controller Commands, Safety Interlocks, Pause/Resume, Fault Handling, Event Logging & Recovery

Document ID

ARCH-078

Version

0.1

Status

FROZEN

Related EDR

EDR-083

Depends On

ARCH-074 Measurement Acquisition Pipeline

ARCH-075 Sensor Architecture

ARCH-076 Calibration Architecture

ARCH-077 Method Engine Architecture

---

# Purpose

This chapter defines the complete Test Execution Engine.

The Test Execution Engine controls the lifecycle of a physical material Test from preparation through completion.

It coordinates

```text
Method

Sensors

Calibration

Controller

Measurement Acquisition

Safety

Feature Detection

Data Recording

Events

Results

Finalization
Core Principle

The Test Execution Engine is a state machine.

The application must never determine Test state from individual UI controls.

The authoritative state belongs to the Test Execution Engine.

Test Execution Architecture
+-----------------------------+
| Test UI                     |
+--------------+--------------+
               |
               v
+-----------------------------+
| Test Execution Engine       |
+------+--------+-------------+
       |        |
       |        |
       v        v
+----------+ +----------------+
| Method   | | Safety Engine  |
| Engine   | +----------------+
+----+-----+
     |
     v
+-----------------------------+
| Controller Service          |
+-------------+---------------+
              |
              v
+-----------------------------+
| PLC / Drive / Machine       |
+-----------------------------+

        ^
        |
+-------+---------------------+
| Measurement Acquisition     |
+-----------------------------+
Test Lifecycle

The normal lifecycle is

CREATED

↓

PREPARING

↓

READY

↓

PRELOAD

↓

RUNNING

↓

COMPLETE

Alternative paths include

RUNNING

↓

PAUSED

↓

RUNNING

and

ANY RUNNING STATE

↓

STOPPING

↓

COMPLETE

and

ANY ACTIVE STATE

↓

FAULT
Primary Test States

The implementation shall support at least

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
State Ownership

Only the Test Execution Engine may change the authoritative Test runtime state.

UI code must request transitions.

Example

UI

↓

RequestStart()

↓

ExecutionEngine

↓

Validate

↓

State = Running
UI Must Not

The UI must not directly execute

PLC Write

Motor Command

State Assignment

Safety Bypass
CREATED

The Test record exists but execution has not started.

CREATED Preconditions

A Test may be Created when

Customer Information

Specimen Information

Method

Geometry

Required Metadata

have been entered sufficiently to create the Test.

CREATED Actions

Allowed

Edit

Save

Delete

Select Method

Select Sensors

Review Geometry
PREPARING

The engine validates all conditions required for execution.

Preparing Checks

At minimum

Method Valid

Method Approved

Method Snapshot Created

Sensor Available

Calibration Valid

Reference Data Available

Controller Connected

Controller Ready

Required Extensometer Available

Geometry Valid

Speed Valid

Clutch Valid

Safety Interlocks Valid

Travel Limits Valid

Load Limits Valid
Preparing Failure

If any required condition fails

PREPARING

↓

FAULT

or the Test remains

CREATED

depending on whether execution has actually begun.

READY

All start conditions have passed.

The machine is ready for the Test.

READY Characteristics
Motor = Stopped

Force = Monitored

Safety = Active

Acquisition = Available

Method = Locked
READY to RUNNING

The operator must explicitly start the Test.

PRELOAD

If the Method defines a preload phase

READY

↓

PRELOAD
PRELOAD Purpose

Preload may be used to

Seat Specimen

Remove Slack

Establish Initial Reference

Stabilize Measurement
PRELOAD Completion

Example

Target Force Reached

AND

Stability Condition Satisfied

then

PRELOAD

↓

RUNNING
PRELOAD Failure

Possible causes

Timeout

Sensor Fault

Controller Fault

Safety Fault

Unexpected Force

Travel Limit
RUNNING

RUNNING is the primary active Test state.

RUNNING Responsibilities

The engine continuously coordinates

Measurement

Control

Method Phases

Safety

Feature Detection

Data Storage

UI Updates
RUNNING Loop

Conceptually

Acquire

↓

Validate

↓

Calibrate

↓

Calculate

↓

Evaluate Method

↓

Evaluate Safety

↓

Generate Control Target

↓

Send Controller Command

↓

Persist Data

↓

Repeat
Acquisition Priority

Safety evaluation must not depend solely on UI refresh rate.

UI Refresh

The UI may receive a reduced / throttled presentation stream.

Example

Hardware Acquisition

1000 samples/s

↓

UI

20-60 updates/s

depending on configuration.

Measurement Persistence

Raw samples should be persisted according to the configured acquisition strategy.

HOLD

HOLD is a controlled state where machine motion is temporarily maintained or stopped according to the Method.

HOLD Use Cases

Examples

Method Hold

Operator Pause Request

Stabilization

Rate Transition

Inspection
HOLD vs PAUSED

HOLD is a Method-defined or controlled execution state.

PAUSED is an operator/system interruption state.

PAUSED

The Test is temporarily suspended.

Pause Requirements

Pause must be implemented according to the machine's safe stopping strategy.

Pause Must Not

Pause must not simply disable the UI.

It must generate an actual controller-level stop / hold command.

Resume

Resume is permitted only if

Safety Valid

Controller Ready

Sensors Valid

Method State Recoverable
Resume Behavior

The Method Engine must know exactly where execution resumes.

Resume Example
Phase = RUNNING

Target = 10 mm/min

Pause

↓

Controlled Stop

↓

Resume

↓

Continue Phase
Resume Is Not Restart

Resume must not reset

Force

Extension

Maximum Force

Yield Detection

Elapsed Time

unless explicitly defined by the Method.

STOPPING

STOPPING is a transitional state.

STOPPING Purpose

The engine safely stops machine motion and finalizes the Test.

STOPPING Sequence
Request Stop

↓

Stop Controller

↓

Verify Motion Stopped

↓

Stop / Finalize Acquisition

↓

Capture Final Sample

↓

Determine Completion Reason

↓

Calculate Results

↓

Finalize Test
COMPLETE

The Test has finished normally or through a controlled stop.

COMPLETE Characteristics
Controller = Stopped

Method = Locked

Raw Data = Preserved

Results = Calculated

Completion Reason = Stored
FAULT

FAULT represents an unsafe, invalid or unexpected execution condition.

Fault Sources
Controller Fault

PLC Communication Fault

Drive Fault

Sensor Fault

Calibration Fault

Safety Interlock

Travel Limit

Load Limit

Software Fault

Data Acquisition Fault
FAULT Priority

Safety-related faults have highest priority.

Fault Transition
ANY ACTIVE STATE

↓

FAULT
Fault Handling

The engine must immediately

Stop / Safely Halt Motion

Record Fault

Record Timestamp

Record State

Record Controller Status

Record Sensor Status

Notify UI
FAULT Does Not Mean Data Loss

Previously acquired raw data must remain preserved.

FAULT Recovery

Recovery depends on fault type.

Possible outcomes

Resume

Controlled Stop

Abort

Require Operator Intervention
ABORTED

ABORTED indicates that the Test cannot or should not continue.

Abort Examples
Emergency Stop

Unrecoverable Controller Fault

Critical Sensor Failure

Safety Violation

Operator Abort
COMPLETE vs ABORTED
COMPLETE

=

Test execution finalized
ABORTED

=

Test terminated without normal completion criteria
Emergency Stop

Emergency Stop is a safety function.

It must not depend on normal application event processing.

Emergency Stop Architecture
Emergency Circuit

↓

Machine Safety System

↓

Drive / Controller


The software should monitor the emergency-stop state but must not be the only mechanism enforcing it.

Emergency Stop Software Response

When detected

Record Event

↓

State = FAULT / ABORTED

↓

Prevent Resume

↓

Require Operator Reset
Emergency Reset

Resetting the emergency-stop circuit must not automatically restart the Test.

Safety Interlocks

The Test Engine must monitor configured safety conditions.

Safety Examples
Emergency Stop

Guard / Door

Upper Travel Limit

Lower Travel Limit

Maximum Force

Maximum Speed

Controller Ready

Sensor Valid

Extensometer Status
Safety Rule

A safety condition may stop execution.

A Method configuration must never disable a mandatory machine safety condition.

Guard Interlock

If a guard / door signal is available

Guard Open

↓

Motion Prohibited
Travel Limits

The system must monitor

Upper Limit

Lower Limit
Travel Limit Response
Limit Detected

↓

Stop Motion

↓

Record Safety Event

↓

FAULT / ABORTED
Maximum Force

The Method may define a maximum force.

The machine may also have a separate hardware safety limit.

Priority
Hardware Safety Limit

>

Software Method Limit
Maximum Speed

The engine must not request a speed above the machine's configured maximum.

Current maximum

500 mm/min
Speed Fault

If the calculated target exceeds the permitted maximum

Control Command = Rejected

↓

Fault / Stop
Controller Command Architecture

The Test Engine communicates with a Controller Service.

Interface

Conceptually

IControllerService
Commands

At minimum

Connect

Disconnect

Enable

Disable

SetSpeed

SetForce

SetPosition

StartMotion

StopMotion

Hold

ResetFault

Only commands actually supported by the current PLC/drive architecture shall be implemented.

Controller Abstraction

The Test Engine must not know

PLC Register Address

Drive Register Address

Communication Protocol Details
Controller Service

The Controller Service translates engineering commands into machine-specific communication.

Example
Method Engine

SetSpeed(10 mm/min)

↓

Controller Service

↓

PLC / Fatek Communication

↓

LS VS20NL-P1

↓

Motor
Existing Communication Constraint

The current system uses the PLC / communication architecture around

Fatek

FaSvr113-14721-en.exe

Autograph_SVR

and

LS VS20NL-P1

The Method Engine must remain independent from these implementation details.

Controller Feedback

The Controller Service should expose

Ready

Running

Stopped

Fault

CurrentSpeed

CurrentPosition

ControllerState

where available.

Command Acknowledgement

Commands should have explicit acknowledgement where the communication layer supports it.

Example
SetSpeed

↓

Command Sent

↓

Controller Acknowledgement

↓

Command Accepted
Command Timeout

If a command is not acknowledged within its configured timeout

ControllerCommunicationFault

must be generated.

Duplicate Command Protection

Repeated commands should not create unintended machine behavior.

Example

Repeated

StartMotion

should not cause multiple independent starts.

Controller State Synchronization

The Test Engine must not assume that a command succeeded merely because it was sent.

Command vs State
Command

=

Request
State

=

Observed Result
Measurement Acquisition

The Test Engine consumes measurements from the Acquisition Service.

Acquisition Health

The engine should monitor

SampleRate

Timestamp

ChannelStatus

DataQuality

CommunicationStatus
Missing Sample

A missing sample must be detected where the configured acquisition protocol permits detection.

Sample Gap

Example

Expected

t0

t1

t2

t3

Received

t0

t1

t3

This creates a detectable gap.

Gap Response

Depending on Method requirements

Warn

Mark Data Quality

Pause

Fault
Timestamp Integrity

Measurement timestamps should originate from the acquisition layer as close to the measurement source as practical.

Time Synchronization

The application should maintain a consistent monotonic timing reference for Test calculations.

Wall Clock vs Measurement Clock
Wall Clock

=

Human-readable timestamp
Monotonic Clock

=

Elapsed Test timing
Test Elapsed Time

Elapsed time must not depend on system clock changes.

System Clock Change

If the operating-system clock changes during a Test, elapsed Test duration must remain consistent.

Data Quality

Every measurement may carry a quality status.

Examples

Good

Warning

Invalid

Missing

OutOfRange
Invalid Measurement

Invalid data must not silently become valid Test results.

Sensor Fault

If a required sensor becomes invalid

RUNNING

↓

FAULT

unless the Method explicitly permits fallback.

Extensometer Failure

If the Method requires an extensometer and it becomes unavailable

Test = Fault

or the configured safe fallback may be used if explicitly defined.

Fallback Source

Fallback is permitted only when

Method Allows Fallback

AND

Fallback Sensor Valid

AND

Measurement Semantics Remain Valid
No Silent Fallback

The engine must record the source change.

Calibration Failure During Test

If the active calibration becomes invalid during a Test, the engine must follow the configured safety/data-integrity policy.

Calibration Snapshot Principle

Normally the Test continues using the immutable calibration snapshot already captured at Test start, while the active calibration state may affect only future Tests.

Test Data

The engine must record

Raw Measurements

Derived Channels

Events

State Changes

Controller Feedback

Method Snapshot

Calibration Snapshot
Event Log

Every significant state or control event should be recorded.

Event Structure
EventId

TestId

Timestamp

State

EventType

Source

Severity

Message

Payload
Event Types

Examples

TestCreated

TestPreparing

TestReady

PreloadStarted

PreloadCompleted

TestStarted

PhaseChanged

SpeedChanged

HoldStarted

HoldCompleted

PauseRequested

Paused

ResumeRequested

Resumed

StopRequested

Stopping

Completed

FaultDetected

SafetyInterlockTriggered

EmergencyStop

ControllerFault

SensorFault

BreakDetected

YieldDetected
Event Severity

Recommended

Info

Warning

Error

Critical
Event Source

Examples

Operator

MethodEngine

Controller

Sensor

Safety

System
Event Payload

Payload may contain structured information.

Example

{
    "speed": 10,
    "unit": "mm/min",
    "phase": "Elastic"
}

The actual implementation may serialize this in SQLite as JSON text.

Event Ordering

Events must be ordered by a reliable sequence number in addition to timestamp.

Event Sequence

Example

1001 TestReady

1002 TestStarted

1003 PhaseChanged

1004 YieldDetected

1005 MaximumForceUpdated

1006 BreakDetected

1007 TestCompleted
Why Sequence Is Required

Two events can share very similar timestamps.

Sequence provides deterministic ordering.

State Transition Log

Every state transition should generate an event.

Example
READY

↓

RUNNING

creates

StateChanged

OldState = READY

NewState = RUNNING
Operator Actions

Operator actions affecting Test execution must be logged.

Examples

Start

Pause

Resume

Stop

Abort
Operator Identity

Where authentication is enabled, the Event must reference the Operator.

Automatic Actions

Automatic engine actions must also be logged.

Example

BreakDetected

↓

AutomaticStop
Automatic Stop Event

The event chain should show

BreakDetected

↓

StopRequested

↓

Stopping

↓

Completed
Test Completion

Completion requires controlled finalization.

Completion Sequence
Motion Stopped

↓

Final Measurement

↓

Final Data Flush

↓

Feature Calculation

↓

Result Calculation

↓

Acceptance Evaluation

↓

Report Data Preparation

↓

Test Lock

↓

Complete
Final Measurement

The final measurement should be captured before the measurement channel is fully closed where technically possible.

Data Flush

Buffered measurement data must be flushed to persistent storage.

Result Calculation

The Method Calculation Engine calculates all required results.

Acceptance Evaluation

Acceptance criteria are evaluated after result calculation.

Test Lock

After finalization, the execution data becomes protected from normal modification.

Post-Test Editing

Administrative metadata may be editable according to permissions.

Measurement and calculated execution data must remain protected.

Test Result Recalculation

If supported, recalculation must create an explicit audit record and preserve the original calculation state.

Test Recovery

The application must support recovery after unexpected termination.

Crash Scenario

Example

RUNNING

↓

Application Crash
Recovery Data

The system should recover

Last Known State

Last Sample Sequence

Last Event Sequence

Method Snapshot

Calibration Snapshot

Controller State

Test Start Time
Recovery Procedure
Application Restart

↓

Detect Open Test

↓

Read Recovery Metadata

↓

Check Controller State

↓

Check Safety State

↓

Determine Recoverability

↓

Require Operator Decision
No Automatic Resume

The application must not automatically resume physical machine motion after a crash.

Safe Recovery

After a crash

Motor Motion = STOPPED / SAFELY HALTED

must be confirmed before recovery proceeds.

Recovery Options

Depending on state

Recover Data

Mark Test Aborted

Continue Analysis

Discard Incomplete Test
Resume After Crash

Automatic physical resume is prohibited.

If continuation is technically supported, it requires explicit operator confirmation and safety revalidation.

Controller Reconnection

After application restart

Connect

↓

Read Controller State

↓

Read Fault State

↓

Read Position

↓

Read Safety State
Unexpected Motion

If the controller reports unexpected motion during recovery

Recovery = Blocked
Test Recovery Record

A Recovery event should be logged.

Recovery Event

Example

ApplicationRestartDetected

PreviousState = RUNNING

RecoveryAction = ABORTED
Stop Behavior

Normal Stop should be controlled.

Stop Sequence
Stop Requested

↓

Controller Stop

↓

Verify Stop

↓

Finalize
Operator Abort

Abort should generate

AbortRequested

AbortReason

ControllerStop

TestAborted
Stop vs Abort
Stop

=

Controlled normal termination
Abort

=

Termination without normal completion
Pause vs Stop

Pause attempts to preserve the Method execution context.

Stop finalizes the Test.

Emergency Stop vs Stop

Emergency Stop is a safety mechanism.

Normal Stop is an application-controlled operation.

Safety Stop

Safety Stop may occur automatically because a configured safety condition has been violated.

Safety Stop Event

Example

SafetyLimitExceeded

↓

StopRequested

↓

Stopping

↓

Aborted
Safety Interlock Evaluation Frequency

Safety evaluation must operate at a sufficiently high rate for the physical system and must not depend solely on WPF UI rendering.

Safety Architecture
Hardware Safety

        +

Controller Safety

        +

Software Safety Monitoring
Software Safety Limitation

Software safety monitoring is supplementary and must not replace hardware safety systems.

Maximum Force Protection

The system should have multiple layers where available.

Hardware Limit

Controller Limit

Software Method Limit
Maximum Travel Protection

Similarly

Hardware Limit

Controller Limit

Software Method Limit
Maximum Speed Protection

Similarly

Drive Limit

Controller Limit

Software Method Limit
Safety Configuration Immutability

Safety-critical configuration must not be casually editable from the normal Method editor.

Test Execution Permissions

Suggested permissions

StartTest

PauseTest

ResumeTest

StopTest

AbortTest

ResetFault
Fault Reset

Resetting a fault must require explicit conditions.

Fault Reset Preconditions
Fault Cause Removed

Safety Valid

Controller Ready

Sensor Valid
No Blind Fault Reset

The application must not repeatedly send ResetFault commands without verifying the cause.

Test Execution Threading

The execution engine must not run inside the WPF UI thread.

Recommended Architecture
UI Thread

↓

ViewModel

↓

Execution Service

↓

Acquisition / Controller Services
UI Responsiveness

A slow controller response must never freeze the UI.

Cancellation

Execution operations should support cancellation.

Cancellation Example
Start Operation

↓

Cancellation Requested

↓

Controlled Stop

↓

Finalize / Abort
Concurrency

Only one physical Test execution may control the machine at a time.

Test Lock

The application should enforce a machine-level execution lock.

Example
Machine State = TEST_RUNNING

A second Test cannot start.

Multi-Window Protection

Opening another Test window must not create a second physical execution session.

Method Lock

Once execution starts

Method Snapshot = Locked
Sensor Lock

Sensor configuration used by the Test must not be changed during execution.

Calibration Lock

Calibration snapshot used by the Test must remain fixed.

Clutch Lock

Clutch configuration must remain fixed during execution.

Geometry Lock

Geometry values used for calculations must not be changed during execution.

Test Runtime Context

Conceptually

TestExecutionContext

contains

TestId

MethodSnapshot

CalibrationSnapshot

SensorConfiguration

GeometrySnapshot

ControllerState

CurrentPhase

CurrentState

StartTime

Sequence
Test Execution Engine Interface

Conceptually

ITestExecutionEngine

with operations

Prepare()

Start()

Pause()

Resume()

Stop()

Abort()

ResetFault()

GetState()

GetContext()
Events

The interface should expose events such as

StateChanged

MeasurementReceived

PhaseChanged

ResultUpdated

FaultOccurred

Completed
State Transition Rules

The following transitions are valid.

CREATED
    |
    v
PREPARING
    |
    v
READY
    |
    v
PRELOAD
    |
    v
RUNNING
Pause Transition
RUNNING

↓

PAUSED

↓

RUNNING
Hold Transition
RUNNING

↓

HOLD

↓

RUNNING
Stop Transition
RUNNING

↓

STOPPING

↓

COMPLETE
Fault Transition
RUNNING

↓

FAULT
Abort Transition
FAULT

↓

ABORTED

or

RUNNING

↓

ABORTED

depending on the cause.

Invalid Transitions

Examples

COMPLETE -> RUNNING

ABORTED -> RUNNING

PAUSED -> START

CREATED -> RESUME

must be rejected.

State Transition Validation

Every transition should be validated by a centralized state machine.

State Transition Error

If an invalid transition is requested

InvalidStateTransition

is generated.

State Transition Example
Current = READY

Request = Resume

Result = Rejected

Reason = ResumeNotAllowedFromReady
Test State Persistence

The current execution state should be persisted.

Persistence Strategy

At important transitions

State

Event

Timestamp

should be persisted immediately.

Measurement Buffer

High-frequency samples may be buffered before database insertion depending on performance requirements.

Data Loss Protection

The buffering strategy must define the maximum acceptable loss in the event of sudden application termination.

SQLite Transaction Strategy

State transitions and important event records should use transactions.

Test Event Transaction

Example

BEGIN

Update Test State

Insert Event

COMMIT
Failure

If transaction fails

State Change = Not Confirmed

The engine must not assume persistence succeeded.

Database Failure During Test

If SQLite becomes unavailable while the machine is moving, the execution engine must follow a defined safety strategy.

Database Failure Strategy

At minimum

Detect

Log if possible

Prevent Silent Data Loss

Controlled Stop if Required
Database Failure Must Not

The system must not continue indefinitely with an unbounded memory buffer.

Memory Buffer Limit

The implementation must define a maximum recoverable in-memory measurement buffer.

Test Data Integrity

Each sample should have

SampleSequence

Timestamp

ChannelValues

Quality
Sample Sequence

Sequence numbers must be monotonically increasing within a Test.

Missing Sequence

A missing sequence should be detectable.

Duplicate Sequence

Duplicate sample sequences should be detected.

Event Sequence vs Sample Sequence

These are independent.

SampleSequence

=

Measurement ordering
EventSequence

=

Execution-event ordering
Test Monitoring UI

The UI should display at least

Current State

Force

Displacement

Speed

Elapsed Time

Current Phase

Maximum Force

Selected Sensor

Method

Safety Status
JOG Controls

JOG controls are separate from normal Test execution.

During an active Test

JOG = Disabled

unless explicitly supported by a safe service mode.

JOG During READY

JOG may be available before Test execution according to machine safety rules.

JOG During FAULT

JOG remains disabled until the fault is safely cleared.

JOG During COMPLETE

JOG may become available after the Test is finalized.

Live Graph

The Test UI may display

Force-Time

Force-Displacement

Stress-Strain

Strain-Time

according to Method configuration.

Graph Source

The graph uses measurement data from the Execution Engine.

Graph Does Not Control Machine

Graph interaction must never modify controller state.

Test Event Timeline

The UI should optionally display

Test Started

Preload Complete

Elastic Phase

Yield Detected

Maximum Force

Break Detected

Test Complete
Event Markers

Important events may appear as graph markers.

Example
Stress

^

|                Fmax
|                 *
|               /   \
|              /     \  Break
|       Yield *       \ *
|          /
|        /
+--------------------------> Strain
Test Completion Report Data

At completion the engine prepares a result context containing

Test Metadata

Method

Standard

Specimen

Geometry

Sensors

Calibration

Maximum Force

Yield

Young's Modulus

Break

Acceptance

Completion Reason
Result Lock

Once finalization completes, calculated results become protected.

Report Generation

Report generation should consume the finalized Test result model.

It must not directly query live hardware.

CSV Export

CSV export must use finalized Test data.

XML Export

XML export must use finalized Test data.

Test Reopen

A completed Test can be reopened for viewing.

It cannot become physically RUNNING again.

Test Duplication

Creating a new Test from an old Test may copy configuration.

It must create a new Test identity.

Historical Integrity

Duplicating a Test must not modify the original Test.

Acceptance Criteria

ARCH-078 is accepted when

Test execution is implemented as a centralized state machine.

UI does not directly control machine state.

CREATED state exists.

PREPARING state exists.

READY state exists.

PRELOAD state exists.

RUNNING state exists.

HOLD state exists.

PAUSED state exists.

STOPPING state exists.

COMPLETE state exists.

FAULT state exists.

ABORTED state exists.

Valid state transitions are explicitly defined.

Invalid state transitions are rejected.

Method Snapshot is locked before execution.

Calibration Snapshot is locked before execution.

Sensor configuration is locked during execution.

Geometry is locked during execution.

Clutch is locked during execution.

Controller communication is abstracted.

Low-level PLC / drive addresses are hidden from Method Engine.

Command acknowledgement is supported where available.

Command timeout is handled.

Controller state is monitored.

Measurement health is monitored.

Sample sequencing is supported.

Safety conditions are monitored.

Emergency stop is treated as a safety function.

Software does not replace hardware safety.

Travel limits are monitored.

Maximum force is monitored.

Maximum speed is monitored.

Sensor faults are handled.

Extensometer faults are handled.

Normal Stop is distinct from Abort.

Pause is distinct from Stop.

Resume is explicit.

Crash recovery is supported.

Automatic physical resume after crash is prohibited.

State changes are persisted.

Important events are logged.

Operator actions are logged.

Automatic actions are logged.

Faults contain cause and context.

Completion reason is stored.

Final measurement is captured where possible.

Buffered data is flushed before finalization.

Results are calculated after acquisition finalization.

Acceptance is evaluated after results.

Finalized execution data is locked.

Completed Tests cannot be restarted physically.

Test duplication creates a new identity.

Architectural Decision (FROZEN)

The Test Execution Engine shall be implemented as a centralized deterministic state machine.

Only the Execution Engine owns the authoritative runtime Test state.

The UI shall request actions but shall never directly control the physical machine.

All machine commands shall pass through the Controller Service.

The Execution Engine shall coordinate Method, Calibration, Sensors, Acquisition, Controller and Safety services.

Safety monitoring shall be independent of WPF UI refresh.

Emergency Stop shall remain a hardware/controller safety function and shall never depend exclusively on software.

No automatic physical motion restart is permitted after application crash or recovery.

Every important state transition and operator action shall be auditable.

Raw measurement data shall remain preserved.

Method, Calibration, Sensor, Geometry and Clutch configuration shall be immutable during active execution.

A Test shall be physically finalized only after motion is stopped, data is flushed and results are calculated.

A completed Test shall never be returned to RUNNING state.

This decision is permanent.

Next Chapter

ARCH-079

Data Acquisition Architecture, High-Speed Sampling, Channel Synchronization, Timestamping, Raw/Processed Data, Buffering, Sample Integrity, Data Quality, Real-Time Graph Pipeline & SQLite Persistence

This chapter will define

Acquisition Service
Channel Architecture
Force Channel
Extension Channel
Displacement Channel
Extensometer Channel
Encoder Channel
Sample Rate
High-Speed Acquisition
Synchronization
Timestamp
Monotonic Clock
Sample Sequence
Raw Data
Calibrated Data
Processed Data
Derived Data
Data Quality
Filtering
Noise
Missing Samples
Duplicate Samples
Buffering
Ring Buffer
Producer/Consumer
Database Writer
SQLite Batch Insert
Transaction Strategy
Crash Recovery
Real-Time Graph
UI Throttling
Data Integrity
Data Retention
CSV Export
XML Export