# ARCHITECTURE
# Chapter 16
# Test Method Template Architecture

Document ID

ARCH-016

Version

0.1

Status

FROZEN

Related EDR

EDR-021

Depends On

ARCH-002 Test Method Architecture

ARCH-003 Material Library Architecture

ARCH-008 Acceptance Architecture

---

# Purpose

This chapter defines the architecture of Test Method Templates.

A Test Method Template is a reusable engineering recipe describing how a specific class of tests shall be performed.

It is **not** a customer specification.

It is **not** a material specification.

It is **not** an acceptance standard.

---

# Philosophy

The software supports two independent ways of creating a Test Method.

```
Method Template
        ↓
Create Test Method

or

Manual Configuration
        ↓
Create Test Method
```

Both produce exactly the same Test Method object.

The software does not distinguish between them after creation.

---

# Definition

A Method Template is a predefined engineering configuration.

Its purpose is to reduce operator work.

Its purpose is NOT to lock engineering freedom.

---

# Method Template Sources

Templates may originate from

International Standards

Company Standards

Internal Procedures

Customer Procedures

Laboratory Procedures

Future Custom Templates

---

# Standard Templates

Examples

ISO 6892-1

ASTM E8

ASTM E111

ISO 527

ASTM D638

ISO 7438

ISO 5173

DIN 51220

DIN 2095

DIN 2096

DIN 2097

ASTM C39

ASTM D695

ASTM D790

Future Standards

Unlimited

---

# Important Principle

One Test Method Standard

may support

thousands of materials.

Example

```
ISO 6892-1

↓

Structural Steel

↓

Tool Steel

↓

Rebar

↓

Stainless Steel

↓

Spring Steel

↓

Copper

↓

Aluminium
```

The Test Method remains identical.

Only the Material changes.

---

# Therefore

Material SHALL NOT exist inside Method Template.

Acceptance SHALL NOT exist inside Method Template.

Customer SHALL NOT exist inside Method Template.

---

# Method Template Contents

General

Machine Behaviour

Measurement Configuration

Sampling Configuration

Analysis Configuration

Graph Configuration

Reporting Configuration

Safety Configuration

---

# General

Contains

Template Name

Standard

Revision

Description

Version

Language

Author

Release Date

---

# Machine Behaviour

Contains

Test Type

Control Mode

Default Speed

Machine Limits

Axis Configuration

Travel Limits

Safety Parameters

---

# Measurement Configuration

Contains

Required Channels

Optional Channels

Sampling Mode

Sampling Rate

Measurement Units

---

# Analysis Configuration

Contains

Enabled Modules

Young Modulus

Yield Detection

Maximum Load

Energy

Fracture

Necking

Spring Analysis

Future Modules

---

# Graph Configuration

Contains

Displayed Curves

Default Axes

Reference Curves

Guide Lines

Zoom Behaviour

Marker Visibility

---

# Report Configuration

Contains

Report Template

Displayed Properties

Displayed Tables

Displayed Graphs

Language

Export Formats

---

# Safety Configuration

Contains

Maximum Load

Maximum Stroke

Maximum Extension

Abort Behaviour

Emergency Behaviour

Warnings

---

# Template Creation

A new Test Method may be created

```
Select Template

↓

Modify Parameters

↓

Save As New Test Method
```

The original template never changes.

---

# Manual Creation

Operator may ignore templates.

```
Blank Method

↓

Configure Everything

↓

Save

↓

New Test Method
```

Manual configuration is fully supported.

---

# Relationship with Material Library

Method Template

↓

Specimen

↓

Material Selection

↓

Material Library

↓

Analysis Assistance

The Material Library is linked during specimen definition.

NOT during Method creation.

---

# Relationship with Acceptance

Acceptance is attached later.

Workflow

```
Method

↓

Specimen

↓

Material

↓

Acceptance Profile

↓

Test

↓

Evaluation
```

Acceptance is never embedded inside the template.

---

# Relationship with Specimen

When defining a specimen, the operator specifies

Geometry

Dimensions

Material Grade

Optional Acceptance Profile

This information is not stored inside the Method Template.

---

# Versioning

Every template contains

Version

Revision

Approval Date

Author

Previous Revision

Templates are immutable after release.

A modification creates a new version.

---

# Future Compatibility

The architecture supports

Unlimited Templates

Unlimited Standards

Company Templates

Customer Templates

Laboratory Templates

Plugin Templates

AI-generated Templates

without redesign.

---

# Design Constraints

Method Templates SHALL NOT

Contain Material Properties

Contain Acceptance Limits

Contain Customer Information

Contain Order Information

Contain Measured Data

Contain Mechanical Results

Communicate with Hardware

---

# Next Chapter

ARCH-017

Material Selection & Specimen Definition Architecture

---

# End of Chapter