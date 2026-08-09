# ARCHITECTURE
# Chapter 02
# Test Method Architecture

Document ID

ARCH-002

Version

0.1

Status

FROZEN

Related EDR

EDR-003

EDR-004

---

# Purpose

This chapter defines the architecture of Test Methods.

A Test Method defines HOW a test shall be performed.

It never defines product acceptance.

It never contains material mechanical properties.

---

# Design Philosophy

Test Method is a reusable template.

One Test Method may be used by thousands of Orders.

One Test Method may be assigned to unlimited Specimens.

A Test Method never belongs to a specific customer.

---

# Definition

A Test Method is a complete description of machine behaviour during a test.

Examples

ISO 6892-1

ASTM E8

ASTM E111

ISO 7438

ISO 5173

ASTM D638

ISO 527

ASTM C39

ASTM A370

DIN 2095

DIN 2096

DIN 2097

...

---

# Test Method Responsibilities

A Test Method SHALL define

Machine Behaviour

Machine Configuration

Measurement Configuration

Sampling Configuration

Analysis Configuration

Graph Configuration

Report Configuration

Stop Conditions

Safety Conditions

Operator Workflow

---

# A Test Method SHALL NOT define

Material Properties

Steel Grade

Aluminium Grade

Acceptance Limits

Yield Strength

Ultimate Strength

Tolerance

Risk

Measurement Uncertainty

Customer Rules

Production Information

Order Information

---

# Internal Structure

```
Test Method

│

├── General

├── Measurement

├── Machine

├── Acquisition

├── Analysis

├── Graph

├── Report

├── Safety

└── Extensions
```

---

# General Section

Contains

Method Name

Description

Revision

Author

Creation Date

Version

Applicable Standards

Enabled

Locked

---

# Measurement Section

Defines

Primary Measurement Channels

Load

Stroke (Crosshead)

Extension

Time

Optional Channels

Temperature

Pressure

Torque

Vision

DAQ

Sampling Policy

Sampling Frequency

Sampling Trigger

---

# Machine Section

Defines

Test Type

Examples

Tension

Compression

Bending

Shear

Spring

Peel

Creep

Fatigue

Relaxation

Machine Limits

Travel Limits

Maximum Speed

Minimum Speed

Default Units

---

# Acquisition Section

Defines

Sampling Mode

Continuous

Fixed Interval

Adaptive

Trigger Based

Buffer Policy

Synchronization

Acquisition Timing

---

# Analysis Section

Defines

Enabled Analysis Modules

Examples

Young Modulus

Yield Detection

Maximum Load

Necking

Energy

True Stress

True Strain

The Test Method enables or disables modules.

It does NOT define material values.

---

# Graph Section

Defines

Displayed Curves

Displayed Channels

Axis Configuration

Grid

Zoom Behaviour

Live Display

Reference Curves

Graph Export

---

# Report Section

Defines

Report Template

Displayed Results

Displayed Graphs

Displayed Tables

Displayed Images

Company Logo

Digital Signature

Language

Units

---

# Safety Section

Defines

Maximum Load

Maximum Stroke

Maximum Extension

Emergency Stop Behaviour

Abort Conditions

Warning Conditions

Hardware Protection

---

# Extension Section

Reserved for

Future Standards

Plugins

Customer Extensions

Special Algorithms

Custom Scripts

---

# Relationship with Material Library

Material Library is NOT part of Test Method.

Relationship

```
Test Method

↓

Specimen

↓

Material Library

↓

Analysis Assistance
```

Material Library only assists

Yield Detection

Young Modulus

Graph Behaviour

Acceptance

---

# Relationship with Acceptance

Acceptance is NOT part of Test Method.

Relationship

```
Test Method

↓

Test Result

↓

Acceptance Engine

↓

Acceptance Profile
```

---

# Relationship with Order

Order

↓

Specimen

↓

Assigned Test Method

The Order never modifies Test Method.

---

# Reusability

One Test Method

↓

Unlimited Orders

↓

Unlimited Specimens

↓

Unlimited Tests

---

# Design Constraints

Test Method shall remain completely independent from

Customer

Order

Material Properties

Acceptance

Business Rules

Hardware Drivers

PLC Registers

---

# Future Compatibility

The architecture shall support

New Standards

New Test Types

New Sensors

New Analysis Modules

without redesign.

---

# End of Chapter