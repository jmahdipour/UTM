---
project: Universal Testing Machine (UTS)
document: SCIENTIFIC_ACCEPTANCE_TESTS
version: 1.0
status: FROZEN
governing_edr: EDR-0014
last_revision: 2026-08-09
---

# Scientific Acceptance Tests

No test below is passed by documentation alone. Detailed variants, execution rules, independent oracles and expected evidence are defined in `TEST_CASE_SPECIFICATIONS.md`; fixture admission and evidence contracts are defined in `TEST_FIXTURE_CATALOG.md`. `CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN` means executable evidence does not yet exist.

| Test | Acceptance criterion | Current result |
|---|---|---|
| `SAT-001` | two Methods pinned to different source/algorithm revisions reproduce their own unchanged result bundles | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-002` | ISO, ASTM and derived profiles reject cross-profile parameters and never share report claims | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-003` | Arm fails on an incomplete snapshot; post-Arm edits cannot change the active snapshot | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-004` | identical raw/snapshot/algorithm input replays deterministically and creates revision lineage without overwrite | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-005` | NaN, infinity, gaps, duplicates, order errors, stale/saturated/range faults produce declared quality outcomes | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-006` | all Clause 4 quantities reject incompatible units and retain source/canonical/display provenance | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-007` | supported and unsupported specimen shape/dimension combinations resolve deterministically | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-008` | independent geometry cases for flat, round, tube and applicable section profiles reproduce `S0` | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-009` | invalid/missing `L0` or `Le` blocks only the properties that require it with stable reasons | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-010` | expired/wrong-class force or extensometer evidence blocks affected properties and Arm where required | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-011` | in-range and out-of-range temperature cases produce the required record/assessment state | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-012` | incorrect force zero or gripping/alignment evidence is rejected or qualified without silent toe removal | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-013` | Method A simulator scenarios prove every rate stage, transition, tolerance and actual-rate record | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-014` | Method B simulator scenarios prove every rate stage, transition, tolerance and actual-rate record | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-015` | report designation is generated from actual selected conditions and exposes every deviation | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-016` | analytical force/extension datasets reproduce engineering stress/strain and rate series with exact provenance | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-017` | continuous yield, discontinuous yield, no-work-hardening, plateau and multi-peak cases produce correct `Fm/Rm` or applicability state | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-018` | independent discontinuous-yield datasets reproduce `ReH` and its source point | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-019` | transient/noisy yield datasets reproduce `ReL`; shortened procedure is separately evidenced | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-020` | parameter sweep for `Rp{x}` reproduces intersections, no-intersection states and hysteresis-origin cases | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-021` | parameter sweep for `Rt{x}` reproduces intersections and no-intersection states | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-022` | `Rr{x}` load-hold-unload scenarios return correct pass/fail and permanent-set evidence | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-023` | both selected `Ae` constructions reproduce independent results and record the chosen method | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-024` | `Ag` cases cover ordinary maximum and plateau midpoint and expose `Delta Lm`, `Rm`, `mE` | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-025` | `Agt` cases cover ordinary maximum and plateau midpoint | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-026` | qualified and ambiguous fracture datasets produce correct `At` or explicit invalidity | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-027` | manual/extensometer `A` paths cover fracture position, range loss, low elongation and agreed conversion | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-028` | independent `S0/Su` geometry cases reproduce `Z` and reject invalid post-fracture measurements | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-029` | Annex J `Awn` is unavailable by default and reproducible only when explicitly selected | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-030` | complete separation, early break, unload, communication loss and noise do not create a false fracture event | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-031` | Annex A interpolation, sampling and software-validation cases reproduce point/property results within declared tolerances | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-032` | Annex B-E specimen-profile boundary tables are covered by generated valid/invalid cases | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-033` | Annex F estimator is opt-in, labelled informative and never silently replaces measured strain control | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-034` | Annex G eligible reference datasets reproduce `E`; ineligible equipment/procedure/data blocks `E` | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-035` | fit range, count, `R2`, `Sm`, `Sm(rel)` and `E` match an independent regression; `mE` remains distinct | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-036` | uncertainty budgets reproduce independent examples and retain method, components, coverage and confidence | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-037` | a released ISO result bundle contains every applicable Clause 22/G.8 field and no report-time recalculation | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-038` | every graph marker resolves bidirectionally to its stored property/event and exact sample range | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-039` | non-applicable/invalid curves never return zero, NaN, empty or fabricated property values | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-040` | UI decimation/zoom/smoothing changes pixels only; declared analytical processing creates a new revision | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-041` | automatic and corrected points coexist; operator reason/identity is audited and prior result bytes remain unchanged | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-042` | analytical monotonic curves reproduce `ln(1+e)` and uniform-region true stress across unit/culture cases | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-043` | closed-form and high-resolution reference curves verify cumulative/interval energy and integration-bound behavior | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-044` | post-neck conversion is truncated/qualified without local area and enabled only with validated local-area input | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `SAT-045` | complete corpus passes production and independent implementations, regression tolerances and signed scientific review | CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Completion rule

Scientific completion requires all 45 results to be `PASS` for the released profile and algorithm revision. A skipped applicable test is a failure. A `PASS-DOC` result cannot close a numerical or procedural test.
