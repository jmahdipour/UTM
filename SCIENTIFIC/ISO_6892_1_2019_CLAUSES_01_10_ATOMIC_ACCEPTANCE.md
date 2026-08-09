---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_CLAUSES_01_10_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic Acceptance Variants - Clauses 1 to 10

## Execution status

These variants refine the existing `SAT-*` cases. They do not replace them. Every atomic RTM row names one variant below; each variant is exercised once for every linked source item and profile parameter that applies.

Current state for all variants is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`. Expected results are definitions of future evidence, not claims that code exists or passed.

## Source, schema and result variants

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-SCOPE-PROFILE` | `SAT-001`, `SAT-031` | pinned ISO 6892-1:2019 profile plus foreign material, temperature and Annex-A claims | hand-reviewed applicability matrix derived from the exact source items | only owned room-temperature metallic tensile capabilities are admitted; informative Annex A remains labelled | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-SOURCE-DEPENDENCY` | `SAT-001`, `SAT-010` | dated/undated dependency manifests, missing and substituted ISO 7500-1/ISO 9513 evidence | independently reviewed dependency register and revision-difference manifest | exact dependency identity is retained; missing, incompatible or silently changed dependencies block affected claims | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-SCHEMA-DEFINITION` | `SAT-006` plus property-family SAT | one valid and one semantically incompatible record for every linked definition | independent term-to-type/unit/applicability catalog | accepted records retain the exact concept; incompatible bases, units and property identities are rejected | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-SCHEMA-SYMBOL` | `SAT-006` | one record per Table 1 symbol in source, canonical and display units; collision cases for the two `R2` concepts | independently authored Table-1 schema manifest | all 46 symbols round-trip with distinct stable IDs, units and meanings; no collision or implicit `mE = E` conversion | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-CALC-FORMULA` | `SAT-008`, `SAT-013`, `SAT-016`, `SAT-027`, `SAT-028`, `SAT-034`, `SAT-035` | nominal, zero-denominator, incompatible-unit, boundary and culture variants for each `IP-FORMULA-*` | separate calculation implementation using decimal/rational or high-precision arithmetic | value, unit, invalidity, parameter revision and source provenance match; no NaN/default-zero result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RESULT-APPLICABILITY` | linked property `SAT-*`, `SAT-039` | applicable, not-applicable and insufficient-evidence inputs for each linked source item | independent applicability decision table | exact `Valid`, `Warning`, `Invalid` or `NotApplicable` state and reason; absent values remain absent | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-REPORT-ROUNDING` | `SAT-035`, `SAT-037` | positive/negative midpoint and adjacent values in invariant and comma-decimal cultures | independent decimal quantization under the cited reporting convention | stored unrounded value is preserved; displayed `E` uses the reviewed 0.1 GPa rule and invariant report bytes | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Environment, specimen and metrology variants

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-ENV-TEMPERATURE` | `SAT-011`, `SAT-036` | values below/equal/inside/above each temperature boundary, gradient present/absent, controlled/general mode | independent interval and evidence-state table | correct in-range state, out-of-range assessment requirement, gradient warning and uncertainty routing | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-REPORT-ENVIRONMENT` | `SAT-011`, `SAT-037` | in-range and out-of-range runs with missing/present measured temperature and assessment | independently authored field/applicability manifest | outside-band temperature and assessment are present in immutable report inputs; omissions block release | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-GEO-SPECIMEN` | `SAT-007`, `SAT-032` | proportional/non-proportional, machined/unmachined/as-cast and each shape; every exact and just-outside boundary | independent geometry/applicability script plus reviewed profile table | deterministic profile, geometry state, warning and source locator; unsupported combinations do not default | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-GEO-PROFILE` | `SAT-007`, `SAT-032` | Table-2 product boundaries, tube routing, customer-agreed external profile with and without source identity | independently reviewed decision table | exact Annex B/C/D/E or external pinned profile is selected; gaps and overlaps are rejected | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-GEO-S0` | `SAT-008` | 2/3/4 cross-sections, each supported geometry, reordered values and one invalid measurement | independent section-area calculations and arithmetic mean | `S0` and provenance match; recommendation state is retained; invalid measurements cannot produce a valid area | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-GAUGE-LENGTH` | `SAT-009`, `SAT-027` | proportional coefficients, non-proportional lengths and `A` suffix labels including collision/round-trip cases | independent label and formula implementation | `L0`, proportionality basis and `A` property identity round-trip without normalization to unsuffixed `A` | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-GAUGE-MARKING` | `SAT-009`, `SAT-027` | marking error at/inside/outside 1 percent; 5 mm rounding with difference below/equal/above 10 percent; unsafe mark and overlap pattern | independent boundary calculator and reviewed marking checklist | only permitted rounding/marking is accepted; manual `A` retains marking evidence and exact rejection reason | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-GAUGE-EXTENSOMETER` | `SAT-009`, `SAT-010` | `Le/L0` and `Le/Lc` below/equal/above guidance values; yield/proof/max-force property sets; missing extensometer | independently reviewed guidance/applicability matrix | mandatory extension-dependent properties block without valid `Le`; guidance deviations are explicit, not silently hard-failed | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-MET-DIMENSIONAL` | `SAT-008`, `SAT-010` | current/range-compatible calibration, expired/missing/wrong-range calibration and traceability-chain variants | independent calibration-eligibility table | only eligible devices contribute to `S0`; calibration and traceability IDs persist | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-MET-FORCE` | `SAT-010` | ISO 7500-1 class 0.5/1/worse, correct/wrong range, current/expired/missing evidence | independent metrology eligibility table | class 1 or better in the used range is eligible; every other variant blocks affected ISO results | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-MET-EXTENSOMETER` | `SAT-009`, `SAT-010` | class 0.5/1/2/worse, extension below/equal/above 5 percent, proof/other property, correct/wrong range | independent property-by-class eligibility table | proof properties require class 1 or better; class 2 is admitted only for the traced conditional path | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-PROC-ZERO` | `SAT-012` | correct sequence plus zero-before-train, zero-after-both-gripped and mid-test zero-change variants | independent state-machine sequence oracle | only correct ordering is accepted; zero identity/time is immutable and no silent offset correction occurs | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-PROC-GRIPPING` | `SAT-012` | supported/unsupported grip, aligned/misaligned, preload below/equal/above 5 percent, correction present/missing | independent procedural checklist and preload arithmetic | exact eligibility/warning/block state; preliminary-force correction and alignment evidence retained | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Rate-control variants

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `IAT-RATE-METHOD-SELECTION` | `SAT-013`, `SAT-014`, `SAT-015` | A1/A2/B and foreign/undeclared method; ISO default and pinned product-standard override | reviewed control-mode and source-override matrix | only a declared eligible mode/rate source is armed; every override retains governing source and values | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-A-CONTROL` | `SAT-013`, `SAT-033` | A1 feedback, A2 open loop, unavailable feedback, Annex-F selected/unselected, continuous/discontinuous/necking curves | independent controller-state oracle and formula-2 calculator | selected controller/source is correct for each phase; no silent fallback; Annex F remains explicit/informative | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-A-PROPERTY` | `SAT-013` | each applicable property and phase; exact target, tolerance edges, just outside, controller source and pre-yield threshold | independent time-series band checker keyed to reviewed parameters | required rate is maintained across the full property interval; every deviation/transition has exact evidence | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-A-POSTYIELD` | `SAT-013` | Ranges 2/3/4, `Rm`-only and multi-property paths, unit conversion for Range 4 | independent interval checker and unit conversion | only permitted post-yield paths pass; `0.0067 s-1` and displayed `0.4 min-1` remain traceably related | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-A-TRANSITION` | `SAT-013`, `SAT-040` | abrupt/gradual transitions with controlled synthetic curves around `Rm`, `Ag`, `Agt` | independent before/after discontinuity and property-impact analysis | distortive transitions are rejected/invalidated; gradual transition and actual-rate series are retained | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-B-ELASTIC` | `SAT-014` | modulus below/equal/above 150000 MPa; Table-3 rate minima/maxima and just outside; attempted closed-loop force control | independent table lookup and interval checker | correct band and crosshead command are used only in elastic region; maximum is never exceeded | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-B-YIELD` | `SAT-014` | `ReH` only, `ReL` only, both; direct strain control available/unavailable; exact and outside ReL bounds | independent phase state machine and band checker | `ReL` conditions govern combined tests; controls remain fixed through yielding where required | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-B-PROOF` | `SAT-014` | `Rp`/`Rt`, Table-3 bands, strain at/below/above 0.0025 s-1 and early control change | independent elastic/proof interval checker | crosshead setting remains through property detection and proof strain ceiling is enforced | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-B-POSTYIELD` | `SAT-014` | multi-property and `Rm`-only paths at/below/above 0.008 s-1 | independent time-series ceiling checker | no sample interval in the governed phase exceeds the reviewed ceiling; actual rates remain reportable | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `IAT-RATE-DESIGNATION` | `SAT-015`, `SAT-037` | A phase combinations including `A224`, B with explicit `30`, unsuffixed B, invalid >3 A characters and mismatch to actual series | independent parser/serializer plus actual-rate manifest | designation round-trips and agrees with actual selected/effective phases; mismatches and omissions block release | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **30**.
- Every linked atomic source item must exercise its assigned variant; a variant-level pass cannot hide an unexecuted linked item.
- Numeric variants remain `BLOCKED` until the referenced parameter is independently reviewed.
- None of these variants has serialized fixtures, production VB.NET code, independent oracle output or execution evidence yet.
