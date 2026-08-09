# ARCHITECTURE
# Chapter 03
# Material Library Architecture

Document ID

ARCH-003

Version

0.1

Status

FROZEN

Related EDR

EDR-005

EDR-006

---

# Purpose

This chapter defines the Material Library architecture.

Material Library is an engineering knowledge base.

It is NOT a database of customer products.

It is NOT a Test Method.

It is NOT an Acceptance Standard.

It assists analysis and acceptance.

---

# Design Philosophy

Material Library provides engineering reference information.

It never controls machine movement.

It never changes the Test Method.

It only assists the Analysis Engine and Acceptance Engine.

---

# Separation Principle

Three completely independent concepts exist.

```
Test Method

↓

defines

HOW the machine performs the test

------------------------------

Material Library

↓

contains

Engineering Knowledge

------------------------------

Acceptance

↓

decides

PASS / FAIL
```

These three modules shall never be merged.

---

# Material Library Responsibilities

Material Library provides

Engineering Reference Data

Mechanical Behaviour Information

Analysis Assistance

Acceptance Profiles

Reference Properties

Search Windows

Default Engineering Parameters

---

# Material Library SHALL NOT contain

Order Information

Customer Information

Machine Settings

PLC Parameters

DAQ Configuration

Sampling Configuration

Graph Configuration

Operator Information

---

# Material Identity

Material Library contains generic engineering materials.

Examples

Steel

Aluminium

Copper

Cast Iron

Titanium

Brass

Spring Steel

Polyethylene

Polypropylene

PVC

Rubber

Composite

Concrete

Wood

Future Materials

---

# Material Grade

Each material may contain unlimited grades.

Example

Steel

↓

S235

S275

S355

...

Example

Rebar

↓

INSO 3132

A1

A2

A3

A4

...

Example

Spring Steel

↓

DIN 2095

DIN 2096

DIN 2097

---

# Material Properties

Typical reference information may include

Elastic Modulus

Poisson Ratio

Density

Typical Yield Behaviour

Typical Necking Behaviour

Typical Failure Behaviour

Typical Stress-Strain Curve

Typical Engineering Notes

Reference Values

Reference Standards

---

# Analysis Assistance

Material Library assists

Young Modulus estimation

Yield Detection

Yield Search Window

Elastic Region estimation

Graph stabilization

Noise reduction parameters

Curve interpretation

Analysis optimization

Material Library never forces calculated values.

---

# Yield Behaviour

Material Library may classify materials.

Examples

Continuous Yield

Upper / Lower Yield

Offset Yield

No Yield

Brittle Behaviour

Ductile Behaviour

Spring Behaviour

Polymer Behaviour

This information assists Event Detection.

---

# Acceptance

Acceptance belongs to Material Library.

Acceptance Profile may include

Reference Standard

Minimum Values

Maximum Values

Decision Rules

Tolerance

Measurement Uncertainty

Risk

Enable / Disable

Acceptance remains independent from Test Method.

---

# Material Selection

Material selection occurs during specimen definition.

Example

```
Order

↓

Specimen

↓

Geometry

↓

Material Grade

↓

Material Library
```

Material selection never modifies Test Method.

---

# Relationship with Test Method

```
Test Method

↓

Specimen

↓

Material Library

↓

Analysis Assistance
```

Test Method determines

HOW

Material Library determines

HOW TO INTERPRET

---

# Relationship with Analysis Engine

Material Library provides reference information to

Yield Detection Engine

Young Modulus Engine

Graph Optimization

Acceptance Engine

Material Library never performs calculations.

---

# Relationship with Acceptance Engine

Acceptance Engine consumes

Measured Results

+

Calculated Results

+

Acceptance Profile

+

Decision Rules

Acceptance Engine produces

PASS

FAIL

WARNING

---

# Design Constraints

Material Library shall remain independent from

Hardware

PLC

DAQ

Machine Configuration

Sampling

Business Objects

Customer

Order

---

# Future Compatibility

The architecture shall support

Unlimited Materials

Unlimited Grades

Unlimited Standards

Unlimited Acceptance Profiles

Unlimited Reference Properties

without redesign.

---

# End of Chapter