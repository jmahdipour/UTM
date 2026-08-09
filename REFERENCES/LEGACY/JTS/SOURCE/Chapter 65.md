# ARCHITECTURE
# Chapter 65
# Machine State Machine, Motion Control & Test Runtime Coordination

Document ID

ARCH-065

Version

0.1

Status

FROZEN

Related EDR

EDR-070

Depends On

ARCH-053 Test Execution Architecture

ARCH-064 Hardware Abstraction Layer

ARCH-062 Application Service Layer

ARCH-061 Navigation & Operator Workflow

ARCH-056 Engineering Detection & Mechanical Property Algorithms

---

# Purpose

This chapter defines the state machines and coordination rules between

```text
Machine

Motion

Test Runtime

Measurement Acquisition

Operator

Hardware Abstraction Layer

The objective is to ensure that machine motion, test execution and application state remain synchronized and traceable.

Core Principle

The Machine State and Test State are separate state machines.

Machine State

=

Physical machine condition
Test State

=

Application test workflow

Neither state machine shall silently assume the state of the other.

Overall Architecture
                    Operator
                       |
                       v
                +-------------+
                | Test Service|
                +-------------+
                       |
                       v
                +-------------+
                | Test Runtime|
                +-------------+
                  |         |
                  v         v
          +-----------+  +-------------+
          | Motion    |  | Measurement |
          | Service   |  | Service     |
          +-----------+  +-------------+
                  |         |
                  v         v
                +-------------+
                |     HAL     |
                +-------------+
                       |
                       v
                    Machine
Machine State Machine

The normalized Machine State shall include at least

Disconnected

Connecting

Ready

Idle

Jogging

Running

Paused

Stopping

Stopped

Fault

EmergencyStop

Unknown
Machine State Meaning
Disconnected

No valid communication exists with the machine.

MachineState = Disconnected

No automatic motion command may be issued.

Connecting

The communication layer is establishing or validating communication.

Disconnected
    |
    v
Connecting
Ready

Communication is healthy and required machine information is available.

Connecting
    |
    v
Ready
Idle

The machine is connected and stationary.

Ready
  |
  v
Idle

The exact distinction between Ready and Idle shall remain defined by the hardware capability model.

Jogging

Manual controlled motion is active.

Idle
  |
  v
Jogging
Running

Automatic test motion is active.

Idle
  |
  v
Running
Paused

Motion is intentionally paused while the machine remains under controlled test execution.

Running
   |
   v
Paused
Stopping

A stop command has been issued and the machine has not yet confirmed the final stopped condition.

Running
   |
   v
Stopping
Stopped

The machine has confirmed the stopped condition.

Stopping
   |
   v
Stopped
Fault

A critical hardware or communication condition has been detected.

Any Active State
       |
       v
     Fault
Emergency Stop

Emergency Stop has been detected.

Any State
   |
   v
EmergencyStop

This state has higher priority than normal workflow states.

Unknown

The application cannot reliably determine the physical machine condition.

Communication Lost

or

Invalid Feedback

↓

Unknown
Machine State Priority

Safety-related states have priority.

Conceptually

EmergencyStop
      >
Fault
      >
Unknown
      >
Stopping
      >
Running / Jogging
      >
Paused
      >
Idle
      >
Ready

This priority is logical and does not replace the physical safety system.

Machine State Transitions

Normal startup

Disconnected
    ↓
Connecting
    ↓
Ready
    ↓
Idle
Normal Motion Start
Idle
 ↓
Running

only after the appropriate runtime and hardware validation.

Normal Motion Stop
Running
 ↓
Stopping
 ↓
Stopped
Jog Start
Idle
 ↓
Jogging
Jog Stop
Jogging
 ↓
Stopping
 ↓
Stopped
Fault Transition
Running
   ↓
Fault

The Test Runtime must respond according to the configured fault policy.

Emergency Stop Transition
Running
   ↓
EmergencyStop

The application shall immediately reflect the detected safety condition.

Test State Machine

The Test Runtime shall use a separate Test State.

Recommended states

New

Preparing

Ready

Starting

Running

Paused

Stopping

Finalizing

Calculating

Evaluating

Completed

Aborted

Faulted

Interrupted
New

A Test object has been created but execution preparation has not completed.

Preparing

The Runtime prepares

Method

Specimen

Sensors

Calibration

Measurement

Machine
Ready

All required preconditions have been satisfied.

Starting

The Runtime is executing the controlled transition from Ready to Running.

Running

The Test is actively acquiring data and executing its configured motion strategy.

Paused

Test execution is temporarily paused.

The exact physical behavior is determined by the Motion Controller and Method configuration.

Stopping

The Runtime has requested termination of normal execution.

Finalizing

Acquisition has stopped and the system is completing dataset finalization.

Calculating

Engineering properties are being calculated.

Evaluating

Acceptance criteria are being evaluated.

Completed

The Test has been successfully finalized.

Aborted

The Test was intentionally terminated abnormally.

Faulted

Execution stopped because of a machine, communication, sensor or other critical failure.

Interrupted

The application or operating environment terminated unexpectedly before normal completion.

Test State Transition

Normal flow

New
 ↓
Preparing
 ↓
Ready
 ↓
Starting
 ↓
Running
 ↓
Stopping
 ↓
Finalizing
 ↓
Calculating
 ↓
Evaluating
 ↓
Completed
Pause Flow
Running
   ↓
Paused
   ↓
Running
Abort Flow
Running
   ↓
Stopping
   ↓
Aborted

where the stop was caused by an explicit abnormal termination request.

Fault Flow
Running
   ↓
Faulted
Unexpected Shutdown
Running
   ↓
Interrupted

on next-session recovery if completion cannot be proven.

State Ownership

The Test Runtime owns the Test State.

The Hardware Layer owns normalized Machine State information.

The UI displays these states.

The UI does not directly set them.

State Command Principle

Commands request transitions.

They do not directly assign state.

Example

StartTest()

requests

Ready
 →
Starting

The Runtime then confirms whether the transition is valid.

Invalid Transition

An invalid command must not silently change state.

Example

Completed
   +
StartTest()

shall be rejected.

State Transition Validation

Every transition should validate

Current State

Requested Command

Machine State

Authorization

Safety Preconditions

Method Rules
Start Test Preconditions

Before entering Starting

Test State = Ready

Machine Connected

Machine Safe

No Critical Fault

Method Valid

Specimen Valid

Required Sensors Available

Calibration Valid

Measurement Acquisition Available

User Authorized
Start Sequence
Ready

↓

Start Request

↓

Authorization

↓

Check Machine

↓

Check Sensors

↓

Initialize Acquisition

↓

Initialize Runtime

↓

Issue Motion Command

↓

Confirm Motion Feedback

↓

Running
Motion Confirmation

The Runtime shall distinguish between

Command Accepted

and

Physical Motion Confirmed

A successful communication write is not proof of physical motion.

Running Confirmation

The Runtime should enter Running only when the required conditions have been satisfied according to the hardware capabilities and test strategy.

Start Failure

If motion cannot be confirmed

Starting

↓

Start Failure

↓

Faulted / Aborted

according to the failure classification.

Pause

Pause is an application-level request.

The Runtime coordinates the physical response.

Running

↓

Pause Request

↓

Motion Control

↓

Confirm Appropriate State

↓

Paused
Resume
Paused

↓

Resume Request

↓

Validate Machine

↓

Validate Sensors

↓

Resume Motion

↓

Running
Stop

Normal Stop

Running

↓

Stop Request

↓

Stopping

↓

Controlled Motion Stop

↓

Confirm Stopped

↓

Finalizing
Stop Confirmation

The Runtime should not mark the machine as Stopped solely because a Stop command was sent.

Feedback should confirm the required condition where available.

Abort

Abort is used when normal completion is no longer appropriate.

Example

Operator Abort

Sensor Failure

Critical Runtime Failure
Abort Sequence
Running

↓

Abort Request

↓

Stop Motion

↓

Stop Acquisition

↓

Finalize Partial Dataset

↓

Aborted / Faulted
Fault Handling

Faults are classified.

Possible categories

Communication Fault

Drive Fault

Sensor Fault

Emergency Stop

Runtime Fault

Data Integrity Fault
Fault Response

Generic flow

Fault Detected

↓

Record Fault

↓

Stop / Inhibit Appropriate Operations

↓

Update Machine State

↓

Update Test State

↓

Notify Operator

↓

Await Recovery
Emergency Stop Handling

Emergency Stop has special priority.

EmergencyStop Detected

↓

Update Machine State

↓

Stop Test Workflow

↓

Record Event

↓

Notify Operator

↓

Require Recovery

The software must not attempt to override the physical emergency-stop mechanism.

Emergency Stop Recovery

Recovery shall not automatically restart motion.

Conceptually

EmergencyStop

↓

Physical E-Stop Released

↓

Hardware State Revalidated

↓

Operator Recovery

↓

Machine Ready
Automatic Restart Prohibition

The following is forbidden

EmergencyStop

↓

Automatic Restart
Communication Loss During Test

If communication becomes unreliable during a test

Running

↓

Communication Loss

↓

Unknown / Fault

↓

Runtime Response

The software must not assume that motion has stopped merely because communication has stopped.

Sensor Failure During Test

If a required measurement channel becomes invalid

Running

↓

Sensor Fault

↓

Faulted

unless the Method explicitly defines the channel as non-critical.

Required Sensor

The Method defines which channels are required.

Example

Load Cell = Required

Crosshead Position = Required

Extensometer = Required for E-Modulus
Non-Critical Sensor

A sensor not required for the selected Method may generate a warning rather than terminate the test.

Command Arbitration

Only one logical motion owner may control automatic motion at a time.

Recommended hierarchy

Emergency Stop

↓

Safety / Fault Handling

↓

Test Runtime

↓

Manual JOG
JOG During Test

JOG shall normally be inhibited while an automatic Test is Running.

The exact behavior must be explicitly configured.

JOG During Idle

JOG may be enabled when

Machine = Idle / Stopped

Test = Not Running

and all safety conditions are satisfied.

JOG Authorization

JOG requires the appropriate permission.

JOG Speed Validation
Requested JOG Speed

↓

Configured JOG Limit

↓

Machine Limit

↓

Hardware Capability

↓

Motion Command
Motion Command Queue

Motion commands should not be blindly queued.

For safety-sensitive commands, the Runtime should validate the current state immediately before execution.

Command Cancellation

A pending motion command should be cancellable where possible.

Stop commands should have priority over normal motion commands.

Stop Priority

Conceptually

Emergency Stop
      ↓
Fault Stop
      ↓
Normal Stop
      ↓
Motion Command
Motion Direction

Direction commands shall be explicit.

Forward

Reverse

Stop

The system shall not infer direction from arbitrary numeric sign conventions without a defined hardware mapping.

Position Limits

Motion commands shall respect configured limits.

Possible limits

Minimum Position

Maximum Position

Forward Limit

Reverse Limit
Hardware Limit

Physical limit switches remain the primary protection.

Software position limits provide an additional control layer.

Limit Detection

If a configured limit is reached

Motion

↓

Limit Detected

↓

Stop / Inhibit Direction

↓

Update State
Direction Lock

When a limit is active, movement toward that limit shall be inhibited.

Movement away from the limit may remain available if permitted by the machine safety design.

Test Runtime Timer

The Runtime may maintain

Elapsed Test Time

Pause Duration

Acquisition Duration

Timekeeping shall be based on reliable system timing.

Test Clock

The Test Runtime should maintain a monotonic timing source for elapsed-time calculations where available.

Wall-clock timestamps are retained for traceability.

Test Initialization

Initialization includes

Load Method Snapshot

Load Specimen

Resolve Sensors

Resolve Calibration

Resolve Hardware Configuration

Initialize Acquisition

Initialize Runtime Variables
Runtime Snapshot

At test start the Runtime should capture the relevant configuration.

Examples

Method Version

Material Version

Calibration Version

Hardware Configuration Version

Geometry

Units
Runtime Configuration Immutability

Once the Test is Running, critical configuration should not be silently changed.

Example

Changing

Load Cell

Method

Gauge Length

during Running is prohibited unless the Method explicitly supports such behavior.

Measurement Acquisition

The Runtime coordinates acquisition.

Start Acquisition

↓

Receive Samples

↓

Timestamp / Sequence

↓

Validate

↓

Store

↓

Publish Live Data
Live Data

Live data is optimized for display.

The authoritative dataset remains the persisted acquisition data.

Buffer

A runtime buffer may separate acquisition from UI rendering.

Acquisition Thread

↓

Concurrent Buffer

↓

Processing

↓

UI Update
Backpressure

If UI rendering becomes slower than acquisition, UI updates may be reduced without discarding authoritative raw samples.

Graph Update

The graph may display downsampled or decimated data.

This does not alter the stored dataset.

Runtime Events

The Runtime may publish events such as

MachineStateChanged

TestStateChanged

MeasurementReceived

FaultDetected

LimitReached

TestStarted

TestPaused

TestResumed

TestStopped

TestCompleted
Event Ordering

Events should preserve logical ordering.

Example

TestStarted

↓

MotionStarted

↓

MeasurementAcquisitionStarted

The exact order depends on the actual initialization protocol but must be deterministic.

Runtime Logging

Runtime events should be logged with

Timestamp

Test ID

Previous State

New State

Event

Reason
Runtime Recovery

If the application restarts after an unexpected shutdown

Load Last Test Session

↓

Determine Last Persisted State

↓

Check Hardware State

↓

Mark Session Interrupted if Completion Cannot Be Proven
Recovery Rule

The system shall prefer

Unknown / Interrupted

over falsely assuming

Completed
Test Finalization

Finalization begins only after acquisition is appropriately stopped.

Stopping

↓

Acquisition Stop

↓

Dataset Finalization

↓

Validation
Finalization Validation

The system verifies

Sample Integrity

Required Channels

Dataset Completeness

Time Ordering

Geometry

Method
Calculation Trigger

After valid dataset finalization

Finalizing

↓

Calculating
Calculation Failure

If engineering calculation fails

Calculating

↓

Faulted / CompletionFailed

The raw dataset should remain preserved.

Acceptance Trigger

After successful calculation

Calculating

↓

Evaluating
Acceptance Failure

A failed acceptance evaluation is not necessarily a calculation failure.

Example

Calculation = Valid

Acceptance = FAIL

This is a legitimate completed test result.

Completed State

A Test may enter Completed only when

Dataset Finalized

Calculation Successful

Acceptance Evaluation Completed

Required Persistence Successful
PASS / FAIL

The Test State shall not use PASS / FAIL as its execution state.

Instead

Test State = Completed

Acceptance Status = PASS

or

Test State = Completed

Acceptance Status = FAIL
Aborted Test

An aborted Test shall retain its data where available.

Example

Test State = Aborted

Dataset Status = Partial
Faulted Test

A faulted Test should preserve

Fault Code

Fault Timestamp

Machine State

Test State

Available Dataset

Operator
State Persistence

Important state transitions should be persisted.

At minimum

Test Created

Test Started

Test Paused

Test Resumed

Test Stopped

Test Completed

Test Aborted

Test Faulted

Test Interrupted
State Transition Record

Conceptually

TestStateHistory

Id

TestId

PreviousState

NewState

Timestamp

UserId

Reason
State Machine Determinism

Given the same

Current State

Command

Machine State

Configuration


the Runtime should produce the same transition result.

No Hidden State

Critical runtime conditions shall not exist only as private UI variables.

The Test Runtime owns authoritative execution state.

ViewModel Role

The ViewModel

Displays State

Sends Commands

Receives Events

It does not own the Test State Machine.

UI Command Example
Start Button

↓

TestViewModel.StartCommand

↓

ITestService.StartTest

↓

TestRuntime
State-to-UI Mapping

The UI may map state to command availability.

Example

Running

Start = Disabled

Pause = Enabled

Stop = Enabled

JOG = Disabled
State-to-Ribbon Mapping

The Ribbon follows the same state.

Example

Test State = Running

↓

Pause Enabled

Stop Enabled

Start Disabled
State-to-Navigation Mapping

During active testing

Running

↓

Test Workspace remains primary

Navigation away from the active operational context may be restricted according to policy.

Runtime and Calibration

Calibration shall not begin automatically because a Test starts.

Calibration is a separate controlled workflow.

Runtime and Method

The Runtime executes the selected Method configuration.

It does not modify the Method definition.

Runtime and Standards

The Runtime may consume Method-generated execution parameters.

It should not independently reinterpret the Standard.

Runtime and Calculation

The Runtime triggers calculation after acquisition finalization.

The Calculation Service owns engineering calculations.

Runtime and Reporting

The Runtime does not generate reports.

Reports operate on completed result data.

Fault Recovery

Recovery from Fault follows

Faulted

↓

Diagnose

↓

Correct Cause

↓

Revalidate Hardware

↓

Operator Acknowledgement

↓

Ready / Stopped
Fault Acknowledgement

Acknowledging a fault means

Operator has seen the fault

It does not necessarily mean

Fault condition has disappeared
Fault Clear

Fault Clear shall require actual hardware confirmation where applicable.

Runtime Safety Rule

No command shall transition the Test Runtime into Running unless the required machine and safety preconditions have been verified.

Runtime Ownership Rule

Only the Test Runtime may initiate automatic test motion.

Manual JOG is a separate controlled command path.

Motion Ownership Rule

At any moment, the machine must have a clearly identifiable motion owner.

Automatic Test

or

Manual JOG

or

Recovery / Service

Never multiple independent owners simultaneously.

Service Mode

If a service/maintenance mode is implemented, it shall be explicitly authorized.

Service mode shall not silently coexist with automatic Test Execution.

Simulation State Machine

Simulation must reproduce the same logical state transitions.

Example

Idle

↓

Running

↓

Paused

↓

Running

↓

Stopping

↓

Stopped
Simulation Faults

Simulation should be able to reproduce

Drive Fault

Communication Loss

Sensor Failure

Emergency Stop

Limit Reached

for testing the Runtime.

Unit Testing State Machine

The state machine shall be testable without hardware.

Tests should verify

Valid Transitions

Invalid Transitions

Fault Transitions

Emergency Stop

Pause / Resume

Stop

Abort

Recovery
State Machine Example
                    +-----------+
                    |   READY   |
                    +-----------+
                          |
                       Start
                          |
                          v
                    +-----------+
                    | STARTING  |
                    +-----------+
                          |
                    Motion Confirmed
                          |
                          v
                    +-----------+
             +----->|  RUNNING  |<-----+
             |      +-----------+      |
             |         |    |          |
          Resume     Pause Stop       |
             |         |    |          |
             |         v    v          |
             |      PAUSED STOPPING    |
             |         |      |        |
             +---------+      v        |
                         FINALIZING     |
                              |        |
                              v        |
                         CALCULATING   |
                              |        |
                              v        |
                          EVALUATING   |
                              |        |
                              v        |
                          COMPLETED    |
                                       |
        Fault / E-Stop ----------------+
Critical Safety Path

The normal state machine can always be interrupted by

Emergency Stop

Critical Fault

Communication Failure

where appropriate.

Safety Override

Safety conditions have precedence over normal workflow commands.

Example

Start Command

+

Emergency Stop Active

=

Start Rejected
Race Condition Prevention

Commands arriving simultaneously shall be serialized through the Runtime command mechanism.

Example

Start

+

Stop

must not produce an undefined state.

Command Sequence

The Runtime should process commands in a controlled order.

Receive

↓

Validate

↓

Acquire Runtime Lock

↓

Check State

↓

Execute Transition

↓

Release

↓

Publish Event
Runtime Lock

A synchronization mechanism shall protect critical state transitions.

The implementation must remain compatible with .NET Framework 4.8.

Threading Rule

UI thread, acquisition thread and communication callbacks shall not directly modify the Test State simultaneously.

All state changes should pass through the Runtime coordination mechanism.

Data Race Prevention

Measurement callbacks shall not directly update UI-bound collections from hardware threads.

UI Synchronization

The ViewModel receives Runtime updates and marshals them to the UI thread as required by WPF.

Architectural Decision (FROZEN)

The application shall maintain separate Machine State and Test State machines.

The Test Runtime owns test execution state.

The Hardware Layer reports normalized physical machine state.

Automatic test motion is controlled exclusively through the Test Runtime and Motion Service.

Manual JOG is a separate authorized motion path.

Safety conditions, Emergency Stop, critical faults and reliable machine feedback have precedence over normal workflow commands.

A command being transmitted successfully is never considered proof that the physical machine has performed the command.

Unexpected termination shall result in an Interrupted or otherwise non-completed state unless successful completion can be proven.

This decision is permanent.

Next Chapter

ARCH-066

Measurement Acquisition, Sampling, Synchronization & Live Data Pipeline

This chapter will define

Load Cell Acquisition
Extensometer Acquisition
Crosshead Encoder
Sampling
Timestamping
Synchronization
Buffering
Threading
Raw Data
Live Data
Downsampling
Data Integrity
Missing Samples
Invalid Samples
Acquisition Start / Stop
Storage Pipeline
Graph Pipeline
Performance Targets
End of Chapter