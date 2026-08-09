# ARCHITECTURE
# Chapter 20
# Decision Rule Engine Architecture

Document ID

ARCH-020

Version

0.1

Status

FROZEN

Related EDR

EDR-025

Depends On

ARCH-008 Acceptance Engine

ARCH-019 Acceptance Profile

---

# Purpose

This chapter defines the Decision Rule Engine.

The Decision Rule Engine is responsible for transforming engineering results into a final acceptance decision.

It does **not** calculate engineering properties.

It only evaluates them.

---

# Philosophy

The workflow is always

```
Measurements

↓

Mechanical Properties

↓

Acceptance Profile

↓

Decision Rule Engine

↓

PASS / FAIL
```

The Decision Rule Engine is the only component allowed to determine acceptance.

---

# Responsibilities

The Decision Rule Engine SHALL

Evaluate measured properties

Apply comparison rules

Apply uncertainty (optional)

Apply risk policy (optional)

Generate individual decisions

Generate overall decision

Produce traceable evaluation

---

# The Engine SHALL NOT

Acquire measurements

Calculate stress

Calculate strain

Calculate Young Modulus

Calculate Yield

Modify results

Modify Acceptance Profiles

Communicate with hardware

---

# Internal Structure

```
Decision Rule Engine

│

├── Property Evaluator

├── Comparison Engine

├── Decision Rule Module

├── Uncertainty Module

├── Risk Module

├── Final Decision Module

└── Audit Module
```

---

# Property Evaluator

Receives

Mechanical Property

↓

Acceptance Requirement

Example

Measured Yield

↓

Minimum Yield

Outputs

Comparison Request

---

# Comparison Engine

Supported comparisons

Greater Than

Greater Than or Equal

Less Than

Less Than or Equal

Range

Target ± Tolerance

Formula

Custom Rule

Future Rule

Unlimited

---

# Example

Requirement

Yield ≥ 400 MPa

Measured

412 MPa

↓

PASS

---

Requirement

Yield ≥ 400 MPa

Measured

395 MPa

↓

FAIL

---

# Decision Rule Module

Defines HOW the comparison is interpreted.

Supported Rules

Strict Rule

Simple Rule

Guard Band

ISO 17025

Producer Risk

Consumer Risk

Balanced Risk

Custom Rule

---

# Rule Selection

Rule is selected by

Acceptance Profile

↓

Decision Rule Engine

The Test Method has no influence.

---

# Uncertainty Module

Optional

Input

Measured Value

Expanded Uncertainty

Coverage Factor

Decision Rule

Output

Corrected Decision

---

Example

Measured

401 MPa

Expanded Uncertainty

±4 MPa

Requirement

400 MPa

Strict Rule

↓

PASS

ISO 17025 Guard Band

↓

REVIEW

or

FAIL

depending on policy.

---

# Risk Module

Optional

Supported

Disabled

Producer Risk

Consumer Risk

Balanced

Custom

Risk modifies

Decision

NOT

Measurements

---

# Final Decision Module

Receives

Individual Property Results

↓

Combines

↓

Final Decision

---

# Combination Rules

Supported

All Pass

Critical First

Weighted

Custom

Future AI

---

# Example

Yield

PASS

Ultimate Strength

PASS

Elongation

FAIL

↓

Final

FAIL

---

# Partial Evaluation

Possible

Yield

PASS

Ultimate

PASS

Elongation

NOT AVAILABLE

↓

Decision

NOT EVALUATED

instead of FAIL.

---

# Audit Module

Every decision stores

Property

Requirement

Measured Value

Decision Rule

Risk

Uncertainty

Timestamp

Operator

Software Version

Approval Status

---

# Decision States

Property Level

PASS

FAIL

DISABLED

NOT AVAILABLE

MANUAL

Overall Level

PASS

FAIL

PASS WITH WARNING

NOT EVALUATED

MANUAL REVIEW

---

# Manual Review

Optional

If enabled

Supervisor may

Accept

Reject

Override

Every override requires

Reason

Signature

Audit Record

---

# Traceability

Every decision shall be reproducible.

Running the same data with

same

Acceptance Profile

same

Decision Rule

shall always produce the same result.

---

# Relationship with Reporting

Reporting displays

Measured Value

Requirement

Decision

Rule

Risk

Uncertainty

No recalculation occurs during reporting.

---

# Relationship with Material Library

Material Library provides

Acceptance Profile

↓

Decision Rule Engine

↓

Decision

Material Library never evaluates.

---

# Future Compatibility

Supports

Multiple Decision Engines

AI Decision Assistant

Cloud Decision Rules

National Rule Packages

Laboratory Rule Packages

Customer Rule Packages

without redesign.

---

# Design Constraints

Decision Rule Engine SHALL NOT

Modify Measurements

Modify Mechanical Properties

Modify Acceptance Profile

Modify Material Library

Communicate with PLC

Generate Reports

---

# Architectural Decision (FROZEN)

Every PASS / FAIL decision inside the software shall originate exclusively from the Decision Rule Engine.

No other module is permitted to evaluate acceptance.

This guarantees complete traceability and ISO 17025 compliance.

---

# Next Chapter

ARCH-021

Uncertainty & Risk Engine Architecture

---

# End of Chapter