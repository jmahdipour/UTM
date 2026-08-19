---
project: Universal Testing Machine (UTS)
document: DOCUMENTATION_GOVERNANCE
version: 0.4
status: FROZEN
classification: GOVERNANCE
effective_date: 2026-08-02
last_revision: 2026-08-17
---

# Documentation and Decision Governance

## Purpose

This document defines how requirements, evidence, engineering decisions and released documentation become authoritative for the UTS project.

## Authority order

When sources conflict, use the first applicable source in this order:

1. Newest non-superseded EDR with status `FROZEN`.
2. Non-superseded Frozen Golden Rules in `AI_HANDOVER_SPECIFICATION.md`.
3. Approved architecture, domain, standard and interface specifications.
4. Project owner's shared conversation and supplied attachments, as requirement evidence awaiting controlled migration.
5. Professional industrial products, manuals and workflows, as benchmark references only.
6. Legacy applications and source code, including AG01, as behavioral evidence only.

A lower authority source cannot silently change a higher authority decision.

## Mandatory start-of-work check

Before analysis, design, implementation or refactoring:

1. Read the default branch and the active controlled branch.
2. Read `FROZEN_DECISIONS.md`.
3. Read every applicable non-superseded Frozen EDR.
4. Read the latest AI Handover and Changelog.
5. Identify contradictions and open decisions before changing code.
6. Mark work based on unavailable or stale repository state as `UNVERIFIED`.

## Decision lifecycle

| Status | Meaning | May drive production implementation? |
|---|---|---:|
| DRAFT | Incomplete working text | No |
| PROPOSED | Ready for review | No |
| ACCEPTED | Owner accepted; awaiting release integration | Only on the controlled implementation branch |
| FROZEN | Released authoritative decision | Yes |
| SUPERSEDED | Replaced by a newer EDR | No |
| REJECTED | Explicitly declined | No |

A Frozen decision changes only through a newer EDR containing an explicit `Supersedes` relationship.

## Implementation-evidence gate

An EDR proposing a new bounded contract (an aggregate, a state machine, a command surface or a persistence shape) may reach `FROZEN` only together with, or immediately followed by, a minimal executable slice that exercises at least one of its public contracts under a passing test. A documentation-only EDR that amends scope, terminology or an existing already-implemented contract is exempt. The purpose is to prevent the accepted-decision backlog from growing faster than the Solution can absorb it; it does not lower the bar for correctness or completeness of the decision text itself.

## Required synchronization

Every new or changed Frozen decision must update, in the same controlled change set:

- the EDR;
- `FROZEN_DECISIONS.md`;
- affected architecture or domain specifications;
- `AI_HANDOVER_SPECIFICATION.md`;
- `CHANGELOG.md`;
- cross-references to any superseded rule.

No important decision may remain only in chat.

## Branch and release policy

- The default branch is the released documentation authority.
- Feature and documentation branches are controlled working records until merged.
- A branch document may be marked Frozen for review continuity, but it becomes the released project baseline only after integration into the default branch.
- Pull request creation and merge remain explicit owner-controlled actions.
- An implementation branch is a controlled working record only. Implementation is released only after its EDR, code, tests, traceability and master-document synchronization are reviewed and integrated into the default branch.

## Evidence handling

- Shared conversations and attachments are primary sources for discovering owner intent.
- Industrial products such as Shimadzu TrapeziumX, Instron Bluehill Universal, ZwickRoell testXpert and MTS TestSuite are benchmarks, not code or UI to clone.
- Legacy formulas, PLC addresses, calibration factors, limits and timing values remain non-authoritative until verified and Frozen by EDR.
- Purchased standards and controlled standard revisions govern normative formulas and acceptance criteria.

## Completion rule

A work item is complete only when its decision, implementation, tests and documentation agree. If one is missing, the item remains open.
