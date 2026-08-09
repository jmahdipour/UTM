# ARCHITECTURE
# Chapter 51
# Material Library Architecture

Document ID

ARCH-051

Version

0.1

Status

FROZEN

Related EDR

EDR-056

Depends On

ARCH-022 Material Library

ARCH-039 Mechanical Property Calculation

ARCH-040 Acceptance Engine

ARCH-042 Project, Order & Sample Management

ARCH-047 Configuration Management

---

# Purpose

This chapter defines the Material Library Architecture.

The Material Library provides a centralized and version-controlled source for material definitions used throughout the testing system.

It supplies material information to

- Test Methods
- Specimens
- Mechanical Property Calculation
- Acceptance Engine
- Reports
- Batch Analysis

---

# Philosophy

Material information is master data.

It shall not be duplicated independently inside individual tests.

A test stores a reference to the material version used at the time of testing.

Historical tests must remain reproducible even if the material definition is later changed.

---

# Architecture

```text
Material Library

↓

Material Definition

↓

Material Grade

↓

Standard / Specification

↓

Acceptance Profile

↓

Test Method

↓

Specimen
```

---

# Responsibilities

Material Library SHALL

Create Materials

Manage Grades

Manage Material Families

Map Materials to Standards

Define Reference Properties

Link Acceptance Profiles

Manage Material Versions

Search Materials

Import Materials

Export Materials

---

# SHALL NOT

Calculate Mechanical Properties

Perform Acceptance Evaluation

Modify Historical Test Results

Control Machine Motion

Communicate with PLC

Generate Reports

---

# Material Hierarchy

Supported structure

```text
Material Family

↓

Material

↓

Grade

↓

Standard

↓

Revision
```

Example

```text
Steel

↓

Carbon Steel

↓

Grade X

↓

API 5L

↓

Revision
```

---

# Material Object

Each material contains

Material ID

Material Name

Material Family

Description

Status

Created Date

Modified Date

Created By

Modified By

---

# Grade Object

Each grade contains

Grade ID

Material ID

Grade Name

Designation

Chemical Specification

Mechanical Specification

Notes

---

# Standard Mapping

A material grade may be associated with multiple standards.

Example

```text
Grade

↓

ISO

ASTM

API

National Standard
```

Each mapping remains independent.

---

# Material Status

Supported

Draft

Active

Deprecated

Archived

---

# Material Versioning

Every modification creates a new version.

Example

```text
Grade X

v1

↓

v2

↓

v3
```

Historical versions remain available.

---

# Historical Test Rule

When a test starts, the system stores

```text
Material ID

Material Version

Grade

Standard Revision
```

The test shall never depend on the current material definition after completion.

---

# Reference Mechanical Properties

Material definitions may contain reference values such as

Yield Strength

Ultimate Tensile Strength

Elongation

Reduction of Area

Young's Modulus

These are reference specifications.

They are NOT measured test results.

---

# Acceptance Limits

Material may reference

Acceptance Profile

The Acceptance Engine evaluates the actual measured properties against that profile.

Material Library itself does not perform PASS / FAIL.

---

# Geometry Association

Material definitions may provide default specimen geometry recommendations.

Examples

Round

Flat

Rebar

Pipe

Tube

Sheet

Custom

These are defaults only.

The actual specimen geometry belongs to the Specimen record.

---

# Default Test Method

A material grade may define

Default Test Method

Example

```text
Material

↓

Grade

↓

ISO 6892-1 Tension
```

The operator may select another permitted method.

---

# Unit Handling

Material reference values have explicit units.

Examples

MPa

GPa

%

mm

kN

Units are never inferred from the displayed UI.

---

# Search

Supported search fields

Material Name

Grade

Designation

Standard

Revision

Material Family

Manufacturer

Heat Number

Status

---

# Favorites

Operators may mark frequently used materials as

Favorites.

Favorites are user preferences and do not modify Material Library master data.

---

# Custom Materials

Authorized users may create custom materials.

Custom material requires

Name

Grade

Source

Specification

Acceptance Profile

Remarks

---

# Approval

Custom or modified material definitions may require approval.

Workflow

```text
Draft

↓

Review

↓

Approved

↓

Active
```

---

# Deprecation

A material may be marked

Deprecated

when it should no longer be used for new tests.

Existing tests remain valid.

Historical records remain accessible.

---

# Import

Supported

CSV

Excel

JSON

XML

Future

LIMS

ERP

External Material Database

---

# Export

Supported

CSV

Excel

JSON

XML

Material Package

---

# Material Package

A material package may contain

```text
Material

Grade

Standard

Revision

Acceptance Profile

Metadata

Manifest
```

---

# Relationship with Test Method

Method may define

Compatible Materials

Default Material

Required Material Properties

Material-specific constraints.

---

# Relationship with Specimen

Specimen references

Material Version

not merely Material ID.

This guarantees historical traceability.

---

# Relationship with Acceptance Engine

```text
Material

↓

Acceptance Profile

↓

Acceptance Engine

↓

Measured Properties

↓

PASS / FAIL
```

---

# Relationship with Reports

Reports display

Material Name

Grade

Standard

Revision

Material Version

Reference values when requested.

---

# Audit

Important operations create Audit Records.

Examples

Material Created

Grade Created

Material Modified

Material Approved

Material Deprecated

Material Imported

Material Exported

---

# Permissions

Operator

View

Select

---

Supervisor

Create Custom Material

Modify Draft

Approve Material

---

Administrator

Manage Library

Import

Export

Archive

---

# Data Integrity

A material version used by a completed test shall never be physically deleted.

If obsolete, it becomes

Archived

or

Deprecated.

---

# Performance

Material Library may be cached in memory.

Search shall remain responsive with

Thousands

or

Millions

of material records.

---

# Future Compatibility

Supports

National Material Databases

Customer Material Databases

LIMS

ERP

Cloud Material Libraries

AI Material Recognition

without changing the core testing workflow.

---

# Design Constraints

Material Library SHALL NOT

Calculate Results

Evaluate PASS / FAIL

Modify Historical Tests

Control Hardware

Modify Calibration

Bypass Audit

---

# Architectural Decision (FROZEN)

The Material Library is the authoritative master-data source for material definitions.

Every completed test shall retain the exact material version and standard revision used during testing.

Material changes shall never retroactively change historical test results.

This decision is permanent.

---

# Next Chapter

ARCH-052

Test Method & Method Library Architecture

This chapter will define

- Method Library
- ISO 6892-1 Methods
- ASTM E8 Methods
- Method Parameters
- Load Cell Selection
- Stroke / Extensometer Selection
- Speed Type A / B / Fixed Speed
- Clutch Selection
- Single / Cycle Test
- Controller Selection
- Reporting Options
- Method Versioning
- Method-to-Specimen Workflow

---

# End of Chapter