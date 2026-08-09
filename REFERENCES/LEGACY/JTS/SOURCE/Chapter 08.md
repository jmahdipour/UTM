# ARCHITECTURE
# Chapter 08
# Acceptance Engine Architecture

Document ID

ARCH-008

Version

0.1

Status

FROZEN

Related EDR

EDR-006

Depends On

ARCH-003 Material Library

ARCH-005 Analysis Architecture

ARCH-007 State Machine

---

# Purpose

The Acceptance Engine determines whether a tested specimen satisfies the required specification.

Acceptance is completely separated from

- Test Method
- Machine Control
- Measurement
- Analysis

Acceptance is a business decision based on engineering results.

---

# Design Philosophy

Acceptance SHALL NOT calculate engineering values.

Acceptance SHALL evaluate engineering values.

```
Measurements

↓

Analysis

↓

Mechanical Properties

↓

Acceptance Engine

↓

Decision
```

---

# Acceptance Sources

Acceptance Engine may use

Material Library

Customer Specification

National Standards

International Standards

Company Standards

Project Requirements

Future Plugins

---

# Acceptance Profile

An Acceptance Profile is a reusable evaluation template.

Examples

INSO 3132 Grade A3

API 5L X52

ASTM A370

EN 10025

Customer Specification

Internal Quality Rule

---

# Acceptance Profile Contents

General Information

Reference Standard

Revision

Description

Enabled

Approval Date

---

Mechanical Requirements

Yield Strength

Ultimate Strength

Yield Ratio

Elongation

Reduction of Area

Young Modulus (optional)

Energy (optional)

Hardness (future)

Impact Energy (future)

---

# Decision Rule

Acceptance uses configurable decision rules.

Examples

Strict

Measured Value ≥ Limit

ISO 17025 Decision Rule

Guard Band

Shared Risk

Customer Defined

Future Rule Engine

---

# Measurement Uncertainty

Measurement uncertainty is optional.

It can be

Enabled

Disabled

Independent for each Acceptance Profile.

When enabled

Acceptance shall evaluate

Measured Value

+

Expanded Uncertainty

+

Decision Rule

---

# Risk Evaluation

Risk evaluation is optional.

Supported modes

Disabled

Consumer Risk

Producer Risk

Balanced Risk

Custom Risk

Risk shall never modify measurements.

Risk only modifies final decision logic.

---

# Acceptance Workflow

```
Mechanical Properties

↓

Acceptance Profile

↓

Decision Rule

↓

Measurement Uncertainty

↓

Risk Evaluation

↓

Final Decision
```

---

# Acceptance Results

Supported results

PASS

FAIL

PASS WITH WARNING

NOT EVALUATED

MANUAL REVIEW REQUIRED

---

# Partial Evaluation

Acceptance Engine supports incomplete evaluation.

Example

Yield available

Ultimate Strength available

Elongation unavailable

Decision

Partial Evaluation

instead of immediate FAIL.

---

# Evaluation Scope

Acceptance may be applied to

Single Specimen

Entire Order

Statistical Batch

Customer Batch

Production Batch

Future Manufacturing Lots

---

# Material Library Relationship

Material Library provides

Reference Properties

Acceptance Profiles

Engineering Notes

Default Decision Rules

Acceptance Engine performs the evaluation.

Material Library never performs PASS / FAIL decisions.

---

# Test Method Relationship

Test Method is independent.

Test Method defines

HOW TO TEST

Acceptance defines

IS THE RESULT ACCEPTABLE

These two modules must remain completely separated.

---

# Reporting Relationship

Acceptance Engine produces

Acceptance Status

Decision Rule Used

Reference Standard

Tolerance Information

Risk Information

Measurement Uncertainty

These become part of the final report.

---

# Database Requirements

Each evaluation shall store

Acceptance Profile ID

Decision Rule

Material Revision

Acceptance Result

Operator Override (if allowed)

Evaluation Timestamp

Software Version

---

# Manual Override

Optional.

If enabled

Operator may override

PASS

FAIL

Only with

Reason

User

Timestamp

Audit Trail

---

# Future Compatibility

The architecture shall support

Unlimited Acceptance Profiles

Unlimited Standards

Unlimited Decision Rules

Unlimited Risk Models

Unlimited Evaluation Parameters

without redesign.

---

# Design Constraints

Acceptance Engine SHALL NOT

Communicate with Hardware

Modify Measurements

Modify Mechanical Properties

Modify Test Method

Modify Material Library

Generate Reports

---

# Next Chapter

ARCH-009

Reporting Architecture

---

# End of Chapter