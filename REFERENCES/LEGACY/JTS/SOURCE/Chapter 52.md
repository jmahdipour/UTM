# ARCHITECTURE
# Chapter 52
# Test Method & Method Library Architecture

Document ID

ARCH-052

Version

0.1

Status

FROZEN

Related EDR

EDR-057

Depends On

ARCH-022 Material Library

ARCH-039 Mechanical Property Calculation

ARCH-040 Acceptance Engine

ARCH-042 Project, Order & Sample Management

ARCH-046 Hardware Abstraction Layer

ARCH-047 Configuration Management

---

# Purpose

This chapter defines the Test Method and Method Library Architecture.

The Method Library contains reusable definitions describing **how a test shall be performed**.

A Method is not a Specimen Definition.

A Method is not a Standard.

A Method references the applicable Standard and defines the machine, acquisition, motion, calculation, stop and reporting behavior required to execute the test.

---

# Philosophy

The system separates

```text
Standard

↓

Method

↓

Specimen

↓

Test Session
```

A Standard defines requirements.

A Method defines execution.

A Specimen defines the physical test item.

A Test Session records the actual execution.

---

# Architecture

```text
Standards Library
        ↓
Method Library
        ↓
Method Version
        ↓
Test Session
        ↓
Measurement / Calculation
        ↓
Acceptance / Report
```

---

# Responsibilities

Method Library SHALL

Create Methods

Edit Methods

Version Methods

Validate Methods

Activate Methods

Archive Methods

Assign Standards

Select Hardware

Define Test Rates

Define Motion Steps

Define Stop Conditions

Define Acquisition Parameters

Define Calculation Profiles

Define Reporting Options

Define Safety Requirements

---

# SHALL NOT

Store Test Results

Modify Historical Tests

Perform Calculations

Evaluate Acceptance

Control Hardware Directly

Communicate with PLC Directly

---

# Method Object

Every Method contains

```text
Method ID

Method Name

Description

Method Type

Standard ID

Standard Revision

Version

Status

Created By

Created Date

Modified By

Modified Date
```

---

# Method Status

Supported

```text
Draft

Under Review

Approved

Active

Deprecated

Archived
```

Only an Active Method may normally be assigned to a new Test Session.

---

# Method Versioning

Every meaningful modification creates a new version.

Example

```text
ISO6892-1_TENSION

v1.0

↓

v1.1

↓

v2.0
```

Historical Test Sessions retain the exact Method Version used.

---

# Historical Reproducibility

A completed Test Session stores

```text
Method ID

Method Version

Standard ID

Standard Revision

Method Configuration Snapshot
```

Changing the current Method shall never modify a completed test.

---

# Method Designer

The Method Designer contains the following sections.

```text
General

Hardware

Standard Parameters

Motion Control

Test Sequence

Acquisition

Calculations

Material

Safety

Reporting

Machine Requirements
```

---

# General Section

Contains

Method Name

Method Code

Description

Standard

Standard Revision

Method Version

Status

Author

Approval

Remarks

---

# Hardware Section

Defines the hardware required by the method.

Supported selections

Load Cell

Stroke (Crosshead)

Extensometer

Controller

DAQ

---

# Load Cell Selection

Method may specify

```text
Load Cell

25 ton

10 ton

2 ton

500 kg

100 kg
```

or

```text
Automatic Selection
```

Automatic selection shall choose a compatible installed load cell according to the method requirements.

---

# Extensometer Selection

Method may specify

```text
None

Extensometer

Extensometer ID
```

The method may define required gauge length.

Supported installed extensometers include

```text
25 mm

50 mm

100 mm
```

---

# Stroke Selection

The method uses the canonical channel name

```text
Stroke (Crosshead)
```

This is the official software terminology.

---

# Canonical Measurement Channel Names

The software shall use exactly

```text
Load

Stroke (Crosshead)

Extensometer

Time
```

These names shall be used consistently in

Graph

Method

Data Acquisition

Reports

Export

Analysis

Test Data

---

# Standard Parameters

The method references a Standard.

Examples

```text
ISO 6892-1

ASTM E8 / E8M

ASTM E111

ASTM A370

API 5L

ISO 7438

ISO 5173
```

The method stores the exact Standard Revision.

---

# Standard Separation

The Standard Library defines

```text
Requirements

Definitions

Standard Revisions

Reference Rules
```

The Method Library defines

```text
Execution Parameters

Machine Settings

Acquisition

Motion Sequence

Calculation Profile

Reporting
```

A Standard shall not be duplicated inside a Method.

---

# Test Rate

Methods support

```text
Type A

Type B

Fixed Speed
```

---

# Type A

Type A rate control follows the applicable standard-defined strain-rate requirements.

The Method stores the required control parameters.

---

# Type B

Type B rate control follows the applicable stress-rate / force-rate requirements defined by the selected Standard.

---

# Fixed Speed

Operator may define

```text
Crosshead Speed

mm/min
```

Example

```text
10 mm/min
```

The exact configured value belongs to the Method Version.

---

# Rate Units

Supported

```text
mm/min

kN/s

MPa/s

Strain/s
```

The selected unit shall always be stored explicitly.

---

# Motion Control

Method defines

Initial Position

Preload

Approach Speed

Test Speed

Return Speed

Maximum Travel

Maximum Load

---

# Motion Steps

A Method may contain multiple sequential steps.

Example

```text
Step 1

Approach

↓

Step 2

Preload

↓

Step 3

Extensometer Acquisition

↓

Step 4

Main Test

↓

Step 5

Break Detection

↓

Step 6

Return
```

---

# Step Object

Each step contains

```text
Step ID

Step Order

Step Type

Target

Rate

Duration

Control Mode

Start Condition

Stop Condition

Safety Limits
```

---

# Control Modes

Supported

Position

Speed

Force

Stress

Strain

Cycle

---

# Single Test

Method may define

```text
Single
```

The sequence executes once.

---

# Cycle Test

Method may define

```text
Cycle Count

Minimum Value

Maximum Value

Loading Rate

Unloading Rate

Hold Time
```

Example

```text
Load

↓

Unload

↓

Load

↓

Unload
```

---

# Stop Conditions

Supported

Maximum Load

Minimum Load

Maximum Stroke (Crosshead)

Maximum Extension

Break

Load Drop

Time

Strain

Position Limit

Emergency Condition

Operator Stop

---

# Break Detection

Method may select

```text
Automatic

Standard Defined

Force Drop

Threshold

Manual
```

The actual detection algorithm belongs to the Calculation / Detection Engine.

The Method only selects and configures it.

---

# Acquisition Section

Defines

Sampling Rate

Channel Selection

Synchronization

Buffer Size

Acquisition Mode

Recording Policy

---

# Required Channels

A Method may require

```text
Load

Stroke (Crosshead)

Extensometer

Time
```

Channels not required by the Method shall not be mandatory for the test.

---

# Acquisition Rate

The Method may define

```text
100 Hz

500 Hz

1000 Hz

Custom
```

The actual supported rate depends on installed DAQ hardware.

---

# Synchronization

All required channels shall share a common measurement timeline.

The primary time reference is

```text
Time
```

---

# Calculation Section

Method references Calculation Profiles.

Examples

```text
Yield

Rp0.2

Rp0.1

Rt0.5

Ultimate Tensile Strength

Young's Modulus

Elongation

Breaking Force
```

The Method does not contain executable calculation code.

---

# Calculation Profile

Contains

Calculation ID

Algorithm ID

Algorithm Version

Parameter Set

Standard Reference

---

# Material Section

Method may define

Compatible Material Families

Compatible Grades

Default Material

Required Material Properties

---

# Material Reference

The Method references the Material Library.

It does not duplicate material master data.

---

# Reporting Section

Method may define

Default Report Template

Required Graphs

Required Tables

Visible Properties

Acceptance Section

Signature Section

Export Options

---

# Default Graphs

Method may request

```text
Load vs Stroke (Crosshead)

Stress vs Strain

Load vs Time

Stroke (Crosshead) vs Time

Extensometer vs Time
```

The Graph Engine remains responsible for rendering.

---

# Safety Section

Defines

Maximum Load

Maximum Speed

Maximum Stroke (Crosshead)

Travel Limits

Required Interlocks

Emergency Requirements

---

# Machine Requirements

A Method may specify

Required Load Capacity

Required Extensometer

Required Stroke Range

Required Controller Capability

Required DAQ Rate

Required Motion Capability

---

# Compatibility Validation

Before a Method can be executed

```text
Method

↓

Machine Compatibility Check

↓

Hardware Availability

↓

Configuration Validation

↓

Ready
```

If requirements are not satisfied

```text
Method Not Executable
```

---

# Method Assignment

Methods may be assigned to

Order

Specimen

Material

Test Session

---

# Method Snapshot

When testing begins, the complete Method configuration is frozen into the Test Session.

This guarantees reproducibility.

---

# Operator Editing

The operator may edit only parameters explicitly marked

```text
Operator Editable
```

Other parameters remain locked.

---

# Locked Parameters

Examples

Standard

Algorithm

Safety Limits

Machine Requirements

Acceptance Rules

These require appropriate authorization to change.

---

# Method Validation

Before activation the Method Validator checks

Required Fields

Standard Compatibility

Hardware Compatibility

Rate Validity

Motion Sequence

Stop Conditions

Acquisition Configuration

Calculation Configuration

Report Configuration

Safety Limits

---

# Approval Workflow

```text
Draft

↓

Validation

↓

Review

↓

Approval

↓

Active
```

---

# Method Duplication

An existing Method may be cloned.

Cloning creates

New Method ID

New Version

New Audit Record

Historical Methods remain unchanged.

---

# Import

Supported

JSON

XML

CSV

Future Method Package

---

# Export

Supported

JSON

XML

Method Package

---

# Method Package

A portable Method Package may contain

```text
Method

Version

Standard Reference

Calculation Profiles

Report Reference

Machine Requirements

Manifest
```

---

# Audit

Important operations create Audit Records.

Examples

```text
Method Created

Method Modified

Method Version Created

Method Approved

Method Activated

Method Deprecated

Method Archived

Method Imported

Method Exported
```

---

# Permissions

Operator

Select Active Methods

Edit Operator-Editable Parameters

---

Supervisor

Create Methods

Modify Drafts

Review Methods

Approve Methods

---

Administrator

Manage Method Library

Archive Methods

Import / Export

Manage Method Permissions

---

# Database Relationship

Method Library is stored independently from

Test Results

Measurement Frames

Reports

Calibration Records

Material Master Data

Repositories provide access.

No subsystem accesses Method tables through direct SQL.

---

# Relationship with Test Session

```text
Method

↓

Method Version

↓

Test Session

↓

Method Snapshot
```

The Test Session owns the historical execution configuration.

---

# Relationship with Material

```text
Material

↓

Compatible Method

↓

Selected Method

↓

Test Session
```

---

# Relationship with Acceptance

Method references

Acceptance Profile

Acceptance Engine evaluates the final measured properties.

---

# Relationship with Calibration

Method selects compatible hardware.

The active Calibration Record for that hardware is applied independently through the Calibration/HAL subsystem.

---

# Relationship with Graph Engine

Method specifies preferred graph configurations.

Graph Engine performs rendering.

---

# Relationship with Report Engine

Method specifies preferred report configuration.

Report Engine generates the final document.

---

# Performance

Method validation shall occur before testing.

During an active test the Method is treated as immutable.

No method editing operation may block

DAQ

Motion

Measurement Processing

---

# Future Compatibility

Supports

Advanced Strain Control

Stress Control

Custom Test Sequences

Multi-Axis Testing

Research Methods

Customer Methods

AI-Assisted Method Design

without changing the Core architecture.

---

# Design Constraints

Method Library SHALL NOT

Calculate Results

Evaluate PASS / FAIL

Modify Historical Data

Directly Control Hardware

Modify Calibration

Modify Material Master Data

Bypass Audit

---

# Architectural Decision (FROZEN)

The Method Library is the authoritative source for defining **how a test is executed**.

Standards define requirements.

Methods define execution.

Specimens define physical test objects.

Test Sessions preserve the exact Method Version and configuration used during testing.

The canonical measurement channel names are permanently:

```text
Load

Stroke (Crosshead)

Extensometer

Time
```

No completed test may depend on a mutable current Method definition.

This decision is permanent.

---

# Next Chapter

ARCH-053

Test Execution & Runtime State Machine Architecture

This chapter will define

- Test Preparation
- Pre-Test Validation
- Ready State
- JOG
- Start
- Running
- Pause
- Resume
- Stop
- Emergency Stop
- Break Detection
- Test Completion
- Fault Handling
- Runtime State Transitions
- Operator Interaction
- Test Session Lifecycle

---

# End of Chapter