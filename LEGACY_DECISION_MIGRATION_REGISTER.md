---
project: Universal Testing Machine (UTS)
document: LEGACY_DECISION_MIGRATION_REGISTER
version: 0.1
status: CONTROLLED
classification: ENGINEERING
source_revision_date: 2026-08-02
---

# Legacy Decision Migration Register

This register controls the ingestion of the legacy TensileTestX handover and UI shell into the UTS documentation repository.

## Authority

1. Newest FROZEN EDR.
2. AI_HANDOVER_SPECIFICATION.md.
3. Current architecture documents.
4. This migration register.
5. Files under REFERENCES/LEGACY/ are evidence only and are not authoritative.

A legacy statement does not become a Frozen UTS decision merely because it is preserved in Git.

## Source files

- REFERENCES/LEGACY/MERGED_TensileTestX_Complete.md
- REFERENCES/LEGACY/tensile_shell.html
- REFERENCES/LEGACY/AG01/README.md (manifest for the supplied AG01 source archive)
- REFERENCES/LEGACY/JTS/README.md (controlled intake for the supplied JTS architecture archive)
- REFERENCES/LEGACY/JTS/REVIEW_AND_MIGRATION.md
- AG01_LEGACY_CODE_ANALYSIS.md

## Status definitions

- MIGRATED: compatible with current Frozen rules and accepted as retained project context.
- CANDIDATE-EDR: valuable decision, but requires a dedicated EDR before implementation.
- SUPERSEDED: conflicts with a newer Frozen decision.
- OPEN: source itself says confirmation is still required.
- REFERENCE-ONLY: benchmark or implementation evidence; it does not define UTS architecture.

## Migrated decisions

| ID | Decision | Current basis |
|---|---|---|
| MIG-001 | VB.NET, .NET Framework 4.8, x86 and SQLite remain mandatory. | AI Handover §3 |
| MIG-002 | Hardware-specific Facon/Fatek behavior must be isolated behind acquisition/driver contracts; Analysis never communicates directly with PLC. | GR-014 |
| MIG-003 | Raw test data must be retained immutably for traceability; re-analysis creates derived results without rewriting the acquired source. | Compatible with GR-012–GR-014 |
| MIG-004 | Sensor, measurement and calculated measurement are separate concepts. | GR-009 and GR-010 |
| MIG-005 | Calibration is traceable per physical sensor and records curve, date, validity and certificate identity. | Compatible extension of GR-009 |
| MIG-006 | Test records must identify the sensors and calibration revisions used to produce the result. | Traceability consequence of MIG-005 |
| MIG-007 | UI and behavior from commercial systems are benchmark references only; vendor implementations must not be cloned. | Project mission and industrial references |
| MIG-008 | No unverified numeric value may drive Pass/Fail; primary standards and approved revisions are required. | Rule-based acceptance and engineering traceability |
| MIG-009 | Re-Test and Re-Analyze are different operations: Re-Test acquires new data; Re-Analyze recomputes from retained data. | Compatible with the analysis pipeline |
| MIG-010 | Export architecture must support CSV and reporting outputs through extensible exporters. | Compatible with modular and extendable goals |

## Candidate EDRs

| ID | Candidate decision | Required resolution |
|---|---|---|
| CEDR-001 | Streaming samples and domain events must be modeled as separate but connected flows. | Clarify GR-013 before pipeline implementation. |
| CEDR-002 | Test Method execution uses ordered phases/segments with control mode, target, rate, transition and termination conditions. | Define the executable Test Method model. |
| CEDR-003 | Load cell and extensometer selection is bound to a method/run configuration. | Reconcile with GR-004 so hardware binding does not introduce material or acceptance rules. |
| CEDR-004 | Calibration, overload validation and usable-range validation are per sensor. | Define warning/block rules and permissions. |
| CEDR-005 | Machine State Machine includes Setup, Ready, Running, Stopping, Fault and Emergency behavior. | Safety architecture and interlocks required. |
| CEDR-006 | JOG controls include latched direction, explicit Stop, clutch/speed constraints and machine-wide state. | Validate against real hardware and safety analysis before freezing. |
| CEDR-007 | Six-page information architecture: Reception/Order, Test, Method, Calibration, Settings and Report. | Rename Reception to fit GR-001 and complete UI Architecture. |
| CEDR-008 | Data-processing items form a dependency graph for formulas, parameters, markers and acceptance evaluation. | Reconcile with Event Detection and Acceptance ownership. |
| CEDR-009 | Test types include tensile, compression, flexure, spring rate, ring stiffness, ASTM D732 shear punch and ASTM D1894 friction. | Verify purchased standards, fixtures, geometry and reporting. |
| CEDR-010 | Facon/Fatek address map and command sequence are implemented only inside a hardware adapter. | Revalidate the legacy map against the rebuilt machine. |
| CEDR-011 | Graphs have configurable channels, independent axes, point inspection, markers and maximization. | Define graph/formula extension contract and accessibility. |
| CEDR-012 | Roles, permissions, audit log, localization and automatic export are data-driven services. | Define security and audit requirements. |

## Superseded legacy decisions

| ID | Legacy statement | Governing decision |
|---|---|---|
| SUP-001 | WinForms UI and light MVVM. | WPF + MVVM in AI Handover §3. |
| SUP-002 | Customer → Reception → SampleGroup is the traceability root. | Order → Customer → Specimens → Tests in GR-001. |
| SUP-003 | TestMethod directly relates to MaterialGrade and Calibration. | Test Method excludes material properties and acceptance under GR-004; binding needs an EDR. |
| SUP-004 | Legacy document is the master prompt and default behavior must copy TRAPEZIUM X. | Repository Frozen decisions are authoritative; commercial products are references only. |
| SUP-005 | Direct implementation milestones from the old Core/WinForms design. | Current repository is in Architecture Phase and coding follows approved EDRs. |

## Open items retained

1. Confirm extensometer travel ranges for SG-25, SG-50 and SG-100.
2. Confirm whether mounted load-cell identity is available from Facon or must be operator/method selected.
3. Verify the rebuilt machine's actual load-cell inventory and calibration mapping.
4. Revalidate the Facon/Fatek ProgID, register map, command sequences, clutch behavior and communication timing against the current machine.
5. Verify INSO 3132 acceptance values from the controlled standard revision.
6. Verify ISO 9969 formula constants from the controlled standard revision.
7. Verify ASTM D732 and ASTM D1894 geometry, speed, sampling and reporting from purchased standards.
8. Resolve the meaning of the legacy UI label "CP".
9. Define safety chain, emergency stop, watchdog, overload, travel limits, JOG interlocks and fault acknowledgement.
10. Reconcile the HTML shell against the future WPF UI Architecture; it is a visual reference, not implementation code.

## Required next documents

1. EDR for data stream versus domain events.
2. Executable Test Method model.
3. Machine/Test State Machine.
4. Safety and Interlock Architecture.
5. Measurement Channel and Sensor Calibration contracts.
6. Event Dictionary.
7. UI Architecture and command/permission matrix.
8. Physical SQLite model.

## AG01 source-code ingestion

The supplied `AG01.zip` was integrity-checked and analyzed as legacy engineering evidence. Controlled results are in `AG01_LEGACY_CODE_ANALYSIS.md`. It adds eight compatible capability observations, ten candidate EDR decisions, eight superseded implementation patterns, a reference-only PLC address map, formula evidence and eight verification items. No PLC address, scaling factor, limit, calibration value, formula or legacy UI pattern became Frozen through this ingestion.

# End of document


## Resolved candidate EDRs

| Candidate | Resolution | Governing decision |
|---|---|---|
| CEDR-001 | Continuous measurement streams and semantic domain events are separate, connected flows. | EDR-0001 |


| CEDR-002 | Test Methods use immutable released versions containing ordered phases/segments, typed control targets/rates, transitions, terminations and per-segment acquisition profiles. Material, Acceptance, calibration and safety remain separate aggregates. | EDR-0002 |


| CEDR-005 | Machine and Test Run use separate coordinated state machines with guarded commands; layered safety/interlocks override all normal transitions. | EDR-0003 and EDR-0004 |
| CEDR-006 | Press-and-hold JOG is limited to Setup, uses explicit/idempotent Stop and approved 0.1/1/10 mm/min UI presets; no software clutch exists. Physical mapping, thresholds and safety performance remain open. | EDR-0003 and EDR-0004 (partial; hardware verification remains) |


| CEDR-003 | Methods declare logical sensor requirements; deploy/run resolution binds actual sensor installations and calibration revisions into an immutable Run Measurement Snapshot. | EDR-0005 |
| CEDR-004 | Calibration, range, overload validation and quality are per sensor/binding; only applicable Active calibration revisions satisfy production arming. | EDR-0005 |


| CEDR-007 | The six primary pages remain Reception/Test/Method/Calibration/Settings/Report; Reception is explicitly an Order-rooted workspace under GR-001. | EDR-0006 |
| CEDR-012 | Roles/permissions are data-driven and commands are checked in Application plus state/safety guards. Audit/localization/export service details continue in their dedicated designs. | EDR-0006 (UI/permission portion) |

## JTS architecture archive ingestion

The supplied `jts.zip` was received and reviewed on 2026-08-09. Its SHA-256 is `334e9341ba5be8980fce5c140b1d59a5be660bd1338d90f10aabc4da8c52f8ce`.

The archive contains 87 Markdown files, including 82 chapters (`ARCH-000` through `ARCH-081`). Every chapter labels itself `FROZEN` and cites a legacy EDR identifier, but those labels do not establish authority in the current UTS repository. The exact archive and a content-equivalent LF-normalized searchable extraction are preserved under `REFERENCES/LEGACY/JTS/`.

### JTS dispositions

| ID | Source statement or topic | Status | Governing resolution |
|---|---|---|---|
| JTS-MIG-001 | Platform is VB.NET, .NET Framework 4.8, WPF/MVVM, SQLite and x86. | MIGRATED | AI Handover §3 already governs it. |
| JTS-MIG-002 | UI/Application must not directly manipulate PLC registers or SQLite. | MIGRATED | EDR-0006, EDR-0008 and EDR-0009 already govern it. |
| JTS-MIG-003 | Raw data is immutable; calculations/results are derived and versioned. | MIGRATED | EDR-0001 and EDR-0007 already govern it. |
| JTS-SUP-001 | Archived v0.1 README, AI Handover, Changelog and Roadmap are the current baseline. | SUPERSEDED | Current `main` includes EDR-0001 through EDR-0009 and newer master documents. |
| JTS-SUP-002 | Every downstream calculation consumes Events rather than validated/derived measurement streams. | SUPERSEDED | EDR-0001 amends GR-013 and separates measurement streams from semantic events. |
| JTS-SUP-003 | Customer → Project → Order is the permanent business hierarchy. | SUPERSEDED | GR-001 keeps Order as the highest business object. |
| JTS-SUP-004 | JTS SQLite Schema v1.1 is authoritative and permanent. | SUPERSEDED | EDR-0007 and migration `0001_initial.sql` govern the physical schema. |
| JTS-REF-001 | Fatek/Facon/VS20NL-P1 details, PLC references and numeric motion/acquisition examples. | REFERENCE-ONLY | Hardware map remains `CONTROLLED-DRAFT`; physical adapter remains `BLOCKED-HARDWARE`. |
| JTS-CEDR-001 | Reporting, report versioning, validation and release workflow. | CANDIDATE-EDR | Incorporate into the next already-open reporting/validation/release architecture. |
| JTS-CEDR-002 | Audit trail and electronic signatures. | CANDIDATE-EDR | Requires identity, signature, retention, threat and regulatory-scope decisions. |
| JTS-CEDR-003 | Standards library governance. | CANDIDATE-EDR | Requires controlled standard revisions and requirement/formula verification. |
| JTS-CEDR-004 | Machine verification and preventive maintenance. | CANDIDATE-EDR | Requires equipment evidence, schedules, permissions and lock policy. |
| JTS-CEDR-005 | Graph/curve analysis and correction contract. | CANDIDATE-EDR | Must preserve raw data and define re-analysis/decimation/marker traceability. |
| JTS-CEDR-006 | Plugin and external integration boundary. | CANDIDATE-EDR | EDR-0008 prohibits v1 public listeners; future scope requires security/safety EDRs. |
| JTS-CEDR-007 | Acquisition performance profile. | CANDIDATE-EDR | Numeric rates, queues, timeouts and batch sizes require code benchmarks and hardware evidence. |

Detailed evidence, duplicate-topic mapping and line references are in `REFERENCES/LEGACY/JTS/REVIEW_AND_MIGRATION.md`. No JTS statement became Frozen through this ingestion.
