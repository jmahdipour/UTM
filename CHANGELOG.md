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


### EDR-0003

- Frozen separate coordinated Machine and Test Run state machines.
- Replaced string/Boolean state with explicit guarded transitions and stable command rejection reasons.
- Defined Setup-only press-and-hold JOG, idempotent Stop, approved 0.1/1/10 mm/min UI presets and no software clutch.
- Defined run terminal EndReason, restart reconciliation and transition audit requirements.
- Added `ARCHITECTURE/STATE_MACHINES.md`.

### EDR-0004

- Frozen layered Safety and Interlock architecture while keeping hardware-specific safety performance open.
- Declared the Windows/WPF application non-safety-rated and prohibited it from being the sole safety layer.
- Defined safety priority, stop intents, interlock snapshots, fail-closed command gating, watchdog behavior and commissioning gates.
- Added official ISO 12100, ISO 13849-1:2023, ISO 13850 and IEC 60204-1 reference links.
- Added `ARCHITECTURE/SAFETY_AND_INTERLOCKS.md`.
- Resolved CEDR-005 and partially resolved CEDR-006.


### EDR-0005 and Event Dictionary

- Frozen separate contracts for logical channels, physical sensors, installations, calibration revisions, channel bindings, zero/tare, compliance correction and run measurement snapshots.
- Kept the six legacy load-cell and three extensometer selections as unverified inventory evidence.
- Prohibited implicit Extensometer-to-Stroke fallback and scalar INI calibration factors.
- Added calibration lifecycle, quality flags, range rules and arming validation.
- Added controlled references to ISO/IEC 17025:2017, ISO 7500-1:2018 and ISO 9513:2012 without claiming conformity.
- Added the first Frozen Event Dictionary with versioned envelopes and machine, run, measurement-quality, analysis and result events.
- Resolved CEDR-003 and CEDR-004.


### EDR-0006

- Frozen the six-page WPF/MVVM shell: Reception, Test, Method, Calibration, Settings and Report.
- Defined Reception as an Order-rooted workspace to preserve GR-001.
- Added the state/permission guarded command matrix, including always-requestable Stop and Setup-only press-and-hold JOG.
- Defined data-driven permission identifiers instead of role-name checks.
- Defined the interactive Measurement Widget command behavior, live Test workspace and graph/re-analysis boundaries.
- Added `UI/UI_ARCHITECTURE.md`.
- Resolved CEDR-007 and the UI/permission portion of CEDR-012.

### EDR-0007

- Frozen SQLite as the installation transactional system of record with a controlled single-writer/WAL operating profile.
- Added a 51-table initial physical model, 19 explicit indexes and 68 protective triggers.
- Added immutable raw/derived measurement chunks, configuration snapshots, audit/event journals and Re-Test/Re-Analyze lineage.
- Frozen explicit unit provenance: source, canonical analysis and display/export units remain separate.
- Frozen force normalization to canonical N while preserving device/import kgf provenance; `1 kgf = 9.80665 N`.
- Added `DATABASE/Migrations/0001_initial.sql`, migration/backup/recovery policy, requirements traceability and SQL acceptance tests.
- Required ordered checksummed migrations, verified backup before migration and no in-place downgrade.
- Revalidated 14/14 structural acceptance checks, foreign keys, integrity and controlled conversion data.

### Remaining dependency order

1. Application/API contracts.
2. PLC/driver contracts and verified hardware map.
3. Reporting, validation and release architecture.
