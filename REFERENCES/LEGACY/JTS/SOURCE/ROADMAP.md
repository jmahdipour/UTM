# ROADMAP

Project

Universal Testing Machine (UTS)

Current Version

Documentation v0.1

Status

Architecture Phase

---

# Project Lifecycle

```
Architecture
        ↓
Domain Design
        ↓
Database Design
        ↓
Core Engine
        ↓
User Interface
        ↓
PLC Integration
        ↓
Testing
        ↓
Release
```

---

# PHASE 01

Project Foundation

Status

Completed

Tasks

- Project Philosophy
- Documentation Rules
- Technology Selection
- Coding Standards
- Repository Structure

---

# PHASE 02

Business Architecture

Status

Completed

Tasks

- Order
- Customer
- Specimen
- Test
- Draft Workflow
- Completed Workflow

---

# PHASE 03

Test Method Architecture

Status

Completed

Tasks

- Test Method
- Standard Separation
- Test Templates
- Machine Behaviour

---

# PHASE 04

Material Library

Status

Completed

Tasks

- Material Properties
- Yield Assistance
- Young Modulus Reference
- Graph Assistance
- Acceptance Support

---

# PHASE 05

Acceptance Engine

Status

Completed

Tasks

- Decision Rules
- Tolerance
- Uncertainty
- Risk
- Enable / Disable

---

# PHASE 06

Measurement Architecture

Status

Completed

Core Channels

- Load
- Stroke (Crosshead)
- Extension
- Time

Optional Channels

- Temperature
- Pressure
- Torque
- Vision
- LVDT
- DAQ
- Virtual

---

# PHASE 07

Analysis Architecture

Status

Completed

Modules

Validation Engine

Signal Processing Engine

Engineering Calculation Engine

Event Detection Engine

Mechanical Property Engine

Acceptance Engine

Reporting Engine

---

# PHASE 08

Documentation

Status

In Progress

Tasks

- README
- AI Handover
- Changelog
- Roadmap
- Architecture Chapters
- EDR Documents

---

# PHASE 09

Event Dictionary

Status

Planned

Tasks

Define every Event

Event ID

Description

Inputs

Outputs

Trigger Condition

Consumers

Priority

Dependencies

---

# PHASE 10

State Machine

Status

Planned

Tasks

Idle

Ready

Specimen Mounted

Preload

Running

Hold

Finished

Abort

Emergency Stop

Fault

Transitions

Permissions

---

# PHASE 11

Database Physical Design

Status

Planned

Tasks

SQLite Schema

Indexes

Constraints

Views

History Tables

Migration Strategy

---

# PHASE 12

UI Architecture

Status

Planned

Tasks

Ribbon

Workspace

Docking

Measurement Widgets

Graph

Navigator

Status Bar

Dialogs

---

# PHASE 13

PLC Layer

Status

Planned

Tasks

Communication

Driver

Acquisition

Synchronization

Diagnostics

Hardware Mapping

---

# PHASE 14

Analysis Algorithms

Status

Planned

Tasks

Elastic Region

Yield Detection

Rp Methods

Young Modulus

Maximum Load

Fracture

Necking

Energy

True Stress

True Strain

---

# PHASE 15

Acceptance Algorithms

Status

Planned

Tasks

Decision Rule

Material Rule

Customer Rule

ISO 17025

Risk

Uncertainty

Pass / Fail

---

# PHASE 16

Reporting

Status

Planned

Tasks

PDF

Excel

CSV

XML

Custom Templates

Digital Signature

---

# PHASE 17

Industrial Benchmark

Status

Continuous

Products

Shimadzu TrapeziumX

Zwick testXpert III

Instron Bluehill Universal

MTS TestSuite

ADMET

Tinius Olsen

---

# Release Plan

v0.1

Architecture Documentation

✅

v0.2

Architecture Complete

Event Dictionary

State Machine

v0.3

Database Complete

v0.4

Core Engine

v0.5

UI

v0.6

PLC

v0.7

Reports

v0.8

Industrial Validation

v0.9

Beta

v1.0

Production Release

---

# Long-Term Vision

The UTS software shall become an industrial-grade, hardware-independent testing platform supporting future expansion without architectural redesign.

Every new feature must follow:

Benchmark

↓

Architecture

↓

Approval

↓

EDR

↓

Implementation

↓

Documentation

↓

Release