---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_B_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex B

## Control rules

This register holds numeric values, dimensional tuples and boundary operators extracted from normative Annex B. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. The Annex-B product interval reuses `IP-PRODUCT-B-THICKNESS-MIN` and `IP-PRODUCT-B-THICKNESS-MAX-EXCLUSIVE` from the Clauses 1-10 package and is not duplicated here.

## Applicability, shape and length relations

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AB-SPECIAL-PRECAUTION-THICKNESS` | `0.5` | mm; special-precaution assessment for thickness strictly below | B.1; p.40; PDF 46 | below / equal / above; assessment absent/present | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-TRANSITION-RADIUS-MIN` | `20` | mm; inclusive minimum | B.2 para.1; p.40; PDF 46 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-END-WIDTH-RATIO-MIN-RECOMMENDED` | `1.2 * b0` | recommended end-width minimum; guidance rather than unconditional shall-limit | B.2 para.1; p.40; PDF 46 | below / equal / above; deviation record | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-FULL-WIDTH-MAX` | `20` | mm; full-product-width option at or below | B.2 para.2; p.40; PDF 46 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-LC-MIN-FORMULA` | `Lc >= L0 + b0 / 2` | compatible lengths; inclusive minimum | B.3 para.2; p.40; PDF 46 | below / equal / above; invalid/missing length | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-LC-DISPUTE-FORMULA` | `Lc = L0 + 2 * b0` | recommended dispute length unless material is insufficient | B.3 para.3; p.40; PDF 46 | exact relation; insufficient-material exception absent/present | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-PARALLEL-SIDED-WIDTH-MAX-EXCLUSIVE` | `20` | mm; default-`L0` route for width strictly below | B.3 para.4; p.40; PDF 46 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-PARALLEL-SIDED-L0-DEFAULT` | `50` | mm; default absent a governing product-standard override | B.3 para.4; p.40; PDF 46 | default/overridden; authority absent/present | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-FREE-LENGTH-FORMULA` | `Lfree = L0 + 3 * b0` | compatible lengths; parallel-sided route | B.3 para.4; p.40; PDF 46 | exact relation; invalid/missing length | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Table B.1 profile tuples

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AB-TYPE1-DIMENSIONS` | `b0=12.5 +/- 1; L0=50; LcMin=57; LcRecommended=75; Lfree=87.5` | mm; width range inclusive; minimum inclusive | Table B.1 type 1; p.41; PDF 47 | every field below/on/above; missing-field and cross-row substitution | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-TYPE2-DIMENSIONS` | `b0=20 +/- 1; L0=80; LcMin=90; LcRecommended=120; Lfree=140` | mm; width range inclusive; minimum inclusive | Table B.1 type 2; p.41; PDF 47 | every field below/on/above; missing-field and cross-row substitution | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-TYPE3-DIMENSIONS` | `b0=25 +/- 1; L0=50; LcMin=60; LcRecommended=NotSpecified; Lfree=NotDefined` | mm; width range inclusive; explicit non-values retained | Table B.1 type 3; p.41; PDF 47 | every numeric field below/on/above; null-state preservation; no fabricated recommendation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Table B.2 width tolerances and nominal-width calculation

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AB-B2-WIDTH-12-5-TOLERANCES` | `bNom=12.5; machining=+/-0.05; shape=0.06` | mm; machining interval inclusive; maximum shape deviation inclusive | Table B.2 row 12.5; p.41; PDF 47 | below/on/above each bound; wrong nominal row | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-B2-WIDTH-20-TOLERANCES` | `bNom=20; machining=+/-0.10; shape=0.12` | mm; machining interval inclusive; maximum shape deviation inclusive | Table B.2 row 20; p.41; PDF 47 | below/on/above each bound; wrong nominal row | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-B2-WIDTH-25-TOLERANCES` | `bNom=25; machining=+/-0.10; shape=0.12` | mm; machining interval inclusive; maximum shape deviation inclusive | Table B.2 row 25; p.41; PDF 47 | below/on/above each bound; wrong nominal row | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-NOMINAL-WIDTH-RANGE-FORMULA` | `bAllowed = [bNom - tMachining, bNom + tMachining]`; example `[12.45, 12.55]` | compatible lengths; endpoints included | B.4 para.5 and examples; p.41; PDF 47 | below / lower endpoint / inside / upper endpoint / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Cross-sectional-area accuracy

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AB-S0-ERROR-MAX` | `2` | percent; symmetric inclusive maximum absolute error | B.5 para.2; p.42; PDF 48 | below / equal / above; sign and unit handling | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-WIDTH-MEASUREMENT-ERROR-MAX` | `0.2` | percent; symmetric inclusive maximum absolute width error | B.5 para.2; p.42; PDF 48 | below / equal / above; independent from total area error | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AB-S0-REDUCED-UNCERTAINTY-ACCURACY` | `1` | percent or better; recommended area-accuracy target | B.5 para.3; p.42; PDF 48 | better / equal / worse; mandatory ceiling still evaluated | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **19**.
- The two Annex-B product-thickness limits are controlled by the Clauses 1-10 parameter register and remain independently review-pending.
- All inequality operators, Table-B.1 tuple semantics, Table-B.2 eligibility rules and null-state meanings require independent comparison with the controlled PDF.
- The general `Lc >= L0 + b0/2` relation conflicts numerically with some Table-B.1 combinations over their stated `b0` ranges. This register preserves both source statements and leaves precedence/footnote interpretation review-blocked.
- Recommended values remain distinguishable from mandatory limits and do not silently become universal acceptance criteria.
