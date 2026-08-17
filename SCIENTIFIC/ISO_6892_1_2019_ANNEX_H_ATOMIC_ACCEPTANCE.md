---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_H_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic Acceptance Variants - Annex H

## Execution status

These variants refine the existing `SAT-*` cases and do not replace them. Every Annex-H atomic RTM row names exactly one variant below. Current state for all variants is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`; expected evidence is not an implementation, validation or PASS claim. Annex H remains informative and the described sequence remains one recommended manual route.

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-AH-INFORMATIVE-APPLICABILITY` | `SAT-001`, `SAT-003`, `SAT-027`, `SAT-039` | Annex-H selected/not selected; specified elongation below/on/above 5 percent; measured result independently below/on/above; method labelled mandatory/recommended | independently reviewed source-authority and strict threshold decision table | route recommendation is triggered only by `specified_A < 5%`; equality and measured-result substitution do not trigger it; no independent acceptance or conformity rule is invented | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AH-PRETEST-MARKING` | `SAT-003`, `SAT-005`, `SAT-007`, `SAT-009`, `SAT-027` | marks before/after test; absent/one/both ends; small/damaging marks; positions near/not near parallel-length ends | independent specimen lifecycle and two-ended marking manifest | two valid small pre-test marks retain left/right identity near the parallel-length ends; late, missing, one-sided or specimen-invalidating marking blocks this route | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AH-ARC-GEOMETRY` | `SAT-003`, `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027`, `SAT-030`, `SAT-038` | analytical `L0/r1/r2`; compatible/wrong units; `Le/Lc/Lu` substitutions; first/second centres; fracture nearest-mark ties and mismatches | independent compass-geometry and centre-selection oracle | `r1=r2=L0`; first centre is its pre-test mark and second centre is the original mark nearest fracture; wrong identity, radius, unit or centre yields no method result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AH-FRACTURE-REASSEMBLY` | `SAT-003`, `SAT-005`, `SAT-027`, `SAT-030`, `SAT-039` | qualified/ambiguous fracture; fixture absent/present; axial/non-axial force; insufficient/sufficient/excess handling; screw/other mechanism | independent fracture-lifecycle and reassembly-condition manifest | reassembly occurs only after qualified fracture; both pieces are firmly held axially during measurement; screw remains preferred rather than mandatory and no unsupported force value is invented | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AH-SCRATCH-DISTANCE` | `SAT-003`, `SAT-005`, `SAT-006`, `SAT-010`, `SAT-027`, `SAT-038` | microscope and other instruments with valid/missing calibration; correct/wrong scratch pair; repeated readings; incompatible units and nonfinite values | independent instrument-eligibility, endpoint-identity and length-comparison oracle | only the distance between the two qualified scratches is admitted with instrument/unit/provenance evidence; unsuitable or invalid measurement produces no elongation input | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AH-VISIBILITY-ALTERNATIVE` | `SAT-001`, `SAT-003`, `SAT-027`, `SAT-040` | dye absent/present before/after test; suitable/obscuring/damaging film; Annex-H manual and Clause-20.2 extensometer routes; mixed results | independent optional-aid and method-isolation manifest | dye remains an optional pre-test visibility aid and cannot alter geometry; Clause 20.2 remains a separate alternative with declared selection and no silent mixing or fallback | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **6**.
- Every linked source item and procedural boundary must execute; one nominal post-fracture measurement cannot close a variant.
- Informative applicability, recommended sequence, preferred mechanism, optional visibility aid and alternative method retain distinct authority semantics.
- An applicable unexecuted variant makes the parent case `BLOCKED` or `FAIL`, never `PASS`.
