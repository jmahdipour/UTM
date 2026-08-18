---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_D_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex D

## Control rules

This register holds numeric values, dimensional tuples, formulas and boundary operators extracted from normative Annex D. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. Annex-D applicability reuses `IP-PRODUCT-D-FLAT-MIN` and `IP-PRODUCT-D-SIZE-MIN`; Formula D.1 reuses `IP-FORMULA-L0`, `IP-K-PREFERRED` and `IP-K-ALTERNATE-PREFERRED` from the Clauses 1-10 package.

## Shape and parallel-length relations

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AD-TRANSITION-RADIUS-CYL-MIN-FORMULA` | `r >= 0.75 * d0` | compatible lengths; inclusive minimum for cylindrical specimens | D.1 item a; p.44; PDF 50 | below / equal / above; wrong geometry | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-TRANSITION-RADIUS-OTHER-MIN` | `12` | mm; inclusive minimum for non-cylindrical specimens | D.1 item b; p.44; PDF 50 | below / equal / above; wrong geometry | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-RECTANGULAR-WIDTH-THICKNESS-RATIO-MAX-RECOMMENDED` | `8` | `b0/a0`; recommended inclusive maximum | D.1 para.4; p.44; PDF 50 | below / equal / above; recommendation deviation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-CYLINDRICAL-DIAMETER-MIN` | `3` | mm; inclusive minimum for machined cylindrical parallel length | D.1 para.5; p.44; PDF 50 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-LC-CYL-MIN-FORMULA` | `Lc >= L0 + d0 / 2` | compatible lengths; inclusive minimum | D.2.1 item a; p.44; PDF 50 | below / equal / above; invalid/missing input | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-LC-PROP-NONCYL-MIN-FORMULA` | `Lc >= L0 + 1.5 * sqrt(S0)` | compatible length/area units; inclusive minimum | D.2.1 item b; p.44; PDF 50 | below / equal / above; invalid/missing area | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-LC-NONPROP-MIN-FORMULA` | `Lc >= L0 + b0 / 2` | compatible lengths; inclusive mandatory minimum | D.2.1 item c; p.44; PDF 50 | below / equal / above; invalid/missing width | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-LC-DISPUTE-CYL-FORMULA` | `Lc = L0 + 2 * d0` | compatible lengths; cylindrical dispute branch | D.2.1 dispute sentence; p.44; PDF 50 | exact relation; wrong branch; insufficient-material exception | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-LC-DISPUTE-PROP-NONCYL-FORMULA` | `Lc = L0 + 2 * sqrt(S0)` | compatible length/area units; other proportional dispute branch | D.2.1 dispute sentence; p.44; PDF 50 | exact relation; wrong branch; insufficient-material exception | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-UNMACHINED-MARK-CLEARANCE-MIN-FORMULA` | `clearance >= sqrt(S0)` | compatible length/area units; applies from each gauge mark to nearest grip | D.2.2; p.44; PDF 50 | below / equal / above for each side | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Table D.1 circular proportional profiles

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AD-D1-D20-DIMENSIONS` | `k=5.65; d0=20; L0=100; LcMin=110` | mm except dimensionless `k`; complete row tuple | Table D.1 diameter 20; p.45; PDF 51 | every field below/on/above; row mixing | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D1-D14-DIMENSIONS` | `k=5.65; d0=14; L0=70; LcMin=77` | mm except dimensionless `k`; complete row tuple | Table D.1 diameter 14; p.45; PDF 51 | every field below/on/above; row mixing | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D1-D10-DIMENSIONS` | `k=5.65; d0=10; L0=50; LcMin=55` | mm except dimensionless `k`; complete row tuple | Table D.1 diameter 10; p.45; PDF 51 | every field below/on/above; row mixing | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D1-D5-DIMENSIONS` | `k=5.65; d0=5; L0=25; LcMin=28` | mm except dimensionless `k`; complete row tuple with table rounding retained | Table D.1 diameter 5; p.45; PDF 51 | every field below/on/above; row mixing; exact table value | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Non-proportional relations and Table D.2 profiles

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AD-LC-NONPROP-RECOMMENDED-FORMULA` | `Lc >= L0 + b0 / 2` | compatible lengths; recommended minimum in D.2.3.2 | D.2.3.2 para.2; p.45; PDF 51 | below / equal / above; recommendation state | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-LC-NONPROP-DISPUTE-FORMULA` | `Lc = L0 + 2 * b0` | compatible lengths; mandatory dispute relation unless material is insufficient | D.2.3.2 para.2; p.45; PDF 51 | exact relation; exception absent/present | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D2-W40-DIMENSIONS` | `b0=40 +/- 0.7; L0=200; LcMin=220; LtApprox=450` | mm; complete typical row tuple | Table D.2 width 40; p.45; PDF 51 | every field below/on/above; approximate-length semantics; row mixing | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D2-W25-DIMENSIONS` | `b0=25 +/- 0.7; L0=200; LcMin=212.5; LtApprox=450` | mm; complete typical row tuple | Table D.2 width 25; p.45; PDF 51 | every field below/on/above; approximate-length semantics; row mixing | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D2-W20-DIMENSIONS` | `b0=20 +/- 0.5; L0=80; LcMin=90; LtApprox=300` | mm; complete typical row tuple | Table D.2 width 20; p.45; PDF 51 | every field below/on/above; approximate-length semantics; row mixing | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Machining and shape calculations

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AD-NOMINAL-DIMENSION-RANGE-FORMULA` | `xAllowed = [xNom - tMachining, xNom + tMachining]` | compatible lengths; endpoints included | D.3.2; p.46; PDF 52 | below / lower endpoint / inside / upper endpoint / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-SHAPE-DEVIATION-FORMULA` | `xMax - xMin <= tShape` | compatible lengths; inclusive maximum over the entire `Lc` | D.3.3 and Table D.3 footnote b; p.46; PDF 52 | below / equal / above; incomplete `Lc` coverage | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Table D.3 four-side-machined or round profiles

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AD-D3-FOUR-3-6-TOLERANCES` | `3 <= xNom <= 6; machining=+/-0.02; shape=0.03` | mm; exact interval and inclusive limits | Table D.3 four-side/round row 1; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D3-FOUR-6-10-TOLERANCES` | `6 < xNom <= 10; machining=+/-0.03; shape=0.04` | mm; exact interval and inclusive tolerance limits | Table D.3 four-side/round row 2; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D3-FOUR-10-18-TOLERANCES` | `10 < xNom <= 18; machining=+/-0.05; shape=0.04` | mm; exact interval and inclusive tolerance limits | Table D.3 four-side/round row 3; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D3-FOUR-18-30-TOLERANCES` | `18 < xNom <= 30; machining=+/-0.10; shape=0.05` | mm; exact interval and inclusive tolerance limits | Table D.3 four-side/round row 4; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Table D.3 two-opposite-side-machined profiles

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AD-D3-TWO-3-6-TOLERANCES` | `3 <= xNom <= 6; machining=+/-0.02; shape=0.03` | mm; exact interval and inclusive limits | Table D.3 two-side row 1; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D3-TWO-6-10-TOLERANCES` | `6 < xNom <= 10; machining=+/-0.03; shape=0.04` | mm; exact interval and inclusive tolerance limits | Table D.3 two-side row 2; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D3-TWO-10-18-TOLERANCES` | `10 < xNom <= 18; machining=+/-0.05; shape=0.06` | mm; exact interval and inclusive tolerance limits | Table D.3 two-side row 3; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D3-TWO-18-30-TOLERANCES` | `18 < xNom <= 30; machining=+/-0.10; shape=0.12` | mm; exact interval and inclusive tolerance limits | Table D.3 two-side row 4; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AD-D3-TWO-30-50-TOLERANCES` | `30 < xNom <= 50; machining=+/-0.15; shape=0.15` | mm; exact interval and inclusive tolerance limits | Table D.3 two-side row 5; p.46; PDF 52 | below/on/inside/on/above interval and tolerances | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Cross-sectional-area measurement

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AD-DIMENSION-MEASUREMENT-ERROR-MAX` | `0.5` | percent; symmetric inclusive maximum error on each measured dimension | D.4; p.47; PDF 53 | below / equal / above for every dimension; sign and unit handling | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **31**.
- Applicability, Formula D.1 and its two listed proportionality coefficients reuse controlled parameters from the Clauses 1-10 package and remain independently review-pending.
- Mandatory, recommended, preferred, approximate and conditional values remain distinguishable and cannot be collapsed into one default profile.
- Table-D.3 interval endpoints, machining groups, shape coverage and nominal-dimension eligibility require independent review and generated boundary evidence.
- The 5 mm Table-D.1 row retains the listed 28 mm minimum `Lc`; extraction does not replace it with the unrounded analytical value.
