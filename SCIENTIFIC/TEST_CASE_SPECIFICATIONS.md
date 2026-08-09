---
project: Universal Testing Machine (UTS)
document: SCIENTIFIC_TEST_CASE_SPECIFICATIONS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
last_revision: 2026-08-09
---
# Scientific Test Case Specifications

## Status and terminology

This document turns each `SAT-*` acceptance criterion into a reproducible test design. Current state for every case is `CASE-SPECIFIED / FIXTURE-PENDING / NOT-RUN`. This means the preconditions, variants, execution rule, oracle and expected result are defined, but serialized fixtures, automation and execution evidence do not yet exist.

A case may become `PASS` only when every applicable variant passes against the pinned profile/algorithm revision. Documentation review alone cannot produce `PASS`.

## Common execution protocol

Unless a case explicitly replaces a step, its runner shall:

1. verify the test-case definition, fixture manifest and controlled-input hashes;
2. create a clean isolated store, deterministic clock and immutable Run Configuration Snapshot;
3. execute the production path through its public Application/Core contract, never by calling private detector helpers;
4. repeat with identical inputs and, for numerical cases, under invariant plus at least one comma-decimal culture;
5. calculate expected results using the independent oracle identified by the fixture manifest;
6. compare value, unit, state, reason code, point coordinates, sample bracket/range and revision provenance;
7. verify that raw evidence, prior Analysis Revisions and released result bytes were not changed;
8. retain the evidence package required by `TEST_FIXTURE_CATALOG.md`.

Numerical comparison uses the tolerance declared by the test manifest and approved for that property/source. Exact identities, states, reason codes, sample IDs, hashes, unit codes and revision links use exact comparison. A missing tolerance authority is a blocked test, not permission to choose a convenient tolerance.

## Profile, snapshot and input integrity

| Test | Required variants and inputs | Execution and independent oracle | Expected result and retained evidence |
|---|---|---|---|
| `SAT-001` | two immutable Method snapshots that differ only by source/profile or algorithm revision; one shared valid raw series | execute each snapshot twice, then re-run the older snapshot after registering the newer profile; compare with revision-specific oracle manifests | each revision reproduces its own byte-stable result bundle; no registry update changes a prior result; source, profile and algorithm IDs are present |
| `SAT-002` | ISO, ASTM inch-pound, ASTM SI and Derived profiles; valid and foreign parameters/properties for each | submit the Cartesian profile/parameter/property matrix through the public validation contract | owned inputs are accepted; every foreign input/claim is rejected with the profile-boundary reason; ASTM unit systems never mix and Derived results carry no ISO/ASTM conformity label |
| `SAT-003` | complete snapshot plus variants missing geometry, channel binding, calibration, rate, profile or algorithm identity | request Arm for each variant; Arm the complete snapshot, then mutate the draft Method and execute | incomplete variants fail before motion with field-specific reasons; the armed snapshot is unchanged by later draft edits; snapshot hash is retained |
| `SAT-004` | valid raw chunks and snapshot; replay request repeated, interrupted and resumed | execute initial analysis, identical replay and a new declared algorithm revision; compare hashes and lineage graph | identical inputs/revision produce identical scientific fields; a new revision has a new identity and parent link; no raw/prior result row or bytes are overwritten |
| `SAT-005` | `FX-MEAS-QUALITY` baseline plus every corruption operator and approved pairs | feed each stream through measurement validation before analysis; compare affected-property map with independent quality-policy table | exact quality/reason codes are emitted; blocking scope is correct; unaffected channels/properties remain available; no non-finite numeric result escapes |
| `SAT-006` | one valid and one incompatible unit for every supported Clause 4 quantity; N/kgf and percent/ratio round trips | construct, serialize, deserialize and calculate through typed quantity contracts; compare with dimensional-analysis oracle | compatible conversions match exactly or within declared conversion tolerance; incompatible units fail; source/canonical/display values and unit codes survive round trip |

## Geometry, apparatus and test procedure

| Test | Required variants and inputs | Execution and independent oracle | Expected result and retained evidence |
|---|---|---|---|
| `SAT-007` | every supported specimen family at nominal and boundary dimensions plus unsupported shape/dimension combinations | resolve specimen profile and requested properties from the selected standard profile | exactly one eligible profile is selected or a stable ambiguity/unsupported reason is returned; no nearest-profile fallback occurs |
| `SAT-008` | `FX-GEO-FLAT`, `FX-GEO-ROUND`, `FX-GEO-WIRE-SECTION` and `FX-GEO-TUBE` valid measurement sets | calculate `S0` through production geometry service and separate formula/table oracle | value/unit and contributing dimensions agree; measurement provenance and profile/table identity are retained; invalid geometry yields no `S0` number |
| `SAT-009` | valid, missing, zero, negative, inconsistent and out-of-profile `L0`/`Le`; properties with and without gauge-length dependency | validate snapshot and request the full property catalog | only dependent properties are blocked with the correct reason; valid lengths bind to the exact extension/elongation results; no Stroke fallback replaces `Le` |
| `SAT-010` | `FX-MET-FORCE` and `FX-MET-EXT` valid/expired/missing/wrong-class/wrong-range cases | resolve metrology eligibility at Arm and again for requested result publication | Arm/publication behavior matches the controlled eligibility matrix; affected results cite calibration identity/range; unrelated results are not silently discarded |
| `SAT-011` | `FX-ENV-TEMP` inside, on and outside each selected profile boundary; missing temperature evidence | execute eligibility and report-input generation | measured value, unit, timestamp and boundary decision are retained; deviations have explicit assessment state; no false in-range claim is generated |
| `SAT-012` | qualified and failed/missing force-zero, gripping and alignment evidence; a curve containing a visible toe | run preparation validation and analysis with display toe correction both disabled and enabled | failed required preparation blocks/qualifies according to profile; raw curve is unchanged; display or declared analytical correction is visible, versioned and never silently applied |
| `SAT-013` | `FX-PROC-RATE-A` covering each configured stage, boundary transition, actual rate inside/on/outside limits, Extensometer loss and fallback request | execute with deterministic Simulator and derive actual-rate records independently from timestamps/extension | every commanded and actual stage is evidenced; out-of-band or unapproved fallback is detected; affected property validity and condition designation match the profile |
| `SAT-014` | `FX-PROC-RATE-B` covering elastic-stage stress rate, transitions, inside/on/outside limits and attempted post-elastic misuse | execute with deterministic Simulator; independently derive stress rate from force, `S0` and time | valid stages pass; post-elastic or out-of-band use is rejected/qualified; no Method A/B substitution occurs |
| `SAT-015` | all supported testing-condition designations plus actual deviations, controller transitions and fallback failures | generate report evidence only from finalized run records | designation matches actual selected/effective conditions; every deviation is present; changing a report template cannot change the designation |

## Canonical series and ISO landmarks

| Test | Required variants and inputs | Execution and independent oracle | Expected result and retained evidence |
|---|---|---|---|
| `SAT-016` | `FX-ANA-ELASTIC` in N, kgf and alternate length display units; irregular-time variant | calculate force, extension, engineering stress/strain and declared rates | series values agree with independent formulas; engineering strain is a ratio internally; every derived sample links to exact source samples and conversions |
| `SAT-017` | continuous, discontinuous, plateau, multi-peak and no-work-hardening fixtures | request `Fm/Rm`; independently apply the profile-specific eligible-region and plateau policies | correct point/range and `Rm = Fm/S0` are returned when applicable; undefined cases return no number and the exact applicability reason |
| `SAT-018` | discontinuous-yield fixtures with ordinary first decrease, interpolated decrease, noise before yield and no decrease | run upper-yield detector; compare with enumerated landmark oracle | `ReH` and its force/stress coordinate, source sample or bracket and first-decrease evidence match; absent cases do not fabricate `ReH` |
| `SAT-019` | lower-yield fixtures with initial transient, several local minima, shortened-procedure selected/not selected and no valid region | run lower-yield detector; compare eligible candidate set and selected minimum | selected `ReL`, excluded transient samples and procedure identity match; invalid/NotApplicable reason is stable when no eligible point exists |
| `SAT-020` | `FX-ANA-RP` parameter sweep including multiple requested offsets, exact-sample/interpolated intersections, no intersection and hysteresis-origin cases | calculate intersections in production and with closed-form or separate high-precision line/curve oracle | value, offset, slope/origin construction, intersection coordinate and bracket match; no-intersection has no numeric default; hysteresis use is explicit |
| `SAT-021` | `FX-ANA-RT` parameter sweep with exact, interpolated, outside-domain and non-monotonic ambiguous variants | calculate total-extension intersection and compare with independent curve evaluator | correct `Rt{x}` or explicit invalid/no-intersection result; requested suffix/parameter and bracket are retained |
| `SAT-022` | `FX-ANA-RR` below, exactly on and above requested permanent set; load-hold-unload timing and incomplete unload variants | execute procedure and independently evaluate residual extension after qualified unload | pass/fail boundary is correct; load/hold/unload points, requested suffix and residual evidence are retained; incomplete procedure is Invalid, not a guessed strength |
| `SAT-023` | discontinuous-yield fixtures for each permitted selected `Ae` construction, exact/interpolated bounds, noisy and no-uniform-hardening variants | run each construction separately and compare with enumerated/independent regression landmark oracle | start/end coordinates, `Ae`, method identity and sample ranges match; methods never switch silently; inapplicable curves return explicit state |
| `SAT-024` | ordinary maximum, plateau, multi-peak and missing-slope variants | calculate `Ag` and dependencies; independently evaluate selected maximum point, `Delta Lm`, `Rm` and `mE` construction | all values and common point identity agree; plateau policy is evidenced; missing required slope blocks/qualifies `Ag` without converting `mE` to Annex G `E` |
| `SAT-025` | ordinary maximum, plateau, multi-peak and extensometer-range-loss variants | calculate `Agt` and compare with independent total-extension value at qualified maximum | value, point/range and plateau selection match; loss before the point blocks the result with no Stroke fallback |
| `SAT-026` | qualified complete separation, interpolated fracture interval, ambiguous drop, Extensometer removal and truncation before fracture | calculate `At` only from a qualified fracture event and compare with independent `Delta Lf/Le` evaluation | correct value and fracture interval are retained when eligible; ambiguous/missing extension returns explicit Invalid/NotApplicable state |
| `SAT-027` | `FX-GEO-POSTFRACTURE` manual and qualified Extensometer paths; valid/invalid fracture location, low elongation and selected conversion procedure | calculate each selected path independently and compare method-specific evidence | `A`, `Lu`, `L0`, fracture-location decision and conversion identity match; methods do not mix; invalid measurements cannot be released as zero |
| `SAT-028` | valid flat/round/tube `S0/Su` cases plus zero, negative, larger-than-`S0`, wrong-location and wrong-geometry `Su` | calculate `Z` and compare with independent area oracle | valid percentage and units agree; source dimensions are retained; impossible or ineligible post-fracture measurements produce no value and stable reasons |
| `SAT-029` | Annex J option absent, enabled with eligible long-product fixture, and enabled with ineligible geometry | request `Awn` across variants and compare with separately reviewed optional-method oracle | property is unavailable by default; eligible explicit selection reproduces expected value/evidence; ineligible use is rejected and remains labelled informative |
| `SAT-030` | `FX-ANA-FRACTURE` complete separation, early break, unload, false force drop, noise, communication loss and end-of-file truncation | run versioned detector and independent event classifier | only qualified separation creates fracture; event carries full source interval and rule revision; ambiguous cases are Warning/Invalid and never silently accepted |

## Computer control, specimen catalogs and modulus

| Test | Required variants and inputs | Execution and independent oracle | Expected result and retained evidence |
|---|---|---|---|
| `SAT-031` | analytical landmarks placed on samples and between samples; low/high sampling, allowed/disallowed interpolation and software-reference datasets | execute full computer-controlled path, not private functions; compare against independent high-resolution oracle and profile tolerances | interpolation/sampling policy, brackets and deviations are explicit; each property stays within its approved tolerance; any unsupported processing blocks the claim |
| `SAT-032` | generated boundary sets for every controlled Annex B-E profile/table row and each relevant dimensional relation | resolve and validate all generated valid, exact-boundary and just-invalid instances | complete generated-case manifest has no unmapped row; valid cases select the correct profile; invalid cases return the exact violated constraint with no nearest-profile coercion |
| `SAT-033` | Annex F option absent/present, eligible/ineligible stiffness inputs and measured-strain control available/unavailable | execute estimator and controller selection separately | estimator is opt-in and informative; inputs/formula revision are retained; its result never masquerades as measured strain or silently replaces the selected controller |
| `SAT-034` | `FX-ANA-REGRESSION` plus eligible/ineligible force/extensometer class, fixture alignment, rate, sampling and evaluation-range cases | execute Annex G profile from full snapshot; compare `E` with independent regression | eligible data reproduce approved `E`; each failed prerequisite blocks `E` with a specific reason; `mE` is not substituted |
| `SAT-035` | exact linear, perturbed, insufficient-point, constant-X and range-boundary regression fixtures | compare production outputs with separately implemented high-precision regression and quality calculations | evaluation bounds, included sample IDs/count, `E`, coefficient of determination, `Sm` and `Sm(rel)` agree; degenerate fits are Invalid and contain no non-finite outputs |
| `SAT-036` | independently reviewed Type A, Type B and combined uncertainty budgets; missing/correlated/invalid component variants | calculate through versioned uncertainty engine and separate reviewed worksheet/script oracle | component values, distributions, sensitivity, combination, coverage/confidence and reported uncertainty match; incomplete budgets are qualified and never silently zero-filled |

## Publication, state, re-analysis and derived engineering

| Test | Required variants and inputs | Execution and independent oracle | Expected result and retained evidence |
|---|---|---|---|
| `SAT-037` | finalized ISO result bundles with all combinations of applicable and non-applicable Clause 22/Annex G.8 fields | validate and render two different report templates from the same bundle | required-field matrix passes; non-applicable fields carry states/reasons; both templates use identical stored scientific values and perform no recalculation |
| `SAT-038` | result bundle containing measured, interpolated, range-based and manually corrected landmarks | navigate result-to-marker and marker-to-result through stored contracts | every link is bidirectional and exact; coordinate, source sample/bracket/range, method, quality and Analysis Revision agree; no marker exists only in UI state |
| `SAT-039` | no-yield, no-hardening, no-intersection, invalid geometry, missing channel and corrupt-data fixtures | request complete property catalog and serialize/export it | each unavailable property uses an allowed terminal state plus reason and absent numeric value; no zero, empty numeric string, NaN or infinity represents failure |
| `SAT-040` | one valid raw series; multiple chart decimation, zoom and display-smoothing settings; one explicitly declared analytical-processing revision | analyze before/after visual changes, then create declared processing revision | visual changes leave result bundle hash unchanged; analytical processing creates a new revision with parameters and raw lineage; display points are rejected as analysis input |
| `SAT-041` | automatic landmark/result plus authorized and unauthorized correction attempts, missing reason, repeated correction and correction reversal | execute correction through Application authorization/audit path | unauthorized/incomplete attempts fail; accepted correction creates a child Analysis Revision; automatic/prior results remain queryable and byte-unchanged; actor/reason/time are audited |
| `SAT-042` | `FX-ANA-TRUE` including zero, positive uniform strain, unit/culture variants, `e <= -1`, and samples beyond declared uniform limit | calculate derived series and compare with independent high-precision logarithm/multiplication oracle | valid values match; engineering ratio is dimensionless; invalid logarithm domain is rejected; ISO result fields remain separate; uniform-limit provenance is retained |
| `SAT-043` | `FX-ANA-ENERGY-LINEAR` and `FX-ANA-ENERGY-PIECEWISE`; exact/interpolated/reversed/outside bounds and cumulative intervals | integrate with declared production quadrature and compare with closed-form/exact piecewise oracle | cumulative and interval energy, bound coordinates, curve/revision, sample range and `J/m^3` unit agree; invalid bounds fail; joule output is absent unless a volume model is supplied |
| `SAT-044` | true-curve data before/at/after necking without local area, with invalid local area and with validated instantaneous local area | execute conversion and validity policy; independently compare uniform conversion and local-area stress where eligible | simple conversion ends or is explicitly qualified at the declared limit; invalid/missing area cannot produce measured local true stress; validated area path retains sensor/calibration provenance |
| `SAT-045` | complete admitted analytical, Golden, boundary, corrupted, interlaboratory and independent-evidence corpus for one release candidate | run production suite and separately owned implementation/review; compare signed corpus manifest and all result diffs | every applicable case passes approved tolerances; no skipped applicable variant or undocumented exclusion; production and independent evidence hashes plus scientific sign-off close the gate |

## Required test result record

Each `SAT-*` result shall contain:

- case and case-revision ID;
- all executed variant/fixture IDs and hashes;
- production build, profile, algorithm and schema revisions;
- start/end time, culture and x86 runtime identity;
- per-assertion expected/actual/tolerance and pass/fail;
- result-bundle and independent-oracle hashes;
- retained evidence location;
- overall result: `PASS`, `FAIL`, `BLOCKED`, or `NOT-RUN`;
- blocker or failure reason without manual result override.

An applicable variant not executed makes the case `BLOCKED` or `FAIL`; it cannot be marked `PASS`.
