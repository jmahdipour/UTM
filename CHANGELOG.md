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
- Preserved the supplied `jts.zip` and a content-equivalent LF-normalized searchable extraction under `REFERENCES/LEGACY/JTS/`, with SHA-256 manifest, conflict review and deterministic validation.
- Classified all JTS-local `FROZEN`/`EDR-*` claims as non-authoritative unless already governed by current EDRs; retained reporting, audit, standards, maintenance, graph, plugin and acquisition details as candidate work only.
- Kept the Order-rooted hierarchy, EDR-0001 stream/event model, EDR-0007 physical schema, EDR-0008 v1 API boundary and EDR-0009 hardware activation gates unchanged.

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

### SG-02 ISO atomic package 3

- Atomized 103 controlled source items from ISO 6892-1:2019 Clauses 17-23 and Figures 1 and 8-10 for `Rm`, `Ag`, `Agt`, `At`, `A`, `Z`, reporting, rounding and uncertainty boundaries.
- Added 15 parameter/formula candidates covering maximum-force/fracture calculations, plateau midpoint, post-fracture metrology/validity, reduced-area measurement, report precision and the Figure-9 illustration assumption.
- Added 26 acceptance variants for property applicability/calculation, manual/extensometer fracture workflows, conversion, area measurement, immutable reporting, rate artifacts and prohibited uncertainty adjustments.
- Expanded the static validator to support globally unique parameter authorities with explicit cross-package reuse while retaining source-local definition checks.
- Kept every new parameter `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; `SG-02` remains open for independent review, Figures 11-15, Annexes A-L and the detailed ASTM package.

### SG-02 ISO atomic package 4

- Atomized 94 source items from informative Annex A, Figures A.1-A.2 and Table A.1, covering raw-data interfaces, channel bandwidth/sampling, computer property determination, fracture, elastic-slope selection, validation and machine-readable guidance.
- Added 19 parameter/formula candidates for minimum sampling, `ReH`/fracture boundaries, approximate `Rp0.2` slope bounds, validation statistics and every Table-A.1 property limit.
- Added 21 acceptance variants with independent-oracle requirements, including source-role, raw-data, interpolation/smoothing, fracture, crosshead bridge, slope and validation-scope paths.
- Expanded the static validator to support Annex source IDs while retaining global identity, source-local parameter, bidirectional routing and count checks across all four packages.
- Kept Annex A informative, every new parameter `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; `SG-02` remains open for independent review, Figures 11-15, Annexes B-L and the detailed ASTM package.

### SG-02 ISO atomic package 5

- Atomized 48 source items from normative Annex B, Tables B.1-B.2 and shared Figure 11 for thin sheet, strip and flat specimens.
- Added 19 parameter/formula records for shape, length relations, all three Table-B.1 profile tuples, all Table-B.2 tolerance rows and original-area accuracy; reused the two package-1 Annex-B thickness limits without duplication.
- Added 14 acceptance variants for exact applicability, geometry, table boundaries, preparation, nominal-width eligibility, special thin-material handling and `S0` determination/accuracy.
- Expanded the static validator to cover five packages while retaining global identity, cross-package parameter reuse, source-local definition and bidirectional routing checks.
- Kept Annex B normative, recommendations separately classified, every new parameter `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; `SG-02` remains open for independent review, Figures 12-15, Annexes C-L and the detailed ASTM package.

### SG-02 ISO atomic package 6

- Atomized 25 source items from normative Annex C, Formula C.1 and Figure 12 for unmachined wire, bar and section specimens below the controlled size boundary.
- Added 10 parameter/formula records for the two `L0` profiles, combined grip-distance bounds, the no-elongation route, `S0` accuracy, perpendicular circular measurements and mass-density area calculation; reused the package-1 Annex-C applicability limit without duplication.
- Added 10 acceptance variants for exact profile selection, Figure-12 geometry, unmachined shape, gauge/grip boundaries, coiled-product preparation and both `S0` routes.
- Expanded the static validator to cover six packages while retaining global identity, cross-package parameter reuse, source-local definition and bidirectional routing checks.
- Kept Annex C normative, every new parameter `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; recorded the unresolved C.2 `b0` meaning as a review blocker instead of selecting a transverse dimension by inference. `SG-02` remains open for Figures 13-15, Annexes D-L and the detailed ASTM package.

### SG-02 ISO atomic package 7

- Atomized 64 source items from normative Annex D, Formula D.1, Tables D.1-D.3 and Figure 13 for machined and unmachined larger flat, wire, bar and section specimens.
- Added 31 parameter/formula records for transition geometry, parallel/dispute lengths, all Table-D.1/D.2 profiles, all nine Table-D.3 tolerance rows and original-area measurement; reused package-1 applicability, Formula-D.1 and coefficient authorities without duplication.
- Added 19 acceptance variants for exact profile/geometry selection, proportional and non-proportional routes, table boundaries, machining/shape examples, nominal-dimension eligibility and `S0` determination.
- Expanded the static validator to cover seven packages while retaining global identity, cross-package parameter reuse, source-local definition and bidirectional routing checks.
- Kept Annex D normative while preserving recommendation, preference, approximation and conditional semantics; every new parameter remains `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`. `SG-02` remains open for Figures 14-15, Annexes E-L and the detailed ASTM package.

### SG-02 ISO atomic package 8

- Atomized 58 source items from normative Annex E, Formulas E.1-E.4 and Figures 14-15 for complete-tube, longitudinal/transverse-strip and circular machined-wall specimens.
- Added 12 parameter/formula records for general longitudinal-strip use, strict and dispute plug geometry, original-area accuracy and every exact/simplified `S0` expression; reused the package-1 Annex-B/Annex-D 3 mm routing boundary without duplication.
- Added 15 acceptance variants for exact product/form selection, both figure geometries, plug use/clearance/interference, strip preparation, product-standard authority and all four formula routes.
- Expanded the static validator to cover eight packages while retaining global identity, cross-package parameter reuse, source-local definition and bidirectional routing checks.
- Kept Annex E normative while preserving permissive, general-use, strict, inclusive and dispute semantics; recorded the overlapping Formula-E.3 `<0.25` and `<0.10` conditions as a review blocker rather than inventing exclusive intervals or precedence. `SG-02` remains open for Annexes F-L and the detailed ASTM package.

### SG-02 ISO atomic package 9

- Atomized 35 source items from informative Annex F and Formulas F.1-F.3 for stiffness-aware estimation of strain rate and crosshead separation rate.
- Added 3 parameter/formula records for estimated strain rate, compensated crosshead separation rate and complete testing-equipment stiffness calibration; reused package-1 Formula (2) authority without duplication.
- Added 8 acceptance variants for informative-source semantics, compliance scope, point/configuration-specific stiffness, optional procedure selection, all three formula routes and continuous/discontinuous-yield behavior.
- Expanded the static validator to cover nine packages while retaining global identity, cross-package parameter reuse, source-local definition and bidirectional routing checks.
- Kept Annex F informative and opt-in; prohibited linear-portion stiffness reuse outside its valid route, retained complete-system/configuration matching and routed discontinuous or serrated yielding to estimated strain over `Lc` with Formula (2), not Formula F.2. Every new parameter remains `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; `SG-02` remains open for Annexes G-L and the detailed ASTM package.

### SG-02 ISO atomic package 10

- Atomized 153 source items from normative Annex G, Formulas G.1-G.8 and Tables G.1-G.3 for uniaxial-tension determination of modulus of elasticity.
- Added 56 parameter/formula records for force/extensometer eligibility, bilateral measurement, specimen and sampling controls, regression/range quality, both uncertainty examples, G.8 reporting and historical reproducibility data.
- Added 24 acceptance variants for applicability, metrology, alignment, area, rate/sampling, repeated use, bilateral averaging, regression, fit quality, range revision, uncertainty-route isolation, CWA/Annex-K examples, reporting and method limitations.
- Expanded the static validator to cover ten packages while retaining global identity, source-local definition, locator, authority and bidirectional routing checks.
- Kept mandatory, permitted, recommended, note and information-only semantics distinct; prohibited silent `mE`/`E` equivalence and prevented Table-G.1/G.2 examples, proficiency values and Table-G.3 historical reproducibility from becoming universal acceptance limits. Every new parameter remains `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; `SG-02` remains open for Annexes H-L and the detailed ASTM package.

### SG-02 ISO atomic package 11

- Atomized 19 source items from informative Annex H for manual measurement of percentage elongation after fracture when the specified value is below 5 percent.
- Added 3 parameter/formula records for the strict specified-value applicability boundary and equal first/second arc radii derived from `L0`.
- Added 6 acceptance variants for informative applicability, two-ended pre-test marking, arc geometry, post-fracture reassembly, scratch-distance metrology, the optional dye aid and Clause-20.2 route isolation.
- Expanded the static validator to cover eleven packages while retaining global identity, source-local definition, locator, authority and bidirectional routing checks.
- Kept Annex H informative and its procedure non-exclusive; distinguished the specified value from the measured result and retained screw use, dye film and extensometer measurement as preferred, optional and alternative semantics. Every new parameter remains `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; `SG-02` remains open for Annexes I-L and the detailed ASTM package.

### SG-02 ISO atomic package 12

- Atomized 35 source items from informative Annex I, Formulas I.1-I.2 and Figure I.1 for subdivision-based measurement of percentage elongation after fracture.
- Added 10 parameter/formula records for equal subdivisions, the 5-mm recommendation and 10-mm upper end, integer `N/n` parity, even/odd mark offsets and both elongation calculations.
- Added 7 acceptance variants for the joint fracture-position/necking applicability condition, pre-test subdivision, X/Y symmetry, parity routing, both formula branches and Figure-I.1 identity.
- Expanded the static validator to cover twelve packages while retaining global identity, source-local definition, locator, authority and bidirectional routing checks.
- Kept Annex I informative and prohibited silent rescue outside its two-condition applicability route; required exact integer parity and mark provenance and retained the illustrated head shape as guidance only. Every new parameter remains `INDEPENDENT-REVIEW-PENDING` and every new variant `NOT-RUN`; `SG-02` remains open for Annexes J-L and the detailed ASTM package.

### SG-02 ISO atomic packages 13-15

- Atomized 15 source items, 5 parameter/formula candidates and 6 acceptance variants from informative Annex J and Formula J.1 for the optional `Awn` workflow.
- Atomized 41 source items, 13 parameter/formula candidates and 14 acceptance variants from informative Annex K, Formulas K.1-K.4 and Tables K.1-K.4 for uncertainty inventory, combination and example routing.
- Atomized 84 source items, 4 parameter/formula candidates and 8 acceptance variants from informative Annex L, preserving all 70 interlaboratory observations, four figures, reproducibility interpretation and evidence-only status.
- Kept every extracted value `INDEPENDENT-REVIEW-PENDING`, every variant `NOT-RUN` and all informative examples/datasets prohibited from becoming universal acceptance limits.

### SG-02 ASTM atomic package 16

- Atomized 166 source items from the exact historical ASTM E8/E8M-15a source, including clauses, annex material, 26 figures and 7 tables.
- Added 25 ASTM-specific parameter/formula candidates and 31 linked acceptance variants covering apparatus, specimens, procedures, speeds, results, reporting, precision/bias and unit-system isolation.
- Expanded the static validator to cover all sixteen ISO/ASTM packages with package-specific identity namespaces and cross-package uniqueness/routing checks.
- Updated the aggregate extraction status to 1,202 source items, 291 parameter/formula candidates and 260 acceptance variants; independent review, serialized fixtures, executable implementation and conformity evidence remain pending.

## Documentation v0.4 — Legacy UI Mockup Review

Date: 2026-08-17

- Reviewed `REFERENCES/LEGACY/tensile_shell.html` line-by-line against EDR-0001 through EDR-0009.
- Classified five patterns as `SUPERSEDED` (software JOG clutch, latched JOG buttons, continuous JOG speed knob, standalone Tare/Zero button, Order-less Customer-rooted Reception hierarchy) and recorded why each conflicts with current Frozen decisions.
- Classified hardcoded numeric values as `REFERENCE-ONLY`/`UNVERIFIED` and two layout patterns as `MIGRATED-ALREADY`.
- No numeric value, PLC behavior, or safety pattern from this file may be implemented as-is; recorded in `LEGACY_DECISION_MIGRATION_REGISTER.md`.

## Documentation v0.5 — MVP Scope, Commissioning Kickoff and Scientific Split Accepted

Date: 2026-08-18

- Owner accepted `MVP_SCOPE.md` as proposed (status PROPOSED -> ACCEPTED): v1 covers Single tensile mode, ISO 6892-1:2019 Clauses 1-16, ASTM E8/E8M-15a, INSO 3132, one sensor pair per channel, CSV + one validated PDF report, Simulator-driven Milestones 1-14 plus `PhysicalMonitorOnly` (G01-G03).
- Owner accepted `DRIVER/COMMISSIONING_KICKOFF_PLAN.md` as proposed (status PROPOSED -> ACCEPTED): confirmed physical machine access; Gates G01-G03 evidence-gathering starts now, in parallel with Milestones 1-14. No gate `Current result` in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changes until real evidence is filed.
- Owner accepted `SCIENTIFIC/SCOPE_ASSESSMENT.md` as proposed (status PROPOSED -> ACCEPTED), including the Clauses 17-23 deferral: v1-critical-path scientific packages are Clauses 1-16, Annexes B/C/D/E/G and ASTM E8/E8M-15a; Clauses 17-23 and Annexes A/F/H/I/J/K/L remain fully designed and deferred to v2+.
- Synchronized `ROADMAP.md` (v0.2): added an MVP-required column to the milestone table reflecting the three accepted decisions above; no milestone's designed exit evidence was removed, only flagged as MVP-required or deferred.

## Documentation v0.6 — Autograph Legacy Archive Review

Date: 2026-08-18

- Owner uploaded `Autograph.zip` (SHA-256 `d6cf28306a546fca9ed8fb9ea929d0be2e502b513b80e877658871023a6666a4`), the software that currently operates the physical machine. Preserved evidence pointer in `REFERENCES/LEGACY/AUTOGRAPH/README.md`.
- Added `AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md`: a fuller cross-verifying AG01-family source snapshot (54 files / 18,084 lines vs. the original 32 files / 12,502 lines). Confirms all previously recorded `DRIVER/HARDWARE_MAP.md` points exactly; no contradiction.
- New legacy evidence: PLC vendor/protocol confirmed independently (`Fatek Facon PLC Server File Format 1`); communication topology is Ethernet/TCP (active target `192.168.2.100`, unused alternate `10.50.10.100`), not previously recorded; PLC read-poll interval `10 ms`; three previously undocumented `Group_read` points (`X0`, `Y2`, `R22`); three unclassified communication-driver addresses (`R3844`, `R4096`, `R3845`).
- Synchronized `DRIVER/HARDWARE_MAP.md` (v0.1 -> v0.2) with the new points, a new communication-topology section, and a second source reference. No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changed state; all remain `BLOCKED-HARDWARE`.
- Explicitly excluded `DataBase/Plc_DB.mdb` (real customer/lab names, addresses, phone numbers) and the other Access databases in the archive from any ingestion; only PLC/communication-driver-relevant technical files were reviewed.
- Distinguished the `.fcs` communication-driver tag list from the PLC's own ladder-logic program source, which remains a separate, still-missing artifact for Gate G03.

## Documentation v0.7 — Live Current-Machine Communication Confirmed

Date: 2026-08-18

- Owner confirmed, while the physical machine was actively communicating, that current communication is Ethernet/TCP via the `FaconSvr` ("FaSvr") intermediary driver at IP `192.168.2.200` — the same driver family reviewed in `AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md`, but a different host than either address recorded in the legacy `.fcs` archive (`192.168.2.100` active, `10.50.10.100` unused).
- Recorded as `OWNER-CONFIRMED-LIVE` in `DRIVER/HARDWARE_MAP.md` (v0.2 -> v0.3), a new status distinct from `LEGACY-EVIDENCE` (describes the machine as it exists today) and from `DOCUMENT-VERIFIED` (no screenshot/export/log filed yet).
- Updated the G02 row in `DRIVER/COMMISSIONING_KICKOFF_PLAN.md` to reflect this initial live confirmation and the remaining artifact needed (FaSvr connection-screen screenshot or export) to advance to `DOCUMENT-VERIFIED`.
- No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changed state.

## Documentation v0.8 — FaSvr Live Screenshot Evidence

Date: 2026-08-18

- Owner provided 3 screenshots of the running `Fatek Communication Server [Autograph_svr.fcs]` application (dated 20/08/2026 09:47:55) plus a re-upload of `Autograph_SVR.fcs` (SHA-256 identical to the previously reviewed copy, still targeting `192.168.2.100` internally).
- Recorded as `SCREENSHOT-VERIFIED-LIVE` in `DRIVER/HARDWARE_MAP.md` (v0.3 -> v0.4): direct visual proof every previously `LEGACY-EVIDENCE` read/write point, plus the three previously `UNCLASSIFIED` addresses (`R3844`, `R4096`, `R3845`), is live, enabled and actively updating on the currently running system.
- New: precise group update rates from FaSvr itself - `Group_read` 31 ms (Hi priority), `Group_write` 110 ms (Normal priority) - distinct from the legacy VB6 app's own 10 ms `TimerReadTick`.
- Recorded a point-in-time value snapshot for both groups (evidence of liveness/scale only, not calibrated engineering values or a specification).
- Flagged an unresolved discrepancy: the live-connected `.fcs` file still encodes `192.168.2.100`, not the `192.168.2.200` reported as the current live address; documented both plausible explanations without assuming either, pending owner clarification.
- No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changed state.

## Documentation v0.9 — PLC/Operator-PC Address Discrepancy Resolved

Date: 2026-08-18

- Owner confirmed: `192.168.2.100` (matching every reviewed `.fcs` file and the live screenshots) is the real, current PLC address. `192.168.2.200` was the operator PC's own address on the same subnet, not a second candidate PLC address.
- `DRIVER/HARDWARE_MAP.md` (v0.4 -> v0.5): merged the prior "owner-confirmed-live" and "unresolved discrepancy" entries into one resolved "Current-machine communication" record. Communication medium and PLC address are now `DOCUMENT-VERIFIED` (screenshots + owner confirmation); electrical schematic, I/O list and communication/drive manuals remain outstanding for G02.
- Updated the G02 row in `DRIVER/COMMISSIONING_KICKOFF_PLAN.md` to reflect the resolution.
- No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changed state.

## Documentation v1.0 — Electrical Schematic and Vendor Manuals Reviewed

Date: 2026-08-18

- Owner provided the 14-sheet electrical schematic `Auto_graph_90-07-14-1.pdf` (AtronicSaman Co., "Auto graph" project, Eng. Zardi, dated 2011-08-15 through 2011-08-28 — current-revision status unconfirmed) plus three Fatek vendor manuals (Facon Server ActiveX interface, Facon Server DDE interface, FBs-CM25/CM55/CBE Ethernet module). All four preserved as evidence pointers with SHA-256 in `REFERENCES/LEGACY/ELECTRICAL/README.md`.
- Added `ELECTRICAL_SCHEMATIC_REVIEW.md`: full sheet-by-sheet extraction. Resolves the plausible (unconfirmed) semantics of previously-`UNCLASSIFIED` points `X0` (encoder channel A) and `Y2` (Servo Stop output); flags a **safety-relevant discrepancy**: the schematic does not independently confirm `X14`'s "main E-stop" identity, which comes only from a VB source comment.
- Confirms servo drive (`APD-VS20NL`) and motor (`APM-SF20MEK`) identity; confirms two dedicated `FBS_1LC` bridge-input modules for Load (`11B3`) and Extensometer (`11B7`) — plausible, unconfirmed correlation to `R32`/`R37`.
- **Physically confirms** the two-ratio magnetic clutch hardware (`12L3`/`12L4`) already flagged `SUPERSEDED`/`REJECTED-FOR-UTS-COMMAND` for software exposure (`TSX-SUP-001`, EDR-0003/EDR-0009) — hardware existence does not lift the prohibition.
- Synchronized `DRIVER/HARDWARE_MAP.md` (v0.5 -> v0.6) and the G02 row in `DRIVER/COMMISSIONING_KICKOFF_PLAN.md`. G02 communication manual requirement now satisfied; electrical schematic obtained but current-revision confirmation and the servo drive's own manual remain outstanding.
- No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changed state.
