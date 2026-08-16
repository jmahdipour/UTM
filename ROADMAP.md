---
project: Universal Testing Machine (UTS)
document: ROADMAP
version: 0.1
status: CONTROLLED
last_revision: 2026-08-09
---

# UTS Implementation Roadmap

The product is implemented from scratch as one VB.NET/.NET Framework 4.8/x86 Modular Monolith. A milestone closes only when code, tests, RTM and documentation agree.

| Milestone | Deliverable | Exit evidence |
|---:|---|---|
| 1 | Supplemental EDRs and technical baseline | EDR-0010-0014 indexed; baseline validator passes |
| 2 | Solution foundation | all production/test projects, dependency rules, pinned packages, Windows CI and architecture tests |
| 3 | Core primitives and canonical serialization | identities, quantities/units, result types, clocks/hashes and deterministic serialization tests |
| 4 | Domain aggregates and state machines | Order/Specimen/Method/Metrology/Run models and exhaustive transition tests |
| 5 | Security/operation/driver forward migrations and repositories | migrations, checksums, SQLite x86 smoke and transaction/invariant tests |
| 6 | Application command/query pipeline | sessions, permissions, validation, idempotency, concurrency and transaction orchestration |
| 7 | Deterministic Simulator and driver conformance | virtual clock/scenarios, mandatory fault catalog and no-auto-resume proof |
| 8 | Machine runtime and execution engine | command lane, Safety Supervisor, JOG lease, segment runner, Stop/reconciliation/recovery |
| 9 | Acquisition and raw persistence | bounded frames/chunks, gaps, replay, backpressure and crash finalization |
| 10 | Scientific and analysis engine | all applicable ISO 6892-1:2019 clauses/points and Annex G; isolated ASTM profile; true/logarithmic curves; energy; uncertainty; deterministic re-analysis; complete scientific RTM and independent verification |
| 11 | WPF operator application | six workspaces, widgets, live chart, settings and permission/state projections |
| 12 | Reporting, export, audit and backup | CSV, selected validated PDF renderer, release lifecycle and restore drills |
| 13 | System performance and packaging | soak/fault tests, x86 budgets, offline installer, diagnostics and upgrade recovery |
| 14 | Traceability and system acceptance | all software RTM rows/test cases closed; no open production-code placeholders |
| 15 | Physical monitor-only and commissioning | controlled hardware evidence; production writes remain blocked until EDR-0009 gates pass |

## Current gate

Milestones 1 and 2 are the active controlled change. Later milestones must not be represented as implemented until their executable evidence exists.

## Milestone 10 scientific sub-gates

Milestone 10 is not one calculation task. It closes only in this order:

1. `SG-01` controlled source/revision integrity;
2. `SG-02` complete atomic source-condition/table/formula-to-requirement-to-test-and-parameter traceability;
3. `SG-03` validated measurements, geometry, units and quality;
4. `SG-04` every applicable ISO point/property and invalid/not-applicable path;
5. `SG-05` derived true/logarithmic curves and energy with necking limits;
6. `SG-06` fit quality, uncertainty and reason codes;
7. `SG-07` immutable deterministic re-analysis and manual correction;
8. `SG-08` graph/report reproduction from the same result bundle;
9. `SG-09` independent numerical implementation and scientific review;
10. `SG-10` every v1 `SCI-*`/`SAT-*` pair is `PASS`.

The governing definition is `SCIENTIFIC/SCIENTIFIC_COMPLETION_SPECIFICATION.md`.

Current scientific assessment: `SG-02 OPEN - ISO PACKAGES 1-9 EXTRACTED`. Clauses 1-23, Figures 1-15 and Annexes A-F now contain 689 atomic source items, 175 parameter/formula candidates and 164 linked acceptance variants. Their independent review remains pending; Annexes G-L, the detailed ASTM package, serialized fixtures and executable evidence remain pending.
