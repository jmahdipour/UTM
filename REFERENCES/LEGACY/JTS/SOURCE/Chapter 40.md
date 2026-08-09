# ARCHITECTURE
# Chapter 40
# Acceptance & Decision Engine Architecture

Document ID

ARCH-040

Version

0.1

Status

FROZEN

Related EDR

EDR-045

Depends On

ARCH-039 Mechanical Property Calculation

ARCH-022 Material Library

ARCH-021 Acceptance Library

ARCH-031 Audit Architecture

---

# Purpose

This chapter defines the Acceptance & Decision Engine.

The Acceptance Engine determines whether a specimen satisfies the selected engineering specification.

It is one of the most important subsystems because laboratory decisions are based on its output.

---

# Philosophy

The Acceptance Engine **never calculates** mechanical properties.

It only evaluates them.

```
Mechanical Properties

↓

Acceptance Rules

↓

Decision

↓

Report
```

---

# Responsibilities

The Acceptance Engine SHALL

Evaluate Mechanical Properties

Apply Standard Rules

Apply Customer Specifications

Determine PASS / FAIL

Generate Decision Records

Generate Acceptance Report Data

Publish Acceptance Events

---

# SHALL NOT

Calculate Mechanical Properties

Acquire Data

Communicate with PLC

Modify Measurements

Generate Graphs

---

# Inputs

Receives

Mechanical Properties

↓

Material

↓

Acceptance Profile

↓

Test Method

↓

Standard

↓

Operator Information

---

# Outputs

Produces

PASS

FAIL

WARNING

NOT EVALUATED

MANUAL REVIEW

---

# Acceptance Object

Every decision contains

Acceptance ID

Acceptance Profile

Decision

Decision Time

Decision Source

Operator

Algorithm Version

Rule Set Version

Remarks

---

# Acceptance Sources

Acceptance Rules may originate from

Material Library

National Standard

International Standard

Customer Specification

Project Specification

Manual Profile

Future ERP

---

# Rule Types

Supported

Minimum Value

Maximum Value

Range

Tolerance

Percentage

Logical Rule

Combined Rule

Future AI Rule

---

# Example Rule

Yield Strength

Minimum

500 MPa

If

Measured

≥500

↓

PASS

Otherwise

↓

FAIL

---

# Multiple Rule Evaluation

Example

```
Yield

PASS

Ultimate Strength

PASS

Elongation

FAIL

↓

Overall

FAIL
```

Each property retains its own result.

---

# Rule Groups

Acceptance Profiles may contain

Mechanical Properties

Geometry

Dimensions

Surface Quality

Future NDT Results

Unlimited groups.

---

# Evaluation Strategy

```
Rule 1

↓

Rule 2

↓

Rule 3

↓

...

↓

Final Decision
```

Evaluation order is deterministic.

---

# Decision Levels

Property Level

↓

Group Level

↓

Specimen Level

↓

Batch Level

↓

Project Level

---

# Property Decision

Each calculated property receives

PASS

FAIL

WARNING

NOT AVAILABLE

---

# Overall Decision

Default policy

If any mandatory property fails

↓

Overall FAIL

Configurable for future standards.

---

# Missing Properties

If a required property is unavailable

↓

Decision

NOT EVALUATED

Reason stored.

---

# Tolerance Handling

Supported

Absolute Tolerance

Relative Tolerance

Engineering Margin

Upper / Lower Limit

Custom Formula

---

# Standard Profiles

Supports

ISO 6892-1

ASTM E8

ASTM A370

API 5L

ISO 7438

National Standards

Future Standards

---

# Material Library Integration

Acceptance Profile may automatically load from

Material

↓

Grade

↓

Standard

↓

Revision

Operator does not need to manually recreate limits.

---

# Manual Override

Supported

Requires

Supervisor Permission

Reason

Electronic Signature

Audit Entry

Original decision remains stored.

---

# Override Object

Stores

Original Decision

New Decision

Reason

User

Timestamp

Signature

Approval

---

# Batch Acceptance

Supported

```
Specimen 1

PASS

Specimen 2

PASS

Specimen 3

FAIL

↓

Batch

FAIL
```

Configurable policies supported.

---

# Statistical Acceptance

Future support

Average

Standard Deviation

Cpk

Minimum Sample Count

Population Analysis

---

# Decision Traceability

Every decision stores

Mechanical Property

Acceptance Rule

Tolerance

Operator

Algorithm Version

Decision Time

Rule Revision

---

# Event Publication

Publishes

AcceptanceCompleted

AcceptanceFailed

AcceptanceOverridden

AcceptanceApproved

---

# Relationship with Reports

Report Engine receives

Final Acceptance Result

Report Engine never evaluates specifications.

---

# Relationship with Material Library

Material Library supplies

Reference Limits

Acceptance Engine performs evaluation.

---

# Relationship with Audit

Every acceptance operation generates

Audit Record

Including

Decision

Reason

Operator

Override

---

# Future Compatibility

Supports

Customer Specifications

AI Decision Assistance

Cloud Standards

ERP Integration

National Standard Updates

without redesign.

---

# Performance

Supports

Single Specimen

Batch Testing

Large Production Runs

Background Evaluation

---

# Design Constraints

Acceptance Engine SHALL NOT

Calculate Mechanical Properties

Modify Measurements

Modify Material Library

Modify Calibration

Communicate with PLC

Generate Reports

---

# Architectural Decision (FROZEN)

The Acceptance Engine is the **only subsystem authorized to determine PASS / FAIL**.

Mechanical Property Calculation and Acceptance Evaluation are permanently separated.

Every acceptance decision shall be fully traceable and reproducible using

- Mechanical Properties
- Acceptance Profile
- Rule Version
- Algorithm Version

This decision is permanent.

---

# Next Chapter

ARCH-041

Report Generation Architecture

This chapter will define

- Report Templates
- Report Engine
- PDF Generation
- Word Export
- Excel Export
- Graph Embedding
- Digital Signatures
- Multi-language Reports
- ISO 17025 Report Layout
- TrapeziumX Compatible Reports

---

# End of Chapter