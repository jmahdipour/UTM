# ARCHITECTURE
# Chapter 19
# Acceptance Profile Internal Architecture

Document ID

ARCH-019

Version

0.1

Status

FROZEN

Related EDR

EDR-024

Depends On

ARCH-003 Material Library

ARCH-008 Acceptance Engine

ARCH-014 Mechanical Property Engine

ARCH-018 Material Library Internal Architecture

---

# Purpose

This chapter defines the complete internal structure of an Acceptance Profile.

Acceptance Profile is an engineering specification.

It is independent from

Test Method

Machine

Customer

Order

Specimen

Hardware

---

# Philosophy

Acceptance Profile answers only one question.

> "What requirements must this specimen satisfy?"

It never answers

How to test?

How to calculate?

How to move the machine?

---

# Acceptance Profile Position

```
Material Library

↓

Acceptance Profiles

↓

Acceptance Engine

↓

Decision
```

---

# Acceptance Profile Object

```
Acceptance Profile

│

├── General

├── Scope

├── Mechanical Requirements

├── Decision Rules

├── Measurement Uncertainty

├── Risk Policy

├── Override Policy

├── Reporting Rules

└── Metadata
```

---

# General

Contains

Profile Name

Reference Standard

Revision

Version

Status

Description

Language

Approval Date

Author

---

Example

INSO 3132

Grade A3

Revision 2024

---

# Scope

Defines

Applicable Material

Applicable Grade

Applicable Product

Applicable Test

Examples

Steel

↓

Rebar

↓

Grade A3

or

Steel

↓

API X52

or

Spring

↓

DIN 2096

---

# Mechanical Requirements

Contains

Required Mechanical Properties

Examples

Yield Strength

Ultimate Strength

Yield Ratio

Elongation

Reduction of Area

Young Modulus (optional)

Energy (optional)

Spring Constant

Future Properties

Unlimited

---

# Requirement Object

Every property consists of

Property Name

Required

Enabled

Comparison Method

Minimum Value

Maximum Value

Target Value

Engineering Unit

Priority

Remarks

---

Example

Yield Strength

Enabled

Minimum

400 MPa

Maximum

—

Required

Yes

---

# Comparison Methods

Supported

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

# Decision Rules

Acceptance Profile never performs calculations.

It defines how results shall be interpreted.

Supported

Strict

Guard Band

ISO 17025

Shared Risk

Producer Risk

Consumer Risk

Custom Rule

---

# Measurement Uncertainty

Optional

Enable

Disable

Independent for every profile

Parameters

Coverage Factor

Confidence Level

Expanded Uncertainty

Reference Document

Decision Rule

---

# Risk Policy

Optional

Disabled

Producer Risk

Consumer Risk

Balanced Risk

Custom

Risk affects only decision logic.

Never measured values.

---

# Override Policy

Defines

Manual Override Allowed

Yes / No

Approval Required

Reason Required

Electronic Signature

Supervisor Approval

Audit Trail

---

# Reporting Rules

Defines

Show Decision Rule

Show Uncertainty

Show Risk

Show Warnings

Show Engineering Notes

Show Failed Properties

Show Disabled Properties

---

# Property Groups

Properties may be grouped.

Example

Strength

Yield

Ultimate

Yield Ratio

----------------

Ductility

Elongation

Reduction of Area

----------------

Elastic

Young Modulus

Proof Stress

----------------

Spring

K

Spring Rate

---

# Optional Properties

Not every profile uses every property.

Example

Spring Standard

does not require

Reduction of Area

Example

Concrete Standard

does not require

Yield Strength

The architecture supports independent enable/disable.

---

# Disabled Property

Disabled means

Ignored

Not evaluated

Not reported (optional)

No FAIL shall be generated.

---

# Property Priority

Critical

Major

Minor

Informational

Future AI

Priority may affect report presentation.

Priority shall NOT modify engineering calculations.

---

# Acceptance Result

Each property produces

PASS

FAIL

NOT EVALUATED

DISABLED

MANUAL

Final profile combines these results.

---

# Final Decision

Possible outputs

PASS

FAIL

PASS WITH WARNING

REVIEW REQUIRED

NOT EVALUATED

---

# Relationship with Material Library

Material Library owns

Acceptance Profiles

Material

↓

Acceptance Profiles

One material

↓

many Acceptance Profiles

---

# Relationship with Specimen

Specimen references one Acceptance Profile.

Changing profile never changes specimen identity.

---

# Relationship with Test Method

There is no direct dependency.

One Test Method

↓

many Materials

↓

many Acceptance Profiles

---

# Version Control

Every Acceptance Profile contains

Version

Revision

Approval

Release Date

History

Old revisions remain available.

---

# Design Constraints

Acceptance Profile SHALL NOT

Store Measurements

Store Test Results

Store Orders

Store Customers

Store Machine Parameters

Calculate Mechanical Properties

Communicate with Hardware

---

# Future Compatibility

Supports

Unlimited Mechanical Properties

Unlimited Decision Rules

Unlimited Standards

Unlimited Revisions

Plugin Rules

Cloud Standards

AI Decision Support

without redesign.

---

# Architectural Decision (FROZEN)

Acceptance Profile is an independent engineering object.

It shall never be embedded inside

Test Method

Material

Specimen

Order

Instead, all objects communicate through references.

This decision is permanent.

---

# Next Chapter

ARCH-020

Decision Rule Engine Architecture

---

# End of Chapter