---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_J_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-17
---

# ISO 6892-1:2019 Annex J Atomic RTM

## Control statement

Paraphrases informative Annex J and Formula J.1 with printed/PDF locators; it does not reproduce the standard.

`EXTRACTED / REVIEW-PENDING` identifies routed design evidence only; it is not independent approval, executable validation, implementation or conformity evidence.

## Annex J - complete workflow

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AJ-001` | Annex J status/title; p.63; PDF 69 | Authority | Keep Annex J informative and explicitly selected. | `SCI-001`; `SAT-001` | `IAT-AJ-SCOPE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-002` | Annex J title; p.63; PDF 69 | Purpose | Scope `Awn` to long products such as bars, wire and rods. | `SCI-029`; `SAT-029` | `IAT-AJ-SCOPE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-003` | Annex J opening; p.63; PDF 69 | Part identity | Perform the method on the longer part of a qualified broken specimen. | `SCI-029`; `SAT-029` | `IAT-AJ-MARKING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-004` | Annex J marking; p.63; PDF 69 | Lifecycle | Create equidistant gauge marks before testing and retain their provenance. | `SCI-003`; `SAT-003` | `IAT-AJ-MARKING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-005` | Annex J marking; p.63; PDF 69 | Partition | Make each interval a declared fraction of `L0_prime`. | `SCI-006`; `SAT-006` | `IAT-AJ-MARKING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-006` | Annex J marking; p.63; PDF 69 | Metrology | Measure `L0_prime` within the stated symmetric accuracy. | `SCI-005`; `SAT-005` | `IAT-AJ-METROLOGY` | `IP-AJ-LENGTH-ACCURACY` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-007` | Annex J final length; p.63; PDF 69 | Metrology | Measure `Lu_prime` after fracture on the longest part within the same accuracy. | `SCI-005`; `SAT-005` | `IAT-AJ-METROLOGY` | `IP-AJ-LENGTH-ACCURACY` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-008` | Annex J condition a; p.63; PDF 69 | Fracture clearance | Keep each measuring-zone limit at least `5*d0` from fracture. | `SCI-005`; `SAT-005` | `IAT-AJ-ZONE` | `IP-AJ-FRACTURE-CLEARANCE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-009` | Annex J condition a; p.63; PDF 69 | Grip clearance | Keep each measuring-zone limit at least `2.5*d0` from the grip. | `SCI-005`; `SAT-005` | `IAT-AJ-ZONE` | `IP-AJ-GRIP-CLEARANCE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-010` | Annex J condition a; p.63; PDF 69 | Joint validity | Require both clearance predicates for the selected zone. | `SCI-029`; `SAT-029` | `IAT-AJ-ZONE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-011` | Annex J condition b; p.63; PDF 69 | Dependency | Meet or exceed the measuring length required by the applicable product standard. | `SCI-002`; `SAT-002` | `IAT-AJ-ZONE` | `IP-AJ-MIN-LENGTH` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-012` | Formula J.1; p.63; PDF 69 | Formula | Compute `Awn=((Lu_prime-L0_prime)/L0_prime)*100`. | `SCI-005`; `SAT-005` | `IAT-AJ-FORMULA` | `IP-AJ-J1` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-013` | Formula J.1 symbols; p.63; PDF 69 | Input validity | Require compatible finite lengths, positive `L0_prime` and same-zone provenance. | `SCI-006`; `SAT-006` | `IAT-AJ-FORMULA` | `IP-AJ-J1` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-014` | Annex J Note; p.63; PDF 69 | Information | Do not convert the stated near-equality of `Ag` and `Awn` for many materials into substitution. | `SCI-001`; `SAT-001` | `IAT-AJ-NOTE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AJ-015` | Annex J Note; p.63; PDF 69 | Counterexample | Retain the cited material/temperature differences as evidence against universal equivalence. | `SCI-029`; `SAT-029` | `IAT-AJ-NOTE` | - | EXTRACTED / REVIEW-PENDING |

## Package count and evidence boundary

- Atomic source items: **15**.
- Parameter/formula records: **5**.
- Atomic acceptance variants: **6**.
- Authority boundary: Annex J remains informative; the product-standard dependency applies only to the selected route.
- Excluded from this package: Annexes K-L and ASTM E8/E8M-15a
