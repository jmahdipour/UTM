# ARCHITECTURE
# Chapter 39
# Mechanical Property Calculation Architecture

Document ID

ARCH-039

Version

0.1

Status

FROZEN

Related EDR

EDR-044

Depends On

ARCH-034 Data Acquisition

ARCH-036 Measurement Channels

ARCH-038 Graph Architecture

ARCH-028 Workflow Architecture

---

# Purpose

This chapter defines the architecture of the Mechanical Property Calculation Engine.

This subsystem converts engineering measurements into standardized mechanical results.

Examples

- Yield Strength
- Tensile Strength
- Proof Stress
- Elongation
- Young's Modulus
- Energy
- Breaking Point

---

# Philosophy

The Calculation Engine is a scientific calculation subsystem.

It does not control the machine.

It does not collect data.

It only analyzes recorded engineering measurements.

---

# Architecture Position

```
Measurement Frames

↓

Calculation Engine

↓

Mechanical Properties

↓

Acceptance Engine

↓

Report Engine
```

---

# Responsibilities

The Calculation Engine SHALL

Receive Engineering Frames

Apply Standard Algorithms

Calculate Properties

Create Result Objects

Generate Calculation Metadata

Provide Traceability

---

# SHALL NOT

Control Motion

Communicate With PLC

Modify Measurements

Generate Reports

Approve Results

Change Calibration

---

# Input Data

The Calculation Engine receives

Load

Stroke (Crosshead)

Extensometer

Time

Geometry

Material Information

Test Method

Standard

Calibration Reference

---

# Calculation Object

Every calculated result contains

```
Property ID

Property Name

Value

Unit

Calculation Method

Standard Reference

Input Data Range

Timestamp

Algorithm Version

```

---

# Calculation Pipeline

```
Engineering Data

↓

Pre Processing

↓

Detection Algorithms

↓

Property Calculation

↓

Validation

↓

Result Storage
```

---

# Pre Processing

Before calculation

The engine may perform

Filtering

Noise Reduction

Offset Removal

Synchronization Check

Range Selection

---

# Important Rule

Filtering shall never modify stored measurement data.

Original measurements remain unchanged.

---

# Standard Calculation Profiles

Supported

ISO 6892-1

ASTM E8

ASTM E111

ASTM A370

API 5L

ISO 7438

ISO 5173

Future Standards

---

# Yield Detection

Supported methods

Automatic Yield

Offset Yield

Manual Yield

Standard Defined Yield

---

# Proof Stress

Supported

Rp0.1

Rp0.2

Rt0.5

Custom Offset

---

# Rp Calculation

General principle

```
Elastic Line

+

Offset Strain

↓

Intersection

↓

Proof Stress
```

Offset value is configurable.

---

# Tensile Strength

Calculation

```
Maximum Load

↓

Divide By Original Area

↓

Rm
```

Result includes

Maximum Force

Time

Stroke

Strain

---

# Breaking Point

Detection methods

Supported

Load Drop

Force Threshold

Strain Limit

Standard Rule

Manual Selection

---

# Elongation

Supported

A

Agt

Percentage Extension

Gauge Length Based

---

# Young's Modulus

Supported according to

ASTM E111

Calculation

```
Stress / Strain Slope

↓

Elastic Region

↓

E-Modulus
```

---

# Elastic Region Detection

Supported

Manual Range

Automatic Linear Regression

Maximum R²

Longest Uniform Slope

---

# Regression Engine

Calculates

Slope

Intercept

R²

Error

Confidence

---

# Stress Calculation

Formula

```
Stress = Force / Area
```

Requires

Original Cross Section

---

# Strain Calculation

Formula

```
Strain = Extension / Initial Length
```

Requires

Gauge Length

---

# True Stress

Optional

Uses

Instantaneous Area

Material Model

Future Extension

---

# Energy Calculation

Supported

Area Under Curve

Examples

Force-Stroke Energy

Stress-Strain Energy

---

# Result Validation

Every result receives

Valid

Warning

Invalid

Manual Review Required

---

# Calculation Traceability

Every result stores

Algorithm Version

Software Version

Standard

Method

Input Range

Operator Modification

---

# Manual Adjustment

Supported but controlled.

Example

Operator selects fracture point.

System stores

Original Automatic Result

Modified Result

Reason

User

Timestamp

---

# Comparison

Supports

Multiple Tests

Multiple Specimens

Material Comparison

Batch Analysis

---

# Uncertainty

Future support

Measurement Uncertainty

Calibration Uncertainty

Statistical Uncertainty

---

# Result Object Example

```
Property:

Ultimate Tensile Strength

Value:

650 MPa

Standard:

ISO 6892-1

Algorithm:

UTS_001

Version:

1.0
```

---

# Event Publication

After calculation

Publishes

```
MechanicalPropertiesCalculated
```

Payload

Test ID

Results

Algorithm Version

Timestamp

---

# Relationship With Acceptance

Acceptance Engine consumes results.

Example

```
Rm

↓

Acceptance Rule

↓

PASS / FAIL
```

---

# Relationship With Report

Report Engine receives

Final Mechanical Properties

It does not recalculate.

---

# Relationship With Database

Calculation Engine writes through

Repository Layer

Never direct SQL.

---

# Performance

Supports

Large datasets

Batch Calculation

Real-Time Partial Calculation

Background Processing

---

# Plugin Support

Future plugins may add

New Standards

New Algorithms

Custom Properties

AI Detection

without changing core engine.

---

# Design Constraints

Calculation Engine SHALL NOT

Control Machine

Modify Raw Data

Modify Calibration

Generate Reports

Access PLC

Access Hardware Directly

---

# Architectural Decision (FROZEN)

All mechanical properties shall be calculated by a centralized Calculation Engine.

Results must always contain complete traceability:

- Input Data
- Algorithm
- Standard
- Version
- User Modification History

No report or acceptance module is allowed to calculate engineering properties independently.

---

# Next Chapter

ARCH-040

Acceptance & Decision Engine Architecture

This chapter will define:

- ISO / ASTM Acceptance Rules
- PASS / FAIL Logic
- Tolerance Handling
- Material Specifications
- Rebar Standards
- API Pipe Acceptance
- Override Management
- Laboratory Decision Workflow

---

# End of Chapter