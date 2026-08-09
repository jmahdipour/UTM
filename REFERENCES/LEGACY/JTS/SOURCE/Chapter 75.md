# ARCHITECTURE
# Chapter 75
# Sensor Architecture, Load Cells, Extensometers, Crosshead Encoder, Calibration Mapping, Sensor Selection & Multi-Sensor Management

Document ID

ARCH-075

Version

0.1

Status

FROZEN

Related EDR

EDR-080

Depends On

ARCH-068 Method Engine

ARCH-069 Machine Controller

ARCH-071 SQLite Database Architecture

ARCH-074 Measurement Acquisition Pipeline

---

# Purpose

This chapter defines the complete sensor architecture for the Universal Testing Machine application.

The architecture covers

```text
Load Cells

Extensometers

Crosshead Encoder

Sensor Identification

Sensor Metadata

Capacity

Range

Resolution

Accuracy

Calibration

Calibration Points

Reference Sensor

Active Sensor

Sensor Selection

Sensor Compatibility

Sensor Switching

Sensor Status

Sensor Fault

Historical Snapshot

Multi-Sensor Management
Core Principle

A sensor is a physical measurement source with its own identity, configuration, calibration and historical traceability.

The application must never treat a sensor as merely a numeric value.

Sensor Architecture
+-----------------------------+
| Physical Sensor             |
+--------------+--------------+
               |
               v
+-----------------------------+
| Sensor Definition           |
|                             |
| ID                          |
| Type                        |
| Capacity                    |
| Range                       |
| Resolution                  |
| Accuracy                    |
+--------------+--------------+
               |
               v
+-----------------------------+
| Calibration                 |
|                             |
| Version                     |
| Points                      |
| Function                    |
| Validity                    |
+--------------+--------------+
               |
               v
+-----------------------------+
| Acquisition Mapping         |
+--------------+--------------+
               |
               v
+-----------------------------+
| Measurement Channel         |
+-----------------------------+
Sensor Types

The current machine configuration supports at least

Load Cell

Extensometer

Crosshead Encoder
Load Cells

The machine has multiple load-cell capacities.

Configured examples

25 ton

10 ton

2 ton

500 kg

100 kg
Load Cell Purpose

A load cell provides the authoritative force measurement for a Test when selected by the active Method.

Load Cell Identity

Each physical load cell must have a unique identifier.

Example

LC-25T-001

LC-10T-001

LC-2T-001

LC-500KG-001

LC-100KG-001

The identifiers above are examples only.

The final identifiers must be configurable.

Load Cell Metadata

Recommended fields

SensorId

SensorName

SensorType

SerialNumber

Capacity

CapacityUnit

MinimumRange

MaximumRange

Resolution

Accuracy

CalibrationId

CalibrationVersion

Status

Active
Capacity

Capacity represents the maximum rated measurement capability.

Example

25 ton
Capacity vs Test Force

The selected sensor must be compatible with the expected Test force.

Example

A Test requiring approximately

180 kN

should not use a

100 kg

load cell.

Minimum Practical Range

The application should also consider the lower useful measurement range.

A sensor with very large capacity may have insufficient resolution for a very small Test.

Sensor Selection Principle

The selected sensor should satisfy both

Maximum Expected Force <= Sensor Capacity

and

Required Resolution <= Sensor Capability
Load Cell Selection

Sensor selection is performed before Test execution.

Selection Flow
Method

↓

Required Force Range

↓

Available Load Cells

↓

Compatibility Filter

↓

Operator Selection / Automatic Selection

↓

Validation

↓

Test Snapshot
Automatic Sensor Selection

Automatic selection may choose the smallest suitable load cell.

Example

Expected Force = 120 kN

Available:

25T

10T

2T

The system may select

2T

if the Test and calibration requirements permit it.

Automatic Selection Restriction

Automatic selection must never override a Method explicitly requiring a specific load cell.

Explicit Sensor Selection

If the Method specifies

Load Cell = 25T

the application must use that sensor.

Sensor Compatibility

Compatibility depends on

Capacity

Range

Calibration

Controller Mapping

Mechanical Installation

Test Method

Measurement Type
Mechanical Compatibility

A sensor may be electrically valid but mechanically unsuitable.

The software should therefore distinguish

Configured

Available

Installed

Connected

Validated
Sensor Status

Recommended states

Available

Installed

Connected

Ready

InUse

Disconnected

Fault

CalibrationExpired

Disabled
Status Model
Configured

↓

Available

↓

Installed

↓

Connected

↓

Ready

↓

InUse
Sensor Fault

A sensor fault may result from

Communication Failure

Out-of-Range Value

Calibration Error

Hardware Error

Controller Error

Unexpected Signal
Sensor Disconnect

Disconnect must be represented separately from generic Fault.

Disconnected

!=

Fault
Calibration Expiration

A sensor may remain physically connected while its calibration is no longer valid.

Therefore

Connected = True

does not imply

CalibrationValid = True
Calibration Status

Recommended

NotCalibrated

Valid

Expiring

Expired

Invalid
Calibration Mapping

Each sensor is mapped to a calibration definition.

Sensor

↓

Calibration Profile

↓

Calibration Version

↓

Calibration Function
Calibration Profile

A calibration profile contains

CalibrationId

SensorId

Version

Date

ReferenceStandard

Operator

Points

Function

Validity

Notes
Calibration Versioning

Calibration must be versioned.

Example

LC-25T

Calibration v1

Calibration v2

Calibration v3
Historical Calibration

A Test must preserve the calibration version used during execution.

Example
Test T-1001

Load Cell = LC-25T-001

Calibration = CAL-LC25T-003

Even if a new calibration is later created, Test T-1001 remains associated with CAL-LC25T-003.

Calibration Points

A calibration may contain multiple reference points.

Example

Point 1

Point 2

Point 3

Point 4

Point 5
Calibration Point

Each point contains at least

RawValue

ReferenceValue

and optionally

Timestamp

Temperature

Operator

Deviation
Calibration Example
Raw       Reference

0         0 kN

1000      10 kN

2000      20 kN

3000      30 kN

4000      40 kN
Calibration Function

The calibration engine converts

Raw Sensor Value

into

Engineering Value
Linear Calibration
Engineering = A × Raw + B
Multi-Point Calibration

For multiple points, the calibration engine may use

Piecewise Linear

Polynomial

Other Configured Function
Calibration Selection

Only one calibration version should be active for a sensor at a given time.

Reference Load Cell

The calibration system may use a reference load cell for calibration comparison.

Reference Sensor Concept
Reference Load Cell

vs

Sensor Under Calibration

The reference load cell is not necessarily the active Test load cell.

Calibration Independence

Calibration is not part of the normal Test workflow.

The Test only consumes a valid calibration definition.

Test Does Not Calibrate

The Test workflow must never automatically modify sensor calibration.

Calibration UI

Calibration should be handled in a separate calibration workflow.

Calibration UI Responsibilities
Select Sensor

Select Reference

Acquire Points

Register Points

Calculate Calibration

Validate

Save New Version
Mouse-Based Point Registration

Where the calibration workflow uses a graph, the operator may select calibration points using mouse interaction.

The point registration must produce a deterministic reference value.

Calibration Validation

Before activating a calibration

Points Valid

Order Valid

Reference Values Valid

Residual Error Acceptable

Sensor Range Valid

must be checked.

Calibration Traceability

Every calibration must record

Who

When

Which Sensor

Which Reference

Which Points

Which Function

Which Version
Extensometers

The machine supports multiple extensometer configurations.

Examples

100 mm

50 mm

25 mm
Extensometer Identity

Example

EXT-100-001

EXT-50-001

EXT-25-001

These are configurable identifiers.

Extensometer Metadata

Recommended

SensorId

SensorName

GaugeLength

MeasurementRange

Resolution

Accuracy

CalibrationId

CalibrationVersion

Status
Gauge Length

Gauge length is an important Test parameter.

Example

L0 = 50 mm
Gauge Length Snapshot

The Test must store the gauge length actually used.

Changing the extensometer configuration later must not modify historical Tests.

Extensometer Compatibility

Compatibility depends on

Gauge Length

Measurement Range

Expected Strain

Resolution

Method

Specimen Geometry
Extensometer Selection

The Method may explicitly specify

Extensometer = 50 mm

or allow selection from compatible sensors.

Extensometer Optionality

Some Methods may require an extensometer.

Others may permit crosshead displacement.

The Method must explicitly define the requirement.

Required Extensometer

If the Method requires an extensometer and it is unavailable

Test Start = Blocked
Optional Extensometer

If the Method permits crosshead-based measurement

Extensometer Unavailable

↓

Warning

↓

Alternative Measurement

only if the Method explicitly allows it.

Extensometer Failure During Test

If required

RUNNING

↓

Extensometer Failure

↓

Controlled Stop

↓

FAULT
Crosshead Encoder

The crosshead encoder is the primary displacement source for crosshead motion.

Crosshead Measurement

Typical engineering value

Displacement [mm]
Encoder Metadata

Recommended

EncoderId

Name

Resolution

Scale

Direction

ZeroOffset

CalibrationVersion

Status
Encoder Direction

The application must define a consistent engineering direction.

Example

Positive = Crosshead Upward

or

Positive = Crosshead Downward

The final convention must be fixed globally.

Direction Consistency

All calculations and graphs must use the same direction convention.

Zero Position

The encoder may require a zero reference.

Zeroing

Zeroing may be performed during machine preparation according to the Method / machine configuration.

Zero Offset

The measured value may be corrected by

EngineeringPosition =
RawPosition - ZeroOffset
Encoder Calibration

The encoder calibration must be versioned where applicable.

Position vs Displacement

The system should distinguish

Absolute Position

Displacement From Test Zero
Test Displacement

Test displacement may be

Current Position - Initial Test Position
Initial Position Snapshot

At Test start

InitialCrossheadPosition

must be recorded when crosshead displacement is used.

Sensor Channel Mapping

Each sensor must be mapped to a logical channel.

Example

Logical Channel

FORCE

DISPLACEMENT

EXTENSION
Example Mapping
FORCE

↓

LC-25T-001
DISPLACEMENT

↓

ENC-CROSSHEAD-001
EXTENSION

↓

EXT-50-001
Channel Independence

The logical channel must not depend directly on a physical sensor implementation.

Sensor Abstraction

Conceptually

ISensor

with specialized implementations

ILoadCell

IExtensometer

ICrossheadEncoder
Common Sensor Properties

Conceptually

SensorId

Name

Type

Status

Unit

Range

Resolution

Accuracy
Load Cell Specific Properties
Capacity

ForceUnit

Calibration
Extensometer Specific Properties
GaugeLength

ExtensionRange

ExtensionUnit

Calibration
Encoder Specific Properties
PositionRange

Resolution

Direction

ZeroOffset
Sensor Manager

The application should contain a central Sensor Manager.

Conceptually

ISensorManager
Sensor Manager Responsibilities
Discover Sensors

Register Sensors

Validate Sensors

Get Sensor

Get Sensors

Select Active Sensor

Report Status

Apply Mapping
Sensor Manager Must Not

The Sensor Manager should not perform Test-specific result calculations.

Sensor Manager vs Acquisition
Sensor Manager

=

What sensors exist?
Acquisition

=

What values are currently being measured?
Sensor Manager vs Calibration
Sensor Manager

=

Which calibration belongs to this sensor?
Calibration Service

=

How is the calibration applied?
Active Sensor

The active sensor is the sensor currently assigned to a logical measurement channel for the running Test.

Active Sensor Rule

Only one authoritative force sensor should be active for a Test force channel unless a Method explicitly supports multi-sensor acquisition.

Sensor Switching

Sensor switching during an active Test is prohibited by default.

Reason

Changing the force sensor during a Test can introduce

Offset Change

Scale Change

Noise

Discontinuity

Traceability Problems
Sensor Switching Before Test

Permitted.

Example

READY

↓

Select Different Load Cell

↓

Revalidate

↓

Ready
Sensor Switching During HOLD

Still prohibited unless a specific validated Method supports it.

Sensor Switching After Test

No effect on historical Test data.

Multi-Sensor Architecture

The machine may physically contain multiple sensors even though only one is active for a particular logical channel.

Example
Installed

25T

10T

2T

500kg

100kg

but

Active Force Sensor

=

2T
Sensor Availability

The application should distinguish

Installed

Connected

Available

Selected

Active
Example
25T

Installed = Yes

Connected = Yes

Available = Yes

Selected = No

Active = No
Sensor Status UI

The UI should provide a concise indication.

Example

Load Cell: 2T
Status: Ready
Calibration: Valid
Sensor Details UI

Detailed configuration may show

Sensor Name

Serial Number

Capacity

Range

Resolution

Accuracy

Calibration Version

Calibration Date

Status
Sensor Validation

Validation occurs before the sensor can become active.

Validation Checklist
Sensor Exists

Sensor Enabled

Sensor Connected

Controller Mapping Valid

Calibration Valid

Capacity Valid

Range Valid

Method Compatible
Sensor Validation Result

Conceptually

SensorValidationResult

IsValid

Errors

Warnings
Validation Error Examples
SensorCalibrationExpired

SensorNotConnected

SensorCapacityTooLow

SensorNotMapped

SensorDisabled

SensorMethodIncompatible
Validation Warning Examples
SensorNearCapacity

CalibrationExpiringSoon

ResolutionMayBeInsufficient
Near Capacity Warning

The system may warn when expected force approaches sensor capacity.

Example

Expected = 9.5T

Capacity = 10T

This should produce a warning according to configured limits.

Sensor Safety Margin

A configured safety margin may be used.

Example

MaximumRecommendedUsage = 90% Capacity

The exact percentage is configuration-dependent.

Sensor Resolution

Sensor resolution should be considered during automatic sensor selection.

Example

For a low-force Test

100 kg

may be preferable to

25 ton

if mechanically and methodologically compatible.

Sensor Accuracy

Accuracy metadata must be retained for traceability.

Accuracy Representation

The database should support the configured representation.

Examples

±0.5% FS

±0.1% Reading

Manufacturer Specification
Sensor Range

Range may be represented as

Minimum

Maximum
Sensor Unit

Each sensor has a native measurement unit.

Unit Conversion

The sensor service converts native units into the application's canonical engineering unit.

Example
Sensor

kgf

↓

Canonical

N
Calibration and Unit Conversion

The order must be explicitly defined.

Recommended conceptual pipeline

Raw Value

↓

Calibration

↓

Native Engineering Value

↓

Canonical Unit Conversion

The implementation must use the exact order defined by the calibration model.

No Ambiguous Conversion

The system must not apply unit conversion twice.

Sensor Configuration Database

Conceptual table

Sensors

Fields

SensorId

SensorType

Name

SerialNumber

Capacity

CapacityUnit

MinimumRange

MaximumRange

Resolution

Accuracy

NativeUnit

Enabled

Status

CreatedAt

UpdatedAt
Sensor Calibration Database

Conceptual

SensorCalibrations

Fields

CalibrationId

SensorId

Version

CalibrationDate

ValidFrom

ValidTo

FunctionType

ReferenceSensorId

OperatorId

Status

CreatedAt
Calibration Points Table
CalibrationPoints

Fields

PointId

CalibrationId

Sequence

RawValue

ReferenceValue

Deviation

CreatedAt
Test Sensor Snapshot

Conceptual table

TestSensorSnapshots

Fields

SnapshotId

TestId

SensorId

SensorType

SensorName

SerialNumber

Capacity

Range

Resolution

Accuracy

CalibrationId

CalibrationVersion

GaugeLength

Unit
Why Snapshot?

The physical sensor configuration may change after the Test.

The Test must retain the historical configuration.

Example

Today

LC-2T-001

Calibration v5

Tomorrow

LC-2T-001

Calibration v6

Historical Test remains

Calibration v5
Sensor Deactivation

A sensor can be disabled without deleting historical records.

Disable Rule
Enabled = False

prevents new Test selection.

Existing historical Tests remain valid.

Sensor Deletion

Physical sensor records should normally not be hard-deleted if they are referenced by historical Tests.

Preferred Approach
Active = False

or

Status = Retired
Retired Sensor

A retired sensor remains available for historical traceability.

Sensor Replacement

If a physical sensor is replaced

Old Sensor

=

Retired

and

New Sensor

=

New SensorId
Do Not Reuse Sensor IDs

A new physical sensor should not inherit the identity of an old physical sensor.

Sensor Serial Number

Serial number should be stored where available.

Sensor Name

Human-readable name is separate from the unique SensorId.

Example
SensorId

LC-0021
Name

2 Ton Load Cell
Sensor Identification Hierarchy
SensorId

>

SerialNumber

>

DisplayName

SensorId is the application-level identity.

Sensor Controller Mapping

The application must know how a sensor maps to the controller.

Mapping Example
Sensor

LC-25T-001

↓

Controller Channel

AI-01
Controller Mapping Metadata

Conceptually

MappingId

SensorId

ControllerId

Channel

Register

Scale

Offset

Enabled
Mapping Version

Controller mappings should be versioned or included in the Test snapshot when they affect measurement interpretation.

Controller Channel Reassignment

Changing a controller mapping must not silently modify historical Tests.

Sensor Discovery

If the controller supports discovery, the application may detect connected sensors.

However, discovery must not replace explicit configuration.

Unknown Sensor

If an unknown sensor appears

Detected

↓

Unknown

↓

Do Not Automatically Use
Unknown Sensor Safety

Unknown sensors must not become active automatically.

Sensor Diagnostics

The Sensor Manager should expose

CurrentValue

LastTimestamp

Status

CalibrationStatus

ControllerMapping

Error

for diagnostics.

Sensor Health

A sensor health indicator may combine

Connection

Signal Quality

Range

Calibration

Communication
Example
Load Cell 2T

Connection: OK

Signal: OK

Calibration: Valid

Range: OK

Overall: Ready
Sensor Health During Test

Sensor health changes must generate events where relevant.

Example
SensorHealthChanged

Ready -> Warning

or

SensorHealthChanged

Warning -> Fault
Sensor Warnings

Warnings must not automatically terminate a Test unless configured as critical.

Sensor Fault Policy

The Method may define whether a sensor is

Required

Optional

Alternative
Required Sensor

Failure

Test Cannot Continue
Optional Sensor

Failure

Test May Continue

provided all required Test calculations remain valid.

Alternative Sensor

A Method may define

Extensometer

OR

Crosshead

but the active source must be determined before Test execution.

Alternative Sensor Selection

The selected source must be snapshotted.

Example
Method

Strain Source = Extensometer preferred

Fallback = Crosshead

If Extensometer is unavailable before Start

Crosshead selected

The Test snapshot records this decision.

No Mid-Test Automatic Fallback

Automatic switching from Extensometer to Crosshead during RUNNING is prohibited unless the Method explicitly defines and validates such behavior.

Sensor Calibration Validity

Calibration validity should be checked using

ValidFrom

ValidTo

Status
Calibration Expiration

If expired before Test start

Start = Blocked

unless an authorized configuration explicitly allows operation.

Calibration Expiration During Test

An already-running Test should continue using its frozen calibration snapshot.

The application must not dynamically switch to a new calibration version during the Test.

Sensor Snapshot Principle

At Test Start

Sensor Definition

+

Calibration Definition

+

Mapping


are frozen for the Test.

Sensor Snapshot Example
TestId = T-2026-001

Force Sensor = LC-2T-001

Calibration = CAL-2T-005

Controller Channel = AI-03

Native Unit = kgf

Canonical Unit = N
Historical Reproducibility

A historical Test must be reproducible from

Test Metadata

+

Method Snapshot

+

Sensor Snapshot

+

Calibration Snapshot

+

Measurement Data
Sensor Manager API

Conceptual interface

ISensorManager

Operations

GetAllSensors()

GetSensor(sensorId)

GetAvailableSensors()

GetSensorsByType(type)

ValidateSensor(sensorId)

SelectSensor(channel, sensorId)

GetActiveSensor(channel)

GetSensorStatus(sensorId)
Calibration Service API

Conceptual

ICalibrationService

Operations

GetActiveCalibration(sensorId)

GetCalibrationVersion(sensorId, version)

ValidateCalibration(calibrationId)

ApplyCalibration(calibrationId, rawValue)
Sensor Repository

Conceptual

ISensorRepository

Responsibilities

Load Sensor

Save Sensor

Update Sensor

Find Sensors

Retire Sensor
Sensor Manager Layering
UI

↓

Application

↓

Sensor Manager

↓

Sensor Repository

↓

SQLite
Acquisition Layering
Sensor Manager

↓

Acquisition Service

↓

Controller Adapter

↓

Hardware / PLC
No UI-to-Hardware Sensor Access

The UI must never directly read sensor registers.

Sensor Selection UI

The UI may request

Select Load Cell

but the Application layer performs validation and selection.

Example Command
SelectLoadCellCommand
Selection Result
Success

or

ValidationError
Selection Error Example
Cannot select 25T load cell.

Calibration is expired.
Sensor Configuration Change

Changing sensor metadata should not modify existing Test snapshots.

Sensor Configuration Audit

Important configuration changes should create an audit record.

Examples

Sensor Added

Sensor Disabled

Calibration Activated

Calibration Retired

Sensor Mapping Changed
Acceptance Criteria

ARCH-075 is accepted when

All supported sensor types are defined.

25T load cell is supported.

10T load cell is supported.

2T load cell is supported.

500 kg load cell is supported.

100 kg load cell is supported.

100 mm extensometer is supported.

50 mm extensometer is supported.

25 mm extensometer is supported.

Crosshead encoder is supported.

Every physical sensor has a unique identity.

Sensor metadata is stored.

Capacity is stored.

Range is stored.

Resolution is stored.

Accuracy is stored.

Calibration is separated from Test execution.

Calibration is versioned.

Calibration points are supported.

Reference sensor is supported.

Active calibration is identifiable.

Historical calibration is preserved.

Sensor selection occurs before Test execution.

Sensor compatibility is validated.

Sensor switching during RUNNING is prohibited by default.

Sensor status is explicitly represented.

Disconnected and Fault states are distinct.

Retired sensors remain historically traceable.

Sensor IDs are not reused.

Controller mappings are represented.

Unknown sensors are not automatically activated.

Test sensor snapshots are stored.

Calibration snapshots are stored.

Sensor health is observable.

Required sensor failure is handled.

Optional sensor failure is handled according to Method.

Alternative sensor selection is supported where Method permits.

Calibration expiration blocks invalid new Tests.

Calibration changes do not modify historical Tests.

UI cannot directly access sensor hardware.

Sensor selection is performed through Application services.

Architectural Decision (FROZEN)

Every physical measurement sensor shall have a unique application identity.

Sensor configuration, calibration, controller mapping and Test usage shall remain separate concepts.

The active sensor is selected before Test execution and becomes part of the Test snapshot.

Sensor switching during an active Test is prohibited by default.

Calibration is independent from the Test lifecycle.

A Test uses a frozen calibration version and does not dynamically adopt later calibration changes.

Retired sensors must remain historically traceable.

Unknown sensors shall never become active automatically.

Sensor health, connection state and calibration state shall be represented independently.

Required sensor failure shall prevent unsafe continuation.

Optional and alternative sensors shall be controlled by the Method definition.

Historical Tests shall remain reproducible from their Sensor and Calibration snapshots.

This decision is permanent.

Next Chapter

ARCH-076

Calibration Architecture, Multi-Point Calibration, Reference Load Cell, Calibration UI, Curve-Based Point Registration, Validation, Versioning & Traceability

This chapter will define

Calibration Workflow
Calibration Session
Reference Load Cell
Sensor Under Calibration
Calibration Points
Zero Point
Span Points
Multi-Point Calibration
Linear Calibration
Piecewise Calibration
Polynomial Calibration
Curve Fitting
Mouse Point Selection
Point Editing
Point Validation
Residual Error
Accuracy
Repeatability
Calibration Certificate
Calibration Version
Validity Period
Calibration Approval
Calibration Lock
Historical Calibration
Calibration Database
Calibration Audit
Calibration Import
Calibration Export
Calibration Security
Calibration/Test Separation
End of Chapter