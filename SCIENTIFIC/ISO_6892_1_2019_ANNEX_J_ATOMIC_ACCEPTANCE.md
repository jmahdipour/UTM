---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_J_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-17
---

# ISO 6892-1:2019 Annex J Atomic Acceptance Variants

## Execution status

Every variant is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`; expected evidence is not a PASS claim.

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-AJ-SCOPE` | `SAT-001`, `SAT-029` | selected route and long-product identity | authority/applicability matrix | informative opt-in behavior | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AJ-MARKING` | `SAT-003`, `SAT-006`, `SAT-029` | part identity and pre-test marks | lifecycle/partition manifest | qualified longer-part marks | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AJ-METROLOGY` | `SAT-005`, `SAT-029` | both lengths around 0.5-mm boundary | calibrated length oracle | accuracy and provenance | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AJ-ZONE` | `SAT-002`, `SAT-005`, `SAT-029` | both clearances and product minimum | geometry/dependency oracle | all three validity predicates | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AJ-FORMULA` | `SAT-005`, `SAT-006`, `SAT-029` | analytical values and mutations | independent decimal J.1 oracle | correct Awn; no note substitution | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AJ-NOTE` | `SAT-001`, `SAT-029` | Ag/Awn equality proposed | negative authority oracle | note never supplies a result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **6**.
- Every applicable boundary must execute; an unexecuted applicable case is `BLOCKED` or `FAIL`, never `PASS`.
