---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_C_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic RTM - Annex C

## Control statement

This inventory paraphrases normative Annex C, Formula C.1 and Figure 12 of the controlled English third edition. It does not reproduce the standard. Printed-page and PDF-page locators identify the controlled local source.

`EXTRACTED / REVIEW-PENDING` means that the source item is independently addressable and cross-linked, but its interpretation and parameterization have not received independent scientific sign-off. No row is implementation, validation execution or conformity evidence.

## Figure 12 - Unmachined-product geometry

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AC-F12-001` | Figure 12 caption; p.30; PDF 36 | Figure applicability | Use the figure only for Annex-C specimens comprising an unmachined portion of the product; retain the Annex-C profile identity. | `SCI-001`, `SCI-007`, `SCI-032`; `SAT-001`, `SAT-007`, `SAT-032` | `IAT-AC-FIGURE12-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-F12-002` | Figure 12 key; p.30; PDF 36 | Length identity | Preserve `L0` as the original gauge length and do not substitute grip distance or total specimen length. | `SCI-006`, `SCI-007`, `SCI-009`; `SAT-006`, `SAT-007`, `SAT-009` | `IAT-AC-FIGURE12-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-F12-003` | Figure 12 key; p.30; PDF 36 | Area identity | Bind `S0` to the original cross-sectional area of the unmachined product section used for the test. | `SCI-006`, `SCI-007`, `SCI-008`, `SCI-038`; `SAT-006`, `SAT-007`, `SAT-008`, `SAT-038` | `IAT-AC-FIGURE12-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-F12-004` | Figure 12 body; p.30; PDF 36 | Section-shape evidence | Preserve the actual unmachined cross-section profile represented by the product rather than coercing circular, rectangular and other section forms to one geometry. | `SCI-007`, `SCI-008`, `SCI-032`, `SCI-039`; `SAT-007`, `SAT-008`, `SAT-032`, `SAT-039` | `IAT-AC-FIGURE12-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |

## C.1 - Applicability and shape

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AC-001` | Annex C title; p.43; PDF 49 | Normative profile | Select Annex C for wire, bar or section products whose governing diameter or thickness is below the controlled 4 mm boundary. | `SCI-001`, `SCI-007`, `SCI-032`; `SAT-001`, `SAT-007`, `SAT-032` | `IAT-AC-PROFILE-APPLICABILITY` | `IP-PRODUCT-C-SIZE-MAX-EXCLUSIVE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-002` | C.1; p.43; PDF 49 | Common shape | Treat an unmachined portion of the product as the general Annex-C specimen form without converting the source's non-exclusive wording into an absolute shape restriction; retain any deviation explicitly. | `SCI-001`, `SCI-003`, `SCI-007`, `SCI-032`; `SAT-001`, `SAT-003`, `SAT-007`, `SAT-032` | `IAT-AC-UNMACHINED-SHAPE` | - | EXTRACTED / REVIEW-PENDING |

## C.2 - Dimensions

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AC-003` | C.2 sentence 1; p.43; PDF 49 | Gauge-length catalog | Select exactly one of the two stated original-gauge-length profiles and retain the selected nominal/tolerance pair. | `SCI-003`, `SCI-006`, `SCI-007`, `SCI-009`, `SCI-032`; `SAT-003`, `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032` | `IAT-AC-L0-OPTIONS` | `IP-AC-L0-LONG-TUPLE`; `IP-AC-L0-SHORT-TUPLE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-004` | C.2 sentence 1, 200 mm option; p.43; PDF 49 | Gauge-length option | For the long profile, enforce the stated 200 mm nominal `L0` with its symmetric tolerance. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-032`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032` | `IAT-AC-L0-OPTIONS` | `IP-AC-L0-LONG-TUPLE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-005` | C.2 sentence 1, 100 mm option; p.43; PDF 49 | Gauge-length option | For the short profile, enforce the stated 100 mm nominal `L0` with its symmetric tolerance. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-032`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032` | `IAT-AC-L0-OPTIONS` | `IP-AC-L0-SHORT-TUPLE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-006` | C.2 sentence 2, first relation; p.43; PDF 49 | Grip-distance relation | Require the distance between machine grips to meet the stated `L0 + 3*b0` lower relation without guessing an Annex-C-specific meaning for `b0`. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-012`, `SCI-032`, `SCI-039`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-012`, `SAT-032`, `SAT-039` | `IAT-AC-GRIP-DISTANCE` | `IP-AC-GRIP-DISTANCE-B0-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-007` | C.2 sentence 2, absolute minimum; p.43; PDF 49 | Grip-distance relation | Independently require the grip distance to be no less than `L0 + 20 mm`. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-012`, `SCI-032`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-012`, `SAT-032` | `IAT-AC-GRIP-DISTANCE` | `IP-AC-GRIP-DISTANCE-ABS-MIN-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-008` | C.2 sentence 2, combined operator; p.43; PDF 49 | Boundary composition | Apply both grip-distance lower bounds, preserving the effective maximum-of-lower-bounds operator and the unresolved `b0` interpretation. | `SCI-003`, `SCI-007`, `SCI-009`, `SCI-012`, `SCI-032`, `SCI-038`, `SCI-039`; `SAT-003`, `SAT-007`, `SAT-009`, `SAT-012`, `SAT-032`, `SAT-038`, `SAT-039` | `IAT-AC-GRIP-DISTANCE` | `IP-AC-GRIP-DISTANCE-EFFECTIVE-MIN-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-009` | C.2 sentence 3, condition; p.43; PDF 49 | Conditional route | Permit the alternative short grip-distance route only when percentage elongation after fracture will not be determined. | `SCI-003`, `SCI-007`, `SCI-009`, `SCI-027`, `SCI-032`; `SAT-003`, `SAT-007`, `SAT-009`, `SAT-027`, `SAT-032` | `IAT-AC-NO-A-GRIP-DISTANCE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-010` | C.2 sentence 3, minimum; p.43; PDF 49 | Conditional minimum | For that no-elongation route, enforce the stated minimum distance between grips. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-012`, `SCI-027`, `SCI-032`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-012`, `SAT-027`, `SAT-032` | `IAT-AC-NO-A-GRIP-DISTANCE` | `IP-AC-GRIP-DISTANCE-NO-A-MIN` | EXTRACTED / REVIEW-PENDING |

## C.3 - Preparation

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AC-011` | C.3; p.43; PDF 49 | Coiled-product preparation | For product delivered coiled, require a documented careful-straightening route and preserve the preparation evidence. | `SCI-003`, `SCI-007`, `SCI-032`, `SCI-038`, `SCI-039`; `SAT-003`, `SAT-007`, `SAT-032`, `SAT-038`, `SAT-039` | `IAT-AC-COILED-STRAIGHTENING` | - | EXTRACTED / REVIEW-PENDING |

## C.4 - Original cross-sectional area

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AC-012` | C.4 para.1; p.43; PDF 49 | Mandatory accuracy | Determine `S0` to the stated symmetric percentage accuracy or better. | `SCI-008`, `SCI-010`, `SCI-032`, `SCI-036`; `SAT-008`, `SAT-010`, `SAT-032`, `SAT-036` | `IAT-AC-S0-ACCURACY` | `IP-AC-S0-ACCURACY-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-013` | C.4 para.2, applicability; p.43; PDF 49 | Circular-section option | For a circular product, permit the stated perpendicular-measurement route for calculating `S0`; do not apply it to a non-circular section. | `SCI-007`, `SCI-008`, `SCI-032`; `SAT-007`, `SAT-008`, `SAT-032` | `IAT-AC-CIRCULAR-S0` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-014` | C.4 para.2, count; p.43; PDF 49 | Measurement count | Require exactly the stated pair of qualified transverse measurements for the circular-section route. | `SCI-003`, `SCI-006`, `SCI-008`, `SCI-038`; `SAT-003`, `SAT-006`, `SAT-008`, `SAT-038` | `IAT-AC-CIRCULAR-S0` | `IP-AC-CIRCULAR-MEASUREMENT-COUNT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-015` | C.4 para.2, directions; p.43; PDF 49 | Measurement orientation | Require the two circular-section measurements to be taken in perpendicular directions and retain their orientation evidence. | `SCI-008`, `SCI-032`, `SCI-038`; `SAT-008`, `SAT-032`, `SAT-038` | `IAT-AC-CIRCULAR-S0` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-016` | C.4 para.2, averaging; p.43; PDF 49 | Averaging rule | Use the arithmetic mean of the two perpendicular measurements as the dimensional input for the optional circular-section `S0` calculation. | `SCI-006`, `SCI-008`, `SCI-032`, `SCI-038`; `SAT-006`, `SAT-008`, `SAT-032`, `SAT-038` | `IAT-AC-CIRCULAR-S0` | `IP-AC-CIRCULAR-MEASUREMENT-MEAN-RULE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-017` | C.4 para.3 sentence 1; p.43; PDF 49 | Mass-density option | Permit `S0` to be determined from specimen mass, a known measured length and material density only when all inputs and route identity are retained. | `SCI-003`, `SCI-006`, `SCI-008`, `SCI-032`, `SCI-038`; `SAT-003`, `SAT-006`, `SAT-008`, `SAT-032`, `SAT-038` | `IAT-AC-MASS-DENSITY-S0` | `IP-AC-MASS-DENSITY-S0-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-018` | Formula C.1; p.43; PDF 49 | Formula | Calculate `S0` from the stated scaled mass-over-density-length expression without changing the source unit contract. | `SCI-006`, `SCI-008`, `SCI-016`, `SCI-032`; `SAT-006`, `SAT-008`, `SAT-016`, `SAT-032` | `IAT-AC-MASS-DENSITY-S0` | `IP-AC-MASS-DENSITY-S0-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-019` | Formula C.1 where `m`; p.43; PDF 49 | Input unit | Bind `m` to specimen mass in grams and reject incompatible or missing mass input. | `SCI-005`, `SCI-006`, `SCI-008`; `SAT-005`, `SAT-006`, `SAT-008` | `IAT-AC-MASS-DENSITY-S0` | `IP-AC-MASS-DENSITY-S0-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-020` | Formula C.1 where `rho`; p.43; PDF 49 | Input unit | Bind `rho` to specimen-material density in grams per cubic centimetre and require positive finite density. | `SCI-005`, `SCI-006`, `SCI-008`; `SAT-005`, `SAT-006`, `SAT-008` | `IAT-AC-MASS-DENSITY-S0` | `IP-AC-MASS-DENSITY-S0-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AC-021` | Formula C.1 where `Lt`; p.43; PDF 49 | Input unit | Bind `Lt` to total specimen length in millimetres, distinct from `L0` and grip distance, and require a positive finite value. | `SCI-005`, `SCI-006`, `SCI-007`, `SCI-008`, `SCI-009`; `SAT-005`, `SAT-006`, `SAT-007`, `SAT-008`, `SAT-009` | `IAT-AC-MASS-DENSITY-S0` | `IP-AC-MASS-DENSITY-S0-FORMULA` | EXTRACTED / REVIEW-PENDING |

## Package count and evidence boundary

- Atomic source items: **25** (`Figure 12=4`, `C.1=2`, `C.2=8`, `C.3=1`, `C.4=10`).
- Parameter/formula records: **10** new Annex-C records; the `<4 mm` applicability limit reuses the controlled package-1 parameter.
- Atomic acceptance variants: **10**.
- Coverage status: extraction and bidirectional family/test/parameter routing complete for Annex C, Formula C.1 and Figure 12; independent interpretation/parameter review and all executable evidence remain pending.
- Review blocker: C.2 uses `b0` in the grip-distance relation, while Figure 12 defines only `L0` and `S0` and Annex C covers circular and other unmachined sections. The applicable transverse-dimension meaning requires independent review; this extraction does not substitute diameter, thickness or another dimension.
- Excluded from this package: Figures 13-15, Annexes D-L, detailed referenced-standard requirements and ASTM E8/E8M-15a.
