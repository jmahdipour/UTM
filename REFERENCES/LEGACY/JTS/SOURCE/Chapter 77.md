# ARCHITECTURE
# Chapter 77
# Method Engine Architecture, Standards, Speed Control, Yield Detection, Young's Modulus, Break Detection & Method Versioning

Document ID

ARCH-077

Version

0.1

Status

FROZEN

Related EDR

EDR-082

Depends On

ARCH-068 Method Engine

ARCH-075 Sensor Architecture

ARCH-076 Calibration Architecture

---

# Purpose

This chapter defines the Method Engine architecture for the Universal Testing Machine.

The Method Engine determines how a Test shall be executed, measured, evaluated and reported.

The Method is therefore the central definition connecting

```text
Standard

Material

Specimen

Sensors

Control

Speed

Acquisition

Detection

Calculation

Acceptance Criteria

Reporting
Core Principle

A Test executes a Method Snapshot.

The Test must never execute a mutable Method definition directly.

Method Definition

↓

Method Version

↓

Method Snapshot

↓

Test Execution
Method Architecture
+-----------------------------+
| Method Library              |
+--------------+--------------+
               |
               v
+-----------------------------+
| Method Version              |
+--------------+--------------+
               |
               v
+-----------------------------+
| Method Validation           |
+--------------+--------------+
               |
               v
+-----------------------------+
| Test Method Snapshot        |
+--------------+--------------+
               |
               v
+-----------------------------+
| Test Execution Engine       |
+-----------------------------+
Method Definition

A Method defines the complete execution and evaluation procedure.

Method Identity

Example

ISO6892-1-TENSION

The identity remains stable while versions may change.

Method Version

Example

ISO6892-1-TENSION

v1

v2

v3
Version Rule

A published Method Version is immutable.

Changes create a new version.

Method Metadata

At minimum

MethodId

Name

Description

Standard

Version

Status

CreatedBy

CreatedAt

UpdatedAt
Method Status

Recommended

Draft

Validated

Approved

Published

Retired
Draft

Method is being configured.

It cannot normally be used for production Tests.

Validated

Technical validation has passed.

Approved

Authorized for use.

Published

Available in the Method Library.

Retired

No longer available for new Tests but remains historically traceable.

Standards

The Method Engine must support standards as configuration entities.

Examples include

ISO 6892-1

ASTM E8

ASTM E111

API 5L

ASTM A370

ASTM E290

ASTM E855

ISO 7438

ISO 5173

ISO 17025

INSO 3132
Standard Identity

Each standard should have

StandardId

Name

Version / Edition

Description

Status
Standard vs Method

A Standard is a normative reference.

A Method is the executable laboratory procedure configured for the machine.

Therefore

Standard

!=

Method
Example
Standard

ISO 6892-1

may be represented by

Method

ISO6892-1 Tensile Test
Standard Edition

The Method must record the applicable edition / version of the Standard.

No Silent Standard Update

Updating the Standard Library must not automatically alter existing Method Versions.

Material Library

A Method may reference a Material Definition.

Examples

Steel

Aluminum

Rebar

Pipe

Plate

Custom Material
Material Properties

Depending on the Method

MaterialName

Grade

Elastic Modulus

Expected Strength

Expected Yield

Density

Other Properties

may be stored.

Method Does Not Assume Material

A Method may be generic.

The actual Test supplies the selected Material / Grade.

Specimen Geometry

The Method must support compatible specimen geometry.

Examples

Round

Flat

Square

Pipe

Custom
Geometry Parameters

Examples

Diameter

Width

Thickness

OuterDiameter

InnerDiameter

GaugeLength

OriginalArea
Geometry Snapshot

The Test stores the actual geometry values.

Method Sensor Configuration

The Method may define

Load Cell

Extensometer

Crosshead Encoder

Force Channel

Extension Channel

Displacement Channel
Load Cell Requirement

The Method may specify

Specific Load Cell

or

Compatible Capacity Range
Extensometer Requirement

The Method may specify

Required

Optional

Preferred

Not Used
Crosshead Requirement

The Method may specify whether crosshead displacement is

Required

Allowed

Not Used
Measurement Source

For each calculated quantity the Method must define the measurement source.

Example

Strain

=

Extensometer

or

Strain

=

Crosshead Displacement
Source Priority

Where alternatives are permitted

Preferred Source

Fallback Source

must be explicitly configured.

No Implicit Source Switching

The engine must never silently change the measurement source without a Method rule.

Clutch Configuration

The machine has two clutch ratios.

1:1

1:10
Default Clutch

The configured default is

1:10

unless the operator explicitly changes it before Test execution.

1:1 Clutch

Typical use

Positioning

Plastics

Metal

Other configured applications
1:10 Clutch

Typical use is higher-speed / measurement configuration according to the machine setup.

The final mechanical meaning must follow the machine configuration.

Clutch Snapshot

The selected clutch must be stored in the Test Snapshot.

Clutch Cannot Change During RUNNING

Changing the clutch during Test execution is prohibited.

Speed Configuration

The Method must define the Test speed strategy.

Speed Types

The architecture shall support at least

Fixed Crosshead Speed

Method A

Method B

Force Rate

Stress Rate

Strain Rate

where applicable to the selected Standard and Method.

Fixed Speed

Example

10 mm/min
Fixed Speed Definition
SpeedValue

SpeedUnit

Example

10

mm/min
Machine Maximum Speed

The current machine maximum speed is

500 mm/min
Speed Validation

Requested speed must satisfy

0 < RequestedSpeed <= MachineMaximumSpeed

subject to the applicable operating limits.

Method A

The Method Engine must represent the configured Method A control strategy explicitly.

The exact target rate, transition and control logic must be associated with the selected Standard / Method Version.

Method B

Method B must likewise be explicitly configured rather than inferred from a generic speed value.

Fixed Speed vs Standard Rate

The Method must distinguish

Control Mode

Target Value

Unit

Transition Rules
Force Rate

Force rate may be represented as

kN/s

or another configured force unit / time combination.

Stress Rate

Stress rate may be represented as

MPa/s
Strain Rate

Strain rate may be represented according to the applicable Method and measurement source.

Rate Conversion

The Method Engine may convert between equivalent control representations only when the required inputs are available and the conversion is valid.

Rate Safety

The system must not convert a rate using incomplete specimen geometry or missing sensor data.

Preload

A Method may define a preload.

Example

Preload = 0.5 kN
Preload Purpose

Preload may be used to

Seat Specimen

Remove Slack

Establish Reference

Start Measurement

depending on the Method.

Preload Validation

Preload must not exceed the configured safe / valid range.

Test Start Condition

The Method may define

Start After Preload

Start Immediately

Start After Stabilization
Gauge Length

The Method may define the expected gauge length.

The actual Test must store the measured / entered value.

Initial Gauge Length
L0

must be part of the Test snapshot when required by the Method.

Cross-Sectional Area

The Method may require

A0

as an initial cross-sectional area.

Stress Calculation

Conceptually

Stress = Force / A0

subject to the exact calculation requirements of the applicable Method.

Engineering Strain

For an extensometer

Strain = ΔL / L0

where

ΔL = CurrentExtension - InitialExtension
Method Calculation Source

Every derived quantity must have an explicitly defined source.

Yield Detection

Yield detection is a major Method Engine responsibility.

Yield Concepts

The system must support configurable yield definitions such as

Rp0.2

Rp0.1

Rt0.5

where required by the applicable Method.

Proof Stress

For a proof-stress method, the engine identifies the stress corresponding to the configured permanent strain offset.

Rp0.2

Conceptually

Rp0.2

=

Stress corresponding to

0.2% permanent strain

The actual algorithm must follow the selected Method / Standard definition.

Rp0.1

Conceptually

Rp0.1

=

Stress corresponding to

0.1% permanent strain
Rt0.5

Conceptually

Rt0.5

=

Stress corresponding to

0.5% total / configured strain criterion

The exact interpretation must be tied to the applicable Standard and Method Version.

Proof Line

The calculation typically uses an offset line based on the elastic portion of the stress-strain curve.

Generic Concept
Stress

^

|             /
|            /
|           /
|          /
|---------/----  Offset Line
|        /
|       /
+------------------> Strain
Elastic Region

The Method must define or determine the region used for the elastic slope.

Young's Modulus

The architecture must support Young's modulus calculation.

ASTM E111

ASTM E111 is a supported reference for elastic modulus calculation.

Young's Modulus

Conceptually

E = ΔStress / ΔStrain

within the valid elastic region.

Elastic Region Selection

The Method may define

Start Strain

End Strain

or another approved selection strategy.

Automatic Elastic Region

Where automatic detection is required, the engine may search for the longest / most uniform linear region subject to configured constraints.

Slope Quality

A candidate elastic region should be evaluated using metrics such as

R²

Residual Error

Slope Stability

Point Count
Minimum Point Count

The Method should define a minimum number of valid samples for modulus calculation.

Modulus Result

The result should include

YoungsModulus

Unit

StartPoint

EndPoint

PointCount

FitQuality
Yield Detection Architecture
Acquired Data

↓

Preprocessing

↓

Elastic Region

↓

Elastic Fit

↓

Offset Line

↓

Curve Intersection

↓

Yield / Proof Stress
Data Preprocessing

Preprocessing may include

Invalid Sample Removal

Noise Filtering

Unit Conversion

Zero Correction

Calibration
No Destructive Processing

Raw acquired measurements must remain preserved.

Derived Data

Filtered / processed data should be represented separately from raw data.

Yield Search Range

The Method may define a search range.

Example

0% to 20% strain

or another configured range.

Yield Detection Constraint

The engine must not search the entire curve if the Method specifies a restricted region.

Yield Detection Marker

A local decrease in force may be an important indicator for yield in some materials / Methods.

However, a simple force drop must not universally be treated as yield.

Force Drop Logic

Where explicitly configured

Force Increase

↓

Local Maximum

↓

Defined Decrease

↓

Candidate Yield Event
Force Drop Threshold

The Method may define

Minimum Force Drop

Minimum Duration

Minimum Strain Interval
Noise Rejection

Small force fluctuations must not be classified as yield events.

Yield Candidate Ranking

If multiple candidates exist, the engine may rank them using

Magnitude

Location

Curve Shape

Method Constraints
Uniform Slope

For automatic elastic / yield region detection, the engine may identify the longest region with relatively uniform slope.

Candidate Segment

A candidate segment can be evaluated by

Slope

R²

Residual

Length

PointCount
Best Linear Segment

The engine may select the segment satisfying the Method criteria with the strongest combination of

Linearity

Length

Stability
No Universal Algorithm

Yield detection algorithms must be Method-specific.

Break Detection

Break detection determines when the specimen has fractured or the Test has reached its defined completion condition.

Generic Break Pattern
Force

^

|             /\
|            /  \
|           /    \
|          /      \
|_________/        \____
                    \
                     \

+--------------------------> Time
Maximum Force

The engine must track

Fmax
Post-Maximum Drop

A potential break event may be detected when

Force reaches Fmax

↓

Force decreases by configured threshold
Break Detection Threshold

The Method may define

Absolute Drop

Percentage Drop

Rate of Drop

Minimum Duration
Example

Conceptually

Break if

ForceAfterPeak <=

Fmax × (1 - Threshold)

where Threshold is Method-defined.

Do Not Hard-Code Break Threshold

Different materials and Methods may require different criteria.

Break Detection Confirmation

A single noisy sample should not necessarily trigger completion.

Confirmation Window

The engine may require

Peak

↓

Sustained Drop

↓

Confirmation
Test Completion

Possible completion reasons

Break

Maximum Extension

Maximum Force

Method Completion

Operator Stop

Safety Stop

Sensor Fault

Controller Fault
Completion Reason

The final Test must store the exact reason.

Method Limits

A Method may define

MaximumForce

MaximumExtension

MaximumStrain

MaximumTime
Safety Limit vs Method Limit

These are separate.

Safety Limit

>

Method Limit

A safety limit must not be weakened by Method configuration.

Control Profile

The Method may define control phases.

Example
Phase 1

Preload

↓

Phase 2

Initial Speed

↓

Phase 3

Elastic / Controlled Rate

↓

Phase 4

Yield Region

↓

Phase 5

Post-Yield

↓

Phase 6

Break / Completion
Phase Definition

Each phase may contain

PhaseId

Name

ControlMode

Target

Unit

EntryCondition

ExitCondition

Limits
Phase Transition

Transitions must be deterministic.

Example
Preload

↓

PreloadReached

↓

TestSpeed
Control Mode

Supported conceptual modes

CrossheadSpeed

ForceRate

StressRate

StrainRate

Hold

Stop
Hold Phase

A Method may require a hold.

Example

Hold

Target = 10 kN

Duration = 5 s
Control Setpoint

The Method Engine produces the target required by the controller.

Controller Boundary
Method Engine

↓

Control Command

↓

Machine Controller

↓

Motor / Drive
Method Engine Does Not Directly Drive Motor

The Method Engine must not write low-level motor commands directly.

Controller Interface

Conceptually

IControllerService
Method Engine Command

Example

SetSpeed

10 mm/min

The controller service translates this to the actual PLC / drive command.

Speed Output

The Method Engine defines the engineering target.

The existing PLC / controller architecture remains responsible for actual hardware implementation.

Method Parameter Validation

Before a Method can be used

All Required Parameters Present

↓

All Units Compatible

↓

All Sensors Compatible

↓

All Limits Valid

↓

All Control Phases Valid

↓

Method Approved
Method Validation Errors

Examples

MissingLoadCell

MissingGaugeLength

InvalidSpeed

SpeedExceedsMachineLimit

MissingArea

InvalidExtensometer

InvalidRate

MissingYieldDefinition

InvalidBreakDefinition
Method Warning Examples
SensorNearCapacity

OptionalExtensometerUnavailable

HighSpeed

LowExpectedResolution
Method Snapshot

At Test creation / start, the complete effective Method configuration must be copied into the Test Snapshot.

Snapshot Contents

At minimum

MethodId

MethodVersion

Standard

StandardEdition

Material

Geometry

SensorSelection

Clutch

SpeedConfiguration

ControlPhases

YieldDefinition

ModulusDefinition

BreakDefinition

AcceptanceCriteria

ReportingOptions
Method Immutability

Once a Test starts, the Method Snapshot cannot be modified.

Method Result Definitions

A Method defines which results are required.

Examples

MaximumForce

YieldStress

Rp0.2

Rp0.1

Rt0.5

TensileStrength

YoungsModulus

Elongation

ExtensionAtBreak

ReductionOfArea
Result Availability

A result may be

Required

Optional

NotApplicable
Result Status

Recommended

Valid

Invalid

NotCalculated

InsufficientData

OutOfRange
Acceptance Criteria

A Method may define limits such as

YieldStrength >= Minimum

TensileStrength >= Minimum

Elongation >= Minimum
Acceptance Result

The Test may report

PASS

FAIL

NOT EVALUATED
Acceptance vs Calculation

Calculation produces a numeric result.

Acceptance evaluates that result.

These are separate operations.

Example
YieldStrength = 420 MPa

then

Required >= 400 MPa

produces

PASS
Reporting Configuration

The Method may define which results appear in reports.

Reporting Options

Examples

Force

Displacement

Stress

Strain

Yield

Young's Modulus

Maximum Force

Break

Acceptance
Graph Configuration

The Method may define

X Axis

Y Axis

Units

Curve Visibility

Guide Lines

Markers
Guide Lines

The UI should support toggling guide lines for applicable calculations.

Examples

Yield Offset Line

Elastic Fit Line

Break Marker
Point Selection

The Method / Analysis UI may allow selection of graph points for inspection.

Raw Data Preservation

Method calculations must always be reproducible from preserved measurement data.

Calculation Pipeline
Raw Samples

↓

Sensor Calibration

↓

Unit Normalization

↓

Zero Correction

↓

Derived Channels

↓

Stress / Strain

↓

Feature Detection

↓

Result Calculation

↓

Acceptance

↓

Report
Calculation Order

The order is important.

Example

Stress should not be calculated from an uncalibrated raw load-cell value.

Correct

Raw Force

↓

Calibration

↓

Force

↓

Stress
Strain Calculation

Correct

Raw Extension

↓

Calibration

↓

Extension

↓

ΔExtension

↓

Strain
Modulus Calculation

Correct

Stress

+

Strain

↓

Elastic Region

↓

Linear Fit

↓

Young's Modulus
Yield Calculation

Correct

Stress-Strain

↓

Elastic Fit

↓

Offset Construction

↓

Intersection

↓

Rp Result
Break Calculation

Correct

Force-Time / Stress-Strain

↓

Maximum Force

↓

Configured Post-Peak Criteria

↓

Break Event
Method Calculation Engine

Conceptually

IMethodCalculationEngine
Responsibilities
CalculateStress()

CalculateStrain()

CalculateYoungsModulus()

CalculateRp02()

CalculateRp01()

CalculateRt05()

FindMaximumForce()

DetectBreak()

EvaluateAcceptance()
Method-Specific Calculators

Prefer separate strategy implementations.

IYieldCalculator

IModulusCalculator

IBreakDetector

IAcceptanceEvaluator
Yield Strategy
ProofStressCalculator

YieldPointCalculator

CustomYieldCalculator
Modulus Strategy
ASTME111ModulusCalculator

ConfiguredLinearFitCalculator
Break Strategy
PeakDropBreakDetector

ConfiguredBreakDetector
Strategy Selection

The Method Version determines which strategy is used.

No Global Yield Algorithm

There shall not be one universal yield algorithm for all standards.

Method A/B Configuration

The Method Version determines the meaning and control parameters of Method A or Method B.

Fixed Speed Configuration

Example

ControlMode = FixedSpeed

Speed = 10

Unit = mm/min
Force Rate Configuration

Example

ControlMode = ForceRate

Rate = 2

Unit = kN/s
Stress Rate Configuration

Example

ControlMode = StressRate

Rate = 5

Unit = MPa/s
Strain Rate Configuration

Example

ControlMode = StrainRate

Rate = Configured

Unit = 1/s
Control Availability

Not every control mode is valid for every machine configuration.

Control Validation

Example

StrainRate selected

+

No valid extensometer

=

Method Invalid

unless a valid alternative source is configured.

Speed Conversion

When a stress or strain rate must be converted to crosshead speed, the engine requires sufficient information.

Example Inputs
CrossSectionArea

GaugeLength

CurrentForce

CurrentStress

CurrentStrain

MeasurementSource
Missing Data

If required information is unavailable

Control Command = Not Generated

rather than using a guessed value.

Method Versioning

Every change affecting Test behavior creates a new Method Version.

Examples of Version-Triggering Changes
Speed

Yield Algorithm

Break Threshold

Sensor Requirement

Gauge Length Rule

Acceptance Criteria

Control Phase

Standard Edition

Calculation Definition
Non-Behavioral Changes

Purely descriptive changes may be handled according to configuration policy.

Examples

Display Description

Internal Notes
Version Snapshot

Each Test stores

MethodId

MethodVersion

and the effective configuration.

Method Library

The application should provide

Search

Filter

Create

Clone

Edit Draft

Validate

Approve

Publish

Retire
Clone Method

Cloning creates a new Method identity or a new version according to the defined workflow.

The resulting object must not share mutable execution state with the original.

Method Import / Export

Method definitions may be exported and imported.

Potential formats

XML

JSON

CSV

JSON/XML are preferred for structured Method definitions.

Import Validation

Imported Methods must pass the same validation pipeline as locally created Methods.

No Blind Import

Imported Methods cannot immediately bypass approval.

Method Security

Method editing should be permission controlled.

Suggested Permissions
ViewMethod

CreateMethod

EditDraftMethod

ValidateMethod

ApproveMethod

PublishMethod

RetireMethod
Method Audit

Important events should be audited.

Examples

MethodCreated

MethodVersionCreated

MethodValidated

MethodApproved

MethodPublished

MethodRetired
Method Database

Conceptual tables

Methods

MethodVersions

MethodParameters

MethodControlPhases

MethodResults

MethodAcceptanceCriteria

MethodAudit
Methods
MethodId

Name

Description

Status

CreatedAt

UpdatedAt
MethodVersions
MethodVersionId

MethodId

Version

StandardId

StandardEdition

Status

CreatedBy

CreatedAt

ApprovedBy

ApprovedAt
MethodParameters
ParameterId

MethodVersionId

Name

Value

Unit

DataType
MethodControlPhases
PhaseId

MethodVersionId

Sequence

Name

ControlMode

Target

Unit

EntryCondition

ExitCondition
MethodResults
ResultDefinitionId

MethodVersionId

ResultCode

Name

Unit

Required

ReportingEnabled
Acceptance Criteria Table
CriterionId

MethodVersionId

ResultCode

Operator

TargetValue

MinimumValue

MaximumValue
Method Snapshot Table

Conceptually

TestMethodSnapshots
Snapshot Data

The snapshot should preserve the effective Method definition used by the Test.

Method Execution State

During Test execution the engine maintains runtime state separately from the immutable Method definition.

Runtime State

Examples

CurrentPhase

CurrentTarget

CurrentControlMode

YieldCandidate

MaximumForce

BreakDetected

CompletionReason
Method Definition vs Runtime State
Method

=

What should happen?
Runtime State

=

What is happening now?
Method Engine State Machine
PREPARE

↓

PRELOAD

↓

INITIAL_CONTROL

↓

TEST_CONTROL

↓

FEATURE_DETECTION

↓

POST_PROCESS

↓

COMPLETE
Fault Transition

At any phase

ANY STATE

↓

FAULT
Stop Transition
ANY RUNNING STATE

↓

CONTROLLED STOP

↓

COMPLETE
Method Abort

An operator stop must not be confused with a specimen break.

Completion Reason Examples
SpecimenBreak

MaximumExtension

MaximumForce

MethodCompleted

OperatorStopped

SafetyStopped

SensorFault

ControllerFault
Method Event System

Important Method Engine events should include

PhaseChanged

SetpointChanged

YieldCandidateDetected

YieldDetected

MaximumForceUpdated

BreakCandidateDetected

BreakDetected

MethodCompleted

MethodFaulted
Event Traceability

Events may be persisted in the Test event log.

Acceptance Criteria

ARCH-077 is accepted when

Method definitions are separate from Test execution.

Method Versions are immutable after publication.

Standards are represented independently from Methods.

ISO 6892-1 is supported.

ASTM E8 is supported.

ASTM E111 is supported.

API 5L is supported.

ASTM A370 is supported.

ASTM E290 is supported.

ASTM E855 is supported.

ISO 7438 is supported.

ISO 5173 is supported.

ISO 17025 is supported.

INSO 3132 is supported.

Material references are supported.

Specimen geometry is supported.

Load-cell selection is supported.

Extensometer selection is supported.

Crosshead displacement is supported.

1:1 clutch is supported.

1:10 clutch is supported.

Default clutch is 1:10.

Clutch selection is snapshotted.

Maximum machine speed is represented as 500 mm/min.

Fixed speed is supported.

Method A is representable.

Method B is representable.

Force rate is supported.

Stress rate is supported.

Strain rate is representable.

Preload is supported.

Gauge length is supported.

Initial area is supported.

Rp0.2 is supported.

Rp0.1 is supported.

Rt0.5 is supported.

Young's modulus is supported.

ASTM E111-related modulus configuration is representable.

Yield detection is Method-specific.

Force-drop candidate detection is configurable.

Uniform-slope analysis is supported.

Break detection is configurable.

Maximum force is tracked.

Completion reason is stored.

Control phases are supported.

Method limits are supported.

Acceptance criteria are supported.

Reporting options are supported.

Guide lines are supported.

Raw measurement data remains preserved.

Derived calculations are separated from raw data.

Method snapshots are immutable during Test execution.

Method changes create new versions.

Imported Methods require validation.

Method actions are auditable.

Architectural Decision (FROZEN)

The Method Engine is the authoritative definition of how a Test is performed and evaluated.

A Test shall execute an immutable Method Snapshot.

Standards, Methods, Method Versions and Test Snapshots are distinct entities.

Sensor selection, speed control, clutch selection, control phases, feature detection, calculations, acceptance criteria and reporting behavior shall be Method-controlled.

Yield detection, proof stress, modulus calculation and break detection shall be Method-specific and shall not rely on one universal algorithm.

The Method Engine shall never directly control low-level motor hardware.

Hardware commands shall pass through the Controller Service.

Raw measurements shall always be preserved independently from processed and calculated data.

Changing a Method after a Test has started is prohibited.

Changing a published Method creates a new Method Version.

Historical Tests shall retain the exact Method Version and effective configuration used during execution.

This decision is permanent.

Next Chapter

ARCH-078

Test Execution State Machine, Test Lifecycle, PREPARE/RUNNING/HOLD/STOP/FAULT/COMPLETE, Controller Commands, Safety Interlocks, Start/Stop/Pause/Resume, Test Event Log & Recovery

This chapter will define

Test Lifecycle
Test States
PREPARE
READY
PRELOAD
RUNNING
HOLD
PAUSED
STOPPING
COMPLETE
FAULT
ABORTED
State Transitions
Start Preconditions
Stop Preconditions
Pause
Resume
Emergency Stop
Controller Fault
Sensor Fault
Safety Interlock
Door / Guard Interlock
Upper / Lower Travel Limits
Maximum Load
Maximum Speed
Test Event Log
Recovery
Crash Recovery
Operator Actions
Automatic Actions
Completion Reason
Test Result Lock
Test Finalization