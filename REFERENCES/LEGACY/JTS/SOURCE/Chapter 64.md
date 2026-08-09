# ARCHITECTURE
# Chapter 64
# Hardware Abstraction Layer & Machine Communication Architecture

Document ID

ARCH-064

Version

0.1

Status

FROZEN

Related EDR

EDR-069

Depends On

ARCH-045 Communication Architecture

ARCH-053 Test Execution Architecture

ARCH-062 Application Service Layer

ARCH-063 Repository & Persistence Architecture

---

# Purpose

This chapter defines the Hardware Abstraction Layer (HAL) and machine communication architecture for the Universal Testing Machine.

The objective is to isolate application logic from the physical machine, PLC communication mechanism, drive implementation and sensor hardware.

The application shall communicate with the machine through stable hardware interfaces rather than directly manipulating communication registers from the UI or business logic.

---

# Hardware Context

The current machine architecture is based on a modified Shimadzu tensile testing machine.

Relevant hardware context includes

```text
Shimadzu AG-25TB / 25T-AB

LS VS20NL-P1 inverter / drive

Fatek PLC communication

Autograph_SVR / FaSvr113-14721-en.exe

DriveView

Load Cells

Extensometers

Crosshead Encoder

The exact hardware mapping remains configuration-controlled.

Core Principle

The application shall not depend directly on a specific communication mechanism.

The architecture is

Application

↓

Hardware Abstraction Layer

↓

Hardware Adapter

↓

Communication Adapter

↓

Physical Hardware
HAL

The Hardware Abstraction Layer provides domain-level machine operations.

Examples

StartMotion

StopMotion

JogForward

JogReverse

SetSpeed

ReadMachineState

ReadLoad

ReadPosition

ReadExtensometer
HAL SHALL NOT EXPOSE

The following shall remain hidden from the upper application layers

PLC Register Address

Bit Number

Raw Communication Frame

Protocol Packet

Fatek Command

Drive Register Address
Example

Application requests

SetCrossheadSpeed(10.0)

It shall not request

WriteRegister(D123, 1000)

The conversion belongs to the Hardware Adapter.

Hardware Interfaces

Recommended interfaces

IMachineController

IMotionController

IMeasurementController

ILoadCellChannel

IExtensometerChannel

IPositionChannel

ICommunicationAdapter
Machine Controller

IMachineController provides high-level machine operations.

Examples

Connect

Disconnect

GetMachineState

Reset

Stop

GetDiagnostics
Motion Controller

IMotionController provides motion-specific operations.

Examples

JogForward

JogReverse

Stop

Move

SetSpeed

GetPosition

GetMotionState
Measurement Controller

IMeasurementController provides acquisition operations.

Examples

StartAcquisition

StopAcquisition

GetChannelValues

GetSample

GetAcquisitionState
Load Cell Interface

A load-cell channel should expose calibrated engineering values.

Conceptually

ReadForce()

↓

ForceValue

Unit = kN

The UI should not receive raw ADC counts.

Extensometer Interface

An extensometer channel may expose

ReadExtension()

↓

ExtensionValue

Unit = mm
Position Interface

Crosshead position may expose

ReadPosition()

↓

PositionValue

Unit = mm
Sensor Abstraction

The upper layer should not need to know whether a measurement comes from

Load Cell

PLC

DAQ

Encoder

Simulation

It consumes the channel interface.

Channel Identity

Every measurement channel should have a stable logical identity.

Example

LOAD_25T

LOAD_10T

LOAD_2T

LOAD_500KG

LOAD_100KG

EXT_100

EXT_50

EXT_25

CROSSHEAD_POSITION
Physical vs Logical Channel

A logical channel is not necessarily the same as a physical input.

Example

Logical Channel

LOAD_PRIMARY

↓

Configured Physical Channel

25 ton load cell

This allows hardware configuration to change without changing application logic.

Load Cell Selection

The Method determines the required load cell where applicable.

Example

Method

↓

Load Cell = 25 ton

The Hardware Layer resolves the logical load-cell identifier to the configured physical channel.

Load Cell Range

The software shall preserve the configured capacity.

Example

25 ton

10 ton

2 ton

500 kg

100 kg

Capacity is metadata and shall not be inferred from a live reading.

Calibration Integration

The HAL provides measurements.

Calibration transforms raw measurements into engineering values.

Conceptually

Raw Value

↓

Calibration

↓

Engineering Force
Calibration Boundary

The HAL should expose the measurement required for calibration without embedding laboratory calibration rules.

Machine State

The HAL shall expose a normalized Machine State.

Example

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
State Normalization

Different hardware implementations may report different raw states.

The HAL converts them to the common application state.

Example

PLC Bits

↓

Hardware Adapter

↓

MachineState.Running
Motion State

Motion state may include

Stopped

MovingForward

MovingReverse

Stopping

Fault
Machine State vs Test State

These are separate concepts.

Machine State

=

Physical machine condition
Test State

=

Application test workflow condition

Example

Machine = Ready

Test = NotStarted
Example

During a test

Machine State = Running

Test State = Running

After controlled motion stop

Machine State = Stopped

Test State = Finalizing
Communication Architecture

The communication chain may be represented as

Application

↓

HAL

↓

Machine Adapter

↓

Communication Adapter

↓

Fatek / PLC Communication

↓

PLC / Drive

↓

Physical Machine
Fatek Communication

The current environment references Fatek communication infrastructure.

The application shall isolate this dependency behind a communication adapter.

Autograph_SVR

The existing communication environment includes

FaSvr113-14721-en.exe

Autograph_SVR

The HAL shall not directly depend on executable-specific behavior.

An adapter shall encapsulate the integration.

Communication Adapter

Conceptual interface

ICommunicationAdapter

Responsibilities

Connect

Disconnect

Read

Write

ReadBlock

WriteBlock

GetCommunicationState
Raw Communication

Raw communication should remain below the HAL boundary.

Communication Adapter

↓

Raw Register / Protocol

↓

Machine Adapter

↓

Normalized Machine Interface
PLC Registers

Existing PLC register assignments shall be treated as hardware configuration.

The application shall not assume arbitrary register addresses.

Register Mapping

A configuration structure may define

Command

Address

Data Type

Scale

Unit

Direction

Description

Example concept

Speed Command

↓

Configured PLC Address

↓

Scale Factor

↓

Raw Value
Register Mapping Version

Hardware register mapping shall be versioned.

A change to register mapping can affect machine operation and therefore must be controlled and audited.

Register Access Policy

Upper layers shall not access registers directly.

Only the Hardware / Communication implementation may perform raw register access.

Digital Inputs

Digital inputs may include signals such as

Machine Ready

Forward Limit

Reverse Limit

Drive Fault

Emergency Stop

Running

Stopped

The actual mapping is configuration-dependent.

Digital Outputs

Digital outputs may include

Forward

Reverse

Stop

Enable

The exact implementation shall follow the actual PLC architecture.

Important Constraint

The current project context indicates that PLC/register definitions are not currently under user control.

Therefore the software shall not assume that a new register can simply be added.

If a required function depends on a register that does not exist, the system must report the hardware integration requirement rather than pretending the function is available.

Speed Control

Speed shall be represented in engineering units.

Example

10 mm/min

The Hardware Adapter converts this value into the format required by the actual controller.

Speed Scaling

Conceptually

Engineering Speed

10.0 mm/min

↓

Hardware Scale

↓

PLC / Drive Command

The scaling factor must be configuration-controlled.

Speed Validation

Before sending a speed command

Requested Speed

↓

Minimum Limit

↓

Maximum Limit

↓

Method Limit

↓

Machine Limit

↓

Hardware Command
Maximum Speed

The machine context specifies a maximum crosshead speed of approximately

500 mm/min

The final configured machine limit shall remain authoritative.

Clutch

The machine contains two clutch configurations referenced as

1:1

1:10

The software shall treat clutch selection as machine configuration.

Default Clutch

The project context defines

Default = 1:10

unless manually changed.

Clutch Usage

The 1:1 configuration may be used for positioning and certain materials / operations according to the machine operating policy.

The software shall not automatically change the physical clutch unless the hardware explicitly supports such control.

JOG

JOG is a controlled manual motion operation.

The workflow is

Operator

↓

Authorization

↓

Safety Validation

↓

HAL

↓

Motion Controller

↓

Machine
JOG Forward
JogForward()

↓

Check Machine State

↓

Check Limits

↓

Check Emergency Stop

↓

Issue Motion Command
JOG Reverse

Same safety rules apply.

JOG Stop

JOG Stop must be immediately accessible.

The UI may provide a dedicated Stop command independent of navigation.

JOG Speed

JOG speed shall be separately configurable from Test Speed where required.

Test Motion

During automatic testing

Test Runtime

↓

Motion Service

↓

IMotionController

↓

Hardware Adapter

↓

Machine
Automatic Motion

The Test Runtime determines the desired test progression.

The HAL performs the hardware operation.

The HAL does not decide ISO 6892-1 test strategy.

Test Speed Profiles

The application may support

Fixed Speed

Method A

Method B

Stress Rate

Strain Rate

depending on the selected Method.

Rate Conversion

Engineering rate calculations belong to the Test / Method / Calculation layers.

The HAL receives the final hardware command or control target appropriate to the machine.

Feedback

The machine may provide

Actual Position

Actual Speed

Actual Load

Actual State

These are feedback values.

Command vs Feedback

The architecture shall distinguish

Command

=

Requested machine behavior

from

Feedback

=

Measured machine behavior
Watchdog

Communication should include a watchdog mechanism where supported.

Conceptually

Application

↓

Heartbeat

↓

Communication Layer

↓

Hardware
Watchdog Failure

If communication becomes stale

No Valid Feedback

↓

Communication Fault

↓

Machine Safety Response

The exact physical safety response belongs to the machine safety architecture and cannot be simulated merely by a software flag.

Communication Timeout

A configurable timeout shall detect stale communication.

Example

Last Valid Response

+

Timeout Threshold

↓

Communication Timeout
Communication Retry

Retries may be used for non-critical communication operations.

Critical motion commands require stricter handling.

The application shall not blindly retry a motion command if doing so could create unintended repeated motion.

Command Idempotency

Commands should be classified.

Examples

Read State

→ Generally safe to retry
Stop

→ May be safely repeatable
Start Motion

→ Must be carefully controlled
Communication Error

Communication errors should be normalized.

Example

Transport Error

↓

CommunicationException

↓

HardwareError

↓

Application Error
Drive Fault

A drive fault shall be exposed as a machine-level fault.

The Test Runtime shall respond according to its fault policy.

Emergency Stop

Emergency Stop is a safety condition.

Software shall monitor the available emergency-stop indication but shall not be considered the primary safety mechanism.

Safety Boundary

The fundamental rule is

Software Safety Logic

≠

Physical Safety System

The machine must retain independent physical safety mechanisms.

Emergency Stop Response

If the application detects Emergency Stop

Detect

↓

Update Machine State

↓

Stop / Abort Test Workflow

↓

Record Event

↓

Notify Operator

The physical emergency stop itself must control the machine independently.

Hardware Disconnect

If communication is lost

Connected

↓

Communication Lost

↓

Unknown / Fault

↓

Test Runtime Response

The application shall not continue to claim that the machine is operating normally.

Reconnection

Reconnection shall be explicit and state-aware.

Disconnected

↓

Connect

↓

Identify Hardware

↓

Validate Configuration

↓

Read Current State

↓

Connected
Hardware Identification

The adapter should expose sufficient information to identify the connected hardware.

Possible fields

Model

Serial Number

Firmware

Controller Type

Communication Version
Configuration Validation

On connection

Hardware Detected

↓

Load Configuration

↓

Validate Mapping

↓

Validate Channels

↓

Validate Capabilities

↓

Ready
Capability Model

Hardware should expose capabilities.

Example

SupportsSpeedCommand

SupportsPositionFeedback

SupportsJog

SupportsLoadFeedback

SupportsExtensometer

SupportsPause
Capability-Based Design

The application should not display or enable functions unsupported by the connected hardware.

Simulation Adapter

A simulation implementation should provide the same interfaces.

IMachineController

↓

RealMachineController

or

SimulationMachineController
Simulation

Simulation can generate

Load

Position

Extension

Motion State

Faults

for development and testing.

Simulation Restrictions

Simulation mode shall be clearly identified.

It shall never be confused with real machine operation.

Simulation Authorization

If simulation mode is capable of creating data that resembles production results, access should be controlled.

Hardware Diagnostics

The HAL should expose diagnostic information.

Examples

Communication Status

Last Response

Controller State

Drive Fault

Channel Status

Watchdog

Configuration
Communication Monitor

A diagnostic workspace may display

Timestamp

Direction

Operation

Status

Duration

Error

Raw register information may be available only to authorized service personnel.

Logging

Technical communication logs may be enabled for diagnostics.

They should not automatically become permanent laboratory audit records.

Performance

Communication should be efficient enough to support live graphing and test acquisition without blocking the UI.

Acquisition Rate

The acquisition rate is determined by the measurement architecture and selected Method / hardware capabilities.

The UI shall not assume that display refresh rate equals acquisition rate.

Acquisition vs UI Refresh

Example

Acquisition

1000 samples/sec

while

UI

20–60 updates/sec

The UI receives appropriately buffered or downsampled data.

Measurement Buffer

The Runtime may use a thread-safe buffer between acquisition and UI.

Hardware

↓

Acquisition Buffer

↓

Test Runtime

↓

Calculation / Storage

↓

UI
Data Loss Detection

The acquisition layer should detect

Dropped Samples

Timestamp Gaps

Invalid Values

Communication Gaps

where the hardware provides sufficient information.

Invalid Measurement

A measurement may be marked

Valid

Invalid

Missing

Estimated

The system shall not silently replace invalid raw measurements with guessed values.

Sensor Disconnect

If a required sensor becomes unavailable during a Test

Sensor Lost

↓

Runtime Event

↓

Test Fault Policy

↓

Operator Notification

↓

Safe Machine Response
Extensometer Removal

If the selected Method requires an extensometer, loss of that channel must be treated according to the Method's validity rules.

Crosshead Encoder

The crosshead encoder provides position feedback.

The software may use it for

Displacement

Crosshead Speed

Test Progress

Graphing
Encoder Calibration

Encoder calibration is a controlled machine configuration operation.

It shall not be silently modified during ordinary Test Execution.

Load Cell Calibration

The active load cell shall reference an approved calibration configuration.

Reference Load Cell

The calibration architecture supports a reference load cell where applicable.

The HAL remains responsible only for obtaining the measurement channels.

Calibration logic belongs to Calibration Services.

Hardware Configuration

Hardware configuration may include

Machine Model

Controller

Communication Adapter

Register Mapping

Load Cells

Extensometers

Encoder

Speed Limits

Clutch Configuration
Configuration Storage

Hardware configuration shall be persisted through the Configuration / Repository architecture.

It shall not be hard-coded into ViewModels.

Configuration Change

Hardware configuration changes shall be

Authorized

Validated

Audited
Configuration Version

A configuration version should be associated with Test Sessions where hardware configuration affects measurement or motion behavior.

Historical Traceability

A completed Test should be able to identify the hardware configuration used during execution.

Hardware Adapter Structure

Recommended conceptual structure

Infrastructure
│
└── Hardware
    │
    ├── HAL
    │   ├── IMachineController
    │   ├── IMotionController
    │   └── IMeasurementController
    │
    ├── Machine
    │   └── ShimadzuMachineAdapter
    │
    ├── Communication
    │   ├── ICommunicationAdapter
    │   └── FatekCommunicationAdapter
    │
    ├── Drive
    │   └── VS20NLAdapter
    │
    ├── Sensors
    │   ├── LoadCellAdapter
    │   ├── ExtensometerAdapter
    │   └── EncoderAdapter
    │
    └── Simulation
        └── SimulationMachineAdapter
VS20NL-P1 Adapter

The VS20NL-P1 adapter encapsulates drive-specific behavior.

It may translate

Speed

Direction

Stop

Enable

State

into the actual communication representation.

Fatek Adapter

The Fatek adapter encapsulates communication with the PLC / communication server.

The upper application layers shall not know the Fatek protocol details.

Autograph_SVR Integration

If Autograph_SVR is required for the installed system, it should be integrated behind the Communication Adapter.

This prevents application-wide dependency on the executable or vendor-specific communication API.

Vendor Dependency

Vendor-specific components should be isolated in Infrastructure.

Example

Vendor DLL

↓

Adapter

↓

Stable Application Interface
Vendor Replacement

If the communication mechanism is later replaced

Fatek

↓

Other PLC Protocol

only the Infrastructure adapter should require substantial modification.

Hardware Testability

Every hardware interface should have

Real Implementation

Simulation Implementation

where practical.

Hardware Integration Test

Integration testing should verify

Connect

Identify

Read State

Read Sensors

Set Speed

Jog

Stop

Fault Detection

Disconnect

on appropriate test hardware.

No Hardware in Unit Tests

Normal unit tests shall not require physical machine access.

Fault Injection

Simulation should support controlled fault injection.

Examples

Communication Lost

Drive Fault

Sensor Lost

Emergency Stop

Invalid Feedback

Stale Feedback
Hardware Error Codes

Examples

HW_NOT_CONNECTED

HW_COMMUNICATION_TIMEOUT

HW_DRIVE_FAULT

HW_SENSOR_FAULT

HW_EMERGENCY_STOP

HW_INVALID_STATE

HW_CONFIGURATION_INVALID
Machine Readiness

Machine readiness shall be calculated from normalized hardware information.

Conceptually

Connected

+

No Critical Fault

+

Required Sensors Available

+

Valid Configuration

+

Machine Safe

=

Machine Ready
Test Readiness

Machine Ready is necessary but not sufficient.

Machine Ready

+

Valid Method

+

Valid Specimen

+

Valid Calibration

+

Valid Channels

=

Test Ready
Hardware and Test Runtime

The Test Runtime owns the execution state machine.

The HAL only reports hardware state and executes authorized commands.

Hardware and Calculation

The HAL provides measurements.

The Calculation Service determines engineering properties.

HAL

↓

Measured Data

↓

Calculation Service

↓

Engineering Results
Hardware and UI

The UI receives normalized state and values.

Hardware

↓

HAL

↓

Runtime

↓

ViewModel

↓

View

The View must never access hardware directly.

Safety-Critical Rule

A software command failure shall never be interpreted as proof that physical motion has stopped.

The application must rely on actual machine feedback and independent safety systems.

Communication Health Indicator

The UI may display

Connected

Healthy

Degraded

Fault

Disconnected

based on normalized communication health.

Communication Health

Possible factors

Connection State

Last Response Time

Timeout Count

Error Count

Heartbeat

Channel Validity
Degraded State

The system may enter Degraded state when communication remains available but quality is below normal operating requirements.

Critical Communication Loss

If the communication layer cannot reliably determine machine state during an active test, the Runtime shall transition to the appropriate safe software state and require operator intervention.

Design Constraints

The HAL SHALL NOT

Depend on WPF
Depend on ViewModels
Expose raw PLC registers to UI
Invent PLC registers
Assume unavailable PLC functionality
Replace physical safety systems
Calculate engineering properties
Decide material acceptance
Modify calibration silently
Architectural Decision (FROZEN)

All physical machine communication shall be isolated behind a Hardware Abstraction Layer and Hardware Adapter architecture.

Fatek communication, Autograph_SVR, VS20NL-P1, PLC registers, drive-specific commands and vendor-specific interfaces shall remain below the stable application-level hardware interfaces.

The application shall use normalized machine state, motion commands and engineering measurement channels.

The architecture shall support both real hardware and simulation implementations.

Hardware configuration, register mapping and calibration references shall be versioned and traceable where they affect test execution or measurement integrity.

The software safety layer shall never be considered a replacement for physical machine safety systems.

This decision is permanent.

Next Chapter

ARCH-065

Machine State Machine, Motion Control & Test Runtime Coordination

This chapter will define

Machine State Machine
Test Runtime State Machine
State Transitions
Start / Stop
Pause / Resume
JOG
Motion Commands
Interlocks
Fault Handling
Emergency Stop Handling
Test Initialization
Test Finalization
Hardware Feedback
Command Arbitration
Runtime Ownership
State Recovery
Abort Logic
Safe-State Rules
End of Chapter