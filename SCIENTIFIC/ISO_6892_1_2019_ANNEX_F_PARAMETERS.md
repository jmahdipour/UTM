---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_F_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex F

## Control rules

This register holds the three formulas extracted from informative Annex F. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. The route is optional, point-specific and configuration-specific, and it does not replace the selected normative rate-control method or measured strain evidence. Simplified Formula (2) remains controlled by `IP-FORMULA-VC` from package 1.

## Stiffness-compensated rate formulas

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | `eDotM = vc / ((m * S0 / CM) + Lc)` | `vc` in mm/s; `m` in MPa; `S0` in mm2; `CM` in N/mm; `Lc` in mm; output s^-1 | Formula F.1 and where list; p.50; PDF 56 | finite positive denominator; matched point and equipment configuration; linear-portion-derived `m` or `CM` invalid | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AF-F2-COMPENSATED-CROSSHEAD-RATE-FORMULA` | `vc = eDotM * ((m * S0 / CM) + Lc)` | `eDotM` in s^-1; `m` in MPa; `S0` in mm2; `CM` in N/mm; `Lc` in mm; output mm/s | Formula F.2; p.50; PDF 56 | crosshead-displacement-control context; finite positive compliance term; matched point and configuration | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AF-F3-EQUIPMENT-STIFFNESS-FORMULA` | `CM = m * S0 / ((vc / eDotM) - Lc)` | `m` in MPa; `S0` in mm2; `vc` in mm/s; `eDotM` in s^-1; `Lc` in mm; output N/mm | Formula F.3; p.51; PDF 57 | denominator finite, nonzero and positive; matched calibration geometry, properties, point, system and rate evidence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **3**.
- Formula F.1 estimates strain rate; Formula F.2 is its rearrangement for a compensated crosshead separation rate; Formula F.3 derives complete testing-equipment stiffness from a matched calibration.
- `m * S0 / CM` has length dimension, so the grouped denominator in Formula F.1 and multiplier in Formula F.2 are dimensionally compatible with `Lc`.
- Equipment stiffness covers the complete used system, including rig, load cell and clamping, at the declared point of interest and actual grip configuration/separation.
- Linear-portion inputs, mismatched configuration or point, invalid denominators and discontinuous-yield calibration routes cannot silently yield a controlled value.
- Annex F remains informative and opt-in; these formulas cannot independently create a normative ISO requirement or conformity claim.
