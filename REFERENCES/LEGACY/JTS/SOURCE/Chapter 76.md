# ARCHITECTURE
# Chapter 76
# Calibration Architecture, Multi-Point Calibration, Reference Load Cell, Calibration UI, Curve-Based Point Registration, Validation, Versioning & Traceability

Document ID

ARCH-076

Version

0.1

Status

FROZEN

Related EDR

EDR-081

Depends On

ARCH-071 SQLite Database Architecture

ARCH-074 Measurement Acquisition Pipeline

ARCH-075 Sensor Architecture

---

# Purpose

This chapter defines the complete calibration architecture of the Universal Testing Machine.

The calibration system covers

```text
Calibration Session

Reference Load Cell

Sensor Under Calibration

Calibration Points

Zero Point

Span Points

Multi-Point Calibration

Linear Calibration

Piecewise Calibration

Curve Fitting

Point Registration

Validation

Residual Error

Accuracy

Repeatability

Calibration Versioning

Validity

Approval

Historical Traceability

Database Storage

Audit
Core Principle

Calibration is a controlled metrology operation.

It is not part of the normal Test execution workflow.

Test

!=

Calibration
Calibration Architecture
+----------------------------+
| Calibration UI             |
|                            |
| Sensor Selection           |
| Reference Selection        |
| Point Registration         |
| Validation                 |
+-------------+--------------+
              |
              v
+----------------------------+
| Calibration Application    |
| Service                    |
+-------------+--------------+
              |
       +------+------+
       |             |
       v             v
+-------------+ +-------------+
| Calibration | | Reference   |
| Engine      | | Measurement |
+------+------+ +-------------+
       |
       v
+----------------------------+
| Calibration Repository     |
+-------------+--------------+
              |
              v
+----------------------------+
| SQLite                     |
+----------------------------+
Calibration Session

Every calibration operation shall be represented by a Calibration Session.

Session Identity

Example

CALSESSION-2026-0001

The identifier must be unique.

Calibration Session Metadata

At minimum

SessionId

SensorId

ReferenceSensorId

OperatorId

StartTime

EndTime

Status

CalibrationVersion

Notes
Session Status

Recommended states

Draft

Preparing

Acquiring

Review

Validated

Approved

Rejected

Cancelled
Draft

The calibration session has been created but no final calibration has been approved.

Preparing

The application is validating

Sensor

Reference

Controller

Connections

Ranges

Existing Calibration
Acquiring

Calibration points are being collected.

Review

All required points have been collected and the operator is reviewing the calibration.

Validated

The calculated calibration has passed technical validation.

Approved

The calibration version is authorized for future Test use.

Rejected

The calibration failed validation or was rejected by an authorized operator.

Cancelled

The session was intentionally terminated without creating an active calibration version.

Calibration Target

The Calibration Target is the sensor whose response is being calibrated.

Example

Sensor Under Calibration

LC-2T-001
Reference Sensor

The Reference Sensor provides the trusted reference measurement.

Example

Reference Load Cell

LC-25T-REF-001
Reference Sensor Requirement

The reference sensor must have a valid calibration traceable to the applicable reference standard.

Reference Sensor Independence

The reference sensor must be logically independent from the sensor being calibrated.

Invalid Configuration

The following configuration is prohibited

Sensor Under Calibration

=

Reference Sensor

unless the calibration procedure explicitly defines a valid self-reference mode.

Reference Load Cell

The reference load cell should have sufficient accuracy and capacity for the calibration range.

Reference Capacity

The reference sensor must safely cover the intended calibration range.

Calibration Range

The calibration range is explicitly defined.

Example

0 kN

to

200 kN
Calibration Range Validation

The application must verify

CalibrationMaximum <= ReferenceCapacity

CalibrationMaximum <= SensorCapacity

subject to the applicable calibration procedure.

Calibration Points

A calibration consists of one or more reference points.

Point Structure

Each point contains at least

PointId

Sequence

RawValue

ReferenceValue

Timestamp

Optional

Deviation

Temperature

Operator

Notes
Zero Point

The zero point represents the sensor response at the reference zero condition.

Example

Raw = 12

Reference = 0 N
Zero Point Importance

The zero point determines the offset component of the calibration.

Span Points

Span points cover the intended measurement range.

Example

0%

20%

40%

60%

80%

100%
Recommended Point Distribution

Calibration points should be distributed across the useful measurement range rather than concentrated only near zero.

Multi-Point Calibration

The system must support multiple calibration points.

Example

Point 1 = 0 kN

Point 2 = 20 kN

Point 3 = 40 kN

Point 4 = 60 kN

Point 5 = 80 kN

Point 6 = 100 kN
Increasing Point Order

For a standard monotonic calibration sequence

ReferenceValue[n+1] >= ReferenceValue[n]

should normally be enforced.

Duplicate Reference Points

Duplicate reference points should be detected.

Duplicate Handling

The application may

Reject

Warn

Allow With Explicit Override

depending on the calibration procedure.

Raw Value

RawValue represents the direct sensor/controller response.

Reference Value

ReferenceValue represents the trusted physical measurement.

Calibration Relationship

The calibration engine determines

EngineeringValue = f(RawValue)
Linear Calibration

The simplest model is

EngineeringValue = A × RawValue + B

where

A = Gain

B = Offset
Linear Fit

With multiple points, A and B should be calculated from the selected calibration points rather than manually entered unless explicitly required.

Piecewise Linear Calibration

For sensors with nonlinear response, piecewise interpolation may be used.

Conceptually

Point 1 ---- Point 2 ---- Point 3 ---- Point 4
    \            \            \
     \            \            \
Piecewise Rule

For a raw value between two calibration points

Raw1 <= Raw <= Raw2

the engineering value is calculated by linear interpolation between the two surrounding points.

Extrapolation

Extrapolation outside the calibrated range should normally be prohibited.

Out-of-Range Calibration

If

Raw < MinimumCalibratedRaw

or

Raw > MaximumCalibratedRaw

the calibration engine should report an out-of-range condition rather than silently extrapolating.

Polynomial Calibration

Polynomial fitting may be supported when explicitly configured.

Example

Engineering =

A0
+ A1 × Raw
+ A2 × Raw²
+ A3 × Raw³
Polynomial Restriction

Polynomial fitting must not be used merely because it produces a smaller fitting error.

The selected model must be technically justified and validated.

Model Selection

Supported model types

Linear

PiecewiseLinear

Polynomial

The final implementation may support additional validated models later.

Calibration Model Metadata

Every calibration version must store

FunctionType

Parameters

InputUnit

OutputUnit

ValidRange
Calibration Curve

The Calibration UI should display the relationship between

Reference Value

and

Sensor Response
Recommended Graph
Y = Reference / Engineering Value

|

|                 *
|             *
|         *
|     *
| *
+-------------------------- X
          Raw Value
Point Registration

The operator may register calibration points from acquired measurements.

Registration Methods

Supported conceptual methods

Manual Entry

Live Acquisition

Mouse Selection From Curve
Live Acquisition

The preferred operational workflow is

Apply Reference Load

↓

Stabilize

↓

Acquire Sensor Value

↓

Acquire Reference Value

↓

Register Point
Mouse Point Selection

If the UI displays a calibration curve, the operator may click a curve location to register a point.

Important Rule

A mouse click must not arbitrarily invent a physical reference value.

The selected graphical point must map to an actual acquired data sample or explicitly entered reference value.

Mouse Selection Workflow
Curve

↓

Mouse Click

↓

Nearest Valid Sample

↓

Display Sample Values

↓

Operator Confirmation

↓

Register Point
Nearest Sample

The nearest measurement sample should be selected deterministically.

Point Confirmation

The UI should display

Raw Value

Reference Value

Timestamp

Deviation

before the point becomes part of the calibration.

Point Editing

The operator may edit a point before final validation.

Point Deletion

A point may be deleted during Draft / Review.

Deletion must be recorded in the session history if audit requirements apply.

Point Reordering

Sequence order may be adjusted when the calibration procedure permits it.

Point Lock

After calibration validation or approval, points become immutable.

Calibration Validation

Validation occurs before activation.

Validation Stages
Structural Validation

↓

Numerical Validation

↓

Range Validation

↓

Fit Validation

↓

Error Validation

↓

Repeatability Validation

↓

Approval
Structural Validation

Check

Sensor Exists

Reference Exists

Points Exist

Units Defined

Function Type Defined
Numerical Validation

Check for

NaN

Infinity

Invalid Values

Duplicate Points

Invalid Ordering
Range Validation

Check

Minimum Point

Maximum Point

Sensor Capacity

Reference Capacity
Fit Validation

Calculate fitting error.

Residual Error

For point i

Residual_i =
MeasuredEngineering_i
-
Reference_i
Absolute Residual
AbsoluteResidual_i =
ABS(Residual_i)
Maximum Residual

The calibration result should expose

MaximumAbsoluteResidual
Mean Error

The system may calculate

MeanError
RMS Error

The system may calculate

RMSError
Error Percentage

Depending on the calibration procedure

ErrorPercent =
Residual / ReferenceRange × 100

The exact definition must follow the selected calibration procedure.

Zero Error

Zero-point error should be reported separately where appropriate.

Span Error

The system should also expose span-related error where required.

Calibration Acceptance

A calibration is accepted only if the measured errors satisfy the configured acceptance criteria.

Acceptance Criteria Source

Acceptance limits should come from the applicable calibration procedure / configuration.

They must not be hard-coded without documentation.

Repeatability

Where the procedure requires repeatability, repeated reference points should be supported.

Example

Increasing Load

↓

Maximum

↓

Decreasing Load
Increasing / Decreasing Sequence

A calibration session may contain

UP-01

UP-02

UP-03

...

DOWN-03

DOWN-02

DOWN-01
Hysteresis

If both increasing and decreasing measurements are required, the system should calculate hysteresis.

Hysteresis Concept
Hysteresis =
Difference between increasing and decreasing response
at the same reference point
Repeatability Error

Repeated measurements at the same reference point may be compared.

Repeatability Result

Example

Reference = 50 kN

Reading 1 = 50.02 kN

Reading 2 = 49.99 kN

Reading 3 = 50.01 kN
Repeatability Statistics

The system may calculate

Minimum

Maximum

Mean

Range

Standard Deviation
Calibration Accuracy

Accuracy must be evaluated according to the defined calibration procedure.

Do Not Confuse
Resolution

Accuracy

Repeatability

Precision

These are distinct properties.

Calibration Approval

Validation and approval are separate concepts.

Validation

Technical system determines

Calibration passes configured criteria
Approval

Authorized user confirms

Calibration is authorized for use
Approval Role

The exact role model belongs to the Security / Authorization architecture.

Calibration Activation

Only an approved calibration may become Active.

Active Calibration

A sensor may have

One Active Calibration

for a given validity context.

Previous Calibration

When a new calibration is activated

Previous Active

↓

Superseded
Calibration Version Number

Versions should increase monotonically.

Example

v1

v2

v3
Version Immutability

Once a calibration version has been approved, its mathematical definition and points must not be modified.

Correction

If an error is discovered, create a new calibration version rather than modifying the historical one.

Calibration Validity

Each calibration should contain

ValidFrom

ValidTo

where applicable.

Expiration

After ValidTo

CalibrationStatus = Expired
Calibration Expiration and Existing Tests

Existing Tests remain associated with their historical calibration.

Calibration Expiration and New Tests

A new Test using an expired calibration should normally be blocked.

Calibration Notes

The session should support notes such as

Reference Equipment

Environmental Conditions

Special Observations
Environmental Conditions

Where required, the calibration session may store

Temperature

Humidity

Other Environmental Data
Reference Equipment Traceability

The reference load cell should have its own

SensorId

Calibration

Certificate

Validity
Reference Calibration Validation

Before calibration starts, the reference sensor's calibration validity must be verified.

Invalid Reference

If the reference calibration is invalid

Calibration Start = Blocked
Calibration Zeroing

Zeroing must be explicitly controlled.

Zero Workflow
Remove Load

↓

Wait for Stable Signal

↓

Acquire Zero

↓

Confirm

↓

Register Zero Point
Stability

A point should not be accepted while the signal is unstable if the procedure requires stabilization.

Stability Detection

Possible criteria

Variation < Threshold

for

Specified Duration
Example
Force variation < 0.1 kN

for 2 seconds

The exact values are configurable.

Point Stability

The UI should indicate

Stable

Unstable

before allowing automatic point capture.

Manual Override

If manual point capture is permitted, it should require explicit confirmation when stability criteria are not met.

Calibration Data Acquisition

Calibration measurements should use the same reliable acquisition architecture defined in ARCH-074.

Acquisition Reuse

The calibration system should reuse

Measurement Acquisition Service

rather than implementing an independent hardware reader.

Calibration Isolation

Although acquisition is shared, calibration data must remain separate from Test data.

Calibration Measurement Record

Conceptual

CalibrationMeasurement

SessionId

Sequence

Timestamp

RawValue

ReferenceValue

Quality
Calibration Measurement vs Calibration Point

A CalibrationMeasurement is acquired data.

A CalibrationPoint is an accepted data point used in the calibration model.

Relationship
CalibrationMeasurement

↓

Operator / Algorithm Selection

↓

CalibrationPoint
Invalid Calibration Measurement

An invalid measurement must not become a CalibrationPoint.

Calibration Curve Data

The UI may display all acquired measurements while only selected points are used in the final model.

Outlier Detection

The system may identify possible outliers.

Outlier Status

Example

Normal

SuspectedOutlier

AcceptedOutlier

Rejected
Automatic Outlier Removal

Automatic deletion of calibration points is prohibited by default.

Operator Review

Outliers must be visible to the operator.

Outlier Reason

If a point is rejected, the session may store

RejectedReason
Calibration Certificate

The system may generate a calibration certificate / report.

Certificate Contents

Recommended

Sensor Identity

Serial Number

Reference Sensor

Calibration Date

Operator

Calibration Version

Range

Calibration Points

Model

Maximum Error

Repeatability

Validity

Approval
Certificate Traceability

The certificate must reference the exact CalibrationId and Version.

Calibration Export

Calibration data may be exported.

Supported conceptual formats

CSV

XML

PDF
Calibration Import

Import may be supported for approved calibration definitions.

Import Validation

Imported calibrations must pass the same validation rules as internally created calibrations.

No Blind Import

Import must never directly activate a calibration.

Imported Calibration Flow
Import

↓

Draft

↓

Validate

↓

Review

↓

Approve

↓

Activate
Calibration Security

Calibration configuration is more sensitive than ordinary display settings because it directly affects measurement interpretation.

Permissions

At minimum, the system should distinguish

View Calibration

Create Calibration

Edit Draft

Validate

Approve

Activate

Retire
Calibration Lock

Approved calibrations must be locked.

Audit Trail

Every important calibration action should generate an Audit record.

Audit Events

Examples

CalibrationSessionCreated

CalibrationPointAdded

CalibrationPointRemoved

CalibrationValidated

CalibrationRejected

CalibrationApproved

CalibrationActivated

CalibrationSuperseded

CalibrationImported
Calibration Database

Conceptual tables

CalibrationSessions

CalibrationMeasurements

CalibrationPoints

Calibrations

CalibrationParameters

CalibrationAudit
CalibrationSessions

Recommended fields

SessionId

SensorId

ReferenceSensorId

OperatorId

Status

StartedAt

CompletedAt

Notes

CreatedAt
Calibrations

Recommended fields

CalibrationId

SensorId

Version

SessionId

FunctionType

ValidFrom

ValidTo

Status

ApprovedBy

ApprovedAt

CreatedAt
CalibrationParameters

Recommended fields

ParameterId

CalibrationId

Name

Value

Sequence
CalibrationPoints

Recommended fields

PointId

CalibrationId

Sequence

RawValue

ReferenceValue

Residual

Deviation

Timestamp
CalibrationMeasurements

Recommended fields

MeasurementId

SessionId

Sequence

Timestamp

RawValue

ReferenceValue

Quality
Calibration Audit

Audit records should contain

AuditId

SessionId

Action

UserId

Timestamp

Details
Calibration Snapshot in Test

At Test start the active calibration should be snapshotted.

Snapshot Contents
CalibrationId

Version

FunctionType

Parameters

ValidRange

SensorId
Mathematical Reproducibility

A historical Test must be able to identify exactly which calibration function was applied.

Example
Test

↓

Sensor = LC-2T-001

↓

Calibration = CAL-2T-007

↓

Model = PiecewiseLinear

↓

Points = P1..P8
Calibration Change

Changing active calibration must not alter

Historical Measurements

Historical Results

Historical Reports
Recalculation

If historical results are intentionally recalculated, the system must explicitly record

Old Result

New Result

Calibration Used

Reason

Operator
Calibration/Test Separation

The Test engine may consume a calibration.

The Test engine must not modify the calibration.

Calibration Service Responsibilities
Create Session

Acquire Measurements

Register Points

Calculate Model

Validate

Approve

Activate

Retire

Export

Import
Calibration Service Must Not

The Calibration Service must not

Start a Normal Material Test

Modify Historical Test Data

Bypass Safety Interlocks

Activate Invalid Calibration
Calibration UI Workflow
Calibration Menu

↓

Select Sensor

↓

Select Reference

↓

Validate Equipment

↓

Start Session

↓

Zero

↓

Acquire Points

↓

Review Curve

↓

Calculate Calibration

↓

Validate

↓

Approve

↓

Activate
Calibration UI Point Table

Recommended columns

#

Raw

Reference

Calculated

Residual

Error %

Status
Calibration UI Curve

The curve should display

Measured Response

Reference Curve

Calibration Fit

where applicable.

Curve Legend

Example

Reference

Measured

Fit
Calibration UI Status

The operator should always see

Sensor

Reference

Session

Point Count

Range

Validation Status
Calibration Completion

A calibration session is complete only after

Required Points Collected

Model Calculated

Validation Passed

Approval Completed

Calibration Persisted
Calibration Failure

If validation fails

Session = Rejected

or remains

Review

until corrected.

Calibration Cancellation

If cancelled

Session = Cancelled

No active calibration is changed.

Calibration Recovery

If the application crashes during calibration, the session should be recoverable from persisted measurements where possible.

Recovery
Application Restart

↓

Find Open Calibration Session

↓

Load Session

↓

Review

↓

Continue / Cancel
No Automatic Activation

A recovered session must never automatically activate a calibration.

Calibration Data Integrity

Calibration points must be stored with sufficient precision.

Numeric Precision

The implementation should avoid unnecessary floating-point rounding during calibration calculations.

Calculation Precision

Internal calculations should use adequate numeric precision.

The final display precision is a Presentation concern.

Rounding

Rounding should occur at the display/reporting boundary unless the calibration procedure explicitly requires otherwise.

Calibration Units

The calibration model must explicitly identify

Input Unit

Reference Unit

Output Unit
Example
Input = Controller Counts

Reference = N

Output = N
Calibration Unit Consistency

All calibration points within a single calibration version must use compatible units.

Unit Conversion During Calibration

If reference equipment reports a different unit, conversion must be explicit.

Example
Reference = kN

Calibration Output = N
Acceptance Criteria

ARCH-076 is accepted when

Calibration is separated from Test execution.

Calibration sessions have unique identities.

Sensor under calibration is identified.

Reference sensor is identified.

Reference calibration validity is checked.

Calibration range is defined.

Zero point is supported.

Multiple calibration points are supported.

Point ordering is validated.

Raw values are preserved.

Reference values are preserved.

Linear calibration is supported.

Piecewise linear calibration is supported.

Polynomial calibration can be represented where required.

Calibration model parameters are stored.

Residual error is calculated.

Maximum error is available.

Repeatability can be evaluated.

Hysteresis can be evaluated where required.

Stability can be evaluated.

Invalid measurements cannot become calibration points.

Mouse-based point selection is deterministic.

Point selection requires confirmation.

Calibration validation is separate from approval.

Approved calibration versions are immutable.

New calibrations supersede old versions rather than modifying them.

Calibration validity dates are supported.

Historical calibration remains traceable.

Calibration certificate can reference exact version.

Calibration import is validated.

Calibration export is supported.

Calibration actions are auditable.

Calibration data is recoverable after application interruption.

Calibration cannot automatically activate after recovery.

Test snapshots contain the calibration version used.

Historical Tests remain reproducible.

Architectural Decision (FROZEN)

Calibration shall be implemented as a dedicated metrology subsystem separate from the normal Test workflow.

Every calibration operation shall have a unique Calibration Session.

The sensor under calibration and the reference sensor shall be explicitly identified.

Reference equipment shall have independently validated calibration.

Calibration shall support multi-point measurement and validated mathematical models.

Calibration points shall be traceable to actual acquired measurements or explicitly entered reference values.

Mouse-based curve point registration shall resolve to deterministic acquired samples.

Approved calibration versions shall be immutable.

A correction shall create a new calibration version rather than modify an existing approved version.

Only an approved and valid calibration may become active.

Calibration changes shall never modify historical Test measurements or results.

The Test shall consume a frozen calibration snapshot.

Calibration approval shall be separate from technical validation.

All important calibration operations shall be auditable.

Calibration recovery shall never automatically activate a calibration.

This decision is permanent.

Next Chapter

ARCH-077

Method Engine Architecture, ISO 6892-1, ASTM E8, ASTM E111, Speed Control, Method A/B, Fixed Speed, Yield Detection, Rp0.2/Rp0.1/Rt0.5, Break Detection & Method Versioning

This chapter will define

Method Definition
Method Version
Standard
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
Material Library
Load Cell Selection
Extensometer Selection
Crosshead Selection
Clutch
Speed Type
Method A
Method B
Fixed Speed
Force Rate
Stress Rate
Strain Rate
Preload
Gauge Length
Yield Detection
Rp0.2
Rp0.1
Rt0.5
Young's Modulus
Break Detection
Maximum Force
Test Completion
Method Validation
Method Snapshot
Method Versioning
Method Immutability