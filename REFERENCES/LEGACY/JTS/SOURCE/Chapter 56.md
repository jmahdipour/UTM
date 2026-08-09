# ARCHITECTURE
# Chapter 56
# Engineering Detection & Mechanical Property Algorithm Architecture

Document ID

ARCH-056

Version

0.1

Status

FROZEN

Related EDR

EDR-061

Depends On

ARCH-039 Mechanical Property Calculation

ARCH-040 Acceptance Engine

ARCH-052 Test Method Architecture

ARCH-054 Test Data & Measurement Storage

ARCH-055 Graph & Curve Visualization

---

# Purpose

This chapter defines the architecture for engineering-property detection and mechanical-property algorithms used by the Universal Testing Machine software.

The subsystem is responsible for detecting and calculating engineering results from finalized measurement datasets.

Supported calculations include

- Yield Point
- Rp0.2
- Rp0.1
- Rt0.5
- Young's Modulus
- Ultimate Tensile Strength
- Maximum Force
- Elongation
- Reduction of Area
- Break Point
- Elastic Region
- Plastic Region
- Slope
- Offset Lines

---

# Philosophy

The Calculation Engine is a deterministic engineering subsystem.

It receives

```text
Finalized Measurement Dataset

+

Specimen Geometry

+

Material Information

+

Method Configuration

+

Standard Revision

+

Algorithm Version

and produces

Mechanical Properties
Architecture
Test Dataset

↓

Preprocessing

↓

Analysis Region Detection

↓

Engineering Algorithms

↓

Mechanical Properties

↓

Result Validation

↓

Acceptance Engine
Responsibilities

Calculation Engine SHALL

Load Measurement Data

Validate Input Data

Create Analysis Regions

Detect Engineering Points

Calculate Mechanical Properties

Store Algorithm Version

Store Parameters

Return Reproducible Results

SHALL NOT

Modify Original Measurement Data

Control Motion

Communicate with PLC

Modify Calibration

Generate Final Reports

Directly evaluate laboratory acceptance

Calculation Input

The Calculation Engine requires

Measurement Dataset

Specimen Geometry

Initial Gauge Length

Cross Section

Method Version

Standard Revision

Algorithm Profile
Calculation Output

Every calculated property contains

Property ID

Property Name

Value

Unit

Source Dataset

Algorithm ID

Algorithm Version

Parameters

Detection Point

Confidence / Quality Flag

Timestamp
Algorithm Versioning

Every algorithm has

Algorithm ID

Version

Standard Reference

Revision

Description

Example

YIELD_RP02

v1.0

ISO 6892-1

A future improvement becomes

v1.1

Historical results retain the original version.

Determinism

The same

Dataset

+

Geometry

+

Method

+

Algorithm Version

+

Parameters

must produce the same result.

Data Validation

Before calculation the engine validates

Missing Values

Duplicate Frames

Invalid Units

Invalid Geometry

Insufficient Data

Non-monotonic Time

Invalid Channel

Corrupted Dataset

Invalid Dataset

If required data is unavailable

Calculation

↓

Not Evaluated

The engine shall never invent missing measurement values.

Preprocessing

Optional preprocessing may include

Noise Filtering

Unit Conversion

Resampling

Outlier Detection

Baseline Correction

These operations produce derived data.

Original data remains unchanged.

Analysis Region

Algorithms may operate on a defined region.

Example

Complete Curve

↓

Elastic Region

↓

Yield Region

↓

Plastic Region

↓

Fracture Region
Elastic Region Detection

The engine may identify the approximately linear portion of the stress-strain curve.

Candidate regions are evaluated using

Linear Regression
R²
Slope Stability
Point Density
Standard-defined limits
Largest Uniform Slope

For Young's Modulus or elastic-region analysis, the engine may search for the longest region with approximately uniform slope.

Conceptually

Stress-Strain Data

↓

Sliding Window

↓

Linear Regression

↓

Slope

↓

R²

↓

Uniformity Score

↓

Best Region

The exact algorithm and parameters are Method/Standard dependent.

Young's Modulus

Young's Modulus is calculated from the selected elastic-region data.

Conceptually

E = ΔStress / ΔStrain

The algorithm shall store

Elastic Region Start

Elastic Region End

Slope

R²

Algorithm Version
Yield Detection

Yield detection is Method/Standard dependent.

The engine shall support multiple algorithms rather than one universal rule.

Rp0.2

Rp0.2 is determined using an offset method.

Conceptually

Elastic Slope

↓

0.2% Strain Offset

↓

Parallel Offset Line

↓

Intersection with Curve

↓

Rp0.2

The configured offset shall be stored explicitly.

Rp0.1

Same architecture as Rp0.2.

Elastic Slope

↓

0.1% Strain Offset

↓

Intersection

↓

Rp0.1
Rt0.5

Rt0.5 is supported as a configurable proof-stress / specified residual-strain method according to the selected Standard.

The exact definition shall come from the applicable Standard Revision.

The algorithm shall not assume that all standards use identical terminology or detection rules.

Offset Line

Each offset calculation stores

Offset Value

Elastic Slope

Reference Region

Intersection Point

Algorithm Version
Yield Point Detection

Where a Standard defines a distinct yield phenomenon, the engine may detect

Upper Yield Point

Lower Yield Point

Detection shall follow the selected Standard/Method rules.

Force-Drop Detection

A configurable force-drop detector may identify yield-related behavior where the Method explicitly permits it.

Conceptually

Force Increasing

↓

Local Peak

↓

Specified Force Reduction

↓

Candidate Yield Region

The threshold and search window must be stored as parameters.

Ultimate Tensile Strength

UTS is calculated from maximum engineering stress.

Conceptually

Maximum Force

÷

Initial Cross-Sectional Area

Result

Ultimate Tensile Strength
Maximum Force

The engine identifies

Fmax

from the finalized Load channel.

The exact selection rule shall be Method dependent.

Elongation

Elongation may be calculated from

Gauge Length

+

Final Gauge Length

or from the applicable extensometer / crosshead measurement according to the selected Standard.

The source measurement shall always be identified.

Reduction of Area

Where required and supported, reduction of area is calculated from

Initial Area

+

Final Area

The geometry source shall be explicitly recorded.

Break Detection

Break detection is configurable.

Possible strategies

Force Drop

Percentage Drop

Absolute Drop

Post-Peak Decline

Standard Rule

Manual Confirmation
Post-Peak Break Detection

A typical strategy may be

Find Fmax

↓

Search After Fmax

↓

Detect Required Force Reduction

↓

Candidate Break Point

The algorithm shall not automatically treat every force decrease as a break.

Break Validation

Candidate break points may be validated using

Force Reduction

Post-Peak Region

Stroke Change

Extensometer Behavior

Data Continuity

Method Threshold
Slope Detection

The engine supports slope analysis.

For two points

Slope = ΔY / ΔX

For regression regions

Slope = Regression Coefficient
Regression

Supported

Linear Regression

R²

Residual Analysis

Slope

Intercept
Curve Segmentation

The curve may be divided into

Preload

Elastic

Yield

Plastic

Necking

Fracture

Segmentation is Method dependent.

Geometry

Calculation requires explicit geometry.

Supported

Round

Flat

Pipe

Square

Rectangular

Custom
Round Geometry

For diameter D

A = πD² / 4
Pipe Geometry

For outer diameter D and thickness t

A = π/4 × (D² - (D - 2t)²)
Flat Geometry

For width W and thickness T

A = W × T
Custom Geometry

Custom geometry may provide

Initial Area

directly.

The source and unit must be recorded.

Initial Gauge Length

The calculation engine shall use the fixed initial gauge length associated with the Test Session.

Historical tests shall never depend on a later modified specimen value.

Stress Calculation

Engineering stress is calculated using

Stress = Force / Initial Area
Strain Calculation

Engineering strain is calculated using

Strain = ΔL / L0

where

ΔL = Change in Gauge Length

L0 = Initial Gauge Length
Unit Normalization

All calculations operate on normalized engineering units.

The engine shall not infer units from numerical magnitude.

Quality Flags

Every result may contain

Valid

Warning

Insufficient Data

Out of Range

Ambiguous

Not Evaluated
Confidence

Where an algorithm produces a measurable quality indicator, the result may include

Confidence

R²

Residual Error

Detection Score

Confidence is informational unless the applicable Standard explicitly defines acceptance criteria for the detection.

Multiple Candidates

If several candidate points satisfy the detection algorithm, the engine shall

Apply Standard rules.
Apply Method parameters.
Rank candidates deterministically.
Select the valid candidate.
Preserve candidate information where required for review.
Manual Override

Authorized users may manually select a point when the Method permits manual review.

Manual override shall never modify the original measurement dataset.

The result shall record

Automatic Result

Manual Result

User

Timestamp

Reason
Result Revision

If a result is recalculated

Result v1

↓

Result v2

Previous results remain traceable.

Calculation Snapshot

Every completed calculation stores

Dataset ID

Method Version

Standard Revision

Algorithm IDs

Algorithm Versions

Parameters

Geometry

Calibration References

Software Version
Acceptance Integration

After calculation

Mechanical Properties

↓

Acceptance Engine

↓

PASS / FAIL / WARNING

The Calculation Engine does not decide acceptance.

Graph Integration

Calculation results may be displayed by the Graph Engine.

Examples

Rp0.2 Point

Young's Modulus Line

Maximum Stress

Break Point
Report Integration

The Report Engine receives finalized calculation results.

It does not recalculate them.

Audit

Important calculation operations may generate audit records.

Examples

Calculation Started

Calculation Completed

Calculation Failed

Result Recalculated

Manual Override Applied
Performance

Final calculation may execute asynchronously after dataset finalization.

Calculation shall not interfere with

Motion
Acquisition
Safety
UI Responsiveness
Testing

Each algorithm shall have

Unit Tests

Reference Datasets

Boundary Tests

Regression Tests

Standard-Specific Tests

Reference datasets shall be retained for future software versions.

Standard Compliance

Algorithms shall be mapped to the applicable Standard Revision.

Examples

ISO 6892-1

ASTM E8 / E8M

ASTM E111

ASTM A370

API 5L

ISO 7438

Where standards differ, separate algorithm profiles shall be used.

Design Constraints

Engineering Detection Engine SHALL NOT

Modify Raw Data

Modify Engineering Data

Control Hardware

Modify Calibration

Modify Material Master Data

Directly decide Acceptance

Generate Reports

Bypass Audit

Architectural Decision (FROZEN)

All mechanical-property calculations shall be deterministic, versioned and reproducible.

Yield detection, proof stress, Young's Modulus, UTS, elongation, reduction of area and break detection shall be implemented as independent algorithm components.

Standard-specific behavior shall be selected through Method and Standard configuration rather than hidden inside generic calculations.

Original measurement data shall never be modified by an engineering algorithm.

This decision is permanent.

Next Chapter

ARCH-057

Standards Library & Standards Compliance Engine

This chapter will define

ISO 6892-1
ASTM E8 / E8M
ASTM E111
ASTM A370
API 5L
ISO 7438
ISO 5173
Standard Revisions
Standard Parameters
Method Mapping
Compliance Rules
Standard Traceability
Future Standards
National Standards
INSO / Iranian Standards
End of Chapter