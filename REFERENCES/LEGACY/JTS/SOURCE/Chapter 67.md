# ARCHITECTURE
# Chapter 67
# Engineering Data Model, Stress-Strain Dataset & Sample Storage

Document ID

ARCH-067

Version

0.1

Status

FROZEN

Related EDR

EDR-072

Depends On

ARCH-063 Repository & Persistence Architecture

ARCH-066 Measurement Acquisition

ARCH-056 Engineering Detection & Mechanical Property Algorithms

ARCH-053 Test Execution Architecture

---

# Purpose

This chapter defines the engineering data model used to represent measurements obtained during a Test.

The model provides the foundation for

```text
Raw Measurements

Engineering Measurements

Stress-Strain Curves

Material Properties

Yield Detection

Young's Modulus

Maximum Force

Break Detection

Reports

CSV Export

Test Traceability
Core Principle

The system shall distinguish between

Measured Data

and

Derived Engineering Data

Measured data must remain recoverable.

Derived values may be recalculated from the authoritative dataset.

Data Layers

The engineering data architecture consists of

Layer 1
Raw Measurement

↓

Layer 2
Calibrated Measurement

↓

Layer 3
Engineering Dataset

↓

Layer 4
Derived Properties

↓

Layer 5
Report Result
Layer 1 — Raw Measurement

Raw measurement represents the value obtained from the hardware or communication interface.

Examples

PLC Force Count

Encoder Count

Extensometer Raw Value
Layer 2 — Calibrated Measurement

Raw measurements are converted using the approved calibration configuration.

Examples

Raw Load Value

↓

Calibration

↓

Force = kN
Encoder Count

↓

Encoder Calibration

↓

Position = mm
Layer 3 — Engineering Dataset

The Engineering Dataset contains values used by engineering calculations.

Typical values

Time

Force

Position

Extension

Stress

Strain
Layer 4 — Derived Properties

Examples

Yield Strength

Rp0.2

Rp0.1

Rt0.5

Ultimate Tensile Strength

Young's Modulus

Elongation

Maximum Force

Break Force
Layer 5 — Report Result

The reporting layer presents the calculated and evaluated results.

The report is not the authoritative measurement source.

Test Dataset Identity

Every dataset belongs to exactly one Test.

Test
 |
 +-- Dataset
      |
      +-- Samples
Dataset Identifier

Each Test Dataset shall have a unique identifier.

Example

DatasetId

The identifier shall remain stable throughout the Test lifecycle.

Dataset Version

The dataset should support a version.

Example

DatasetVersion = 1

A version is useful when processing or migration rules evolve.

Dataset Status

Recommended states

Building

Finalizing

Finalized

Partial

Corrupted

Archived
Building

Samples are still being acquired.

Finalizing

Acquisition has stopped and the system is completing persistence and integrity checks.

Finalized

The dataset is complete and internally consistent according to the applicable rules.

Partial

The Test ended without a complete dataset.

Example

Operator Abort

Hardware Fault

Communication Failure
Corrupted

The system detected an integrity problem that prevents reliable interpretation.

Archived

The dataset is retained but is no longer an active operational dataset.

Dataset Immutability

After

DatasetStatus = Finalized

the authoritative samples shall not be modified directly.

Recalculation

Engineering properties may be recalculated from the finalized dataset without changing the authoritative samples.

Finalized Dataset

↓

Calculation Version 2

↓

New Derived Results
Sample Model

A logical sample contains

SampleId

DatasetId

SequenceNumber

Timestamp

Force

Position

Extension

Quality

Additional channels may be included through the channel model.

Sample Sequence

SequenceNumber provides the logical ordering of samples.

Example

1001
1002
1003
1004
Sequence Rule

For a normal acquisition stream

Sequence(n+1) = Sequence(n) + 1

unless the acquisition source explicitly defines another sequence policy.

Sequence Gap

Example

1001
1002
1004

indicates that sample 1003 may be missing.

This must be detectable.

Duplicate Sample

Example

1001
1002
1002
1003

shall be detected as a duplicate sequence.

Sample Timestamp

Every sample should contain a timestamp.

The timestamp shall identify the measurement time as accurately as supported by the hardware and acquisition architecture.

Sample Time Unit

The internal representation shall provide sufficient resolution for the maximum expected acquisition frequency.

Force

Force is represented as an engineering measurement.

Recommended internal unit

kN
Force Sign Convention

The sign convention shall be explicitly defined.

For example

Tension = Positive

Compression = Negative

if that convention is selected for the application.

The application shall not mix sign conventions between Methods.

Force Raw Value

Where available, the raw hardware value should remain traceable.

Example

RawForce

CalibratedForce
Position

Position represents crosshead displacement.

Recommended unit

mm
Position Reference

The position reference shall be defined.

Possible references

Machine Zero

Test Start Position

Configured Reference Position
Extension

Extension represents extensometer measurement.

Recommended unit

mm
Extensometer Availability

Extension may be unavailable for a Test if the selected Method does not require an extensometer.

Extension Quality

An absent extensometer is not automatically a fault.

Example

Method = Tensile Test without Extensometer

Extension = NotUsed
Gauge Length

Gauge length is a Test input.

Example

L0 = 50 mm

The value shall be preserved with the Test snapshot.

Initial Length

Initial length is represented as

L0

and is an input to strain calculation.

Cross-Section Area

Initial cross-sectional area is represented as

A0

and is an input to engineering stress.

Geometry Model

The geometry model must support at least

Round

Square

Pipe

Custom
Round Geometry

For diameter d

A0 = π × d² / 4
Square Geometry

For side a

A0 = a²
Pipe Geometry

For external diameter D and wall thickness t

Di = D - 2t

and

A0 = π × (D² - Di²) / 4
Custom Geometry

Custom geometry shall allow the operator to provide the required initial cross-sectional area directly where the selected Method permits it.

Geometry Snapshot

The Test must preserve

GeometryType

Dimensions

A0

Units

even if the Material Library or Method is later changed.

Engineering Stress

Engineering stress is calculated from force and initial area.

σ = F / A0

When using

F = N

A0 = mm²

the result is

MPa

because

1 N/mm² = 1 MPa
Engineering Strain

Engineering strain is calculated from extension and initial gauge length.

ε = ΔL / L0
Percentage Strain

For display

StrainPercent = ε × 100
Position-Based Strain

If the selected Method permits crosshead displacement to represent extension, the system may calculate

ε = ΔPosition / L0

However, the Method must explicitly define whether crosshead displacement is an acceptable strain source.

Extensometer Priority

When an extensometer is required by the Method

Extensometer

>

Crosshead Position

for strain-related engineering calculations.

Young's Modulus

Young's modulus shall be calculated using the approved calculation method associated with the selected Standard / Method.

The acquisition layer only provides the data.

Stress-Strain Dataset

The engineering dataset may contain

Time

Force

Position

Extension

Stress

Strain

Example

Time      Force      Position    Extension    Stress    Strain
0.000     0.00       0.000       0.000        0.00      0.0000
0.010     0.25       0.005       0.004        0.80      0.00008
0.020     0.51       0.011       0.009        1.63      0.00018
Derived Data Policy

Stress and strain may be calculated dynamically from the authoritative force, extension and geometry values.

They may also be cached for performance.

If cached, the calculation version must be identifiable.

No Independent Truth

A cached stress value must never become an independent source of truth if it can be deterministically regenerated from the authoritative measurements.

Calculation Version

Engineering calculations should identify

CalculationEngineVersion

CalculationMethodVersion
Standard Reference

The calculation result should identify the Standard / Method used.

Examples

ISO 6892-1

ASTM E8

ASTM E111

ASTM E290

The exact applicable Standard is determined by the Test Method.

Yield Results

The Result model should support

Rp0.1

Rp0.2

Rt0.5

where configured.

Yield Result Structure

Conceptually

YieldResult

Type

Stress

Force

Strain

Position

DetectionPoint

DetectionMethod
Yield Detection Point

The system should preserve the sample or interpolated position associated with the detected yield result.

Maximum Force

Maximum force is derived from the authoritative force dataset.

Fmax = max(F)
Ultimate Tensile Strength

Engineering UTS is derived from maximum force and initial cross-sectional area.

UTS = Fmax / A0
Break Point

The Break Point identifies the relevant failure location according to the configured detection algorithm.

It must not simply be assumed to be the final sample.

Break Result

Conceptually

BreakResult

Timestamp

Force

Stress

Strain

Position

DetectionMethod
Elongation

Elongation is derived according to the selected Standard / Method.

The calculation may use final gauge length or extensometer-derived values as required.

Result Provenance

Every important derived result should be traceable to

DatasetId

Calculation Version

Method

Standard

Input Geometry

Input Calibration
Result Status

Recommended states

Calculated

Invalid

NotAvailable

Estimated

Manual
Calculated

Result generated by the approved calculation engine.

Invalid

Calculation was attempted but required data was insufficient or invalid.

NotAvailable

The selected Method does not provide the property.

Estimated

The value was produced by an approved estimation process.

Manual

The operator entered or adjusted the value manually.

Manual values must be auditable.

Manual Result Override

If manual override is allowed

Automatic Result

↓

Operator Override

↓

Manual Result

The original automatic result must remain recoverable.

Override Audit

A manual override should record

User

Timestamp

Original Value

New Value

Reason
Acceptance Criteria

Acceptance criteria should be stored separately from the measurement dataset.

Example

UTS >= 500 MPa

Yield Strength >= 355 MPa

Elongation >= 20 %
Acceptance Evaluation

The evaluation result may contain

Criterion

Measured Value

Required Value

Operator

Status
PASS

All mandatory acceptance criteria are satisfied.

FAIL

At least one mandatory acceptance criterion is not satisfied.

NOT EVALUATED

Required information is unavailable or evaluation is not applicable.

Dataset and Report Separation

The report should reference the finalized dataset and results.

It should not become the storage location for raw measurement data.

CSV Export

CSV export should support at least

Timestamp

Sequence

Force

Position

Extension

Stress

Strain

where available.

CSV Export Principle

CSV export is a representation of the dataset.

Exporting CSV shall not alter the authoritative dataset.

CSV Metadata

The export should include sufficient metadata to identify

Test ID

Method

Standard

Units

Geometry

Gauge Length

Area

Date

according to the export format.

XML Interchange

XML interchange may represent

Test Metadata

Specimen

Method

Measurement Dataset

Results

according to the defined interchange schema.

Unit Consistency

A dataset shall not mix units within the same logical field.

Forbidden example

Force

Sample 1 = kN

Sample 2 = N

without explicit conversion.

Unit Conversion

Conversion shall happen at a defined boundary.

Preferred

Hardware Unit

↓

Calibration / Conversion

↓

Engineering Unit

↓

Storage
Storage Unit Policy

The authoritative engineering dataset should use normalized units.

Recommended

Force      = kN
Length     = mm
Stress     = MPa
Strain     = dimensionless
Time       = defined internal time unit
Display Units

The UI may display alternative units.

Example

Stored = kN

Displayed = tonf

if the unit conversion feature is implemented.

The stored authoritative value remains unchanged.

Sample Storage Strategy

High-frequency measurement samples shall be stored separately from low-frequency Test metadata.

Conceptually

Tests
  |
  +-- TestDatasets
        |
        +-- MeasurementSamples
Proposed SQLite Tables

Minimum logical tables

Tests

TestDatasets

MeasurementSamples

EngineeringResults

AcceptanceResults

Additional tables are defined by the database architecture.

TestDatasets

Conceptual fields

Id

TestId

Version

Status

StartedAt

EndedAt

SampleCount

AcquisitionRate

CalculationVersion

CreatedAt
MeasurementSamples

Conceptual fields

Id

DatasetId

SequenceNumber

Timestamp

Force

Position

Extension

Quality

Additional channels may be stored according to the extensible channel model.

EngineeringResults

Conceptual fields

Id

TestId

ResultType

Value

Unit

Status

CalculationVersion

SourceDatasetId
AcceptanceResults

Conceptual fields

Id

TestId

Criterion

MeasuredValue

RequiredValue

Unit

Status
Indexing

The measurement table should be indexed for common access patterns.

Important access patterns

DatasetId + SequenceNumber

DatasetId + Timestamp
Primary Key

Each sample requires a unique database identifier.

The sequence number remains a logical acquisition identifier.

Composite Uniqueness

The database may enforce

DatasetId + SequenceNumber

as unique where compatible with the selected persistence strategy.

Database Transactions

Sample batches should be persisted transactionally.

Partial Batch Failure

If a batch fails

Batch

↓

Transaction Rollback

↓

Retry / Fault Policy

No false success state shall be recorded.

Dataset Finalization Transaction

Finalization should ensure that

All Samples Persisted

+

Sample Count Confirmed

+

Dataset Status Updated

are handled consistently.

Sample Count

The persisted SampleCount should correspond to the finalized authoritative dataset.

Integrity Check

The system may store an integrity marker such as

SampleCount

Checksum

Hash

where useful.

Hash

A dataset hash can help identify unintended modifications.

Conceptually

Dataset

↓

Canonical Representation

↓

Hash

↓

Dataset Integrity Identifier
Hash Policy

The hash algorithm and canonical representation shall be defined by the persistence/security architecture.

Dataset Immutability Enforcement

After finalization

UPDATE MeasurementSamples

should not be part of normal application workflows.

Correction

If a legitimate correction is required

Original Dataset

↓

New Dataset Version

↓

Correction Metadata

rather than silent modification.

Reprocessing

A finalized dataset may be reprocessed using a newer calculation engine.

Dataset v1

↓

Calculation Engine v2

↓

Results v2

The original dataset remains unchanged.

Calculation Reproducibility

Given

Same Dataset

Same Geometry

Same Method

Same Calculation Version

the calculation should produce reproducible results.

Engineering Result Snapshot

Completed Test results should preserve the calculated result snapshot used by the report.

Report Reproduction

A report should be reproducible from

Test Metadata

+

Finalized Dataset

+

Calculation Results

+

Acceptance Results
Data Traceability Chain

The complete traceability chain is

Hardware

↓

Raw Measurement

↓

Calibration

↓

Engineering Measurement

↓

Dataset

↓

Calculation

↓

Result

↓

Acceptance

↓

Report
Traceability Requirement

Every final engineering result shall be traceable backwards through this chain.

Data Integrity Principle

The system shall never silently

Delete Samples

Change Units

Change Geometry

Change Calibration

Change Method

for an existing finalized Test.

Test Snapshot

At Test creation / execution the system shall capture the effective values required for reproducibility.

Examples

Specimen Geometry

Initial Area

Gauge Length

Method

Standard

Load Cell

Calibration Reference

Acquisition Configuration
Material Library

Material definitions may provide default values.

However, the Test shall preserve the values actually used.

Material Version

Where material library versioning exists

MaterialId

MaterialVersion

should be retained.

Specimen Identity

A Test should identify the specimen independently from the Material Library.

Specimen Geometry

The specimen record shall retain the exact dimensions used for the Test.

Geometry Validation

Before calculation

A0 > 0

L0 > 0

and all required dimensions must be valid.

Calculation Preconditions

Engineering calculations require

Valid Force

Valid Geometry

Valid Required Length

Valid Required Channel
Invalid Calculation

If prerequisites are missing

ResultStatus = Invalid

rather than producing a misleading numerical result.

NaN / Infinity

The engineering layer must prevent invalid numerical results such as

NaN

Infinity

from becoming valid Test Results.

Zero Area

If

A0 = 0

stress calculation is invalid.

Zero Gauge Length

If

L0 = 0

strain calculation is invalid.

Negative Area

Negative area is invalid.

Negative Gauge Length

Negative gauge length is invalid.

Measurement Ordering

Engineering calculations shall operate on correctly ordered samples.

Sorting

The calculation layer may sort a dataset by timestamp only if the policy explicitly permits it.

Silent reordering of the authoritative dataset is prohibited.

Original Order

The original acquisition sequence shall remain available.

Duplicate Timestamp

Duplicate timestamps are not automatically invalid if the acquisition source supports multiple measurements at the same timestamp.

Sequence number remains the primary ordering mechanism.

Stress-Strain Curve

The curve is conceptually

X Axis = Strain

Y Axis = Stress

for a conventional tensile stress-strain representation.

Curve Data Source

The curve shall be generated from the engineering dataset.

Curve Point Selection

The user may select points on the graph for analysis features.

Selected points are UI interaction data.

They do not modify the authoritative dataset.

Guide Lines

Guide lines may be displayed for engineering analysis.

Examples

Elastic Fit

Offset Line

Yield Point

Maximum Stress
Guide Line Storage

If a user saves an analysis configuration, the parameters should be stored separately from raw samples.

Raw Dataset vs Analysis Annotation
Raw Dataset

≠

Analysis Annotation
Analysis Annotation

An annotation may contain

Point

Range

Line

Label

Result Reference
Annotation Audit

If annotations affect a reported result, their origin should be traceable.

Calculation Inputs

The calculation engine should receive a defined input object.

Conceptually

CalculationInput

Dataset

Geometry

GaugeLength

Method

Standard

CalculationOptions
Calculation Output

Conceptually

CalculationOutput

Results

Warnings

Diagnostics

UsedSamples

CalculationVersion
Calculation Warnings

Examples

Insufficient Elastic Region

Missing Extensometer Data

Large Data Gap

Invalid Sample Region

Yield Point Ambiguous
Warning vs Error

A warning does not necessarily invalidate the Test.

An error prevents reliable calculation of the affected property.

Result-Level Validity

A Test may contain

Young's Modulus = Invalid

UTS = Valid

Yield Strength = Valid

The entire Test does not necessarily become invalid because one derived property failed.

Engineering Result Collection

Results should be individually addressable.

Example

YoungsModulus

YieldStrength

UltimateTensileStrength

Elongation

MaximumForce
Result Unit

Every result shall include its unit where applicable.

Examples

Young's Modulus = MPa

Yield Strength = MPa

UTS = MPa

Maximum Force = kN

Elongation = %
Result Precision

Calculation precision and display precision remain separate.

Display Formatting

The UI determines

Decimal Places

Scientific Notation

Unit Presentation

whereas the calculation layer provides the numerical value.

Export Precision

CSV / XML export may use a configurable numerical precision but shall not modify the stored value.

Engineering Dataset API

Conceptual interface

IEngineeringDatasetService

CreateDataset()

AppendSample()

FinalizeDataset()

GetDataset()

GetSamples()

GetDatasetStatistics()
Result Service

Conceptual interface

IEngineeringResultService

Calculate()

GetResults()

Recalculate()

EvaluateAcceptance()
Repository Separation

Services shall not directly embed SQL.

Engineering Service

↓

Repository

↓

SQLite
Performance Rule

Measurement sample persistence shall be optimized for sequential writes.

Result queries should be optimized for random access and reporting.

Large Dataset Retrieval

The UI should not load millions of samples into a WPF collection unnecessarily.

Pagination / Windowing

Large datasets should support

Range Query

Time Window

Sample Window

Downsampled Query
Graph Query

The graph should request only the data required for its current view.

Example

Full Dataset

↓

Visible Time Range

↓

Display Decimation

↓

Graph
Full Dataset Export

CSV export should be able to retrieve the complete authoritative dataset independently of the graph window.

Database Independence

The engineering model shall remain independent from SQLite-specific details.

Serialization

Engineering dataset objects should be serializable where required for

Recovery

Interchange

Diagnostics

Testing
Version Compatibility

Dataset schema changes shall use explicit migration versions.

Migration

Existing datasets shall not be silently reinterpreted after a schema migration.

Backward Compatibility

Readers should identify unsupported dataset versions and fail clearly rather than guessing.

Audit

Engineering data changes should be auditable.

Important events include

Dataset Created

Dataset Finalized

Calculation Performed

Calculation Repeated

Result Overridden

Acceptance Evaluated
Operator Association

Where relevant, the active operator should be associated with the Test and important actions.

Date / Time

Test start and end times should use a consistent application policy.

Time Zone

Stored timestamps should retain enough information to reconstruct the intended local test time.

Engineering Data Security

Completed measurement data shall not be casually editable through the normal UI.

Read-Only Completed Test

A Completed Test should normally open in read-only mode.

Editing Completed Tests

If editing is supported for metadata only

Measurement Dataset

=

Read Only

while permitted metadata changes are separately audited.

Acceptance Criteria

ARCH-067 is accepted when

Raw and engineering data are distinguishable.

Every Test has an identifiable dataset.

Samples have sequence and timestamp information.

Force, position and extension are represented consistently.

Geometry is preserved with the Test.

Stress and strain can be reproduced.

Derived results retain provenance.

Finalized datasets are immutable.

Large datasets do not require unbounded RAM.

SQLite persistence supports controlled batch storage.

CSV/XML export can represent the engineering dataset.

Calculation results can be reproduced from the finalized dataset.
Architectural Decision (FROZEN)

The authoritative Test Dataset is the permanent engineering source for all calculations, detection algorithms, exports and reports.

Raw measurements and derived engineering values are conceptually distinct.

Test-specific geometry, gauge length, Method, Standard, calibration reference and acquisition configuration are snapshotted for reproducibility.

Finalized measurement data is immutable.

Engineering results may be recalculated without modifying the authoritative dataset.

A result is valid only when its required inputs are valid and traceable.

The database representation shall remain independent of SQLite-specific implementation details.

Large datasets shall be persisted incrementally and shall not depend on keeping the entire dataset in memory.

This decision is permanent.

Next Chapter

ARCH-068

Method Engine, Standards, Test Parameters & Execution Profile

This chapter will define

Method Definition
Method Versioning
ISO 6892-1
ASTM E8
ASTM E111
ASTM E290
API 5L
ASTM A370
ISO 7438
ISO 5173
Test Parameter Profiles
Speed Control
Method A / B
Fixed Speed
Force Rate
Stress Rate
Load Cell Selection
Extensometer Selection
Crosshead Selection
Clutch Selection
Cycle Tests
Single Tests
Yield Configuration
Break Configuration
Reporting Options
Material Library Binding
Method Snapshot
Method Validation
Method Execution Rules
End of Chapter