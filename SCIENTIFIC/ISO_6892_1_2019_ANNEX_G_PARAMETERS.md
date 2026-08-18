---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_G_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex G

## Control rules

This register holds numeric values, formulas, table entries and report quantization extracted from normative Annex G. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. Mandatory limits, recommendations and example-only values remain distinct. `E`, `mE`, `SE`, `Sm`, `Sm(rel)`, `SX` and `SY` preserve separate identities.

## Equipment, specimen and procedure controls

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AG-FORCE-CLASS-MAX` | `class <= 1` | ISO 7500-1 class; inclusive maximum in relevant range | G.3.1.1; p.52; PDF 58 | better / equal / worse; missing, expired or wrong-range evidence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-EXTENSOMETER-CLASS-MAX` | `class <= 0.5` | ISO 9513 class; inclusive maximum in relevant range | G.3.1.2; p.52; PDF 58 | better / equal / worse; missing, expired or wrong-range evidence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-LE-RECOMMENDED-MIN` | `Le >= 50` | mm; recommended example, not an unconditional minimum | G.3.1.2 recommendation; p.53; PDF 59 | below / equal / above; recommendation retained/not converted to mandate | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-SYSTEM-DISCRETE-VALUES-MIN` | `count >= 50` | distinct measured values; inclusive mandatory minimum | G.3.1.3; p.53; PDF 59 | 49 / 50 / 51; duplicate quantization levels; missing range evidence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-DIMENSION-DEVICE-ERROR-MAX-EXCLUSIVE` | `abs(error) < 0.5` | percent of measured value; symmetric strict maximum | G.3.1.4; p.53; PDF 59 | below / equal / above on both signs; calibration and traceability absent/present | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-DIMENSION-MEASUREMENTS-MIN` | `count >= 3` | measurements per dimension; inclusive minimum | G.4.2; p.53; PDF 59 | 2 / 3 / 4 for every dimension; repeated-value identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-S0-ACCURACY-MAX` | `abs(error) <= 0.5` | percent; symmetric inclusive maximum or better | G.4.2; p.53; PDF 59 | below / equal / above on both signs; averaging and unit evidence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-RATE-RECOMMENDED-PROFILE` | `Method A / Range 1` | controlled rate-profile identity; recommendation | G.5.3.1; p.54; PDF 60 | recommended / permitted alternative / unsupported route; actual-rate record | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-EVALUATION-SAMPLES-MIN` | `N >= 50` | measured values in `R1-R2`; inclusive mandatory minimum | G.5.3.2; p.54; PDF 60 | 49 / 50 / 51; valid range membership; gaps/duplicates | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-REUSED-SPECIMEN-LOAD-FRACTION-MAX` | `Fmax <= 0.50 * expected(ReH or Rp0.2)` | dimensionless fraction; inclusive maximum for repeated use | G.5.3.3; p.54; PDF 60 | below / equal / above; wrong yield identity; expected value unavailable | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Sampling and regression formulas

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AG-G1-SAMPLING-FREQUENCY-FORMULA` | `f = N * E * eDot / (R2 - R1)` | `N` count; `E/R1/R2` in compatible stress units; `eDot` s^-1; output Hz | Formula G.1; p.54; PDF 60 | analytical values; `R2 > R1`; finite positive inputs; grouping and unit mutations | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G1-EXAMPLE-R1` | `R1 = 10` | MPa; steel example only | G.5.3.2 example; p.54; PDF 60 | exact example identity; not admitted as universal default | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G1-EXAMPLE-R2` | `R2 = 50` | MPa; steel example only | G.5.3.2 example; p.54; PDF 60 | exact example identity; range width and units | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G1-EXAMPLE-STRAIN-RATE` | `eDot = 0.00007` | s^-1; steel example only | G.5.3.2 example; p.54; PDF 60 | exact decimal and reciprocal-time unit; not a default rate | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G1-EXAMPLE-FREQUENCY-MIN-EXCLUSIVE` | `f > 18` | Hz; strict example boundary | G.5.3.2 example; p.54; PDF 60 | below / equal / above; derived minimum versus configured sampling frequency | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G2-REGRESSION-FORMULA` | `R = (E * e / 100%) + b` | `R/E/b` in MPa; `e` in percent | Formula G.2 and where list; p.55; PDF 61 | independent regression; percent scaling; intercept and symbol/unit mutations | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-R2-RECOMMENDED-MIN-EXCLUSIVE` | `R_squared > 0.9995` | dimensionless; recommended quality threshold and insufficient-quality example boundary | G.6.2; p.55; PDF 61 | below / equal / above; coefficient versus upper stress `R2` identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-REGRESSION-POINTS-RECOMMENDED-MIN` | `count >= 50` | considered regression points; inclusive recommendation | G.6.2; p.55; PDF 61 | 49 / 50 / 51; distinct valid points; recommendation semantics | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-RELATIVE-STANDARD-DEVIATION-MAX-EXCLUSIVE` | `Sm(rel) < 1` | percent; strict recommended maximum | G.6.2; p.55; PDF 61 | below / equal / above; percent/fraction and statistic identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-R1-START-FRACTION-APPROX` | `R1 ~= 0.10 * (ReH or Rp0.2)` | dimensionless fraction; recommended starting point | G.6.2 list item 1; p.55; PDF 61 | yield identity and provenance; approximate recommendation not exact eligibility | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-R2-START-FRACTION-APPROX` | `R2 ~= 0.40 * (ReH or Rp0.2)` | dimensionless fraction; recommended starting point | G.6.2 list item 2; p.55; PDF 61 | yield identity and provenance; `R2 > R1`; recommendation semantics | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G3-STRAIN-OFFSET-FORMULA` | `x(y=0) = -b / E` | compatible stress units; dimensionless strain-axis offset | Formula G.3; p.55; PDF 61 | analytical signs; `E != 0`; finite inputs; percentage display conversion explicit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## CWA uncertainty route and example

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AG-G4-CWA-COMBINED-UNCERTAINTY-FORMULA` | `uc(E) = sqrt((Le/S0)^2*u(SE)^2 + (SE/S0)^2*u(Le)^2 + (-SE*Le/S0^2)^2*u(S0)^2)` | compatible `Le/S0/SE` units; output same modulus unit as `E` | Formula G.4; p.56; PDF 62 | independent propagation; squared terms/grouping; nonnegative finite uncertainties; unit conversion | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-UNCERTAINTY-EXAMPLE-E` | `E = 186.7` | GPa; information-only example | G.7.2.2; p.56; PDF 62 | exact example value/unit; not expected-material default | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-LE` | `Le = 50` | mm; information-only example | G.7.2.2; p.56; PDF 62 | exact input and gauge-length identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-S0` | `S0 = 78.5` | mm2; information-only example | G.7.2.2; p.56; PDF 62 | exact input and original-area identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-SE` | `SE = 293.07` | kN/mm; information-only example | G.7.2.2; p.56; PDF 62 | exact input and force-extension-slope identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-U-LE` | `u(Le) = 0.144` | mm; information-only example | G.7.2.2 and Table G.1; pp.56-57; PDFs 62-63 | exact uncertainty input; standard-uncertainty identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-U-S0` | `u(S0) = 0.785` | mm2; information-only example | G.7.2.2 and Table G.1; pp.56-57; PDFs 62-63 | exact uncertainty input; area-unit identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-U-SE` | `u(SE) = 0.064` | kN/mm; information-only example | G.7.2.2 and Table G.1; pp.56-57; PDFs 62-63 | exact uncertainty input; slope-unit identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG1-LE-S0-SENSITIVITY` | `Le / S0 = 0.637` | mm^-1; information-only sensitivity coefficient | Table G.1; p.57; PDF 63 | independent recomputation from unrounded inputs; displayed rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG1-SE-S0-SENSITIVITY` | `SE / S0 = 3.733` | kN/mm3; information-only sensitivity coefficient | Table G.1; p.57; PDF 63 | independent recomputation; unit exponent and rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG1-S0-SENSITIVITY` | `-SE * Le / S0^2 = -2.378` | kN/mm4; information-only sensitivity coefficient | Table G.1; p.57; PDF 63 | negative sign; squared area; independent recomputation and rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-UC-E` | `uc(E) = 1.9` | GPa; information-only combined standard uncertainty | Table G.1 and Formula G.5; p.57; PDF 63 | independent result; kN/mm2 to GPa identity; rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G5-CWA-EXAMPLE-FORMULA` | `uc(E) = sqrt(0.637^2*0.064^2 + 3.733^2*0.144^2 + (-2.378)^2*0.785^2) = 1.9` | compatible Table-G.1 units; output GPa | Formula G.5; p.57; PDF 63 | independent high-precision computation; sign disappears only through squaring; rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-COVERAGE-FACTOR-95` | `k = 2` | dimensionless; stated 95-percent-confidence examples | G.7.2.2 and G.7.3; pp.57-58; PDFs 63-64 | exact example factor and confidence identity; no universal substitution | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G6-EXPANDED-UNCERTAINTY-FORMULA` | `U(E) = k * uc(E)` | compatible absolute uncertainty units; output GPa in example | Formula G.6; p.57; PDF 63 | analytical multiplication; standard versus expanded identity; finite nonnegative inputs | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-RELATIVE-UNCERTAINTY` | `3.8 / 186.7 * 100 ~= 2.0` | percent; information-only example | G.7.2.2; p.57; PDF 63 | independent ratio and rounding; absolute/relative distinction | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-CWA-EXAMPLE-EXPANDED-UNCERTAINTY` | `U(E) = 3.8` | GPa; `k=2`, 95-percent-confidence example | Formula G.6 and result; p.57; PDF 63 | independent `2 * 1.9`; report interval and method evidence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Annex-K route, proficiency and reporting

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AG-TG2-SMREL-CONTRIBUTION` | `0.2` | percent; information-only uncertainty contribution | Table G.2; p.58; PDF 64 | exact contribution; statistic and percent identity; rectangular distribution | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG2-SX-CONTRIBUTION` | `3` | percent; information-only X-value contribution | Table G.2; p.58; PDF 64 | exact contribution; absolute small-extension derivation retained | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG2-SY-CONTRIBUTION` | `1` | percent; information-only Y-value contribution | Table G.2; p.58; PDF 64 | exact contribution; X/Y identity and no double count | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG2-LE-CONTRIBUTION` | `0.5` | percent; information-only gauge-length contribution | Table G.2; p.58; PDF 64 | exact contribution; `Le` identity and distribution divisor | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG2-S0-CONTRIBUTION` | `1` | percent; information-only original-area contribution | Table G.2; p.58; PDF 64 | exact contribution; `S0` identity and distribution divisor | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG2-EXTENSOMETER-ABSOLUTE-BIAS` | `1.5` | micrometres; class-0.5 information-only absolute example | Table G.2 footnote c; p.58; PDF 64 | exact value/unit; absolute versus relative handling | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG2-EXTENSION-EXAMPLE-TUPLE` | `DeltaR=200 MPa; E=200 GPa; Le=50 mm; DeltaL=0.05 mm` | information-only dimensional tuple | Table G.2 footnote c; p.58; PDF 64 | independent `DeltaL=Le*DeltaR/E`; unit normalization; no defaulting | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G7-ANNEXK-COMBINED-UNCERTAINTY-FORMULA` | `uc(E) = sqrt((0.2/sqrt(3))^2 + (3/sqrt(3))^2 + (1/sqrt(3))^2 + (0.5/sqrt(3))^2 + (1/sqrt(3))^2) = 1.9%` | percent; information-only example | Formula G.7; p.58; PDF 64 | root-sum-square; divisor applied to every rectangular term; independent rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-G8-RELATIVE-EXPANDED-UNCERTAINTY-FORMULA` | `U(E) = k * uc(E)` | relative percent output | Formula G.8; p.58; PDF 64 | analytical multiplication; relative/absolute identity; `k=2` example | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-ANNEXK-EXAMPLE-EXPANDED-UNCERTAINTY` | `U(E) = 7.1` | GPa; `(186.7 +/- 7.1) GPa`, `k=2`, 95-percent example | G.7.3 result; p.58; PDF 64 | percent-to-absolute conversion and reported interval; rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-PROFICIENCY-UNCERTAINTY-RANGE` | `1.2 <= U <= 5` | percent at 95-percent confidence; information-only proficiency evidence | G.7.4; p.58; PDF 64 | below / endpoints / inside / above; never used as conformity tolerance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-E-REPORT-ROUNDING-QUANTUM` | `0.1` | GPa; nearest quantum according to ISO 80000-1 | G.8 item d; p.58; PDF 64 | half-quantum ties under reviewed dependency; no intermediate rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Table G.3 historical reproducibility data

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AG-TG3-UNWIN-REPRODUCIBILITY` | `2` | percent, +/-2s; historical information only | Table G.3 row 1; p.59; PDF 65 | exact row/material/year identity; not a universal limit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG3-VAMAS-REPRODUCIBILITY` | `6` | percent, +/-2s; historical information only | Table G.3 row 2; p.59; PDF 65 | exact row/material/year identity; not a universal limit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG3-CRM661-REPRODUCIBILITY` | `12` | percent, +/-2s; historical information only | Table G.3 row 3; p.59; PDF 65 | exact row/material/year identity; not a universal limit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG3-TENSTAND-WP3-REPRODUCIBILITY` | `5 to 25` | percent, +/-2s; historical information-only range | Table G.3 row 4; p.59; PDF 65 | lower/upper and dataset identity; no interpolation into tolerance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AG-TG3-TENSTAND-WP2-REPRODUCIBILITY` | `1 to 6` | percent, +/-2s; historical information-only range | Table G.3 row 5; p.59; PDF 65 | lower/upper and ASCII-data identity; no conformity use | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **56**.
- Formulas G.1-G.8, all three tables, strict/inclusive operators, recommended starting points, report rounding and example-only values require independent numerical and dimensional review.
- CWA and Annex-K examples are separate uncertainty routes; absolute and relative results cannot be mixed or reported without method, components, coverage and confidence evidence.
- Table-G.1, Table-G.2, proficiency and Table-G.3 values remain information-only and cannot become universal eligibility, acceptance or conformity tolerances.
- Annex G is normative for its selected route, but permissions and recommendations do not become unconditional shall-rules.
