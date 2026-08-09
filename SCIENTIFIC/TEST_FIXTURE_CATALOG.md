---
project: Universal Testing Machine (UTS)
document: SCIENTIFIC_TEST_FIXTURE_CATALOG
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
last_revision: 2026-08-09
---
# Scientific Test Fixture Catalog

## Purpose and present status

This catalog defines the inputs and independent-oracle contract required by the `SAT-*` cases. It does not contain production results and does not make a conformity claim. Serialized fixture files, production test code and independent calculation outputs remain pending.

Every future fixture instance shall have a manifest containing:

- stable fixture ID and revision;
- source class: analytical, controlled Golden, boundary, corrupted, procedural or metrology;
- profile and source edition, or the explicit label `NON-STANDARD-ANALYTICAL`;
- input units and canonical units;
- exact geometry, channel, calibration and Method snapshot identities;
- sample count, ordering, timestamps and quality flags;
- generation code/hash or controlled source file/hash;
- expected outputs, applicability states, reason codes and tolerances;
- oracle identity, oracle revision and reviewer identity.

No production algorithm may generate its own expected results. A production implementation and its independent oracle may share public input contracts, but may not share detector, regression, interpolation, integration or rounding code.

## Canonical analytical constants

The following constants are test data, not material claims or ISO limits:

| ID | Value | Purpose |
|---|---:|---|
| `C-E0` | `200000000000 Pa` | exact elastic slope for analytical curves |
| `C-S0` | `0.0001 m^2` | original cross-sectional area |
| `C-L0` | `0.05 m` | original gauge length |
| `C-Le` | `0.05 m` | extensometer gauge length |
| `C-DT` | `0.01 s` | uniform sample interval where a case does not override it |
| `C-KGF` | `9.80665 N/kgf` | exact conventional conversion already Frozen by EDR-0007 |

Standard-defined limits, specimen tolerances, rate bands, equipment classes and rounding rules shall not be copied from this table or invented in code. They are resolved from a reviewed profile-parameter record that cites the controlled source clause/table and edition.

## Analytical series families

| Fixture family | Deterministic definition | Independent expected result |
|---|---|---|
| `FX-ANA-ELASTIC` | ordered strain samples `e_i`; `sigma_i = C-E0 * e_i`; force is `sigma_i * C-S0`; extension is `e_i * C-Le` | zero intercept, exact slope `C-E0`, closed-form stress/strain and energy |
| `FX-ANA-BILINEAR` | elastic branch of slope `E0` followed by a continuous plastic branch of declared slope `H`, with `0 < H < E0` | branch intersection, offset-line intersection and piecewise closed-form integral |
| `FX-ANA-DISCONTINUOUS` | declared first peak, force decrease, lower-yield region, uniform work-hardening start, maximum-force region and fracture interval; all landmark sample IDs are listed in the manifest | exact enumerated `ReH`, eligible `ReL` candidates, `Ae` bounds and post-yield `Fm` candidate |
| `FX-ANA-PLATEAU` | maximum-force plateau with declared first/last sample and midpoint policy input | expected plateau bounds, selected midpoint and dependent `Rm`, `Ag`, `Agt` coordinates |
| `FX-ANA-NO-YIELD` | smooth monotonic curve without a discontinuous-yield event | `ReH/ReL/Ae = NotApplicable`; proof-strength properties remain independently testable |
| `FX-ANA-NO-HARDENING` | discontinuous-yield curve with no qualifying later work-hardening maximum | standard-profile applicability state for `Fm/Rm`; no fabricated numeric value |
| `FX-ANA-MULTIPEAK` | deterministic local maxima before and after the qualifying region | the profile-qualified maximum, never an arbitrary first/global peak |
| `FX-ANA-RP` | bilinear curve plus declared plastic offset `x`; offset line is `sigma = E0 * (e - x)` | closed-form line/curve intersection and bracketing sample IDs |
| `FX-ANA-RT` | continuous analytical curve plus declared total extension `x` | curve value at `e = x`, explicit interpolation bracket or no-intersection state |
| `FX-ANA-RR` | load, hold and unload sequence with declared permanent set below/equal/above the requested value | independent pass/fail plus unload and residual-extension evidence |
| `FX-ANA-FRACTURE` | ordered pre-fracture samples followed by a declared separation interval; variants include unload, early break and communication loss | qualified fracture interval or an explicit non-fracture/invalid state |
| `FX-ANA-TRUE` | positive engineering strains and stresses in the declared uniform region | `epsilon_ln = ln(1 + e)` and `sigma_true = sigma_eng * (1 + e)` calculated independently |
| `FX-ANA-ENERGY-LINEAR` | `sigma = K * e` on declared bounds | `W = K * (e_b^2 - e_a^2) / 2` |
| `FX-ANA-ENERGY-PIECEWISE` | continuous piecewise-linear curve with exact breakpoint coordinates | sum of exact trapezoid areas over complete and partial intervals |
| `FX-ANA-REGRESSION` | exact linear data and deterministic perturbed variants with declared residuals | independently calculated slope, intercept, evaluated count, coefficient of determination, `Sm` and `Sm(rel)` |

The `FX-ANA-DISCONTINUOUS`, `FX-ANA-PLATEAU` and fracture families are synthetic algorithm fixtures. They are not Golden evidence of conformity with a licensed standard until their expected landmark interpretations have been independently reviewed against the selected controlled edition.

## Geometry and specimen families

| Fixture family | Required variants | Expected outcome source |
|---|---|---|
| `FX-GEO-FLAT` | minimum, nominal, maximum and just-outside boundary dimensions for each supported flat profile | independent geometry formula plus controlled profile table |
| `FX-GEO-ROUND` | machined round and full-section round variants | independent area formula plus controlled profile table |
| `FX-GEO-WIRE-SECTION` | wire, bar, polygonal/section and unsupported-shape variants | controlled applicability table and independent area calculation |
| `FX-GEO-TUBE` | complete tube, longitudinal/transverse strip and machined wall specimen variants | independent tube/strip calculation plus controlled Annex E profile |
| `FX-GEO-POSTFRACTURE` | valid and invalid `Lu`/`Su`, fracture-location and reassembled-piece measurements | selected property procedure and stable validity reason |

Boundary generation shall use the exact reviewed value from the selected profile and create at least `limit - delta`, `limit`, and `limit + delta` cases in the native unit system. `delta` is chosen so that it survives canonical conversion and declared rounding.

## Measurement, metrology and procedure families

| Fixture family | Variants |
|---|---|
| `FX-MEAS-QUALITY` | finite baseline, `NaN`, positive/negative infinity, duplicate sample ID, duplicate timestamp, out-of-order timestamp, gap, stale, saturated, out-of-range and cross-channel skew |
| `FX-MET-FORCE` | correct class/range/current evidence; expired, missing, wrong-range and wrong-class evidence |
| `FX-MET-EXT` | correct class/range/current evidence; expired, missing, wrong-range, removed and saturated evidence |
| `FX-ENV-TEMP` | within-profile, exact-boundary and outside-profile temperatures with evidence identity |
| `FX-PROC-ZERO-GRIP` | qualified zero/gripping/alignment evidence and individually failed or missing variants |
| `FX-PROC-RATE-A` | each Method A stage, transition, permitted controller source and out-of-band/fallback variant |
| `FX-PROC-RATE-B` | each Method B stage, transition and out-of-band/fallback variant |
| `FX-PROC-REPORT` | applicable/non-applicable report fields, deviation records and edition/unit-system isolation |

## Corruption operators

Each valid series can be transformed by one operator at a time and by an approved pairwise set:

`DROP-SAMPLE`, `DUPLICATE-ID`, `DUPLICATE-TIME`, `REORDER`, `TIME-GAP`, `STALE`, `SATURATE`, `OUT-OF-RANGE`, `UNIT-MISMATCH`, `SCALE-X1000`, `NON-FINITE`, `TRUNCATE-BEFORE-POINT`, `REMOVE-EXTENSOMETER`, `FALSE-DROP`, `COMMUNICATION-LOSS` and `CULTURE-SWAP`.

The expected result is never merely "throws" or "does not crash". Each case declares whether Arm, the complete analysis, or only affected properties are blocked, and it declares the stable reason code and retained unaffected evidence.

## Controlled Golden and independent evidence

| Evidence family | Admission rule |
|---|---|
| `FX-GOLD-ISO` | licensed or owner-approved raw dataset; selected ISO edition; independently reviewed expected points and results; file/hash registered |
| `FX-GOLD-ASTM` | licensed or owner-approved raw dataset; exact E8/E8M edition and unit system; no ISO expected-result reuse |
| `FX-INTERLAB` | approved data derived from the intended use of ISO Annex L or another controlled interlaboratory source; provenance and use limitation recorded |
| `FX-INDEPENDENT` | result generated by a separately owned implementation or reviewed calculation workbook/script with no production algorithm reuse |

No row can reach `PASS` using only the synthetic fixtures when the row requires controlled Golden, interlaboratory or signed independent-review evidence.

## Evidence package emitted by a test run

Each execution shall retain:

1. test-case and fixture manifest hashes;
2. Method, profile, algorithm and Analysis Revision identities;
3. exact input sample/chunk hashes;
4. production result bundle bytes and hash;
5. independent-oracle result bytes and hash;
6. field-level comparison including tolerances and reason codes;
7. graph-marker/sample-range cross-links where applicable;
8. environment, culture, build and x86 process identity;
9. pass/fail result with no manual overwrite;
10. reviewer/signature evidence for gates that require it.
