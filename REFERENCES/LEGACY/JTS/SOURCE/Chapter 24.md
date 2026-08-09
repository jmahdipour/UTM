# ARCHITECTURE
# Chapter 24
# Logical Database Schema (Entity Model)

Document ID

ARCH-024

Version

0.1

Status

FROZEN

Related EDR

EDR-029

Depends On

ARCH-023 Database Architecture

---

# Purpose

This chapter defines the logical Entity Model of the Universal Testing Machine (UTS).

This document is the master blueprint for the SQLite database.

It defines

Entities

Relationships

Ownership

References

Cardinality

Lifecycle

This chapter does NOT define SQL tables yet.

It defines the logical model.

---

# Philosophy

The database follows Domain Driven Design.

Every Entity represents one business object.

No table exists merely because the UI requires it.

---

# Entity Categories

```
Business

Engineering

Machine

Security

Reporting

Configuration

History
```

---

# Business Domain

```
Customer

↓

Project

↓

Order

↓

Specimen
```

---

## Customer

Purpose

Stores customer identity.

Owns

Projects

Orders

---

## Project

Optional grouping.

Example

Bridge

Building

Pipeline

Research

---

## Order

Represents one testing request.

Owns

Specimens

Reports

---

## Specimen

Represents one physical sample.

Owns

Geometry

Dimensions

Material Reference

Acceptance Reference

Test Sessions

---

# Engineering Domain

```
Method Template

↓

Test Method

↓

Test Session

↓

Measurements

↓

Mechanical Properties

↓

Acceptance

↓

Report
```

---

## Method Template

Reusable engineering template.

One template

↓

Many Test Methods

---

## Test Method

Machine-independent procedure.

One Test Method

↓

Many Tests

---

## Test Session

One execution of one specimen.

Owns

Measurements

Events

Results

Graphs

---

## Measurement

Stores synchronized engineering channels.

Owns

Frames

Channels

Time Series

---

## Event

Stores engineering events.

Yield

Maximum Load

Fracture

Operator Events

Machine Events

---

## Mechanical Property

Stores calculated engineering properties.

Independent from Acceptance.

---

## Acceptance Result

Stores PASS / FAIL evaluation.

References

Acceptance Profile

Mechanical Properties

Decision Rule

---

# Material Domain

```
Material Family

↓

Material Grade

↓

Acceptance Profiles

↓

Reference Curves

↓

Engineering Notes
```

---

## Material Family

Steel

Aluminium

Copper

Spring

Concrete

...

---

## Material Grade

Individual engineering material.

---

## Acceptance Profile

Independent entity.

Referenced by

Specimen

NOT

Test Method

---

## Reference Curve

Optional

Graphical assistance.

---

## Engineering Note

Optional

Operator guidance.

---

# Reporting Domain

```
Report

↓

Report Template

↓

Attachments

↓

Digital Signature
```

---

## Report

One report

↓

One Test Session

---

## Report Template

Reusable layout.

---

## Attachment

Photos

Certificates

External Files

---

## Signature

Approval

Reviewer

Digital Signature

---

# Machine Domain

```
Machine

↓

Channels

↓

Calibration

↓

Communication
```

---

## Machine

Stores machine identity.

---

## Channel

Engineering channel definition.

Load

Stroke

Extension

Time

Future Sensors

---

## Calibration

Stores calibration history.

Independent entity.

---

## Communication

Stores hardware communication configuration.

---

# Security Domain

```
User

↓

Role

↓

Permission

↓

Audit
```

---

## User

Operator

Supervisor

Administrator

Engineer

---

## Role

Permission group.

---

## Permission

Individual permission.

---

## Audit

Every important operation.

Immutable.

---

# Configuration Domain

Contains

Software Settings

Machine Settings

DAQ Settings

Graph Settings

Units

Themes

Languages

Communication

---

# History Domain

Contains

Archived Reports

Old Methods

Old Acceptance Profiles

Old Materials

Old Configurations

Historical Revisions

---

# Core Relationships

```
Customer

1

↓

∞

Order

1

↓

∞

Specimen

1

↓

∞

Test Session

1

↓

∞

Measurements

1

↓

∞

Mechanical Properties

1

↓

1

Acceptance Result

1

↓

1

Report
```

---

# Material Relationships

```
Material Family

1

↓

∞

Material Grade

1

↓

∞

Acceptance Profiles

1

↓

∞

Reference Curves
```

---

# Method Relationships

```
Method Template

1

↓

∞

Test Method

1

↓

∞

Test Session
```

---

# Security Relationships

```
User

↓

Audit

↓

Every Important Action
```

---

# Ownership Rule

Each entity owns only its own data.

Example

Specimen owns

Dimensions

Material Reference

Acceptance Reference

Specimen does NOT own

Material Library

Acceptance Profile

Test Method

---

# Reference Rule

Entities communicate by

UUID

NOT

Duplicated Data

Example

Specimen

stores

MaterialID

NOT

Young Modulus

Yield Strength

Acceptance Limits

---

# Cardinality Rules

Customer

→

Many Orders

Order

→

Many Specimens

Specimen

→

Many Test Sessions

Material Grade

→

Many Specimens

Acceptance Profile

→

Many Specimens

Test Method

→

Many Tests

---

# Revision Policy

Version-controlled entities

Method

Material

Acceptance Profile

Report Template

Machine Configuration

Calibration

Older revisions remain available.

---

# Design Constraints

No entity shall

Contain UI objects

Contain PLC addresses

Contain hardware drivers

Contain engineering algorithms

Contain report rendering logic

---

# Architectural Decision (FROZEN)

The database is fully normalized at the logical level.

Every business object has exactly one owner.

Relationships are reference-based.

No engineering information shall be duplicated across entities.

This decision is permanent and forms the foundation for the physical SQLite schema.

---

# Next Chapter

ARCH-025

SQLite Physical Schema

(Table Definitions, Primary Keys, Foreign Keys, Indexes)

This chapter will translate the logical entity model into the actual SQLite database used by the VB.NET application.

---

# End of Chapter