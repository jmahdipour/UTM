---
project: Universal Testing Machine (UTS)
document: FROZEN_DECISIONS
version: 0.2
status: FROZEN
classification: MASTER-INDEX
last_revision: 2026-08-02
---

# Frozen Decision Index

This is the mandatory entry point for authoritative UTS decisions. Read it before design or implementation.

## Platform and architecture baseline

| Decision | Status | Authority |
|---|---|---|
| VB.NET | FROZEN | AI Handover §3 |
| .NET Framework 4.8 | FROZEN | AI Handover §3 |
| WPF with MVVM | FROZEN | AI Handover §3 |
| SQLite | FROZEN | AI Handover §3 |
| x86 target | FROZEN | AI Handover §3 |
| Hardware-independent layered architecture | FROZEN | GR-014 |
| Raw acquired data is immutable | FROZEN | MIG-003 |
| Re-Test and Re-Analyze are distinct operations | FROZEN | MIG-009 |

## Golden Rules

| ID | Subject | Status | Governing source |
|---|---|---|---|
| GR-001 | Order-rooted business hierarchy | FROZEN | AI Handover |
| GR-002 | Specimen Draft/Completed lifecycle | FROZEN | AI Handover |
| GR-003 | Test Method Standard versus Acceptance Standard | FROZEN | AI Handover |
| GR-004 | Test Method exclusions | FROZEN | AI Handover |
| GR-005 | Material Library analytical role | FROZEN | AI Handover |
| GR-006 | Acceptance ownership | FROZEN | AI Handover |
| GR-007 | Core measurement channels | FROZEN | AI Handover |
| GR-008 | Optional measurement channels | FROZEN | AI Handover |
| GR-009 | Sensor is not Measurement | FROZEN | AI Handover |
| GR-010 | Measurement is not Calculated Measurement | FROZEN | AI Handover |
| GR-011 | Interactive Measurement Widget | FROZEN | AI Handover |
| GR-012 | Analysis pipeline | FROZEN | AI Handover |
| GR-013 | Data and event consumption | FROZEN-AS-AMENDED | EDR-0001 |
| GR-014 | Hardware independence | FROZEN | AI Handover |

## Frozen EDRs

| EDR | Decision | Status | Supersedes or amends |
|---|---|---|---|
| EDR-0001 | Separate measurement streams from domain events | FROZEN | Amends GR-013 and resolves CEDR-001 |
| EDR-0002 | Executable, versioned Test Method model | FROZEN | Resolves CEDR-002; constrained by GR-003/GR-004 |
| EDR-0003 | Separate coordinated Machine and Test Run state machines | FROZEN | Resolves CEDR-005 state portion |
| EDR-0004 | Layered safety and interlock architecture | FROZEN | Resolves CEDR-005 safety portion; partially resolves CEDR-006 |
| EDR-0005 | Measurement Channel, Sensor and Calibration contracts | FROZEN | Resolves CEDR-003 and CEDR-004 |
| EDR-0006 | UI architecture, command matrix and data-driven permissions | FROZEN | Resolves CEDR-007 and UI portion of CEDR-012 |

## Open decision sequence

These items must be resolved in dependency order:

1. Physical SQLite model and migration policy.
2. Application/API contracts.
3. PLC/driver contracts and verified hardware map.
4. Reporting, validation and release architecture.

## Synchronization check

Every Frozen EDR must appear here and must also update the AI Handover, affected architecture documents and Changelog.
