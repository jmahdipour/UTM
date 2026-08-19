---
project: Universal Testing Machine (UTS)
document: MVP_SCOPE
version: 0.1
status: PROPOSED
classification: SCOPE
last_revision: 2026-08-17
---

# MVP Scope Proposal

## Why this document exists

Nothing else in the repository answers "when is v1 done?" in a way that bounds effort. `ROADMAP.md` lists fifteen milestones and `EDR-0014` covers the full ISO 6892-1:2019 annex set plus ASTM E8/E8M-15a. Both are correct as *complete* target architectures, but neither says which slice must exist before the first paying use. Without that line, every milestone can always justify one more sub-task, and v1.0 has no natural stopping point.

This document is `PROPOSED`, not `FROZEN`. It requires an explicit owner decision before it governs anything. Its purpose is to force that decision to be made once, explicitly, rather than implicitly by whichever task is worked on next.

## Proposed v1 boundary

| In v1 | Out of v1 (defer to v2+) |
|---|---|
| Tensile test, Single test mode only | Compression, Flexure, Cycle, Control modes |
| ISO 6892-1:2019 Clauses 1-16 and the core Rp/Rt/Rm/A properties | Annexes G-L (advanced modulus/uncertainty/interlaboratory material) |
| ASTM E8/E8M-15a as a second isolated profile | Any further ASTM/EN/other standard family |
| INSO 3132 acceptance profile (rebar) | Other acceptance standard families |
| One load cell + one extensometer sensor pair per run | Multi-sensor arbitration, DAQ/vision channels |
| CSV export + one validated PDF report template | Word/Excel/HTML report formats |
| Simulator-driven Milestones 1-14 complete and `PhysicalMonitorOnly` (G01-G03) evidence | `PhysicalCommissioning` and `PhysicalProduction` (G04-G17) |
| Six-page WPF shell as already specified in EDR-0006 | Any UI feature not already required by a Frozen EDR |

## What this deliberately excludes from the decision

This document does not propose changing any Frozen EDR's *scope of correctness* — EDR-0014 remains the authoritative complete definition of the Scientific Engine, and nothing in the "Out of v1" column is wrong or should be un-designed. This document only proposes an *implementation sequencing* boundary: build and verify the left column first, ship on it, and treat the right column as already-designed backlog for the next release.

## Required owner action

This proposal needs one of:

1. **Accept as-is** — move status to `ACCEPTED`, and `ROADMAP.md` milestone exit criteria get a "MVP-required" flag matching this table.
2. **Adjust the boundary** — the columns above are a starting proposal, not a fixed answer; the actual first market (e.g., rebar testing labs under INSO 3132) should drive which ISO clauses and which acceptance profile are truly load-bearing for v1.
3. **Reject** — if the intent is genuinely to ship the full EDR-0014 scope before any release, say so explicitly here so this document does not linger as an unresolved question.

Until one of these happens, this file's table is a proposal only and carries no authority under `DOCUMENTATION_GOVERNANCE.md`.
