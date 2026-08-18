---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_L_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-17
---

# ISO 6892-1:2019 Annex L Atomic Acceptance Variants

## Execution status

Every variant is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`; expected evidence is not a PASS claim.

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-AL-SCOPE` | `SAT-001`, `SAT-045` | guidance proposed as limit | authority classifier | informative evidence only | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AL-RPR` | `SAT-005`, `SAT-036`, `SAT-045` | means/deviations and invalid means | high-precision Rpr oracle | formula/confidence metadata | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AL-DATASET` | `SAT-045` | all 70 observations; missing/duplicate/reordered | independent table manifest | exact row identities and values | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AL-FIGURES` | `SAT-006`, `SAT-038`, `SAT-045` | four plots/keys against tables | plot-from-table oracle | no new observations | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AL-FOOTNOTES` | `SAT-005`, `SAT-045` | A/Z conversions | unit-aware conversion oracle | correct examples, no limit promotion | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AL-METROLOGY` | `SAT-028`, `SAT-045` | Z scatter interpretation | metrology-evidence review | cautions remain attached | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AL-COMPARISON` | `SAT-036`, `SAT-045` | Rpr versus expanded uncertainty | coverage-definition oracle | compatible comparisons only | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AL-NO-LIMIT` | `SAT-045` | dataset extrema/averages as pass-fail | negative authority oracle | no universal tolerance | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **8**.
- Every applicable boundary must execute; an unexecuted applicable case is `BLOCKED` or `FAIL`, never `PASS`.
