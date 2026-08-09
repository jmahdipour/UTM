---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_CLAUSES_11_16_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Clauses 11 to 16

## Control rules

This register holds the formulas, numeric values, boundary operators and property parameterization referenced by the Clauses 11-16 atomic RTM. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration.

Approximate values remain guidance and cannot be converted silently into exact acceptance limits. Requested property suffixes and permanent-set bases are typed inputs whose source must be retained.

## Yield and proof properties

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-C11-FORMULA-REH` | `ReH = FeH / S0` | force divided by positive original area; engineering stress | C11; p.15; PDF 21 | valid / zero-or-negative area / incompatible unit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C12-FORMULA-REL` | `ReL = FeL / S0` | force divided by positive original area; engineering stress | C12; p.16; PDF 22 | valid / zero-or-negative area / incompatible unit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C12-SHORT-WINDOW-PERCENT` | `0.25` | percent strain after `ReH`; exact endpoint policy requires independent review | C12 para.2; p.16; PDF 22 | below / equal / above window end with operator review | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C13-RP-OFFSET-PERCENT` | requested finite positive `x` | percentage plastic extension; preserve in `Rp{x}` identity | 13.1; p.16; PDF 22 | multiple suffixes / zero-or-negative / non-finite / round trip | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C13-HYSTERESIS-UNLOAD-FRACTION-APPROX` | `0.10` | approximate fraction of previously obtained force | 13.1 para.3; p.16; PDF 22 | below / near / above with guidance state | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C13-FORMULA-RP` | `Rp{x} = Fp{x} / S0` | intersection force divided by positive original area | 13.1; p.16; PDF 22 | primary/alternative consistency; invalid area/unit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C14-RT-TOTAL-PERCENT` | requested finite positive `x` | percentage total extension; preserve in `Rt{x}` identity | 14.1; p.16; PDF 22 | multiple suffixes / zero-or-negative / non-finite / round trip | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C14-FORMULA-RT` | `Rt{x} = Ft{x} / S0` | intersection force divided by positive original area | 14.1; p.16; PDF 22 | exact/interpolated/no intersection; invalid area/unit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Permanent-set verification and yield-point extension

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-C15-FORMULA-FORCE` | `Ftarget = RrSpecified * S0` | compatible stress and positive area; output force | C15 para.1; p.17; PDF 23 | exact target / invalid area / incompatible unit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C15-HOLD-MIN` | `10` | s, inclusive minimum | C15 para.1; p.17; PDF 23 | below / equal / inside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C15-HOLD-MAX` | `12` | s, inclusive maximum | C15 para.1; p.17; PDF 23 | inside / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C15-PERMANENT-SET-LIMIT` | requested finite non-negative `x`; pass when residual `<= x` | percent of explicitly declared `L0` elongation or `Le` extension basis | C15; p.17; PDF 23 | below / equal / above; L0/Le basis separation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C16-FORMULA-AE` | `Ae = 100 * (DeltaLeEnd - DeltaLeAtReH) / Le` | compatible lengths and positive `Le`; output percent | C16; p.17; PDF 23 | exact/interpolated bounds; non-positive span/Le | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **13**.
- Every numeric/operator interpretation requires independent comparison with the controlled PDF.
- `0.10` is approximate guidance; a reviewer must define how evidence quality is represented without inventing an exact conformity band.
- No suffix, line-fit choice, transient exclusion, corrected origin or permanent-set basis may be inferred silently.
