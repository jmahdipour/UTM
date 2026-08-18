---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_H_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex H

## Control rules

This register holds the applicability boundary and arc-geometry relations extracted from informative Annex H. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. The Annex-H route is recommended guidance, and its threshold is evaluated against the specified elongation-after-fracture value rather than the measured result.

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AH-SPECIFIED-ELONGATION-MAX-EXCLUSIVE` | `specified_A < 5` | percent; strict applicability threshold | Annex H title and para.1; p.60; PDF 66 | below / equal / above; specified versus measured value identity; informative semantics | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AH-DIVIDER-RADIUS-FORMULA` | `r1 = L0` | compatible lengths; first-arc divider radius equals original gauge length | Annex H method sentence 2; p.60; PDF 66 | analytical equality; wrong `Le/Lc/Lu` substitution; unit mismatch; missing pre-test setting | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AH-SECOND-ARC-RADIUS-FORMULA` | `r2 = r1 = L0` | compatible lengths; second arc uses the same radius | Annex H method sentence 4; p.60; PDF 66 | equal/unequal radii; centre and radius identity; unit mismatch | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **3**.
- The `<5 percent` operator is strict and applies to the specified value; equality does not enter the Annex-H precaution route by this threshold.
- Both arc radii derive from the declared original gauge length and require independent dimensional and procedural review.
- Annex H remains informative; these records cannot independently create an eligibility failure, acceptance criterion or conformity claim outside the selected route.
