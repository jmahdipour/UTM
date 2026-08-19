---
project: Universal Testing Machine (UTS)
document: SCIENTIFIC_SCOPE_ASSESSMENT
version: 1.0
status: ACCEPTED
classification: SCOPE
governing_edr: EDR-0014
related: MVP_SCOPE.md
proposed_date: 2026-08-17
proposed_by: External review (documentation/implementation effort ratio)
accepted_date: 2026-08-18
accepted_by: Project owner
---

# Scientific Package Scope Assessment

## Owner decision

**ACCEPTED as proposed on 2026-08-18**, including the Clauses 17-23 deferral as
initially proposed (no separate first-customer check requested). This split now
governs which of the 16 atomic packages require independent review, fixtures and
implementation for v1 (Clauses 1-16, Annexes B/C/D/E/G, ASTM E8/E8M-15a) versus v2+
(Clauses 17-23, Annexes A/F/H/I/J/K/L).

## Why this document exists

`SCIENTIFIC/` atomizes all of ISO 6892-1:2019 (Clauses 1-23, Figures 1-15, Annexes
A-L) and the exact historical ASTM E8/E8M-15a text into 1,202 source items, 291
parameter/formula candidates and 260 acceptance variants. That work is correct and
will eventually be needed. This document asks a narrower question: **does all of it
need independent review, fixtures and implementation before v1 can ship**, or can
some of it be sequenced into v2+ without weakening v1's scientific correctness for
its actual first customers?

This is the same question `MVP_SCOPE.md` asks at the product level, applied here in
per-annex detail because EDR-0014/Milestone 10 is large enough to need its own
breakdown.

## Effort already recorded per package

| Package | Source items | Parameters | Acceptance variants | Normative or informative |
|---|---:|---:|---:|---|
| Clauses 1-10 | 191 | 53 | 30 | Normative |
| Clauses 11-16 | 71 | 13 | 21 | Normative |
| Clauses 17-23 | 103 | 15 | 26 | Normative |
| Annex A (sampling/fracture) | 94 | 19 | 21 | Informative |
| Annex B (product-form tables) | 48 | 19 | 14 | Normative |
| Annex C (proportional test pieces) | 25 | 10 | 10 | Normative |
| Annex D (non-proportional pieces) | 64 | 31 | 19 | Normative |
| Annex E (tube/plug pieces) | 58 | 12 | 15 | Normative |
| Annex F (stiffness-compensated rate) | 35 | 3 | 8 | Informative |
| Annex G (modulus/regression) | 153 | 56 | 24 | Normative |
| Annex H (arc-shaped pieces) | — | 3 | 6 | Informative |
| Annex I (subsize/elongation) | 35 | 10 | 7 | Informative |
| Annex J (`Awn` workflow) | 15 | 5 | 6 | Informative |
| Annex K (uncertainty) | 41 | 13 | 14 | Informative |
| Annex L (interlaboratory data) | 84 | 4 | 8 | Informative |
| ASTM E8/E8M-15a | 166 | 25 | 31 | Separate isolated standard |

## Proposed v1/v2 split, tied to `MVP_SCOPE.md`

`MVP_SCOPE.md` proposes v1 covers "ISO 6892-1:2019 Clauses 1-16 and the core
Rp/Rt/Rm/A properties" plus ASTM E8/E8M-15a and INSO 3132 (rebar). Applied per
package:

| Keep in v1 (independent review + fixtures + implementation required) | Reasoning |
|---|---|
| Clauses 1-16 | Core test procedure, apparatus, speeds and primary results; nothing else is testable without these. |
| Annex B, C, D, E | Normative product-form/test-piece geometry tables. A rebar/round-bar test cannot legally select dimensions without at least the applicable geometry annex (INSO 3132 specimens map to round/proportional forms in this set). |
| Annex G (modulus) | Rm/Rp0.2 alone is not a complete mechanical-property report for most acceptance standards; modulus is commonly required and Clause 1-16 depends on it for elastic-zone handling. |
| ASTM E8/E8M-15a | Explicitly named as a v1 second profile in `MVP_SCOPE.md`; keep as scoped. |

| Defer to v2+ (design stands; independent review/fixtures/implementation deferred) | Reasoning |
|---|---|
| Clauses 17-23 | Cover extended/optional procedures (e.g., elevated conditions, machine-specific procedures) not required for a first rebar/round-bar tensile release; confirm against actual first-customer requirement before deferring further packages here. |
| Annex A (sampling/fracture behavior) | Informative; edge-case fracture-location handling can start as `NOT-APPLICABLE`/manual-flag in v1 and tighten in v2. |
| Annex F (stiffness-compensated rate) | Informative; smallest package (35 items, 3 parameters) — low cost either way, but not required for a first correct result. |
| Annex H, I, J | Informative, smallest packages, cover specimen/geometry edge cases (arc-shaped, subsize, `Awn`) unlikely to be the first market's specimen type. |
| Annex K (uncertainty) | Informative; measurement uncertainty reporting is valuable but not required for a first Pass/Fail result against INSO 3132. |
| Annex L (interlaboratory data) | Informative; reproducibility/repeatability reference data, not needed to produce or accept a single lab's result. |

This split removes 6 of 16 packages (Clauses 17-23 plus Annexes A, F, H, I, J, K, L —
9 of 16 by count, but K/L/H/I/J/A/F together are the smallest-effort packages) from
the v1 independent-review/fixture/implementation critical path while keeping every
package already-designed and available to re-enter scope the moment a real customer
requirement needs it.

## What this does not do

- Does not un-atomize, weaken or delete any deferred package; all remain exactly as
  written under `SCIENTIFIC/`.
- Does not change `EDR-0014`'s definition of scientific completion; that definition
  still describes the full v1+v2 scope.
- Does not replace the `SG-01` through `SG-10` sub-gate sequence in `ROADMAP.md`;
  it proposes which packages must clear those sub-gates for a v1 exit versus which
  may clear them on a later release cadence.

## Decision record

Accepted as-is on 2026-08-18; per-package split not adjusted. `ROADMAP.md` Milestone
10 exit criteria and `SCIENTIFIC/README.md` should be read alongside this split when
scheduling SG-01 through SG-10 sub-gate work: v1-tagged packages block a v1 release,
v2+-tagged packages remain fully designed and available to re-enter scope on demand.
