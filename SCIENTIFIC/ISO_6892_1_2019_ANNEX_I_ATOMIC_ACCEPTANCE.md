---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_I_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic Acceptance Variants - Annex I

## Execution status

These variants refine the existing `SAT-*` cases and do not replace them. Every Annex-I atomic RTM row names exactly one variant below. Current state for all variants is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`; expected evidence is not an implementation, validation or PASS claim. Annex I remains informative and its result requires the complete applicability, marking, fracture, parity and measurement chain.

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-AI-INFORMATIVE-APPLICABILITY` | `SAT-001`, `SAT-009`, `SAT-027`, `SAT-030`, `SAT-039` | Annex-I selected/not selected; Clause-20.1 fracture position compliant/noncompliant; complete necking inside/outside `L0`; all four condition combinations | independently reviewed two-condition applicability matrix | route is available only for noncompliant fracture position with complete necking inside `L0`; every other combination remains ordinary valid/invalid/not-applicable and no rescue is fabricated | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AI-SUBDIVISION-MARKING` | `SAT-003`, `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027` | marking before/after test; `d` below/on/above 5 and 10 mm; equal/unequal intervals; integer/noninteger `L0/d`; wrong length identities | independent decimal partition and specimen-lifecycle oracle | pre-test equal subdivisions sum exactly to `L0`, `N` is integer and units agree; 5 mm remains recommended, 10 mm is inclusive upper end, and invalid marking blocks route | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AI-XY-SYMMETRY` | `SAT-003`, `SAT-005`, `SAT-006`, `SAT-027`, `SAT-030`, `SAT-038` | qualified/ambiguous fracture; shorter/longer parts swapped; candidate X/Y marks at equal/unequal fracture distances; ties and missing marks | independent broken-part, mark-distance and lifecycle manifest | X belongs to shorter part, Y to longer part at equal fracture distance, and `n` counts exact intervals X-to-Y; ambiguity or mismatch yields no Annex-I result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AI-PARITY-ROUTING` | `SAT-005`, `SAT-006`, `SAT-027`, `SAT-039` | integer/noninteger, nonnegative/negative `N/n`; `n` below/on/above `N`; even/odd `N-n`; forced wrong branch | independent integer arithmetic and parity oracle | valid counts satisfy `0<=n<=N`; exactly one parity branch is selected without rounding, fallback or dual execution; invalid counts produce stable invalidity | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AI-EVEN-FORMULA` | `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027`, `SAT-038` | analytical even `N-n`; Z at correct/adjacent/wrong side; `lXY/lYZ/L0` valid, missing, nonfinite or unit-mismatched; Formula-I.1 mutations | independent integer-offset geometry and high-precision Formula-I.1 implementation | Z is `(N-n)/2` intervals beyond Y; measured lengths and `A` agree with exact grouping and factor 2; odd/mispositioned/invalid inputs yield no result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AI-ODD-FORMULA` | `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027`, `SAT-038` | analytical odd `N-n`; `Z'/Z''` correct/swapped/adjacent/wrong side; three lengths valid/invalid; Formula-I.2 mutations | independent dual-offset geometry and high-precision Formula-I.2 implementation | offsets are `(N-n-1)/2` and `(N-n+1)/2`, exactly one interval apart; measured lengths and `A` agree; even or invalid inputs yield no result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AI-FIGURE-IDENTITY` | `SAT-001`, `SAT-006`, `SAT-007`, `SAT-009`, `SAT-027`, `SAT-038`, `SAT-039` | both Figure-I.1 branches; every key symbol; mark-order and dimension swaps; alternative head shapes | independent figure-symbol, ordering and parity manifest | figure construction agrees with formulas and key; X/Y/Z identities and dimensions never cross branches; illustrated head shape remains guidance rather than eligibility geometry | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **7**.
- Every linked source item, formula, figure landmark and parity boundary must execute; one nominal reconstruction cannot close a variant.
- Informative applicability, recommended interval, exact geometry, parity-specific formulas and figure guidance retain distinct authority semantics.
- An applicable unexecuted variant makes the parent case `BLOCKED` or `FAIL`, never `PASS`.
