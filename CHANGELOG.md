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

### EDR-0008

- Frozen a versioned in-process Application/API boundary for WPF, Application, Core and Infrastructure.
- Prohibited public HTTP, REST, gRPC, socket, scripting and remote-motion listeners in v1 without a separate security and safety EDR.
- Added 57 versioned commands, side-effect-free query contracts and 56 stable reason codes.
- Defined trusted command envelopes, idempotency, optimistic concurrency and atomic transaction boundaries.
- Defined fail-closed JOG Begin/Renew/End leases, priority Stop behavior and mandatory reconciliation after uncertain motion timeouts.
- Kept Re-Analyze isolated from drivers and machine coordination; display-decimated data remains prohibited as scientific input.
- Added Application ports, transaction boundaries, a 40-requirement traceability matrix, 40 acceptance scenarios and a passing static package validator.
- Kept executable VB.NET, simulator and hardware acceptance evidence explicitly pending implementation or commissioning.

### Remaining dependency order

1. PLC/driver contracts and verified hardware map.
2. Reporting, validation and release architecture.


### EDR-0009

- Frozen the hardware-independent `IMachineDriver` boundary, typed semantic command protocol, capability advertisement and connection/reconciliation lifecycle.
- Frozen the immutable machine hardware profile and PLC mapping lifecycle from `LegacyEvidence` through independently reviewed `Released`.
- Frozen deterministic Simulator and fault-injection behavior as software evidence only; Simulator success does not substitute for physical commissioning.
- Prohibited production generic register/coil writes, software clutch exposure, UI-owned heartbeat and automatic retry/resend after uncertain motion timeouts.
- Recorded 25 AG01 legacy points as `LEGACY-EVIDENCE` with all writes `WRITE-DISABLED`; no address, polarity, scale, timing or acknowledgement was promoted to verified production data.
- Preserved raw `kgf` provenance and canonical force normalization under EDR-0007: `1 kgf = 9.80665 N`.
- Added `ARCHITECTURE/DRIVER_PLC_ARCHITECTURE.md`, Driver contract, hardware-map register, Simulator/fault-injection contract, commissioning gates, traceability and acceptance matrices.
- Revalidated 45 requirements and 45 acceptance tests with exact status parity: 10 `PASS-DOC`, 26 `PENDING-CODE`, 9 `BLOCKED-HARDWARE`.
- Kept the physical hardware map `CONTROLLED-DRAFT` and physical adapter activation `BLOCKED-HARDWARE` until controlled machine evidence and signed commissioning exist.

### Remaining dependency order

1. Verified physical hardware map and adapter commissioning.
2. Reporting, validation and release architecture.

## Documentation v0.3 — Implementation Baseline

Date: 2026-08-09

### EDR-0010

- Frozen Windows-integrated v1 identity using the authenticated Windows SID mapped to a UTS Actor.
- Kept authorization based on stable permission identifiers and versioned role assignments.
- Added short-lived trusted Application sessions, permission-revision invalidation, separation-of-duties and redaction rules.
- Kept the default process local-only with no external listener or application-owned password store.

### EDR-0011

- Frozen SQLite-backed durable operations for analysis, import, reporting, export, backup and maintenance.
- Excluded motion/JOG/Stop from background jobs and prohibited unsafe automatic retry.
- Added startup recovery, abandoned-attempt, controlled shutdown, backup/restore verification and no-auto-resume rules.

### EDR-0012

- Frozen immutable report input bundles, template/report lifecycle, deterministic validation and authorized release manifests.
- Prohibited report-time scientific calculations and raw/driver dependencies.
- Required Simulator non-production labeling and retained ISO/standard claims as validation-gated.
- Kept PDF behind `IReportRenderer` until a compatible renderer passes Windows x86 and visual-regression gates.

### EDR-0013 and technical baseline

- Frozen the local VB.NET/.NET Framework 4.8/x86 Modular Monolith delivery shape.
- Pinned the initial reference, SQLite, charting, diagnostic and test package versions in `ENGINEERING/TECHNICAL_BASELINE.md`.
- Added Windows/offline deployment rules, CI/build-quality constraints and explicit performance acceptance budgets.
- Added Solution Architecture, implementation RTM and baseline acceptance tests.
- Corrected stale README progress labels and added an executable implementation roadmap.

## Documentation v0.4 - Scientific Scope Correction

Date: 2026-08-09

### Controlled sources

- Registered the supplied `ISO 6892-1:2019(E)` third-edition PDF as `REF-STD-ISO-6892-1-2019`, including page count and SHA-256 identity.
- Retained the supplied `ASTM E8/E8M-15a` as an exact historical controlled revision; it is not represented as E8/E8M-25.
- Retained J. R. Davis (ed.), *Tensile Testing*, 2nd edition, ASM International (2004), as a non-normative engineering reference.
- Kept licensed PDFs outside Git while preserving the controlled source register and integrity checks.

### EDR-0014 and scientific package

- Corrected the incomplete Rm/Rp0.2-only description of scientific completion.
- Frozen separate ISO 6892-1:2019, ASTM E8/E8M and Derived Engineering analysis profiles.
- Required every applicable ISO 6892-1 point, property, procedure, validity state, report field and normative Annex G modulus output.
- Added parameterized `Rp`, `Rt` and `Rr`; `ReH`, `ReL`, `Ae`, `Ag`, `Agt`, `At`, `A`, `Z`, optional `Awn`, `Fm/Rm`, fracture, rate and geometry coverage.
- Added Annex G `E`, evaluation ranges, point count, coefficient of determination, `Sm` and `Sm(rel)` while prohibiting implicit equivalence between `mE` and `E`.
- Added derived logarithmic strain, true stress and engineering/true energy integration with explicit post-necking validity limits.
- Required explicit `Valid`, `Warning`, `Invalid`, `NotApplicable`, `Estimated` and live `Provisional` semantics; failed calculations may not fabricate a number.
- Added immutable point provenance, manual-correction revisions, graph-decimation isolation and deterministic re-analysis rules.
- Added `SCIENTIFIC/SCIENTIFIC_COMPLETION_SPECIFICATION.md`, a 45-row scientific RTM and 45 paired acceptance tests.
- Expanded Roadmap Milestone 10 into ten scientific sub-gates and kept all implementation evidence explicitly pending.

### Scientific traceability and test-design correction

- Corrected the earlier overstatement that the 45 scientific rows alone constituted complete atomic clause coverage or executable acceptance evidence.
- Classified the 45 `SCI-*`/`SAT-*` pairs as requirement/test families; `SG-02` remains open until every applicable condition, table, formula and reviewed profile parameter is atomically traced.
- Added `SCIENTIFIC/TEST_CASE_SPECIFICATIONS.md` with variants, execution protocol, independent-oracle rules, expected results and evidence requirements for all 45 cases.
- Added `SCIENTIFIC/TEST_FIXTURE_CATALOG.md` covering analytical, geometry, measurement-quality, procedural, Golden and independent fixture admission.
- Added `SCIENTIFIC/SOURCE_COVERAGE_AUDIT.md` with ISO family routing, open atomic work, the detailed ASTM E8/E8M-15a gap and current gate assessment.
- Kept all scientific test results `NOT-RUN`; no documentation-only `PASS` or conformity claim was created.

### SG-02 ISO atomic package 1

- Atomized 191 controlled source items from ISO 6892-1:2019 Clauses 1-10, including all 46 Table 1 symbols and the Method A/Method B rate conditions.
- Added 53 exact parameter/formula candidates with printed-page/PDF-page locators, units, inclusivity and boundary-test requirements.
- Added 30 atomic acceptance variants linked to every source item and its existing `SCI-*`/`SAT-*` family.
- Added a static validator for counts, locators and bidirectional source/parameter/acceptance routing.
- Kept every parameter `INDEPENDENT-REVIEW-PENDING` and every variant `NOT-RUN`; `SG-02` remains open for review, Clauses 11-23, Annexes A-L and the detailed ASTM package.

### SG-02 ISO atomic package 2

- Atomized 71 controlled source items from ISO 6892-1:2019 Clauses 11-16 and Figures 2-7 for `ReH`, `ReL`, `Rp{x}`, `Rt{x}`, `Rr{x}` and `Ae`.
- Added 13 parameter/formula candidates covering the shortened `ReL` window, proof constructions, hysteresis guidance, permanent-set hold/decision boundaries and `Ae` calculation.
- Added 21 acceptance variants for primary/alternative constructions, all required figure landmarks, applicability, procedure sequencing, controlled external-method routing and reporting evidence.
- Expanded the static validator to check both packages, cross-package ID uniqueness and bidirectional SCI/SAT/parameter/variant routing.
- Kept every new parameter `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; `SG-02` remains open for independent review, Clauses 17-23, Annexes A-L and the detailed ASTM package.
