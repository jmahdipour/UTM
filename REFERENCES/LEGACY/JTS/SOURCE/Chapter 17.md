# ARCHITECTURE
# Chapter 17
# Specimen Definition & Material Selection Architecture

Document ID

ARCH-017

Version

0.1

Status

FROZEN

Related EDR

EDR-022

Depends On

ARCH-001 Business Architecture

ARCH-002 Test Method

ARCH-003 Material Library

ARCH-008 Acceptance Engine

---

# Purpose

This chapter defines how a physical specimen is identified before testing.

This is one of the most important architectural chapters because it is the bridge between

Business

↓

Engineering

↓

Material Library

↓

Acceptance

Unlike the Test Method, which describes **how to perform the test**, the Specimen Definition describes **what is being tested**.

---

# Fundamental Principle

The workflow is intentionally divided into three independent parts.

```
1. Test Method
↓

How to perform the test

---------------------------

2. Specimen Definition

↓

What is being tested

---------------------------

3. Material Library

↓

Engineering knowledge

---------------------------

4. Acceptance

↓

Pass / Fail
```

These four objects shall never be merged.

---

# Specimen Definition Responsibilities

Specimen Definition SHALL identify

Geometry

Dimensions

Material Grade

Manufacturing Information

Sampling Information

Optional Notes

It SHALL NOT

Control Machine

Control Speed

Control Sampling

Control Analysis

Contain Acceptance Limits

---

# Workflow

```
Order

↓

Create Specimen

↓

Select Test Method

↓

Enter Geometry

↓

Enter Dimensions

↓

Select Material Grade

↓

(Optional)

Select Acceptance Profile

↓

Ready for Test
```

---

# Geometry

Supported Geometries

Round Bar

Flat Bar

Tube

Pipe

Wire

Plate

Spring

Compression Block

Custom Geometry

Future Geometries

Unlimited

---

# Dimensions

Dimensions are entered according to Geometry.

Examples

Round Bar

Diameter

Gauge Length

Flat Bar

Width

Thickness

Gauge Length

Tube

Outside Diameter

Inside Diameter

Wall Thickness

Spring

Wire Diameter

Coil Diameter

Free Length

Active Coils

Compression Block

Width

Height

Length

Custom

User-defined dimensions

---

# Automatic Calculations

Geometry automatically produces

Cross-sectional Area

Moment of Inertia (future)

Section Modulus (future)

Equivalent Diameter (future)

These calculations are purely geometric.

They are **not** Material Library functions.

---

# Material Selection

After geometry is complete

Operator selects

Material

↓

Grade

Examples

Steel

↓

S355

Rebar

↓

INSO 3132 A3

Aluminium

↓

6061-T6

Spring Steel

↓

DIN 2096

Polyethylene

↓

PE100

---

# Why Material Selection Happens Here

Material selection is performed during specimen definition because only now does the software know

what the specimen actually is.

The Test Method must remain reusable.

Example

ISO 6892-1

can test

Rebar

Structural Steel

Tool Steel

Copper

Aluminium

Therefore material cannot be stored inside the Test Method.

---

# Material Library Connection

Selecting a Material creates a logical link.

```
Specimen

↓

Material Grade

↓

Material Library
```

Material Library now provides

Reference Young Modulus

Yield Behaviour

Yield Search Window

Reference Curves

Engineering Notes

Acceptance Profiles

This information is advisory until explicitly used.

---

# Acceptance Profile Selection

Acceptance Profile is optional.

Possible workflow

Automatic

↓

Material

↓

Default Acceptance

or

Manual

↓

Operator chooses

Customer Specification

National Standard

Internal Specification

No Acceptance

---

# Acceptance Independence

Changing Acceptance Profile

shall NEVER change

Material

Geometry

Dimensions

Test Method

Machine Configuration

---

# Manufacturing Information

Optional fields

Heat Number

Batch Number

Lot Number

Casting Number

Rolling Direction

Manufacturing Date

Supplier

Production Line

Remarks

These belong to the specimen identity, not to the material definition.

---

# Specimen Identification

Each specimen has

Specimen ID

Barcode (future)

QR Code (future)

RFID (future)

Serial Number

Sample Number

Order Reference

---

# Relationship with Test Method

```
Test Method

↓

defines

HOW TO TEST

----------------

Specimen

↓

defines

WHAT IS TESTED
```

These responsibilities are completely separate.

---

# Relationship with Material Library

```
Specimen

↓

Material Grade

↓

Material Library

↓

Engineering Assistance
```

The Material Library never owns the specimen.

---

# Relationship with Acceptance

```
Specimen

↓

Acceptance Profile

↓

Acceptance Engine
```

Acceptance evaluates the specimen after testing.

---

# Future Compatibility

The architecture supports

Unlimited Geometry Types

Unlimited Dimension Sets

Unlimited Material Grades

Unlimited Acceptance Profiles

Barcode Integration

QR Integration

ERP Integration

LIMS Integration

without redesign.

---

# Design Constraints

Specimen Definition SHALL NOT

Control Machine Motion

Control Test Speed

Contain Material Mechanical Properties

Contain Test Results

Contain Acceptance Calculations

Perform Engineering Analysis

---

# Next Chapter

ARCH-018

Material Library Internal Structure

---

# End of Chapter