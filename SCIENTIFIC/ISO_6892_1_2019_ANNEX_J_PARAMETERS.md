---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_J_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-17
---

# ISO 6892-1:2019 Annex J Profile Parameters

## Control rules

Every entry remains review-pending; units, operators, source identity and authority are part of the parameter.

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AJ-LENGTH-ACCURACY` | `abs(error)<=0.5` | mm; inclusive | Annex J; p.63; PDF 69 | initial/final; below/equal/above; calibration | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AJ-FRACTURE-CLEARANCE` | `c_f>=5*d0` | length; inclusive | condition a; p.63; PDF 69 | both zone limits; fracture identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AJ-GRIP-CLEARANCE` | `c_g>=2.5*d0` | length; inclusive | condition a; p.63; PDF 69 | both zone limits; grip identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AJ-MIN-LENGTH` | `L_measure>=L_product` | length; dependency | condition b; p.63; PDF 69 | missing/revisioned product input | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AJ-J1` | `Awn=((Lu_prime-L0_prime)/L0_prime)*100` | percent | Formula J.1; p.63; PDF 69 | analytical cases; L0_prime>0; no Ag substitution | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **5**.
- Annex J remains informative; the product-standard dependency applies only to the selected route.
