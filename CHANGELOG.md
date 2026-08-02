# CHANGELOG

All significant architectural decisions shall be recorded here.

---

# Version 0.1

Status

Released

Date

2026-08-02

---

## Added

Project Documentation Repository

README.md

AI_HANDOVER_SPECIFICATION.md

Architecture Repository Structure

Engineering Documentation Rules

---

## Business Architecture

Order is the primary business object.

Customer belongs to Order.

Specimen belongs to Order.

Draft specimen workflow introduced.

Completed specimen workflow introduced.

---

## Test Method

Separated Test Method from Acceptance.

Test Method defines only machine behavior.

Material is excluded from Test Method.

Acceptance is excluded from Test Method.

---

## Material Library

Material Library introduced.

Mechanical properties added.

Young Modulus reference.

Yield Search Window.

Graph Optimization.

Acceptance Support.

Material Library defined as analytical assistance only.

---

## Acceptance

Acceptance moved into Material Library.

Decision Rules supported.

Tolerance support.

Measurement Uncertainty support.

Risk support.

Enable / Disable capability approved.

---

## Measurement Architecture

Core Measurement Channels approved.

Load

Stroke (Crosshead)

Extension

Time

Optional Measurement Channels approved.

Temperature

Torque

Pressure

LVDT

Vision

DAQ

Virtual

Future Channels

---

## Measurement Widget

Interactive Measurement Widget approved.

Separate Zero button removed.

Click Measurement Widget opens:

Zero

Diagnostics

Information

Calibration

Future tools

---

## Analysis Engine

Pipeline Architecture approved.

Validation Engine

Signal Processing Engine

Engineering Calculation Engine

Event Detection Engine

Mechanical Property Engine

Acceptance Engine

Reporting Engine

---

## Event Architecture

Event Driven Architecture approved.

Event Detection Engine declared as software core.

All future standards shall consume Events.

No module is allowed to process raw measurements directly.

---

## Hardware Independence

Hardware

↓

Acquisition

↓

Measurement

↓

Analysis

↓

Reporting

Analysis layer completely isolated from hardware.

---

## Documentation

Documentation Repository introduced.

README.md

AI_HANDOVER_SPECIFICATION.md

CHANGELOG.md

ROADMAP.md

ARCHITECTURE/

EDR/

DOMAIN/

STANDARDS/

REFERENCES/

---

# Pending

Event Dictionary

State Machine

Physical Database Design

PLC Layer

UI Architecture

Reporting Engine

API Layer

Hardware Drivers

---

# Next Planned Version

Documentation v0.2

Expected Additions

Event Dictionary

State Machine

Architecture Chapters

First EDR Package


---

# Unreleased

## Legacy decision ingestion

- Preserved the consolidated legacy TensileTestX handover under `REFERENCES/LEGACY/`.
- Preserved the historical tensile UI shell under `REFERENCES/LEGACY/`.
- Added `LEGACY_DECISION_MIGRATION_REGISTER.md` to classify retained statements as migrated, candidate EDR, superseded, open or reference-only.
- Explicitly retained WPF/MVVM, the Order-rooted domain model and current Frozen Golden Rules where legacy material conflicts.
- Recorded unresolved sensor, standards, hardware, safety, event-stream and UI architecture items for controlled follow-up.

- Analyzed the supplied `AG01.zip` legacy VB.NET/WinForms code and recorded its SHA-256 source identity.
- Added `AG01_LEGACY_CODE_ANALYSIS.md` with controlled classifications for retained capabilities, candidate EDRs, superseded patterns, formulas, PLC evidence and open verification items.
- Kept all legacy PLC addresses, calibration/scaling values, limits, formulas and speed presets non-authoritative pending hardware/standard verification and approved EDRs.


## Documentation v0.2 — Architecture Decisions

### Governance

- Added `DOCUMENTATION_GOVERNANCE.md` with source authority, decision lifecycle, synchronization and branch-release rules.
- Added `FROZEN_DECISIONS.md` as the mandatory current decision index.
- Required repository refresh before every analysis, design, implementation or refactoring task.

### EDR-0001

- Frozen the separation of continuous measurement streams from semantic domain events.
- Amended GR-013 so numerical analysis consumes validated/derived measurement streams while events retain semantic meaning and sample provenance.
- Preserved immutable raw data and deterministic replay.
- Defined ordering, timestamps, quality flags, backpressure, graph-decimation isolation and re-analysis lineage.
- Added `ARCHITECTURE/DATA_FLOW.md`.
- Resolved CEDR-001.

### Remaining dependency order

1. Executable Test Method model.
2. Machine/Test State Machines.
3. Safety and Interlock architecture.
4. Measurement/Sensor/Calibration contracts.
5. Event Dictionary.
6. UI command/permission matrix.
7. Physical SQLite model.
8. Application/API and PLC/driver contracts.


### EDR-0002

- Frozen the executable, versioned Test Method model.
- Defined ordered phases and deterministic segments with typed control modes, targets, rates, transitions and method termination conditions.
- Defined per-segment sampling and non-recording approach support.
- Preserved the seven-tab Method experience while separating Test Method, Specimen, Material, Acceptance, physical calibration, chart and report ownership.
- Defined Draft, Validated, Released and Retired lifecycle with immutable released revisions.
- Required an immutable Run Configuration Snapshot before arming.
- Added `DOMAIN/TEST_METHOD_MODEL.md`.
- Resolved CEDR-002.
