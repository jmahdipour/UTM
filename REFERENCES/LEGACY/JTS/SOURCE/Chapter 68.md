# ARCHITECTURE
# Chapter 68
# Method Engine, Standards, Test Parameters & Execution Profile

Document ID

ARCH-068

Version

0.1

Status

FROZEN

Related EDR

EDR-073

Depends On

ARCH-053 Test Execution Architecture

ARCH-056 Engineering Detection & Mechanical Property Algorithms

ARCH-067 Engineering Data Model

ARCH-064 Hardware Abstraction Layer

---

# Purpose

This chapter defines the Method Engine.

The Method Engine determines how a Test shall be performed.

It defines

- Standard
- Test type
- Specimen configuration
- Load cell
- Extensometer
- Crosshead measurement
- Speed control
- Force / stress rate
- Clutch
- Test sequence
- Yield detection
- Break detection
- Calculation options
- Reporting options

The Method Engine does not directly control hardware.

It produces an immutable Test Execution Profile consumed by the Runtime and Controller layers.

---

# Core Principle

The Method is the engineering definition of the Test.

The execution chain is

```text
Method Definition

↓

Method Validation

↓

Test Execution Profile

↓

Test Runtime

↓

Controller / HAL

↓

Measurement Acquisition

↓

Engineering Calculation
Method Definition

A Method is a reusable engineering configuration.

Example

ISO 6892-1
Tensile Test
25 ton Load Cell
Extensometer
10 mm/min
Rp0.2
Break Detection
Method Identity

Every Method shall have

MethodId

MethodVersion

MethodName

Standard

TestType
Method Version

Methods shall be versioned.

Example

MethodId       = ISO6892_TENSION
MethodVersion  = 3

A Test shall retain the exact version used.

Method Immutability

Once a Method Version has been used by a completed Test, that version shall not be modified.

A new version shall be created.

Method Lifecycle

Recommended states

Draft

Validated

Active

Deprecated

Archived
Draft

The Method is being configured and has not yet been approved for execution.

Validated

The Method has passed configuration validation.

Active

The Method can be selected for a new Test.

Deprecated

The Method remains available for historical interpretation but should not normally be selected for new Tests.

Archived

The Method is retained for historical traceability only.

Method Capacity

The application shall support multiple reusable Methods.

The existing project requirement allows up to approximately 20 Methods in the standard operational configuration.

Method Components

A Method consists conceptually of

Method Identity

Standard

Test Type

Specimen Rules

Sensor Configuration

Speed Configuration

Control Configuration

Detection Configuration

Calculation Configuration

Reporting Configuration
Standard

The Standard identifies the engineering reference used by the Method.

Supported standards may include

ISO 6892-1

ASTM E8

ASTM E111

ASTM E290

API 5L

ASTM A370

ISO 7438

ISO 5173

Additional standards may be added through the Method architecture.

Standard Is Not Test Type

The Standard and Test Type are separate.

Example

Standard = ISO 6892-1

TestType = Tensile
Test Type

The architecture shall support at least

Tension

Compression

Bend

Flexure

Shear

Custom

The actual enabled types depend on the implemented machine capabilities.

Method Name

MethodName is the operator-facing identifier.

Example

ISO 6892-1 Rebar Tensile
Description

A Method may contain a human-readable description.

Specimen Rules

The Method may define required specimen geometry.

Examples

Round

Square

Pipe

Flat

Custom
Geometry Requirement

A Method may require

Diameter

Width

Thickness

External Diameter

Wall Thickness

Gauge Length

according to the applicable Standard.

Geometry Validation

Before execution

Required Dimensions

↓

Validate

↓

Calculate A0

↓

Confirm
Cross-Section Area

The Method may specify whether A0 is

Automatically Calculated

Operator Entered

Standard Derived
Initial Gauge Length

The Method shall specify whether L0 is

Required

Optional

Derived
Sensor Configuration

The Method defines required measurement channels.

Examples

Force

Crosshead Position

Extensometer
Load Cell Selection

The Method may select a specific load cell.

Available configurations include

25 ton

10 ton

2 ton

500 kg

100 kg
Load Cell Rule

The Runtime shall verify that the selected load cell is available and valid before Test start.

Load Cell Mismatch

If the Method requires a load cell that is unavailable

Test Start = Blocked
Load Cell Calibration

The Method references the required calibrated load-cell configuration.

Calibration itself is not part of the Test sequence.

Extensometer Selection

The Method may specify

No Extensometer

100 mm Configuration

50 mm Configuration

25 mm Configuration

The exact device identity remains hardware configuration data.

Extensometer Requirement

If the Method requires an extensometer

Extensometer Ready

must be true

before automatic execution begins.

Crosshead Measurement

The Method may select crosshead position as

Measurement Only

Control Feedback

Strain Source

The permitted use depends on the Method.

Strain Source

The Method shall explicitly define the source of engineering strain.

Possible values

Extensometer

Crosshead

Operator Defined
Strain Source Priority

If the Standard requires extensometer data and the Method specifies an extensometer

Extensometer

>

Crosshead
Speed Configuration

The Method defines how machine speed is controlled.

Supported conceptual modes include

Fixed Speed

Method A

Method B

Force Rate

Stress Rate
Fixed Speed

Example

10 mm/min

The controller receives a fixed crosshead-speed setpoint.

Speed Unit

Typical unit

mm/min
Method A

Where supported by the selected Standard, Method A shall represent the relevant strain-rate-controlled procedure.

The exact rate and transition rules shall be stored as Method parameters.

Method B

Where supported, Method B shall represent the relevant stress-rate / strain-rate procedure defined by the selected Standard.

The exact control definition shall remain Standard-specific.

Important Rule

The Method Engine shall not assume that Method A or Method B has the same implementation across all Standards.

Fixed Speed vs Method A/B

These are separate configuration modes.

SpeedMode = Fixed

is not equivalent to

SpeedMode = MethodA

unless the Standard explicitly defines equivalence.

Force Rate

A Method may specify

ForceRate = kN/s

when supported by the controller and applicable Standard.

Stress Rate

A Method may specify

StressRate = MPa/s

when required by the selected procedure.

Controller Conversion

If the controller requires force-rate or stress-rate information to be converted into a machine command, the conversion shall occur in the Control layer.

The Method Engine only provides the engineering target.

Speed Limits

Every Method execution must remain inside the machine's configured safe operating limits.

Machine Maximum Speed

The current machine context specifies a maximum crosshead speed of approximately

500 mm/min

The Method Engine must validate requested speed against the active machine configuration.

Speed Validation

Conceptually

RequestedSpeed <= MachineMaximumSpeed

must hold.

Minimum Speed

If the controller has a minimum valid speed, the Method shall also respect that limit.

Speed Transition

A Method may define multiple execution phases.

Example

Preload

↓

Approach

↓

Elastic Region

↓

Yield Region

↓

Post-Yield

↓

Break
Execution Phase

Each phase may contain

PhaseId

ControlMode

Target

Rate

Limit

TransitionCondition
Phase Sequence

The Runtime shall execute phases in a deterministic order.

Preload

A Method may define an initial preload.

Example

Preload = 1 kN

The actual value is Method-specific.

Preload Validation

The preload must not exceed configured machine or specimen safety limits.

Zeroing

The Method may specify whether measurement zeroing is required before Test execution.

Zeroing must not be confused with calibration.

Calibration vs Zeroing

Calibration establishes measurement correctness.

Zeroing establishes the Test reference point.

They are different operations.

Zero Reference

For example

Force Zero = Test Start Reference

Position Zero = Test Start Position

Extension Zero = Test Start Extension

where supported.

Clutch

The Method may contain a clutch selection.

The current machine configuration contains

1:1

1:10
Default Clutch

The project requirement defines

Default = 1:10

unless manually changed or overridden by a validated Method.

Clutch Usage

The Method should identify the intended operating range.

Example

1:1

Positioning / plastics / metal

and

1:10

Default testing configuration

The exact mechanical behavior remains machine-specific.

Clutch Validation

The Runtime shall confirm that the requested clutch state is physically available before automatic motion.

Clutch Change During Test

Changing the clutch during an active automatic Test shall be prohibited unless a specific Method explicitly defines and validates such a transition.

Cycle Test

The Method may define a cyclic procedure.

Conceptually

Cycle 1

↓

Cycle 2

↓

Cycle 3

Each cycle may contain

Target

Loading Rate

Unloading Rate

Hold Time

Repeat Count
Single Test

A single Test is a continuous execution sequence without repeated cyclic phases.

Cycle Definition

A cycle may contain

Load

Hold

Unload

Return

depending on the Standard.

Hold

A Method may define a force, displacement or time-based hold.

Hold Accuracy

The controller shall determine how the target is maintained.

The Method only defines the required target and tolerance.

Transition Conditions

Transitions may depend on

Force

Position

Extension

Time

Detected Event
Example
Preload

↓

Force >= PreloadTarget

↓

Begin Main Test
Event-Based Transition

A Method may transition after

YieldDetected

when the applicable procedure requires it.

Yield Configuration

The Method may enable

Rp0.1

Rp0.2

Rt0.5
Offset Configuration

The Method may define the offset strain.

Examples

0.1 %

0.2 %

0.5 %
Yield Detection Range

The Method may define the range used for detection.

This is especially important for algorithms that search for a characteristic slope change or force decrease.

Yield Detection Policy

The Method Engine stores the parameters.

The Detection Engine performs the calculation.

Important Separation
Method

=

What parameters to use
Detection Engine

=

How to calculate
Break Detection

The Method may define

BreakEnabled

BreakDropThreshold

MinimumForce

PostPeakRequirement

or equivalent engineering parameters.

Maximum Force

The Method may require maximum-force detection.

Break Detection Concept

A generic detection sequence may be

Detect Fmax

↓

Observe subsequent force decrease

↓

Check break conditions

↓

Determine break point

The exact algorithm is defined in ARCH-056.

Extensometer Removal

Some Standards require extensometer removal before specimen failure.

A Method may define

ExtensometerRemovalRequired = True

The Runtime shall then require an operator or controlled action before the relevant stage.

Removal State

Conceptually

Attached

RemovalRequired

Removed

Verified
Extensometer Protection

If extensometer removal is required, the Test Runtime must not continue into the hazardous region without satisfying the configured condition.

Calculation Options

Method calculations may include

Young's Modulus

Yield Strength

UTS

Elongation

Reduction of Area

Break Force

Only properties applicable to the Standard should be enabled.

Young's Modulus

The Method may enable Young's modulus according to the selected Standard / calculation procedure.

ASTM E111 may be used as the governing method where configured.

Reporting Options

The Method may define whether the final report includes

Stress-Strain Curve

Force-Displacement Curve

Mechanical Properties

Specimen Geometry

Acceptance Result

Raw Data Summary

Test Metadata
CSV Export

The Method may enable CSV export.

XML Export

The Method may enable XML interchange.

Graph Options

Method graph configuration may include

Show Stress-Strain

Show Force-Displacement

Show Guide Lines

Show Yield Marker

Show Maximum Force

Show Break Marker
Material Library Binding

A Method may reference a Material Library entry.

However, the actual material values used by a Test must be snapshotted into the Test.

Material vs Method

Material describes material properties / acceptance requirements.

Method describes how the material is tested.

They are separate entities.

Acceptance Criteria

A Method may reference acceptance rules.

Example

Yield Strength >= Required Value

UTS >= Required Value

Elongation >= Required Value
Acceptance Rule Version

Acceptance criteria shall be versioned where changes could affect Test interpretation.

Method Validation

Before a Method becomes Active

Method Configuration

↓

Structural Validation

↓

Engineering Validation

↓

Hardware Compatibility

↓

Safety Validation

↓

Active
Structural Validation

Checks

MethodName exists

Standard exists

TestType exists

Version valid
Engineering Validation

Checks

Required geometry exists

Required channels exist

Speed mode has parameters

Required calculation parameters exist
Hardware Validation

Checks

Load Cell available

Extensometer available

Crosshead available

Controller available
Safety Validation

Checks

Speed <= Machine Maximum

Force target <= configured limits

Position limits valid

Required protective conditions satisfied
Incompatible Method

If a Method is incompatible with the current machine configuration

MethodStatus = NotExecutable

The UI should explain the reason.

Method Validation Message

Example

ISO6892-1 Method cannot execute.

Required load cell: 25 ton

Available load cell: 2 ton
Test Execution Profile

When a Test starts, the Method is converted into an immutable execution profile.

Conceptually

Method

+

Machine Configuration

+

Specimen

+

Operator Options

↓

TestExecutionProfile
Execution Profile

The profile contains all values required by the Runtime.

Example

Standard = ISO 6892-1

TestType = Tensile

LoadCell = 25 ton

Extensometer = 50 mm

SpeedMode = Fixed

Speed = 10 mm/min

Clutch = 1:10

Yield = Rp0.2

BreakDetection = Enabled
Profile Immutability

Once Test Execution begins, the execution profile shall not change.

Runtime Input

The Runtime consumes the profile.

TestExecutionProfile

↓

TestRuntime
Runtime Does Not Query Method

The Runtime should not continuously query the mutable Method database during execution.

It uses the frozen profile.

Method Snapshot

The Test record should retain

MethodId

MethodVersion

ExecutionProfile
Reproducibility

A completed Test must be reproducible from

Method Snapshot

+

Machine Snapshot

+

Specimen Snapshot

+

Measurement Dataset
Machine Snapshot

The execution profile should retain relevant machine configuration.

Examples

Maximum Speed

Active Controller

Load Cell

Extensometer

Encoder Configuration

Clutch Configuration
Operator Overrides

The application may allow controlled Method parameter overrides before Test start.

Examples

Speed

Gauge Length

Specimen Dimensions

Such overrides must be explicit.

Override Rule

An operator override does not modify the reusable Method.

Instead

Method

↓

Test-Specific Override

↓

Execution Profile
Override Audit

The profile should retain

Original Value

Override Value

User

Timestamp

where applicable.

Method UI

The Method Editor should be organized into logical sections.

Recommended

General

Standard

Specimen

Sensors

Control

Speed

Detection

Calculation

Reporting

Acceptance
General Section

Fields

Method Name

Description

Test Type

Status
Standard Section

Fields

Standard

Procedure

Standard Version / Reference
Specimen Section

Fields

Geometry Type

Required Dimensions

Gauge Length

Area Rule
Sensor Section

Fields

Load Cell

Extensometer

Crosshead

Strain Source
Control Section

Fields

Controller

Clutch

Control Mode
Speed Section

Fields

Speed Mode

Fixed Speed

Method A

Method B

Force Rate

Stress Rate
Detection Section

Fields

Yield Type

Offset

Detection Range

Break Detection

Maximum Force
Calculation Section

Fields

Young's Modulus

Yield Strength

UTS

Elongation
Reporting Section

Fields

Graph

Report

CSV

XML
Acceptance Section

Fields

Criteria

Limits

Pass / Fail Rules
Method Storage

Methods should be persisted through the Repository layer.

MethodService

↓

MethodRepository

↓

SQLite
Proposed SQLite Tables

Logical tables include

Methods

MethodVersions

MethodParameters

MethodAcceptanceCriteria

MethodReportOptions

The final schema shall follow the database architecture and normalization rules.

Method Parameter Storage

Parameters should be strongly typed at the domain level.

The UI should not treat engineering parameters as arbitrary strings.

Example

Bad

Speed = "10 mm/min"

Preferred

SpeedValue = 10

SpeedUnit = mm/min
Enumeration

Modes should use enumerations.

Example

SpeedMode.Fixed

SpeedMode.MethodA

SpeedMode.MethodB

SpeedMode.ForceRate

SpeedMode.StressRate
Validation Before Save

A Method cannot be saved as Active if required parameters are missing.

Validation Before Execute

Even an Active Method shall be validated against the current machine before execution.

Double Validation
Method Save Validation

+

Runtime Compatibility Validation

This protects against hardware/configuration changes after Method creation.

Method Compatibility

A Method may be valid in general but incompatible with the current machine.

Example

Method requires 100 mm extensometer

Machine currently has only 50 mm
Compatibility Result

The system should return explicit compatibility information.

Compatible

CompatibleWithWarnings

NotCompatible
Warning Example
Method is valid.

Selected load cell is available but currently requires operator confirmation.
Execution Blocking

Conditions affecting measurement validity or machine safety shall block execution.

Non-Blocking Warning

Informational issues may be warnings.

Example

Method contains optional report output that is unavailable.
Method Change During Test

Method changes are prohibited once the Test enters Running.

Test Restart

If the Test is aborted and restarted, a new Test Execution Profile should be generated.

Historical Method

Completed Tests must retain the Method version even if the Method later becomes Deprecated.

Method Cloning

A Method may be cloned.

The clone receives a new Method Version / identity according to the application policy.

Method Import

Methods may eventually be imported through XML or another controlled format.

Imported Methods must pass validation before activation.

Method Export

Method definitions may be exported for backup or transfer.

Method Security

Only authorized users should be able to modify Active Methods.

Role Separation

Possible roles

Operator

Engineer

Administrator

Method editing may require Engineer or Administrator privileges.

Audit Trail

Important Method actions should generate audit records.

Examples

Created

Modified

Validated

Activated

Deprecated

Cloned

Imported
Method Testing

Every Method should be testable using a simulation / dry-run environment.

Simulation

A simulated machine may validate

Phase Sequence

Speed Transitions

Detection Triggers

Limits

Calculation Inputs

without moving the physical machine.

Dry Run

A dry run shall never generate a valid physical measurement dataset.

Method Unit Tests

Unit tests should verify

Validation

Compatibility

Parameter Conversion

Phase Generation

Execution Profile Creation
Method Integration Tests

Integration tests should verify

Method

↓

Execution Profile

↓

Runtime

↓

HAL Commands
Safety Tests

Every method should be tested against

Overspeed

Overforce

Missing Sensor

Wrong Load Cell

Missing Extensometer

Invalid Geometry

Invalid Target
Example Method
Method Name

ISO 6892-1 Tensile 25T

Standard

ISO 6892-1

Test Type

Tension

Load Cell

25 ton

Extensometer

50 mm

Strain Source

Extensometer

Speed Mode

Fixed

Speed

10 mm/min

Clutch

1:10

Yield

Rp0.2

Maximum Force

Enabled

Break Detection

Enabled

Young's Modulus

Enabled

Stress-Strain Curve

Enabled

CSV Export

Enabled
Execution Example
Operator selects Method

↓

Enter Specimen Dimensions

↓

Validate Geometry

↓

Validate Hardware

↓

Create Execution Profile

↓

Confirm Test

↓

Acquire Measurements

↓

Execute Method

↓

Detect Events

↓

Finalize Dataset

↓

Calculate Results

↓

Evaluate Acceptance

↓

Generate Report
Method Engine Responsibility

The Method Engine is responsible for

Method Definition

Method Versioning

Parameter Validation

Compatibility Validation

Execution Profile Generation
Method Engine Does Not

The Method Engine does not directly perform

PLC Communication

Motor Control

Raw Acquisition

Graph Rendering

SQLite SQL

Physical Calibration

Those responsibilities belong to other layers.

Architectural Boundary
Method Engine
        |
        v
Execution Profile
        |
        v
Test Runtime
        |
        +--> Controller
        |
        +--> Acquisition
        |
        +--> Detection
        |
        +--> Calculation
Acceptance Criteria

ARCH-068 is accepted when

Methods are versioned.

Active Methods are immutable after use.

Methods can be validated.

Methods can be checked against machine compatibility.

Speed modes are explicitly represented.

Fixed speed is distinct from Method A/B.

Load cell and extensometer selection are explicit.

Clutch selection is represented.

Yield and break parameters are represented.

Calculation and reporting options are represented.

Operator overrides are captured in the Test profile.

The Runtime consumes an immutable execution profile.

Completed Tests retain the exact Method version used.

Method configuration is independent from hardware implementation.

Architectural Decision (FROZEN)

A Method is a reusable engineering definition.

A Test never executes directly against a mutable Method record.

At Test start, the Method, specimen information, machine configuration and approved operator options are resolved into an immutable Test Execution Profile.

The Execution Profile is the authoritative definition of how that Test was performed.

Method versions used by completed Tests are immutable.

Changing a Method creates a new version rather than modifying historical configuration.

The Method Engine defines engineering intent and parameters but does not directly control hardware.

Hardware control remains the responsibility of the Controller / HAL layers.

Detection algorithms remain independent from Method storage.

Calculation algorithms remain independent from Method storage.

This decision is permanent.

Next Chapter

ARCH-069

Machine Controller, Motion Control, Speed Profiles & PLC/Drive Integration

This chapter will define

Controller Architecture
PLC Communication
Fatek Communication Server
Autograph_SVR
VS20NL-P1
Drive Commands
Up / Down Control
Speed Setpoint
Position Feedback
Crosshead Motion
JOG
Automatic Motion
Speed Profiles
Acceleration
Deceleration
Motion Limits
Emergency Stop
Interlocks
Clutch State
Controller State
Communication Timeout
Command Acknowledgement
Fault Handling
Manual vs Automatic Control
Hardware Abstraction
No-PLC-Modification Constraint
Register Mapping
Controller Diagnostics
End of Chapter