---
project: Universal Testing Machine (UTS)
document: SCIENTIFIC_COMPLETION_SPECIFICATION
version: 1.0
status: FROZEN
governing_edr: EDR-0014
implementation_status: PENDING-CODE
last_revision: 2026-08-09
---

# Scientific Completion Specification

## Corrected definition

Scientific completion is not the presence of a stress-strain chart and a few scalar outputs. It is the demonstrated ability to reproduce every applicable property, point, procedure and validity decision of the selected controlled standard revision from immutable measurement evidence.

For v1, the scope is:

- complete ISO 6892-1:2019 tensile analysis, including its normative Annex G modulus procedure;
- a revision-isolated ASTM E8/E8M profile, initially limited to controlled revision 15a until another licensed revision is supplied and traced;
- derived engineering analysis for logarithmic strain, true stress and energy;
- deterministic re-analysis, quality, uncertainty, graph annotation, report evidence and independent verification.

The architecture and scope are Frozen. The engine is not yet implemented and no conformity claim is permitted.

## Source and profile boundaries

| Profile | Governing source | Status |
|---|---|---|
| `ISO6892_1_2019AnalysisProfile` | `REF-STD-ISO-6892-1-2019` | Full scope Frozen; family routing complete; atomic source-item coverage and implementation pending |
| `ASTME8E8M_15aAnalysisProfile` | `REF-STD-ASTM-E8-E8M-15A` | Separate historical revision; detailed implementation pending |
| `DerivedEngineeringAnalysisProfile` | documented equations plus `REF-SCI-ASM-TENSILE-2004` | Non-conformity engineering results; implementation pending |

The ASTM profile may be upgraded only by adding a separately versioned profile after a controlled edition is supplied and a difference review is approved. An existing Method remains pinned to its original edition.

## Required scientific stages

| Stage | Required outcome |
|---|---|
| 1. Snapshot | Immutable Method, profile, source edition, geometry, calibration, channel binding, rate and algorithm identities |
| 2. Measurement validation | Ordered finite samples with unit, time, range, saturation, gap, stale and synchronization quality |
| 3. Geometry | Valid `S0`, `L0`, `Le` and specimen-specific inputs; `Su`/`Lu` when post-fracture properties require them |
| 4. Canonical series | Force, extension, engineering stress/strain and rate series with source provenance |
| 5. Declared processing | Versioned filter/resampling/interpolation only when the Method/profile permits it; untouched raw evidence retained |
| 6. Landmark detection | Yield, elastic range, maximum force, uniform-work-hardening transition, necking/fracture and property intersections |
| 7. Standard properties | Every applicable ISO or ASTM property calculated by the selected isolated profile |
| 8. Derived properties | Logarithmic strain, true stress and energy with validity limits and no conformity mislabelling |
| 9. Quality/uncertainty | Applicability, fit quality, uncertainty, warnings, invalidity and stable reason codes |
| 10. Publication | Immutable Analysis Revision, graph markers, result bundle and report-ready evidence |

## ISO 6892-1:2019 property and point catalog

| Family | Mandatory capabilities |
|---|---|
| Specimen geometry | All applicable flat, round, wire, bar, section and tube inputs from Clauses 6-8 and normative Annexes B-E; `S0`, `Su`, `L0`, `Le`, `Lc`, `Lt`, `Lu`, proportional-gauge coefficient and related dimensions |
| Test conditions | Temperature evidence, force zero, gripping/alignment evidence, Method A strain-rate controls, Method B stress-rate controls and condition designation |
| Force/stress | Force and engineering stress series, `Fm` and `Rm`, including discontinuous-yield and maximum-force plateau rules |
| Yield | `ReH` and `ReL` with transient rejection, applicability rules and every detected graph coordinate |
| Proof/permanent-set | Parameterized `Rp{x}`, parameterized `Rt{x}` and parameterized `Rr{x}` verification; Rp hysteresis-origin method when applicable |
| Extensions | `Ae` by the applicable horizontal/minimum or regression construction; `Ag`, `Agt`, `At`, `A`; `Delta Lm` and `Delta Lf` |
| Fracture/area | Fracture event and criteria, `Lu`, `Su`, `Z`, fracture-location validity and special elongation handling |
| Optional ISO guidance | `Awn` when Annex J is selected; Annex F crosshead-rate estimation and Annex H/I special elongation workflows |
| Elastic evaluation | `m`, `mE`, Annex G `E`, evaluation bounds `R1/R2` or `e1/e2`, evaluated point count, coefficient of determination `R2`, `Sm` and `Sm(rel)` |
| Uncertainty/report | Clause 23/Annex K uncertainty evidence, Annex G uncertainty, all Clause 22 and G.8 report data and used procedures |

Not every specimen legitimately produces every property. The engine proves complete coverage by producing the correct value when applicable and the correct `NotApplicable` or `Invalid` decision with a reason when it is not.

## ISO graph-landmark registry

"All points" includes the construction and boundary points represented by the standard's figures, not only the final scalar values.

| ISO figure | Required point/behavior coverage |
|---:|---|
| 1 | elastic/plastic/total extension boundaries at maximum force and fracture; `Ag`, `Agt`, `At`, `A`, `Rm`, `Delta Lm` and `Delta Lf` relationships |
| 2 | upper/lower yield points for every illustrated curve family, including cases where a lower yield point or a valid yield phenomenon is absent |
| 3 | parameterized plastic-offset line, elastic-slope line and `Rp{x}` intersection |
| 4 | parameterized total-extension ordinate and `Rt{x}` intersection |
| 5 | load, hold, unload and permanent-set verification points for `Rr{x}` |
| 6 | hysteresis loop, corrected origin, reconstructed parallel line and alternative `Rp{x}` intersection |
| 7 | `Ae` start/end boundaries for horizontal-line and regression constructions, including last local minimum and start of uniform work-hardening |
| 8 | `Rm` for continuous/discontinuous-yield curve families and the special case where `Rm` is undefined |
| 9 | every Method A/Method B control interval, transition and property group affected by the rate stage |
| 10 | inadmissible stress-strain discontinuity and its effect on `Rp`, `Rm`, `Ag` and `Agt` validity |
| 11-15 | geometric dimensions and measurement points for rectangular, unmachined, round and tube specimen families |

Each landmark is stored even when it is only an intermediate construction. It carries an ID, X/Y coordinates, source sample or interpolation bracket, detector/construction rule, quality and Analysis Revision. Interpolation is explicit; it does not replace the neighboring measured samples.

## Derived true curves and energy

Engineering strain must be stored as a dimensionless ratio internally even when displayed as percent. In the uniform-deformation region:

\[
\varepsilon_{ln}=\ln(1+e)
\]

\[
\sigma_{true}=\sigma_{eng}(1+e)
\]

The engine must provide separate engineering and true-curve cumulative integrals using a declared deterministic quadrature rule:

\[
W_{eng}=\int \sigma_{eng}\,de,\qquad
W_{true}=\int \sigma_{true}\,d\varepsilon_{ln}
\]

Required selectable intervals are origin/preload-corrected start to yield, `Fm/Rm`, necking onset and fracture, plus an arbitrary audited marker interval. Each energy result records integration bounds, curve/revision, sample range, algorithm, unit and validity. Energy density is represented canonically in `J/m^3` (numerically equivalent to Pa); any specimen-energy result in joules additionally requires a declared deforming volume model.

Elastic, plastic, resilience and toughness labels require explicit definitions in the analysis profile. The software must not infer a single universal split from a graph label.

Simple converted true stress stops being a local true-stress measurement after necking. Continuation beyond necking requires validated instantaneous local-area measurements; otherwise the post-neck series is truncated or explicitly marked estimated/invalid beyond necking.

## Result and point contract

Every calculated property or detected point must expose:

- stable property/point ID and human-readable symbol;
- numeric value and canonical/display unit, or explicit absence;
- X/Y graph coordinate and exact source sample/range;
- selected standard/profile, edition and clause or engineering formula reference;
- algorithm and parameter revision;
- geometry, calibration, Method and Analysis Revision identities;
- applicability, quality state, uncertainty and reason codes;
- automatic result and any separately revisioned operator correction.

Allowed terminal result states are `Valid`, `Warning`, `Invalid` and `NotApplicable`. `Estimated` is an additional qualification, not permission to label an estimate as measured. Live values remain `Provisional` until finalization.

## Validation corpus

Scientific validation requires all of the following:

- analytically generated curves with known intersections and integrals;
- licensed/approved Golden Datasets covering each applicable ISO property family;
- independent calculations that do not reuse the production algorithm;
- no-yield, discontinuous-yield, plateau, multi-peak, noise, early-fracture and missing-intersection curves;
- missing, duplicated, out-of-order, stale, saturated and gapped samples;
- unit and scale tests, including preserved kgf provenance and canonical newton conversion;
- flat, round, tube, wire and other applicable geometry boundary cases;
- extensometer removal/range loss, fracture outside gauge length and invalid post-fracture measurement cases;
- deterministic replay and cross-culture numeric/rounding tests;
- comparison of automatic and audited manual-point revisions;
- uncertainty, report-field and standard-edition isolation tests.

Golden Dataset agreement alone is insufficient. Each algorithm needs boundary, invalidity and metamorphic tests as well as an independent review.

## Exit gates

| Gate | Exit evidence |
|---|---|
| `SG-01 Source Control` | exact controlled source identity, edition and hash registered |
| `SG-02 Clause Traceability` | every applicable normative condition/table/formula mapped to an atomic source-item, `SCI-*` family, `SAT-*` variant and reviewed profile parameter |
| `SG-03 Input Integrity` | immutable raw, validation, geometry, units and channel-quality tests pass |
| `SG-04 ISO Algorithms` | all applicable ISO points/properties and not-applicable paths pass |
| `SG-05 Derived Analysis` | true-curve and energy algorithms pass with post-neck limits enforced |
| `SG-06 Quality and Uncertainty` | regression quality, uncertainty and reason-code tests pass |
| `SG-07 Re-analysis` | deterministic revisioning and manual correction preserve prior evidence |
| `SG-08 Reporting` | graphs and reports reproduce the same immutable results and provenance |
| `SG-09 Independent Verification` | independent calculation and scientific review signed |
| `SG-10 Closure` | all v1 `SCI-*`/`SAT-*` pairs are `PASS`; no scientific TODO remains |

Failure of any gate means the implementation remains scientifically incomplete.
