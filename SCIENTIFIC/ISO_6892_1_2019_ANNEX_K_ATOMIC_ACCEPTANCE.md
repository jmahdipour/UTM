---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_K_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-17
---

# ISO 6892-1:2019 Annex K Atomic Acceptance Variants

## Execution status

Every variant is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`; expected evidence is not a PASS claim.

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-AK-SCOPE` | `SAT-001`, `SAT-036` | authority and material/measurement scope | independent scope oracle | informative isolation | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-TYPE-ROUTING` | `SAT-036` | repeated/certificate/tolerance sources | source classifier | one justified route/component | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-K1` | `SAT-005`, `SAT-036` | datasets and n boundaries | sample-statistics oracle | K.1 result/provenance | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-K2` | `SAT-005`, `SAT-036` | intervals and distributions | distribution/K.2 oracle | correct half-width route | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-K3` | `SAT-005`, `SAT-006`, `SAT-036` | components and units | dimensional RSS oracle | K.3 result or stable block | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-MATRIX` | `SAT-010`, `SAT-036` | all K.1 cells | transcribed matrix oracle | exact relevance mapping | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-CERTIFICATE` | `SAT-010`, `SAT-011`, `SAT-036` | certificates/classes/drift | calibration-evidence oracle | actual uncertainty evidence | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-EXAMPLES` | `SAT-036` | worked values proposed as defaults | negative authority oracle | no example promotion | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-RP` | `SAT-020`, `SAT-036` | flat/steep/nonlinear curves | curve perturbation oracle | Rp sensitivity evidence | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-K4` | `SAT-005`, `SAT-028`, `SAT-036` | S0/Su contributions | independent K.4 oracle | correct Z combination | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-EXPANDED` | `SAT-036` | k and confidence basis | coverage-factor oracle | declared expanded result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-MONITORING` | `SAT-036` | scheduled samples/charts | QC lifecycle oracle | recommendation only | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-FACTORS` | `SAT-036` | seven/additional factors | budget completeness review | distribution and one-sigma evidence | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AK-EVIDENCE` | `SAT-036`, `SAT-045` | interlab/CRM/in-house routes | evidence-admission manifest | limitations/provenance retained | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **14**.
- Every applicable boundary must execute; an unexecuted applicable case is `BLOCKED` or `FAIL`, never `PASS`.
