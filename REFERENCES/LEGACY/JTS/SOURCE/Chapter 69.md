# ARCHITECTURE
# Chapter 69
# Machine Controller, Motion Control, Speed Profiles & PLC/Drive Integration

Document ID

ARCH-069

Version

0.1

Status

FROZEN

Related EDR

EDR-074

Depends On

ARCH-053 Test Execution Architecture

ARCH-064 Hardware Abstraction Layer

ARCH-068 Method Engine

ARCH-066 Measurement Acquisition

---

# Purpose

This chapter defines the architecture responsible for controlling machine motion and communicating with the existing controller / PLC / drive system.

The architecture must support the current rebuilt Shimadzu tensile-testing machine configuration without requiring changes to the existing PLC program unless such changes are explicitly authorized later.

---

# Core Principle

The application shall not directly manipulate physical motor signals.

The control chain is

```text
Test Runtime

↓

Motion Controller Service

↓

Hardware Abstraction Layer

↓

Communication Adapter

↓

Fatek Communication Server / PLC Interface

↓

PLC

↓

LS VS20NL-P1 Drive

↓

Motor

↓

Crosshead
Existing Hardware Context

The current machine configuration includes

Shimadzu Universal Testing Machine

LS VS20NL-P1 inverter / drive

PLC

Fatek communication environment

Autograph_SVR

DriveView

Crosshead encoder

Mechanical clutch system
Existing Communication Constraint

The current project has an important constraint:

PLC program/register configuration is not currently available for modification.

Therefore the software architecture shall work with the existing exposed communication interface.

No Assumption of PLC Modification

The application shall not assume that new PLC registers can simply be created.

For example, the architecture shall not depend on

New Speed Register

unless that register is confirmed to exist and be accessible.

Existing Communication

The project uses the Fatek communication environment.

The existing server executable is associated with

FaSvr113-14721-en.exe

and the application-side communication concept is referred to as

Autograph_SVR
Communication Architecture

The application should communicate through an adapter rather than embedding Fatek protocol logic throughout the application.

MotionController

↓

IFatekCommunication

↓

FatekCommunicationAdapter

↓

Autograph_SVR / PLC
Separation of Responsibility

The following layers remain separate.

Method Engine
    |
    v
Motion Intent
    |
    v
Motion Controller
    |
    v
HAL
    |
    v
Communication Adapter
    |
    v
PLC / Drive
Motion Intent

The Test Runtime does not directly issue raw PLC commands.

It creates an engineering motion request.

Example

Move

Direction = Up

Speed = 10 mm/min

Mode = Automatic
Motion Command

Conceptually

MotionCommand

CommandId

Mode

Direction

Speed

Target

Acceleration

Deceleration

Timestamp

Only parameters supported by the actual controller shall be transmitted.

Motion Modes

The controller architecture shall support at least

Idle

Jog

Positioning

Automatic

Hold

Stop

EmergencyStop

Fault
Idle

No active movement command exists.

Jog

Manual operator-controlled motion.

Positioning

Motion toward a specified position or machine reference.

Automatic

Motion controlled by the active Test Execution Profile.

Hold

Motion is stopped while the Test Runtime continues monitoring the Test.

Stop

Controlled normal motion stop.

Emergency Stop

Immediate safety stop according to the machine's safety architecture.

Software emergency-stop handling shall not replace the physical emergency-stop circuit.

Fault

The controller has detected a condition that prevents safe continuation.

Motion State Machine

The controller should implement a deterministic state machine.

Idle
 |
 +--> Jog
 |
 +--> Positioning
 |
 +--> Automatic
 |
 +--> Stop
 |
 +--> EmergencyStop
 |
 +--> Fault
State Transition Rule

Every transition must be explicitly validated.

Invalid transitions must be rejected.

Example
Fault

X

Automatic

until the fault has been cleared and the machine has been revalidated.

Motion Intent vs Hardware Command

These are different concepts.

MotionIntent

"Move upward at 10 mm/min"

versus

HardwareCommand

PLC / drive-specific command representation
Hardware Command

The Hardware Abstraction Layer converts the engineering request into the actual command representation.

Hardware Independence

The Test Runtime shall not know whether motion is implemented using

PLC bit

Register

Drive command

Fieldbus

Serial command

Ethernet command
Controller Interface

Conceptual interface

IMachineController

Connect()

Disconnect()

GetState()

StartJog()

StopJog()

StartAutomatic()

Stop()

EmergencyStop()

SetSpeed()

GetPosition()

GetFault()
Important Constraint

Only operations supported by the real machine shall be implemented as functional operations.

Unsupported commands shall return an explicit unsupported result.

No Fake Hardware Success

The application must never report

Speed Set = 10 mm/min

unless the command was actually accepted by the hardware interface.

Command Result

A controller command should return

CommandResult

Accepted

Rejected

Unsupported

Timeout

Fault
Command Acknowledgement

Where the communication system provides acknowledgement, the application shall wait for and validate it.

Timeout

Every communication command must have a defined timeout.

Timeout Behavior

If acknowledgement is not received

Command

↓

Timeout

↓

Controller Communication Fault

The Test Runtime shall determine whether the Test can safely continue.

Communication Failure

Communication failure during automatic movement is a critical condition.

The application shall transition the control layer to a safe state according to the available hardware capabilities.

Communication Recovery

The application must not automatically resume machine motion after an unexpected communication failure unless the machine safety architecture and Method explicitly permit this.

PLC Interface

The PLC interface should expose only the required machine signals.

Examples

Up Command

Down Command

Stop Command

Drive Ready

Drive Fault

Position

Speed

Limit State

The exact addresses are hardware configuration.

Register Mapping

Register addresses must not be hard-coded throughout the application.

They shall be defined in a configuration / mapping layer.

Example

PLC Mapping

UpCommand       -> Address X
DownCommand     -> Address Y
StopCommand     -> Address Z
Position        -> Register A
Mapping Version

Hardware mappings should be versioned.

Mapping Validation

On application startup the system should validate that the required mapping is available.

Missing Mapping

If a required mapping is unavailable

ControllerState = NotConfigured

Automatic Test execution shall be blocked if the missing mapping affects safety or required control.

Up / Down Control

The current control architecture may expose directional commands such as

Up

Down

through PLC-controlled signals.

Mutual Exclusion

Up and Down commands must never be asserted simultaneously.

Up = TRUE

Down = TRUE

is an invalid state.

Software Interlock

The application shall reject conflicting directional commands.

Hardware Interlock

The PLC / drive should also provide the final physical interlock where supported.

Software interlocks do not replace hardware safety.

Stop Priority

A Stop command has higher priority than a normal motion command.

Emergency Stop Priority

Emergency Stop has the highest software control priority.

However, the physical emergency-stop circuit remains the primary safety mechanism.

Motion Command Priority

Recommended priority

Emergency Stop

↓

Fault

↓

Stop

↓

Automatic

↓

Jog
Jog Control

The JOG interface shall remain accessible according to the UI architecture.

The JOG area is intended for controlled manual positioning.

Jog Up

The operator may request

JOG UP

subject to

Machine Ready

No Fault

Safety Conditions

Limit Conditions
Jog Down

The operator may request

JOG DOWN

under the same conditions.

Jog Speed

Jog speed shall be separately configurable from automatic Test speed.

Jog Speed Limit

Jog speed must remain below the machine's configured maximum.

Jog Release

For a momentary JOG control, releasing the control should result in a controlled stop.

Jog Latch

A latched JOG command should not be used unless the hardware interface explicitly requires it and safety validation has been performed.

Automatic Motion

Automatic motion is generated from the Test Execution Profile.

Example

Speed = 10 mm/min

Direction = Up

ControlMode = Automatic
Automatic Motion Start Conditions

Before automatic motion

Method Valid

Hardware Connected

Controller Ready

Load Cell Ready

Required Extensometer Ready

Clutch Valid

Safety Conditions Valid

Specimen Valid

Test State = Ready

must all be satisfied.

Automatic Motion Start

Only after all prerequisites are satisfied may

Automatic Motion


be enabled.

Speed Setpoint

The Method Engine may specify speed in engineering units.

Example

10 mm/min

The controller layer determines how this is represented to the actual hardware.

Speed Conversion

Conceptually

Engineering Speed

↓

Controller Conversion

↓

Hardware Setpoint
Important Constraint

If the existing PLC does not expose a writable speed register, the application must not pretend that software speed control exists.

Speed Register

A writable speed register may be used only if confirmed in the actual PLC / controller configuration.

Alternative Speed Control

If speed is controlled through predefined PLC states or another existing mechanism, the Motion Controller shall use the existing supported mechanism.

Speed Capability Discovery

The controller may expose

SupportsDirectSpeedSetpoint

as a capability.

Capability Example
DirectSpeedSetpoint = False

means the Method Engine cannot rely on a direct speed register.

Method Compatibility

A Method requiring direct speed control must not be executable when

SupportsDirectSpeedSetpoint = False

unless another validated implementation provides equivalent control.

Speed Profile

A speed profile may contain

TargetSpeed

Acceleration

Deceleration

MaximumSpeed

RampMode
Current Machine Limit

The project hardware context defines an approximate maximum crosshead speed of

500 mm/min

This shall be treated as a configured machine parameter, not as an unconditional universal constant.

Maximum Speed Validation
RequestedSpeed <= ConfiguredMaximumSpeed

must be true.

Acceleration

Acceleration controls how quickly the target speed is reached.

If the controller / PLC does not expose acceleration control, the application shall not simulate an unsupported acceleration parameter.

Deceleration

Deceleration defines the controlled reduction of motion speed where supported.

Unsupported Ramp

If the hardware does not support software-defined acceleration / deceleration

RampMode = HardwareDefined

may be used.

Motion Profile Phases

A Test may contain multiple speed phases.

Example

Approach

10 mm/min

↓

Test Speed

2 mm/min

↓

Post-Yield

10 mm/min

Only if permitted by the Method.

Phase Transition

A transition may occur because of

Position

Force

Strain

Yield Detection

Time

Operator Action
Controller Ownership

The Runtime owns the engineering phase.

The Controller owns physical command execution.

Example
Runtime:

"Switch to Test Speed"

↓

Controller:

Set / select appropriate machine speed mechanism
Position Feedback

Position feedback shall be provided through the acquisition / HAL architecture.

The Motion Controller may query position for control validation.

Position Source

The machine currently has a crosshead encoder.

The exact encoder representation remains a hardware configuration detail.

Encoder Calibration

Encoder calibration converts raw encoder information into engineering position.

Position Units

Engineering position shall use

mm
Position Direction

The sign convention shall be explicitly configured.

Example

Up = Positive

Down = Negative

or the inverse, depending on the actual machine configuration.

Direction Normalization

The HAL shall normalize the physical direction into the application-level direction.

Position Limits

The controller must monitor configured limits.

Examples

UpperLimit

LowerLimit
Limit Condition

If a movement command requests motion toward an active limit

Command = Rejected

or the machine shall stop according to the hardware safety design.

Software Limit

Software limits provide an additional control layer.

They do not replace hardware limit switches.

Limit Configuration

Limits shall be machine configuration parameters.

They shall not be embedded in individual Methods unless a Method-specific limit is explicitly required.

Force Limit

The Method may define a maximum permitted force.

Example

MaximumForce = configured threshold
Force Limit Action

When the limit is reached

Normal Test

↓

Force Limit Event

↓

Controlled Stop

unless the applicable Method defines another valid action.

Overforce

Overforce beyond configured safety limits is a critical condition.

Drive Ready

The controller should expose a drive-ready state if available.

Drive Fault

The controller should expose drive-fault status.

VS20NL-P1

The current drive context identifies

LS VS20NL-P1

as the motor drive / inverter.

The application shall access it through the existing control architecture rather than assuming direct unrestricted drive communication.

DriveView

DriveView may be used as a diagnostic / engineering tool.

The application shall not depend on DriveView being open during normal Test execution unless explicitly required by the deployed architecture.

Fatek Server

The Fatek communication server acts as an integration boundary where applicable.

Conceptually

Application

↓

Fatek Adapter

↓

FaSvr113-14721-en.exe

↓

PLC
Server Availability

If the communication server is required and unavailable

ControllerState = CommunicationUnavailable
Startup Detection

At application startup

Check Server

↓

Check PLC Connection

↓

Check Controller State

↓

Expose Machine Readiness
Reconnection

The communication adapter may attempt reconnection after a communication failure.

Automatic Reconnection Rule

Reconnection must not automatically resume motion.

Reconnection State

After reconnect

Communication Restored

≠

Motion Resumed
Motion Resume

A resume operation requires explicit validation.

Fault Reset

Fault reset shall be separate from motion start.

Conceptually

ResetFault()

↓

ValidateReady()

↓

AllowMotion()
Fault Reset Restriction

The application shall not repeatedly issue automatic fault resets.

Controller Diagnostics

The Controller service should expose diagnostics such as

Connected

PLC Available

Drive Ready

Drive Fault

Position

Direction

Motion State

Communication Latency

Last Command

Last Error
Diagnostics UI

The engineering diagnostics screen may display these values.

The normal Test UI should expose only the values relevant to operation.

Communication Logging

Communication events should be logged at a configurable level.

Normal Log

Example

Motion command accepted
Diagnostic Log

Example

PLC register read
Address = ...
Value = ...
Timestamp = ...
Sensitive Logging

Raw communication data should not be logged indefinitely at maximum verbosity during normal operation.

Command Correlation

Each command should have a command identifier where practical.

Example

CommandId = CMD-000123

This helps correlate

Request

PLC Command

Acknowledgement

Error
Command Queue

Normal commands may be serialized through a controller command queue.

Queue Safety

Safety commands such as Stop / Emergency Stop shall not be delayed behind normal queued motion commands.

Command Cancellation

Pending normal commands should be cancellable when the Test transitions to Stop or Fault.

Duplicate Command

The controller should avoid sending duplicate motion commands unnecessarily.

Idempotence

Commands such as

Stop

should ideally be safely repeatable.

Commands that cause motion should be treated carefully and should not be blindly retried.

Retry Policy

Communication retry shall depend on command type.

Recommended

Read Status

Retry = Allowed
Stop

Retry = Carefully Allowed
Start Motion

Automatic Retry = Prohibited

unless specifically validated.

Start Motion Protection

A motion-start command should require a fresh safety / readiness validation.

Motion Command Sequence

Recommended

Validate

↓

Command

↓

Acknowledge

↓

Verify State

↓

Continue
Start Verification

After starting motion, the controller should verify that the expected motion state actually occurred.

Example
Start Up

↓

Expected: MovingUp

↓

Actual: MovingUp

↓

Success
Unexpected State

Example

Command = MoveUp

Actual = Fault

The Runtime must stop the execution phase and report the controller fault.

Emergency Stop

The software emergency-stop function should invoke the highest-priority available safe stop mechanism.

However:

Software Emergency Stop

≠

Physical Emergency Stop
Physical Emergency Stop

The machine must retain its physical emergency-stop safety circuit.

Software architecture shall never remove or bypass it.

Interlocks

Possible interlocks include

Door / Guard

Upper Limit

Lower Limit

Drive Ready

Emergency Stop

Load Cell State

Extensometer State

Clutch State

Only interlocks actually provided by the machine should be represented as active hardware capabilities.

Interlock Model

Conceptually

Interlock

Name

State

Source

Severity

Action
Interlock Severity

Possible values

Information

Warning

Blocking

Emergency
Blocking Interlock

Prevents automatic motion.

Emergency Interlock

Requires immediate safe machine response.

Clutch State

The Controller should expose the current clutch state if this information is available.

Possible values

1:1

1:10

Unknown
Clutch Verification

If the Method requires

1:10

the system should verify the state where the hardware provides feedback.

Unknown Clutch State

If clutch state cannot be verified

Automatic Test = Blocked

when clutch correctness is safety- or measurement-critical.

Manual Clutch

If clutch state is changed manually and no feedback exists, the operator must explicitly confirm the state before execution.

Operator Confirmation

Example

Confirm:

Clutch = 1:10

[Confirm]

The confirmation must be recorded in the Test audit trail where appropriate.

Controller Ready State

Recommended readiness evaluation

Communication OK

AND

Drive Ready

AND

No Fault

AND

Emergency Stop Released

AND

Required Interlocks OK
Machine Ready

The application-level MachineReady state is true only when all required readiness conditions are satisfied.

MachineReady Formula

Conceptually

MachineReady =
CommunicationReady
AND ControllerReady
AND SafetyReady
AND RequiredSensorsReady
TestReady

TestReady adds Test-specific conditions.

TestReady =
MachineReady
AND MethodValid
AND SpecimenValid
AND ExecutionProfileValid
Start Button

The Start Test command shall be enabled only when TestReady is true.

Manual Control While Test Running

Manual JOG control should normally be disabled during automatic Test execution.

Exception

If a Standard or recovery procedure explicitly requires operator motion, the Runtime shall transition to a controlled operator-interaction state.

Automatic / Manual Separation
Automatic Mode

X

Manual Jog

during normal Test execution.

Stop During Test

Operator Stop should result in

Test Runtime

↓

Stopping

↓

Motion Stop

↓

Data Finalization / Partial State
Abort

Abort is an engineering Test state.

It is not equivalent to a hardware emergency stop.

Emergency Stop During Test

Emergency Stop should result in

Motion Safety Action

+

Test Runtime = EmergencyStopped

The dataset shall be preserved as partial data where possible.

Recovery

After Emergency Stop

Emergency Stop Released

↓

Hardware Reset

↓

Controller Ready

↓

Operator Review

↓

New Test / Controlled Recovery

Automatic continuation should not occur by default.

Motion Safety Boundary

The Controller layer is not a replacement for machine safety hardware.

The architecture follows

Software Safety

+

PLC Interlocks

+

Drive Protection

+

Physical Emergency Circuit
Register Configuration

The application shall maintain a configurable mapping for known PLC signals.

Example conceptual mapping

Motion.Up

Motion.Down

Motion.Stop

Status.Ready

Status.Fault

Status.LimitUp

Status.LimitDown
Unknown Register

If an address is unknown

NotConfigured

must be represented explicitly.

Register Discovery

Automatic discovery should not be assumed.

The application may provide a diagnostic configuration screen for known mappings.

No PLC Programming Assumption

The software architecture shall remain functional even when the PLC program cannot be modified.

This is a fundamental project constraint.

Future PLC Extension

If PLC modification becomes available later, additional signals such as

DirectSpeedSetpoint

Acceleration

Deceleration

MotionAcknowledgement

may be added through a new mapping version.

The upper software architecture should not require redesign.

Hardware Capability Model

The Controller should expose capabilities.

Example

MachineCapabilities

DirectSpeedControl

PositionFeedback

ForceLimit

SpeedRamp

ClutchFeedback

DriveFaultFeedback
Capability-Based Execution

The Method compatibility engine uses these capabilities to determine whether a Method can execute.

Example
Method:

Requires DirectSpeedControl = True

Machine:

DirectSpeedControl = False

Result:

NotCompatible
Controller Abstraction

The application should not expose PLC register addresses to the Test Runtime.

Example

Incorrect

Runtime.WriteRegister(40021, 1)

Correct

Controller.StartMotion(Direction.Up)
Adapter Responsibility

The adapter converts

Controller.StartMotion(Direction.Up)

into the actual communication representation.

Future Hardware

This permits a future controller to replace the current PLC/Fatek arrangement without changing the Test Runtime.

Controller Interface Example

Conceptual

IMachineController

    Connect()

    Disconnect()

    GetStatus()

    StartJog(direction)

    StopJog()

    StartAutomaticMotion(profile)

    StopMotion()

    EmergencyStop()

    ResetFault()

    GetPosition()

    GetCapabilities()
Motion Profile Interface

Conceptual

IMotionProfile

    Speed

    Direction

    Acceleration

    Deceleration

    MaximumForce

    PositionLimit

Only supported properties are transmitted to hardware.

Controller Event Model

The Controller should publish events such as

StateChanged

MotionStarted

MotionStopped

FaultOccurred

LimitReached

CommunicationLost

CommunicationRestored
Runtime Subscription

The Test Runtime subscribes to these events.

Event Priority

Safety-related events must be processed before ordinary informational events.

Fault Event

Example

DriveFaultOccurred

causes

Controller State = Fault

↓

Runtime receives event

↓

Automatic phase stopped
Limit Event

If a movement reaches a configured limit

Motion Stop

+

Limit Event

must be generated.

Communication Event

If communication is lost

CommunicationLost

must be raised.

Measurement Relationship

Motion control and measurement acquisition are related but separate.

Motion Controller
       |
       +----> Motion State
       |
       +----> Position

Acquisition
       |
       +----> Force
       |
       +----> Extension
Synchronization

Measurements should retain timestamps / sequence information so that motion and engineering data can be correlated.

Controller Time

The application should not assume that PLC time and PC time are identical.

Timestamp Source

The authoritative measurement timestamp policy is defined by ARCH-066.

Motion Log

The system should retain important motion events.

Example

10:00:00 StartMotion
10:00:01 Moving
10:00:10 LimitChanged
10:01:20 StopMotion
Motion Audit

Important operator actions should be auditable.

Examples

JOG UP

JOG DOWN

STOP

FAULT RESET

CLUTCH CONFIRMATION
Diagnostic Mode

A separate engineering diagnostic mode may expose low-level PLC / controller information.

It must not be mixed into normal Test execution logic.

Diagnostic Mode Safety

Diagnostic commands that can cause motion must have explicit safety confirmation and role authorization.

Engineering Access

Low-level register access should normally be restricted to authorized engineering users.

Normal Operator

The normal Operator should see engineering commands rather than raw PLC addresses.

Controller Logging

Recommended log levels

Error

Warning

Info

Debug

Trace
Production Default

Production should normally use

Info

or

Warning

depending on the deployed diagnostic policy.

Trace Logging

Trace-level communication logging should be enabled only when troubleshooting.

Performance

The controller communication layer shall not block the WPF UI thread.

Async Boundary

Communication operations should execute asynchronously or on a dedicated communication thread.

UI Rule

The UI must remain responsive while

PLC Read

PLC Write

Connection

Timeout

Reconnect

operations are occurring.

Thread Safety

Controller state must be thread-safe.

State Snapshot

The UI should consume an immutable state snapshot rather than directly reading mutable communication objects.

Example
MachineStateSnapshot

Connected = True

Ready = True

Motion = MovingUp

Position = 125.42 mm

Fault = None
Controller Repository

Controller configuration should be stored through a configuration repository rather than hard-coded.

Configuration Examples
PLC IP

Port

Server Name

Register Mapping

Timeout

Retry Policy

Machine Limits
Configuration Validation

Invalid communication configuration shall result in

ControllerState = ConfigurationError

rather than a generic connection failure.

Deployment

The deployed machine software shall document required communication components.

Examples

Fatek Communication Server

Required network configuration

Required PLC mapping

Required controller configuration
Startup Sequence

Recommended

Application Start

↓

Load Configuration

↓

Validate Mapping

↓

Start / Detect Communication Server

↓

Connect PLC

↓

Read Controller State

↓

Read Capabilities

↓

Evaluate MachineReady
Shutdown Sequence

Recommended

Application Shutdown

↓

Block New Motion

↓

Stop Normal Communication

↓

Disconnect Controller

↓

Close Logging

↓

Exit
Shutdown During Motion

The application should not silently terminate while automatic motion is active.

A controlled stop or explicit operator confirmation is required according to the safety policy.

Controller Fault Recovery

Recovery should follow

Detect Fault

↓

Stop / Safe State

↓

Record Fault

↓

Display Diagnostic

↓

Operator / Engineer Review

↓

Reset if permitted

↓

Revalidate

↓

Ready
Automatic Recovery Restriction

The software shall not automatically clear serious drive or safety faults without an explicit validated policy.

Acceptance Criteria

ARCH-069 is accepted when

Motion control is isolated from the Test Runtime.

The application does not depend on direct motor control.

Fatek / PLC communication is isolated behind an adapter.

VS20NL-P1 integration is treated as hardware-specific.

PLC register mappings are configurable.

The architecture does not require modification of the existing PLC.

Up and Down commands are mutually exclusive.

Stop has higher priority than normal motion.

Emergency Stop has highest software priority.

Physical emergency-stop circuitry remains authoritative.

JOG and automatic motion are separated.

Automatic motion requires MachineReady and TestReady.

Speed is represented in engineering units.

Unsupported speed-control features are not simulated.

Position feedback is represented in engineering units.

Clutch state can be represented and validated.

Communication timeouts are handled explicitly.

Communication recovery does not automatically resume motion.

Controller faults propagate to the Test Runtime.

The WPF UI is never blocked by PLC communication.

Controller state is thread-safe.

Low-level diagnostics are separated from normal Test operation.

Architectural Decision (FROZEN)

The machine-control architecture shall be hardware-independent at the application level.

The Test Runtime shall generate engineering Motion Intent rather than PLC-specific commands.

The Hardware Abstraction Layer and communication adapter are responsible for converting engineering commands into the actual machine interface.

The current Fatek / PLC / LS VS20NL-P1 architecture is treated as the deployed hardware implementation.

The application shall not require modification of the existing PLC program or creation of new PLC registers.

Direct speed control shall be capability-driven and shall never be assumed.

If a required control capability is unavailable, the Method must be rejected as incompatible rather than simulated.

Software emergency handling shall never replace the physical emergency-stop system.

Communication recovery shall never automatically resume physical motion.

All motion commands shall pass through readiness, interlock and capability validation.

This decision is permanent.

Next Chapter

ARCH-070

WPF HMI Architecture, Main Window, Ribbon, Live Values, JOG Panel & TrapeziumX-Compatible UI

This chapter will define

WPF
MVVM
.NET Framework 4.8 x86
Main Window
Ribbon
Classic Office 2010 Style
Status Bar
Live Values
Sensor Selection
JOG Panel
Test Panel
Graph Area
Method Selection
Specimen Panel
Customer / Project Information
Acceptance Number
Material Selection
Layout
Theme
Colors
Fonts
Navigation
Dialogs
Operator Workflow
Read-Only Completed Tests
Alarm / Fault Presentation
UI State Management
Responsive Layout
Canvas-Based Graph
TrapeziumX Visual Compatibility
Accessibility
Keyboard Controls
Engineering Diagnostic UI
End of Chapter