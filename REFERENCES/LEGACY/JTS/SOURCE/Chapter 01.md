# ARCHITECTURE
# Chapter 01
# Business Architecture

Document ID

ARCH-001

Version

0.1

Status

FROZEN

Related EDR

EDR-001

EDR-002

---

# Purpose

This chapter defines the complete business architecture of the Universal Testing Machine (UTS).

This architecture is independent from

- Hardware
- PLC
- Database
- User Interface

It represents only business logic.

---

# Business Philosophy

The software is NOT test-centric.

The software is ORDER-centric.

Everything starts from an Order.

---

# Business Hierarchy

```
Order
    │
    ├── Customer Information
    │
    ├── Project Information
    │
    ├── Acceptance Profile
    │
    ├── Specimens
    │       │
    │       └── Test Records
    │
    └── Reports
```

---

# Business Objects

## Order

Highest business object.

Owns

- Customer
- Project
- Specimens
- Reports

Order Number must be unique.

Order cannot exist without Order Number.

---

## Customer

Customer belongs to Order.

Customer is NOT an independent entity.

Customer information may repeat across multiple Orders.

Customer never owns Specimens.

---

## Project

Project belongs to Order.

Examples

Project Name

Contract Number

Batch Number

Production Line

Purchase Order

Heat Number

Remarks

Project data is completely independent from Test Method.

---

## Specimen

Specimen belongs to one Order.

Each specimen represents one physical sample.

Each specimen has its own identity.

Examples

Specimen ID

Sample Number

Diameter

Thickness

Width

Gauge Length

Cross Section

Material Grade

Shape

Direction

Remarks

---

# Specimen Status

Only two business states currently exist.

Draft

Completed

---

## Draft

Draft means

Physical specimen exists

Test has not yet been completed.

Draft specimens may be modified.

---

## Completed

Completed means

Testing finished successfully.

Business information becomes read-only.

Only reporting is allowed.

---

# Test Record

Each specimen may contain one or more Test Records.

A Test Record stores

Raw Measurements

Calculated Results

Events

Mechanical Properties

Acceptance Result

Operator

Date

Time

Equipment

---

# Business Rules

Rule 1

Order must exist before creating Specimens.

---

Rule 2

Specimens cannot exist without Order.

---

Rule 3

Customer cannot own Specimens.

---

Rule 4

Deleting an Order deletes all Draft Specimens.

Completed Specimens follow archive policy.

---

Rule 5

One Order may contain unlimited Specimens.

---

Rule 6

Every Specimen has exactly one current Status.

---

Rule 7

Business objects never communicate directly with Hardware.

---

# Acceptance Relationship

Order

↓

Acceptance Profile

↓

Specimens

↓

Test Results

↓

Pass / Fail

Acceptance belongs to the business process.

It is NOT part of Test Method.

---

# Material Relationship

Material information belongs to Specimen Identity.

Examples

Material Grade

Steel Grade

Aluminium Grade

Polymer Grade

Cast Iron Grade

Spring Material

Material Library uses this information only for

Analysis Assistance

Acceptance Evaluation

Young Modulus Reference

Yield Detection Assistance

Material Library never controls machine behaviour.

---

# Test Method Relationship

Order

↓

Specimen

↓

Assigned Test Method

Test Method describes

ONLY

How testing is performed.

It never stores

Material Properties

Acceptance

Customer Rules

---

# Report Relationship

Order

↓

Report

A report may contain

One specimen

Multiple specimens

Entire Order

Statistical Summary

Customer Summary

Report generation never modifies business objects.

---

# Design Constraints

Business Layer shall never access

PLC

DAQ

Sensors

Motors

Load Cells

Communication Drivers

Analysis Algorithms

---

# Future Compatibility

Business Architecture must support

Compression

Tension

Bending

Shear

Spring Testing

Fatigue

Creep

Relaxation

Future Standards

without redesign.

---

# End of Chapter