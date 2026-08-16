---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_C_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic Acceptance Variants - Annex C

## Execution status

These variants refine the existing `SAT-*` cases and do not replace them. Every Annex-C atomic RTM row names exactly one variant below. Current state for all variants is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`; expected evidence is not an implementation, validation or PASS claim.

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-AC-PROFILE-APPLICABILITY` | `SAT-001`, `SAT-002`, `SAT-007`, `SAT-032` | wire/bar/section and foreign product forms; governing size below/on/above 4 mm; profile revision mismatch | independently reviewed Clause-6/Annex-C applicability decision table | Annex C is selected only for the controlled product families below the exclusive boundary; equality routes away from Annex C and no nearest-profile coercion occurs | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-FIGURE12-GEOMETRY` | `SAT-006`, `SAT-007`, `SAT-008`, `SAT-009`, `SAT-032`, `SAT-038`, `SAT-039` | circular/rectangular/other unmachined sections; complete/incomplete `L0` and `S0`; swapped length/area identities | independent Figure-12 symbol and section-profile manifest | `L0` and `S0` retain identity, unit, provenance and lifecycle; actual unmachined section form and Annex-C authority remain explicit | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-UNMACHINED-SHAPE` | `SAT-001`, `SAT-003`, `SAT-007`, `SAT-032` | unmachined/machined specimen; general and deviation routes; deviation evidence absent/present | independently reviewed shape/applicability matrix preserving the source's non-exclusive wording | general unmachined route is retained without becoming an invented exclusive rule; any deviation is explicit and revisioned, and this extraction does not silently approve or reject it beyond the source text | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-L0-OPTIONS` | `SAT-003`, `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032` | each 100/200 mm profile below/on/inside/on/above tolerance endpoints; cross-profile nominal/tolerance mixtures; missing selection | independent decimal boundary generator and two-row profile manifest | exactly one complete tuple is selected; inclusive endpoints pass; cross-row mixtures, gaps and ambiguous selection fail with stable reasons | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-GRIP-DISTANCE` | `SAT-003`, `SAT-006`, `SAT-007`, `SAT-009`, `SAT-012`, `SAT-032`, `SAT-038`, `SAT-039` | analytical `L0/b0/G` sets below/on/above each lower bound; each branch dominant and equal crossover; circular/rectangular/other section routes | independent high-precision dual-bound calculator plus reviewed `b0` applicability decision | both lower bounds are evaluated and effective minimum is reproducible; unresolved `b0` meaning or missing input produces a stable review-blocked/no-result state, never an inferred transverse dimension | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-NO-A-GRIP-DISTANCE` | `SAT-003`, `SAT-006`, `SAT-007`, `SAT-009`, `SAT-012`, `SAT-027`, `SAT-032` | `A` requested/not requested; grip distance below/on/above 50 mm; ordinary relation present/absent | independent conditional-route truth table and boundary comparison | 50 mm route is available only when `A` is not determined; equality passes; requesting `A` prevents this route from silently bypassing ordinary geometry | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-COILED-STRAIGHTENING` | `SAT-003`, `SAT-007`, `SAT-032`, `SAT-038`, `SAT-039` | product coiled/not coiled; straightening method/evidence absent/present; damaged/unaltered preparation outcomes | independently reviewed preparation-evidence matrix | coiled product retains method and preparation outcome; absent or unacceptable evidence blocks or qualifies the specimen with a stable reason | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-S0-ACCURACY` | `SAT-008`, `SAT-010`, `SAT-032`, `SAT-036` | area error below/on/above 1 percent; positive/negative errors; adequate/inadequate measurement evidence | independent uncertainty/error budget and exact absolute-boundary comparison | symmetric mandatory accuracy is evaluated; equality passes; insufficient evidence or excess error blocks/qualifies `S0` without fabricating a value | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-CIRCULAR-S0` | `SAT-003`, `SAT-006`, `SAT-007`, `SAT-008`, `SAT-032`, `SAT-038` | circular/non-circular sections; one/two/more measurements; perpendicular/non-perpendicular directions; analytical pairs and mixed units | independent two-measurement arithmetic-mean calculation plus route-eligibility manifest | only the circular eligible route uses exactly two perpendicular measurements; mean and provenance agree; missing orientation, wrong count and incompatible units fail explicitly | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-AC-MASS-DENSITY-S0` | `SAT-003`, `SAT-005`, `SAT-006`, `SAT-008`, `SAT-016`, `SAT-032`, `SAT-038` | analytical `m/rho/Lt` values; grams, density and millimetres plus convertible/wrong units; zero/negative/nonfinite/missing inputs; `L0/Lt` swap | independent rational/decimal Formula-C.1 implementation and dimensional analysis | `S0` agrees in mm2 with preserved inputs and route identity; scaling is exact; invalid denominator, quantity substitution or incompatible units produces no area and a stable reason | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **10**.
- Every linked source item and parameter boundary must execute; one passing nominal specimen cannot close a variant.
- Normative requirements, permissive routes and figure guidance retain distinct authority semantics.
- An applicable unexecuted variant makes the parent case `BLOCKED` or `FAIL`, never `PASS`.
