# ARCHITECTURE
# Chapter 18
# Material Library Internal Architecture

Document ID

ARCH-018

Version

0.1

Status

FROZEN

Related EDR

EDR-023

Depends On

ARCH-003 Material Library

ARCH-008 Acceptance Engine

ARCH-017 Specimen Definition

---

# Purpose

This chapter defines the internal architecture of the Material Library.

The Material Library is the engineering knowledge repository of the UTS software.

It is **not** a product database.

It is **not** a customer database.

It is **not** a standards database.

It stores reusable engineering knowledge.

---

# Design Philosophy

Material Library provides engineering assistance.

It never controls

Machine

Test Method

Acquisition

Analysis Flow

Operator Decisions

Its responsibility is to provide reference engineering information.

---

# Internal Structure

```
Material Library

│

├── Material Families

├── Material Grades

├── Mechanical References

├── Yield Behaviour

├── Young Modulus References

├── Reference Curves

├── Acceptance Profiles

├── Engineering Notes

└── Metadata
```

---

# Material Family

Highest level.

Examples

Steel

Aluminium

Copper

Titanium

Cast Iron

Polymer

Composite

Concrete

Wood

Spring Material

Future Materials

Unlimited

---

# Material Grade

Each family contains unlimited grades.

Examples

Steel

↓

S235

S275

S355

42CrMo4

AISI 4140

...

Rebar

↓

INSO 3132 A1

INSO 3132 A2

INSO 3132 A3

INSO 3132 A4

...

Spring Steel

↓

DIN 2095

DIN 2096

DIN 2097

...

---

# Mechanical References

Each grade may contain reference engineering values.

Examples

Typical Young Modulus

Typical Yield Range

Typical Tensile Strength

Typical Elongation

Typical Density

Typical Poisson Ratio

Typical Thermal Expansion

Future Properties

Unlimited

---

# Important Rule

Reference values are **not measured values**.

They are engineering references only.

Measured data always has priority.

---

# Yield Behaviour

Each material may define its expected yield behavior.

Supported types

Continuous Yield

Upper / Lower Yield

Offset Yield

No Yield

Brittle Fracture

Elastic Only

Spring Behaviour

Polymer Behaviour

Viscoelastic Behaviour

Custom Behaviour

This information assists the Event Detection Engine.

---

# Young Modulus Reference

Material Library may contain

Typical Elastic Modulus

Tolerance

Recommended Elastic Search Window

Recommended Linear Region

This information assists

Young Modulus Engine

It never replaces measured calculations.

---

# Reference Curves

Each material may provide

Engineering Stress-Strain Curve

True Stress-Strain Curve

Spring Load-Deflection Curve

Typical Plastic Region

Typical Elastic Region

Reference curves are used only for

Visualization

Comparison

Analysis Assistance

Never for result calculation.

---

# Acceptance Profiles

Each material may contain one or more Acceptance Profiles.

Example

Rebar

↓

INSO 3132

↓

Grade A3

↓

Acceptance Profile

Another example

Steel

↓

API 5L

↓

X52

↓

Acceptance Profile

One material may have multiple acceptance profiles.

---

# Engineering Notes

Optional information

Testing Notes

Preparation Notes

Grip Recommendations

Extensometer Recommendations

Special Warnings

Surface Preparation

Failure Characteristics

Applicable Standards

These notes assist the operator only.

---

# Metadata

Each material stores

Material ID

Revision

Version

Creation Date

Approval Date

Status

Author

Source

Reference Documents

---

# Material Status

Possible states

Draft

Approved

Deprecated

Archived

Experimental

Only Approved materials are selectable by default.

---

# Version Control

Every modification creates

New Revision

Previous revisions remain available for traceability.

---

# Search

Material Library supports searching by

Material Name

Grade

Standard

Keyword

Family

Engineering Property

Alias

Future Tags

---

# Relationship with Specimen

```
Specimen

↓

Material Grade

↓

Material Library
```

The specimen stores only the selected reference.

The Material Library remains independent.

---

# Relationship with Test Method

There is **no direct relationship**.

A Test Method can test many different materials.

Therefore the Material Library must never be embedded inside a Test Method.

---

# Relationship with Analysis

The Analysis Engine may request

Typical Young Modulus

Yield Behaviour

Reference Curve

Engineering Notes

The Analysis Engine remains responsible for all calculations.

---

# Relationship with Acceptance

The Acceptance Engine may request

Acceptance Profile

Decision Rules

Engineering References

The Material Library does not evaluate PASS/FAIL.

---

# Design Constraints

The Material Library SHALL NOT

Store Customer Data

Store Orders

Store Specimens

Store Test Results

Store Machine Parameters

Control Machine Behaviour

Perform Engineering Calculations

---

# Future Compatibility

The architecture supports

Unlimited Material Families

Unlimited Grades

Unlimited Acceptance Profiles

Unlimited Reference Curves

Unlimited Engineering Notes

Plugin Material Packages

Cloud Material Databases

AI-assisted Material Recommendations

without redesign.

---

# Next Chapter

ARCH-019

Acceptance Profile Internal Architecture

---

# End of Chapter