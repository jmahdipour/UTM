---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_C_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex C

## Control rules

This register holds numeric values, dimensional tuples, formulas and boundary operators extracted from normative Annex C. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. Annex-C applicability reuses `IP-PRODUCT-C-SIZE-MAX-EXCLUSIVE` from the Clauses 1-10 package and is not duplicated here.

## Gauge length and grip distance

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AC-L0-LONG-TUPLE` | `nominal=200; tolerance=2` | mm; symmetric inclusive tolerance | C.2 sentence 1; p.43; PDF 49 | below / lower endpoint / nominal / upper endpoint / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AC-L0-SHORT-TUPLE` | `nominal=100; tolerance=1` | mm; symmetric inclusive tolerance | C.2 sentence 1; p.43; PDF 49 | below / lower endpoint / nominal / upper endpoint / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AC-GRIP-DISTANCE-B0-FORMULA` | `G >= L0 + 3 * b0` | compatible lengths; inclusive lower bound; `b0` meaning review-blocked | C.2 sentence 2; p.43; PDF 49 | below / equal / above; missing or inapplicable `b0` | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AC-GRIP-DISTANCE-ABS-MIN-FORMULA` | `G >= L0 + 20 mm` | compatible lengths; inclusive lower bound | C.2 sentence 2; p.43; PDF 49 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AC-GRIP-DISTANCE-EFFECTIVE-MIN-FORMULA` | `G >= max(L0 + 3 * b0, L0 + 20 mm)` | compatible lengths; both lower bounds apply; `b0` meaning review-blocked | C.2 sentence 2; p.43; PDF 49 | each branch dominant / equal crossover / below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AC-GRIP-DISTANCE-NO-A-MIN` | `50` | mm; inclusive minimum; only when `A` is not determined | C.2 sentence 3; p.43; PDF 49 | below / equal / above; `A` requested/not requested | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Original cross-sectional area

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AC-S0-ACCURACY-MAX` | `1` | percent; symmetric inclusive maximum absolute error | C.4 para.1; p.43; PDF 49 | below / equal / above; sign and unit handling | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AC-CIRCULAR-MEASUREMENT-COUNT` | `2` | count; exact | C.4 para.2; p.43; PDF 49 | fewer / exact / more; perpendicularity evidence absent/present | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AC-CIRCULAR-MEASUREMENT-MEAN-RULE` | `dMean = (d1 + d2) / 2` | compatible transverse-length units; arithmetic mean of two perpendicular measurements | C.4 para.2; p.43; PDF 49 | analytical pairs / swapped order / unequal units / missing orientation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AC-MASS-DENSITY-S0-FORMULA` | `S0 = 1000 * m / (rho * Lt)` | `m` in g; `rho` in g/cm3; `Lt` in mm; output mm2 | Formula C.1; p.43; PDF 49 | analytical values / unit conversion / zero-negative-nonfinite denominator / missing input | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **10**.
- The Annex-C product-size limit is controlled by the Clauses 1-10 parameter register and remains independently review-pending.
- The source meaning of `b0` for circular and other unmachined Annex-C sections is unresolved; all three grip-distance records depending on it remain review-blocked and cannot become production rules by extraction alone.
- The arithmetic-mean record captures the source's dimensional averaging rule; geometry-specific area evaluation still requires an independently reviewed calculator and evidence.
- Conditional, permissive and mandatory operators remain distinct and must not be collapsed into one default route.
