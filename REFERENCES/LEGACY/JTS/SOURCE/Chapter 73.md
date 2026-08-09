# ARCHITECTURE
# Chapter 73
# Detailed Test Lifecycle State Machine, Start / Stop / Hold / Abort Logic & Failure Recovery

Document ID

ARCH-073

Version

0.1

Status

FROZEN

Related EDR

EDR-078

Depends On

ARCH-053 Test Execution Architecture

ARCH-068 Method Engine

ARCH-069 Machine Controller

ARCH-071 SQLite Database Architecture

ARCH-072 Application Services

---

# Purpose

This chapter defines the complete Test lifecycle state machine for the Universal Testing Machine application.

The state machine controls

```text
Test Preparation

Validation

Machine Readiness

Start

Preload

Running

Hold

Resume

Controlled Stop

Abort

Emergency Stop

Fault

Completion

Recovery

The state machine is the authoritative application model for Test lifecycle transitions.

Core Principle

A Test state transition must never be performed merely because an operator clicked a button.

Every transition requires

Current State

+

Requested Operation

+

Validation

+

Machine State

+

Safety Conditions
State Machine

The conceptual lifecycle is

DRAFT
  |
  v
READY
  |
  v
PREPARING
  |
  v
STARTING
  |
  v
PRELOAD
  |
  v
RUNNING
  |
  +------> HOLDING ------> RUNNING
  |
  +------> STOPPING
  |
  +------> ABORTING
  |
  +------> FAULT
  |
  +------> EMERGENCY_STOPPED
             |
             v
          RECOVERY

Normal completion

RUNNING

↓

STOPPING

↓

FINALIZING

↓

COMPLETED
State List

Baseline states

Draft

Ready

Preparing

Starting

Preload

Running

Holding

Resuming

Stopping

Finalizing

Completed

Aborting

Aborted

Fault

EmergencyStopped

Recovering
DRAFT

The Test exists but is not yet ready for execution.

DRAFT Conditions

Typical conditions

Method Missing

Specimen Missing

Geometry Incomplete

Required Metadata Missing

Machine Not Ready
DRAFT Allowed Actions
Edit Test

Select Method

Edit Specimen

Select Material

Validate
DRAFT Forbidden Actions
Start

Automatic Motion

Result Finalization
READY

The Test has passed all required preparation and validation checks.

READY Conditions
Method Valid

Specimen Valid

Geometry Valid

Machine Connected

Machine Ready

Required Sensors Available

Calibration Valid

Safety Interlocks Valid
READY Actions
Start

Edit Non-Locked Metadata

Cancel
READY Restrictions

Changes affecting execution parameters require re-validation.

PREPARING

This state represents the machine and application preparation sequence.

PREPARING Sequence
Validate Test

↓

Validate Method

↓

Validate Machine

↓

Validate Sensors

↓

Validate Calibration

↓

Initialize Acquisition

↓

Initialize Result Engine

↓

Prepare Controller
PREPARING Failure

If preparation fails

PREPARING

↓

FAULT

or, for a user-correctable validation condition

PREPARING

↓

DRAFT
STARTING

The application has passed preparation and is initiating Test execution.

STARTING Sequence
Start Acquisition

↓

Confirm Controller Ready

↓

Apply Initial Conditions

↓

Start Test Motion
STARTING Failure

If motion cannot start

STARTING

↓

FAULT
PRELOAD

If the active Method requires preload, the Test enters PRELOAD.

PRELOAD Purpose

Preload may be used to

Remove Slack

Stabilize Specimen

Establish Reference

Confirm Load Response
PRELOAD Completion

The Method determines the preload completion condition.

Example

Force >= PreloadForce
PRELOAD Failure

Possible failures

Timeout

Unexpected Force

Sensor Failure

Machine Fault

Result

FAULT
RUNNING

RUNNING is the main Test execution state.

RUNNING Responsibilities

During RUNNING

Acquire Measurements

Calculate Engineering Values

Update Graph

Detect Events

Evaluate Limits

Control Motion

Persist Measurements

Monitor Safety
RUNNING Data Flow
Machine

↓

Measurement Acquisition

↓

Normalization

↓

Engineering Calculations

↓

Result Detection

↓

Graph / UI

↓

Persistence
RUNNING Events

Examples

MeasurementUpdated

YieldDetected

MaximumForceDetected

BreakDetected

LimitReached

MachineFault

CommunicationLost
HOLDING

HOLDING represents a controlled temporary pause.

HOLD Sequence
Operator Request

↓

Validate Hold

↓

Request Machine Hold

↓

Confirm Machine Stopped

↓

Set HOLDING
HOLDING Rules

While HOLDING

No automatic forward motion

Measurements may continue

Graph may continue

Machine state remains monitored
HOLDING Resume
HOLDING

↓

Validate Resume

↓

RESUMING

↓

RUNNING
RESUMING

The application is releasing the hold condition.

RESUMING Validation
Machine Ready

Safety Valid

No Fault

Test Still Valid
RESUMING Failure
RESUMING

↓

FAULT
STOPPING

STOPPING is the controlled normal stop sequence.

STOP Sequence
Stop Request

↓

Request Controlled Stop

↓

Confirm Machine Stopped

↓

Stop Motion Commands

↓

Finalize Acquisition
STOPPING Must Not Immediately Become Completed

The application must confirm that

Machine = Stopped

Acquisition = Finalized

Result Calculation = Complete

before declaring completion.

FINALIZING

FINALIZING performs final Test calculations and persistence.

FINALIZING Sequence
Stop Acquisition

↓

Flush Measurement Buffer

↓

Finalize Result Engine

↓

Calculate Final Results

↓

Validate Results

↓

Persist Results

↓

Persist Events

↓

Write Audit Record
COMPLETED

The Test has successfully completed.

COMPLETED Characteristics
Historical

Read-only

Results Available

Report Available

Export Available
COMPLETED Modification

A completed Test cannot be edited through the normal Test workflow.

ABORTING

ABORTING is the controlled abnormal termination sequence.

ABORT Sequence
Abort Request

↓

Request Stop

↓

Stop Motion

↓

Stop Acquisition

↓

Preserve Available Data

↓

Record Abort Event

↓

Finalize Persistence
ABORTED

The Test ended abnormally by operator or application abort.

ABORTED Data

The system should preserve

Available Measurements

Test Metadata

Method Snapshot

Machine Snapshot

Events

Reason for Abort
ABORTED Results

Partial calculations may be retained but must be clearly identified as incomplete.

FAULT

FAULT represents an abnormal machine/application condition that prevents safe Test continuation.

Fault Sources

Examples

Drive Fault

PLC Communication Loss

Load Cell Failure

Extensometer Failure

Controller Error

Position Limit

Unexpected Machine State

Database Failure

Critical Acquisition Failure
FAULT Behavior

When a critical fault occurs

Automatic Motion

↓

Controlled Stop

where technically possible.

FAULT Transition
RUNNING

↓

FAULT
FAULT Recovery

Recovery requires

Identify Fault

↓

Clear Fault

↓

Validate Machine

↓

Validate Sensors

↓

Determine Test Recoverability
Recoverable Fault

A recoverable fault may allow the Test to continue only if

Machine State Is Safe

Data Integrity Is Valid

Method Allows Continuation

No Safety Boundary Was Violated
Non-Recoverable Fault

If continuation cannot be guaranteed

FAULT

↓

ABORTED
EMERGENCY_STOPPED

This state indicates activation of the emergency-stop condition.

Emergency Stop Principle

The physical emergency stop is authoritative.

The software must never assume that an emergency stop command has physically stopped the machine unless the controller confirms the state.

Emergency Stop Sequence
Emergency Stop Detected

↓

Stop Test Processing

↓

Stop Motion Request if Possible

↓

Set EMERGENCY_STOPPED

↓

Alarm

↓

Preserve Data
Emergency Stop Restrictions

While EMERGENCY_STOPPED

Start = Disabled

Resume = Disabled

JOG = Disabled

Automatic Motion = Disabled
Emergency Recovery

Recovery requires

Emergency Condition Cleared

↓

Machine Controller Reset

↓

Machine State Valid

↓

Safety Interlocks Valid

↓

Operator Confirmation
RECOVERING

RECOVERING is used when the application is restoring a safe known state after an interruption.

Recovery Sources
Application Restart

Unexpected Controller State

Communication Recovery

Database Recovery

Power Interruption
Recovery Sequence
RECOVERING

↓

Read Persistent Test State

↓

Check Machine State

↓

Check Acquisition State

↓

Check Data Integrity

↓

Determine Recovery Path
Recovery Outcomes

Possible outcomes

READY

RUNNING_REQUIRES_OPERATOR_CONFIRMATION

ABORTED

FAULT

The exact available recovery transitions depend on the Test state and safety conditions.

Automatic Test Resume

Automatic resume after application restart is not permitted by default.

Resume Principle

The machine must never automatically resume motion simply because software restarted.

Operator Confirmation

If continuation is technically possible, explicit operator confirmation is required.

State Transition Table
Current State	Request / Event	Result
Draft	Validate	Ready / Draft
Draft	Edit	Draft
Ready	Start	Preparing
Ready	Edit execution parameter	Draft
Preparing	Success	Starting
Preparing	Validation failure	Draft
Preparing	Machine fault	Fault
Starting	Success	Preload / Running
Starting	Failure	Fault
Preload	Condition reached	Running
Preload	Timeout	Fault
Running	Hold	Holding
Running	Stop	Stopping
Running	Abort	Aborting
Running	Fault	Fault
Running	Emergency Stop	EmergencyStopped
Holding	Resume	Resuming
Holding	Stop	Stopping
Holding	Abort	Aborting
Resuming	Success	Running
Resuming	Failure	Fault
Stopping	Success	Finalizing
Stopping	Failure	Fault
Finalizing	Success	Completed
Finalizing	Failure	Fault
Aborting	Success	Aborted
Fault	Recoverable	Recovering
Fault	Non-recoverable	Aborted
EmergencyStopped	Recovery	Recovering
Recovering	Validated	Ready / Aborted / Fault
Completed	Open	Read-only
Aborted	Open	Read-only
State Transition Rules

A transition must be atomic from the application's perspective.

Transition Record

Important transitions should generate TestEvents.

Example

RUNNING -> HOLDING

should create an event containing

Timestamp

PreviousState

NewState

Reason

Operator
State Persistence

The current Test state should be persisted at important lifecycle boundaries.

Persistence Points

At minimum

Test Created

Ready

Running

Holding

Stopping

Finalizing

Completed

Aborted

Fault

EmergencyStopped
Crash Recovery

If the application crashes while

TestState = Running

the next startup must not simply assume the Test completed.

Interrupted Test

The recovery system should identify the Test as potentially interrupted.

Interrupted State

If required by the implementation, an internal persisted status may be introduced:

Interrupted

This state represents

Application Terminated Unexpectedly

and does not imply machine motion status.

Machine State Check

After restart

Read Controller State

↓

Determine Actual Machine State
Critical Rule

Software Test State and Physical Machine State are separate concepts.

Example
Software = Running

Machine = Stopped

is an inconsistency that must be reconciled.

Reconciliation

The Machine Service should report the physical state to the Test Service.

State Reconciliation Example
Expected

Running

Actual

Stopped

↓

Fault / Recovery Required
Communication Loss

Communication loss during Test is a critical event.

Communication Loss Sequence
RUNNING

↓

CommunicationLost

↓

Attempt Controlled Stop

↓

FAULT
Communication Recovery

Restoring communication does not automatically mean the Test can resume.

Load Cell Failure

If the active force sensor becomes invalid

RUNNING

↓

FAULT

unless the Method explicitly defines an alternate safe strategy.

Extensometer Failure

Behavior depends on the Method.

If extensometer data is mandatory

FAULT

If crosshead strain is allowed

Warning

Continue
Position Limit

Unexpected position limit

RUNNING

↓

Controlled Stop

↓

FAULT
Maximum Force Limit

If a configured safety limit is reached

RUNNING

↓

Controlled Stop

↓

FAULT / Completed

The exact result depends on the Method configuration.

Yield Detection

Yield detection is an analytical event, not necessarily a state transition.

Example

RUNNING

↓

YieldDetectedEvent

↓

RUNNING
Maximum Force Detection

Likewise

RUNNING

↓

MaximumForceDetectedEvent

↓

RUNNING
Break Detection

Break detection may trigger normal Test completion if the Method defines break as the endpoint.

RUNNING

↓

BreakDetected

↓

Stopping
Method-Defined Completion

The Test Service must not hard-code one universal completion condition.

The Method determines whether completion occurs at

Break

Target Strain

Target Extension

Specified Load

Specified Displacement

Operator Stop
Safety Limits vs Test Limits

These must remain separate.

Safety Limit

=

Protect machine / specimen / operator

versus

Test Limit

=

Define Test procedure
Example

A Method may specify

Target Strain = 20%

while machine safety specifies

Maximum Force = 250 kN

The safety limit takes precedence.

Safety Precedence
Emergency Stop

>

Safety Fault

>

Machine Protection

>

Test Procedure

>

Operator Convenience
Start Interlocks

Before STARTING

Emergency Stop = Clear

Drive Fault = False

Controller = Connected

Machine = Ready

Load Cell = Valid

Required Extensometer = Valid

Specimen = Valid

Method = Valid

Calibration = Valid

must be confirmed.

JOG During Test

Automatic Test motion and JOG are mutually exclusive.

JOG State Rule
TestState = Running

↓

Jog = Disabled
JOG During Ready
TestState = Ready

Machine = Ready

↓

Jog = Allowed

subject to all machine interlocks.

Stop Priority

Stop requests must not be delayed by UI operations.

Abort Priority

Abort must terminate the Test workflow even if the normal completion path cannot be completed.

Emergency Stop Priority

Emergency stop has the highest priority.

UI Button State

Example

Draft

Start = Disabled
Hold = Disabled
Resume = Disabled
Stop = Disabled
Abort = Disabled
JOG = Machine dependent
READY UI
Start = Enabled
Hold = Disabled
Resume = Disabled
Stop = Disabled
Abort = Disabled
JOG = Enabled
RUNNING UI
Start = Disabled
Hold = Enabled
Resume = Disabled
Stop = Enabled
Abort = Enabled
JOG = Disabled
HOLDING UI
Start = Disabled
Hold = Disabled
Resume = Enabled
Stop = Enabled
Abort = Enabled
JOG = Disabled
FAULT UI
Start = Disabled
Hold = Disabled
Resume = Disabled
Stop = Disabled
Abort = Enabled / Context dependent
Reset Fault = Enabled
JOG = Disabled
EMERGENCY_STOPPED UI
Start = Disabled

Resume = Disabled

JOG = Disabled

Reset = Restricted
COMPLETED UI
Edit = Disabled

Start = Disabled

Report = Enabled

Export = Enabled

Results = Enabled
State Machine Implementation

The state machine should not be implemented as scattered Boolean conditions.

Avoid

If IsRunning AndAlso Not IsFault AndAlso ...

throughout the application.

Preferred Implementation

Use a central TestState model and transition mechanism.

Conceptually

ITestStateMachine
State Machine Operations
CanTransition()

Transition()

GetAvailableActions()
Transition Request

Conceptually

Transition(
    CurrentState,
    RequestedAction
)
Transition Validation

The transition engine verifies

Current State

Allowed Action

Required Conditions

Safety Conditions
State Transition Result

Example

TransitionResult

Success

PreviousState

NewState

Reason

Errors

Warnings
Illegal Transition

Example

Completed -> Start

must be rejected.

Illegal Transition Error

Example

TestCannotStartFromCompletedState
State Machine Testability

Every transition should be unit-testable without hardware.

Transition Tests

Examples

Ready -> Preparing

Preparing -> Starting

Starting -> Preload

Preload -> Running

Running -> Holding

Holding -> Running

Running -> Stopping

Stopping -> Finalizing

Finalizing -> Completed
Failure Tests
Preparing -> Fault

Running -> Fault

Running -> EmergencyStopped

Finalizing -> Fault

Recovery -> Aborted
Event Ordering

Events must be generated in a deterministic order.

Example Start Events
TestValidated

MachinePrepared

AcquisitionStarted

ControllerStarted

TestStateChangedToRunning
Example Completion Events
StopRequested

MachineStopped

AcquisitionStopped

ResultsFinalized

PersistenceCompleted

TestCompleted
Persistence Ordering

The final Completed state must not be persisted before the required result data has been successfully persisted.

Example

Incorrect

Set Completed

↓

Save Results

Correct

Save Results

↓

Commit

↓

Set / Persist Completed

or perform the complete logical operation in one transaction.

Fault Event Ordering

For a critical fault

FaultDetected

↓

Stop Request

↓

Machine State Confirmed

↓

Test State = Fault

where physically possible.

Fault Without Controller Response

If the controller does not respond

FaultDetected

↓

Communication Fault

↓

Emergency / Safety Procedure

according to the machine safety architecture.

Operator Confirmation

Certain recovery operations require explicit operator confirmation.

Examples

Resume After Hold

Recover Interrupted Test

Clear Critical Fault
No Automatic Unsafe Recovery

The application shall never automatically restart machine movement after

Application Crash

Communication Recovery

Emergency Stop

Critical Fault
Test Data During Failure

Failure does not justify deleting available data.

The system shall preserve

Measurements

Events

Method Snapshot

Machine Snapshot

Specimen

Failure Reason

whenever possible.

Partial Results

Partial results must be explicitly marked.

Example

ResultStatus = Partial
Report After Abort

An aborted Test may have a diagnostic report, but it must not appear as a normal successful Test report.

Result Status

Recommended

Complete

Partial

Invalid

NotCalculated
Recovery After Database Failure

If persistence fails during Finalizing

Finalizing

↓

Persistence Fault

↓

Fault

The application must retain unsaved Test data in a recovery mechanism where technically possible.

Recovery Buffer

The implementation should provide a temporary recovery file or equivalent mechanism for critical unsaved Test data.

Recovery File

Example conceptual structure

Recovery
|
+-- Test_<TestId>.recovery
Recovery File Purpose

It protects against

Database Failure

Application Crash

Power Loss

during finalization.

Recovery File Deletion

The recovery file may be deleted only after successful database persistence.

Startup Recovery Scan

At startup

Scan Recovery Directory

↓

Find Incomplete Sessions

↓

Display Recovery Notification
Recovery Notification

Example

An interrupted Test session was detected.

The available Test data can be recovered.

Review before continuing.
Recovery Review

The operator / engineer should be able to inspect

Test ID

Acceptance Number

Last Measurement

Last Known Machine State

Failure Time
Recovery Acceptance

Recovery should require explicit confirmation.

State Machine and Database

The database stores persistent lifecycle state.

The in-memory state machine controls active transitions.

State Synchronization
In-Memory State

↕

Persistent State

must be synchronized at defined lifecycle boundaries.

State Persistence Frequency

Not every measurement requires a Test state database update.

State changes are persisted at lifecycle boundaries.

Measurement Persistence

Measurement persistence is separate from lifecycle-state persistence.

Acceptance Criteria

ARCH-073 is accepted when

All Test lifecycle states are explicitly defined.

Valid transitions are defined.

Invalid transitions are rejected.

Start sequence is defined.

Preload is supported.

Running state is defined.

Hold / Resume is defined.

Controlled Stop is defined.

Abort is defined.

Emergency Stop is defined.

Fault handling is defined.

Recovery is defined.

Crash recovery is defined.

Communication loss is defined.

Sensor failure is defined.

Position limits are defined.

Safety limits have precedence.

JOG is blocked during automatic Test motion.

State changes are traceable.

Critical state changes are persisted.

Completed Tests are immutable.

Partial results are explicitly identified.

Recovery data is preserved.

Automatic unsafe restart is prohibited.

State-machine transitions are unit-testable.

Architectural Decision (FROZEN)

The Test lifecycle shall be controlled by an explicit state machine.

The state machine shall be centralized and testable.

UI buttons shall request state transitions rather than directly modifying Test state.

Machine state and application Test state shall remain separate but synchronized.

Safety conditions have priority over normal Test procedure.

Emergency Stop has priority over all normal Test commands.

Automatic restart after crash, communication recovery or Emergency Stop is prohibited.

All available measurement data shall be preserved during abnormal termination whenever technically possible.

Completed Tests are immutable.

Partial and abnormal Test results must be clearly distinguished from successful completed results.

The final Completed state shall only be reached after the required acquisition, calculation and persistence operations have succeeded.

This decision is permanent.

Next Chapter

ARCH-074

Measurement Acquisition Pipeline, Sensor Normalization, Sampling, Buffering, Real-Time Data Flow & Persistence Worker

This chapter will define

Load Cell Acquisition
Crosshead Encoder
Extensometer
Sampling Frequency
Timestamping
Raw Values
Engineering Values
Sensor Quality
Calibration Application
Unit Conversion
Measurement Buffer
Threading
Queue
Batch Persistence
Data Decimation
Live Graph Data
Raw Data Preservation
Acquisition Failure
Sensor Disconnect
Stale Data
Synchronization
Data Integrity
Measurement Sequence
SQLite Persistence Worker
Recovery Buffer
Performance Limits
High-Speed Acquisition
Test Data Integrity
End of Chapter