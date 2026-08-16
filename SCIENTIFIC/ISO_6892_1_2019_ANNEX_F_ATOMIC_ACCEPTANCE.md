---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_F_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic Acceptance Variants - Annex F

## Execution status

These variants refine the existing `SAT-*` cases and do not replace them. Every Annex-F atomic RTM row names exactly one variant below. Current state for all variants is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`; expected evidence is not an implementation, validation or PASS claim. Every route preserves Annex F as informative, explicitly selected guidance and cannot silently replace normative rate control or measured strain evidence.

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-AF-INFORMATIVE-SOURCE` | `SAT-001`, `SAT-013`, `SAT-032`, `SAT-033` | Annex-F route selected/not selected; normative rate-control method and measured evidence present/absent; estimator labelled mandatory/informative | independently reviewed authority and selection manifest | Annex F executes only after explicit opt-in and remains informative; it never changes the selected normative method, fabricates measured strain or creates an independent conformity claim | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AF-COMPLIANCE-GAP` | `SAT-001`, `SAT-010`, `SAT-013`, `SAT-033`, `SAT-038` | Formula (2) and Annex-F routes; frame/load-cell/grip/other compliance absent/present; estimate and measurement labels | independent equipment-boundary and evidence-kind decision table | Formula (2) is identified as uncompensated; optional compensation covers the participating system and its result remains an estimate distinct from measured strain control | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AF-STIFFNESS-QUALIFICATION` | `SAT-003`, `SAT-006`, `SAT-010`, `SAT-033`, `SAT-038`, `SAT-039` | point of interest, grip configuration/separation and bite state matched/mismatched; elastic/post-elastic and linear/nonlinear input sources | independent configuration-identity matrix and post-elastic suitability review | only point- and configuration-matched complete-system stiffness is admitted; elastic-portion specimen stiffness and linear-portion-derived inputs are rejected outside the permitted route | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AF-PROCEDURE-SELECTION` | `SAT-001`, `SAT-003`, `SAT-010`, `SAT-013`, `SAT-033`, `SAT-038`, `SAT-039` | procedure opted in/out; `CM` and `m` point evidence complete/missing/mismatched; in-test check performed/not performed | independent optionality, input-match and recommendation-semantics manifest | procedure runs only when selected with matched inputs; the in-test check remains a recommendation and no missing check is converted into an unconditional ISO failure | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `SAT-003`, `SAT-005`, `SAT-006`, `SAT-008`, `SAT-010`, `SAT-013`, `SAT-033`, `SAT-038` | analytical `vc/m/S0/CM/Lc`; compatible/wrong units; point/configuration matches; zero/negative/nonfinite values; regrouping and symbol swaps | independent decimal Formula-F.1 implementation plus dimensional and provenance analysis | estimated s^-1 result and grouping agree only for valid matched inputs; invalid denominator, unit, symbol or provenance produces no controlled estimate | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AF-F2-COMPENSATED-CROSSHEAD-RATE` | `SAT-003`, `SAT-005`, `SAT-006`, `SAT-008`, `SAT-010`, `SAT-013`, `SAT-033`, `SAT-038` | analytical `eDotM/m/S0/CM/Lc`; crosshead-displacement and foreign control modes; valid/invalid units, values and provenance; Formula-F.1 inverse pairs | independent decimal Formula-F.2 implementation, dimensional analysis and F.1 inverse oracle | compensated mm/s result and inverse consistency agree only in the declared optional crosshead-displacement context; no result replaces measured or normative control evidence | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AF-F3-STIFFNESS-CALIBRATION` | `SAT-003`, `SAT-005`, `SAT-006`, `SAT-007`, `SAT-008`, `SAT-010`, `SAT-013`, `SAT-033`, `SAT-038` | same/different specimen geometry and similar/dissimilar properties; slow known constant `vc`; point intervals matched/mismatched; analytical values and invalid denominators | independent calibration-identity manifest, decimal Formula-F.3 implementation and complete-system boundary review | `CM` in N/mm is produced only from matched calibration evidence with a finite positive denominator and covers rig, load cell and clamping; otherwise the optional route is blocked | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AF-YIELDING-BEHAVIOR-ROUTE` | `SAT-001`, `SAT-003`, `SAT-013`, `SAT-033`, `SAT-039` | continuous, discontinuous and serrated yielding in/out of relevant range; F.2/F.3 and simplified Formula-(2) selections | independently reviewed yielding-classification and route-selection matrix | F.3 calibration is recommended only without relevant discontinuous yielding; discontinuous/serrated behavior bypasses stiffness and uses estimated strain over `Lc` with Formula (2), never F.2 | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **8**.
- Every linked source item and formula boundary must execute; one passing nominal calculation cannot close a variant.
- Informative guidance, optional selections, recommendations, invalid-input prohibitions and alternative yielding routes retain distinct authority semantics.
- An applicable unexecuted variant makes the parent case `BLOCKED` or `FAIL`, never `PASS`.
