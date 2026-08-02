---
project: Universal Testing Machine (UTS)
document: AI_HANDOVER_SPECIFICATION
version: 0.2
status: FROZEN
classification: MASTER
priority: HIGHEST
last_revision: 2026-08-02
author: Project Owner + OpenAI
---

# AI HANDOVER SPECIFICATION

> This document is the primary reference for every future engineer and AI working on the UTS project.

---

# 1. PROJECT MISSION

Design and implement a professional Universal Testing Machine software comparable to world-class commercial products while remaining independent from any vendor implementation.

The software must support future expansion without redesigning the architecture.

---

# 2. PRIMARY GOALS

The software shall be

- Modular
- Event Driven
- Rule Based
- Hardware Independent
- Extendable
- Standard Independent
- Maintainable
- Industrial Grade

---

# 3. TARGET PLATFORM

Language

VB.NET

Framework

.NET Framework 4.8

Architecture

WPF

MVVM

Database

SQLite

Target

x86

No C#

No .NET Core

---

# 4. GOLDEN RULES

These rules SHALL NOT change without issuing a new documentation revision.

---

## GR-001

Order is the highest business object.

Hierarchy

Order

↓

Customer

↓

Specimens

↓

Tests

Customer never owns Orders.

---

## GR-002

Specimen lifecycle

Draft

↓

Completed

Draft means specimen has never been tested.

---

## GR-003

Two completely different standards exist.

### Test Method Standard

Examples

ISO 6892-1

ASTM E8

ASTM E111

ISO 7438

Purpose

Defines HOW the machine performs a test.

---

### Acceptance Standard

Examples

INSO 3132

API

ASTM Material Grades

EN

Customer Specification

Purpose

Defines PASS / FAIL criteria.

---

## GR-004

Test Method NEVER contains

Material Properties

Acceptance

Mechanical Limits

Tolerance

Customer Rules

---

## GR-005

Material Library

Material Library assists

Yield Detection

Young Modulus

Graph Optimization

Acceptance

Mechanical Hints

Material Library never controls machine movement.

---

## GR-006

Acceptance belongs to Material Library.

Acceptance may include

Limits

Decision Rule

Uncertainty

Risk

Tolerance

Each item can be enabled or disabled.

---

## GR-007

Core Measurement Channels

Always available

Load

Stroke (Crosshead)

Extension

Time

---

## GR-008

Optional Measurement Channels

Temperature

Pressure

Torque

LVDT

Vision

DAQ

Virtual

Future Sensors

Unlimited expansion.

---

## GR-009

Sensor != Measurement

Example

Load Cell

↓

Load

Extensometer

↓

Extension

Encoder

↓

Stroke

---

## GR-010

Measurement != Calculated Measurement

Measured

Load

Stroke

Extension

Time

Calculated

Stress

Strain

True Stress

True Strain

Young Modulus

Rp0.2

Rm

Energy

Reduction of Area

etc.

---

## GR-011

Interactive Measurement Widget

Separate Zero buttons are prohibited.

Clicking Measurement Widget opens

Zero

Diagnostics

Information

Calibration (if permitted)

Future tools

---

## GR-012

Analysis Architecture

Measurement

↓

Validation

↓

Signal Processing

↓

Engineering Calculation

↓

Event Detection

↓

Mechanical Property

↓

Acceptance

↓

Reporting

---

## GR-013

Measurement streams and domain events are separate, connected flows.

Continuous calculations consume validated or derived measurement streams according to their declared contracts.

Semantic landmarks and state changes are represented as versioned domain events with sample provenance.

No mechanical-property, acceptance, reporting or UI module may calculate directly from raw measurements.

The complete governing decision is EDR-0001.

---

## GR-014

Hardware Independence

Hardware

↓

Acquisition

↓

Measurement

↓

Analysis

↓

Reporting

Analysis NEVER communicates directly with PLC.

---

# 5. DOMAIN MODEL

Main Business Objects

Order

Customer

Specimen

Test

Test Method

Material Library

Acceptance Profile

Report

Measurement Channel

Event

---

# 6. CORE MEASUREMENT CHANNELS

Load

Stroke (Crosshead)

Extension

Time

These four channels always exist.

---

# 7. ANALYSIS PHILOSOPHY

Analysis is

Event Driven

Pipeline Based

Rule Based

Independent from Hardware

Independent from Standards

---

# 8. DOCUMENTATION POLICY

Every architectural decision becomes

EDR

Every EDR follows the governed status lifecycle.

Every Frozen decision updates

FROZEN_DECISIONS

Architecture

AI Handover

Changelog

DOCUMENTATION_GOVERNANCE defines source authority, branch authority and synchronization rules.

---

# 9. INDUSTRIAL REFERENCES

Primary

Shimadzu TrapeziumX

Zwick testXpert III

Instron Bluehill Universal

MTS TestSuite

Secondary

ADMET

Tinius Olsen

---

# 10. CURRENT PROJECT STATUS

Completed

Business Architecture

Database Philosophy

Test Method

Material Library

Acceptance

Measurement Architecture

Interactive Measurement Widgets

Analysis Pipeline

Event Driven Architecture

Measurement Stream / Domain Event Separation

Executable Versioned Test Method Model

Documentation Repository

Pending

Machine and Test State Machines

Safety and Interlock Architecture

Measurement/Sensor/Calibration Contracts

Event Dictionary

State Machine

Database Physical Model

UI Architecture

PLC Layer

Reporting

API

Hardware Drivers

---

# 11. FUTURE WORKFLOW

Every future feature shall follow

Benchmark

↓

Analysis

↓

Proposal

↓

Approval

↓

EDR

↓

Implementation

↓

Documentation Update

---

# 12. AI INSTRUCTIONS

Before continuing development

Read

README.md

DOCUMENTATION_GOVERNANCE.md

FROZEN_DECISIONS.md

AI_HANDOVER_SPECIFICATION.md

All EDR documents

Architecture documents

Never violate Frozen Decisions.

If a contradiction exists

Newest EDR wins.

Never redesign architecture without creating a new Revision.

---

# END OF DOCUMENT
