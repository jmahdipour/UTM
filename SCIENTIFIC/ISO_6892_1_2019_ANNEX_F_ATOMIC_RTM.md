---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_F_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic RTM - Annex F

## Control statement

This inventory paraphrases informative Annex F and Formulas F.1-F.3 of the controlled English third edition. It does not reproduce the standard. Printed-page and PDF-page locators identify the controlled local source. Annex F is opt-in guidance for estimating crosshead separation rate with testing-equipment stiffness; it does not silently replace the selected normative rate-control method or measured strain evidence.

`EXTRACTED / REVIEW-PENDING` means that the source item is independently addressable and cross-linked, but its interpretation and parameterization have not received independent scientific sign-off. No row is implementation, validation execution or conformity evidence.

## F.1 - Informative scope and compliance model

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AF-001` | Annex F status; p.50; PDF 56 | Source role | Preserve Annex F as informative, explicitly selected guidance; never present its estimator as an independently mandatory ISO requirement. | `SCI-001`, `SCI-032`, `SCI-033`; `SAT-001`, `SAT-032`, `SAT-033` | `IAT-AF-INFORMATIVE-SOURCE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-002` | Annex F title; p.50; PDF 56 | Estimator objective | Scope the optional estimator to crosshead separation rate while considering testing-equipment stiffness or compliance. | `SCI-013`, `SCI-033`; `SAT-013`, `SAT-033` | `IAT-AF-INFORMATIVE-SOURCE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-003` | Annex F para.1 sentence 1; p.50; PDF 56 | Model limitation | Record that Formula (2) does not account for elastic deformation of the testing equipment during force application. | `SCI-013`, `SCI-033`, `SCI-038`; `SAT-013`, `SAT-033`, `SAT-038` | `IAT-AF-COMPLIANCE-GAP` | `IP-FORMULA-VC` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-004` | Annex F para.1 sentence 1 examples; p.50; PDF 56 | Equipment scope | Include frame, load cell, grips and other participating equipment in the compliance limitation rather than attributing it to one component. | `SCI-010`, `SCI-033`, `SCI-038`; `SAT-010`, `SAT-033`, `SAT-038` | `IAT-AF-COMPLIANCE-GAP` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-005` | Annex F para.1 sentence 2; p.50; PDF 56 | Compensation option | Permit estimation of equipment-deflection compensation without claiming that the estimate is measured strain control. | `SCI-001`, `SCI-013`, `SCI-033`; `SAT-001`, `SAT-013`, `SAT-033` | `IAT-AF-COMPLIANCE-GAP` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-006` | Annex F para.1 sentence 2; p.50; PDF 56 | Point-specific input | Use testing-equipment stiffness qualified at the declared point of interest for the compensation estimate. | `SCI-003`, `SCI-010`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-010`, `SAT-033`, `SAT-038` | `IAT-AF-STIFFNESS-QUALIFICATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-007` | Annex F para.1 sentence 3; p.50; PDF 56 | Post-elastic warning | Beyond the elastic range, prohibit use of elastic-portion specimen stiffness because it would grossly overestimate the correction. | `SCI-010`, `SCI-033`, `SCI-039`; `SAT-010`, `SAT-033`, `SAT-039` | `IAT-AF-STIFFNESS-QUALIFICATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-008` | Annex F para.1 sentence 4, grip configuration; p.50; PDF 56 | Configuration identity | Qualify equipment stiffness for the actual grip configuration used and retain that configuration identity. | `SCI-003`, `SCI-010`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-010`, `SAT-033`, `SAT-038` | `IAT-AF-STIFFNESS-QUALIFICATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-009` | Annex F para.1 sentence 4, grip separation; p.50; PDF 56 | Geometry identity | Qualify equipment stiffness for the actual grip separation and reject silent reuse at another separation. | `SCI-003`, `SCI-006`, `SCI-010`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-006`, `SAT-010`, `SAT-033`, `SAT-038` | `IAT-AF-STIFFNESS-QUALIFICATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-010` | Annex F para.1 sentence 5; p.50; PDF 56 | Time-varying behavior | Preserve the possibility that effective equipment stiffness changes substantially as grips bite into the specimen during a test. | `SCI-010`, `SCI-033`, `SCI-038`; `SAT-010`, `SAT-033`, `SAT-038` | `IAT-AF-STIFFNESS-QUALIFICATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-011` | Annex F para.1 sentence 6; p.50; PDF 56 | Evaluation point | Evaluate equipment stiffness at the point of interest and retain the matching time/property landmark. | `SCI-003`, `SCI-010`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-010`, `SAT-033`, `SAT-038` | `IAT-AF-STIFFNESS-QUALIFICATION` | - | EXTRACTED / REVIEW-PENDING |

## F.2 - Optional compensated-rate procedure

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AF-012` | Annex F para.2 opening; p.50; PDF 56 | Optional procedure | Execute the compensated crosshead-rate procedure only through an explicit opt-in selection. | `SCI-001`, `SCI-003`, `SCI-013`, `SCI-033`; `SAT-001`, `SAT-003`, `SAT-013`, `SAT-033` | `IAT-AF-PROCEDURE-SELECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-013` | Annex F para.2, stiffness input; p.50; PDF 56 | Matched input | Use equipment stiffness evaluated at the same declared point of interest as the requested estimate. | `SCI-003`, `SCI-010`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-010`, `SAT-033`, `SAT-038` | `IAT-AF-PROCEDURE-SELECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-014` | Annex F para.2, slope input; p.50; PDF 56 | Matched input | Use stress-strain-curve slope evaluated at the same point of interest and retain its range and derivation. | `SCI-003`, `SCI-006`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-006`, `SAT-033`, `SAT-038` | `IAT-AF-PROCEDURE-SELECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-015` | Annex F para.2 recommendation; p.50; PDF 56 | In-test check | Preserve the recommendation to check resulting strain rate at the point of interest during the test without converting it into an unconditional shall-rule. | `SCI-001`, `SCI-013`, `SCI-033`, `SCI-039`; `SAT-001`, `SAT-013`, `SAT-033`, `SAT-039` | `IAT-AF-PROCEDURE-SELECTION` | - | EXTRACTED / REVIEW-PENDING |

## Formula F.1 - Estimated strain rate

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AF-016` | Formula-F.1 sentence; p.50; PDF 56 | Output identity | Bind the Formula-F.1 output to estimated strain rate at the point of interest in reciprocal seconds. | `SCI-005`, `SCI-013`, `SCI-033`; `SAT-005`, `SAT-013`, `SAT-033` | `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-017` | Formula F.1; p.50; PDF 56 | Formula | Calculate estimated strain rate as crosshead rate divided by the sum of compliance-equivalent length and parallel length. | `SCI-006`, `SCI-013`, `SCI-033`; `SAT-006`, `SAT-013`, `SAT-033` | `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-018` | Formula F.1 where `vc`; p.50; PDF 56 | Input unit | Bind `vc` to crosshead separation rate in millimetres per second. | `SCI-005`, `SCI-006`, `SCI-013`; `SAT-005`, `SAT-006`, `SAT-013` | `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-019` | Formula F.1 where `m`; p.50; PDF 56 | Input identity | Bind `m` to the stress-percentage-extension curve slope in megapascals at the declared moment; do not substitute specimen mass. | `SCI-005`, `SCI-006`, `SCI-033`, `SCI-038`; `SAT-005`, `SAT-006`, `SAT-033`, `SAT-038` | `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-020` | Formula F.1 where `S0`; p.50; PDF 56 | Input unit | Bind `S0` to original cross-sectional area in square millimetres with retained geometry provenance. | `SCI-005`, `SCI-006`, `SCI-008`, `SCI-033`; `SAT-005`, `SAT-006`, `SAT-008`, `SAT-033` | `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-021` | Formula F.1 where `CM`; p.50; PDF 56 | Input unit | Bind `CM` to complete testing-equipment stiffness in newtons per millimetre around the point of interest, including nonlinear configuration effects. | `SCI-005`, `SCI-006`, `SCI-010`, `SCI-033`; `SAT-005`, `SAT-006`, `SAT-010`, `SAT-033` | `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-022` | Formula F.1 where `Lc`; p.50; PDF 56 | Input unit | Bind `Lc` to specimen parallel length in millimetres and distinguish it from gauge or grip separation. | `SCI-005`, `SCI-006`, `SCI-007`, `SCI-009`; `SAT-005`, `SAT-006`, `SAT-007`, `SAT-009` | `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-023` | Formula F.1 note; p.50; PDF 56 | Invalid input source | Do not use `m` or `CM` derived from the linear portion of the stress-strain curve for this Annex-F route. | `SCI-003`, `SCI-010`, `SCI-033`, `SCI-039`; `SAT-003`, `SAT-010`, `SAT-033`, `SAT-039` | `IAT-AF-F1-ESTIMATED-STRAIN-RATE` | `IP-AF-F1-ESTIMATED-STRAIN-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |

## Formula F.2 - Compensated crosshead separation rate

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AF-024` | Annex F para.4 sentence 1; p.50; PDF 56 | Baseline limitation | Retain that Formula (2) does not compensate for compliance effects and do not label its result as Annex-F-compensated. | `SCI-013`, `SCI-033`, `SCI-038`; `SAT-013`, `SAT-033`, `SAT-038` | `IAT-AF-F2-COMPENSATED-CROSSHEAD-RATE` | `IP-FORMULA-VC` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-025` | Annex F para.4 condition; p.50; PDF 56 | Control context | Apply Formula F.2 only in the declared crosshead-displacement-control context and retain the active control mode. | `SCI-003`, `SCI-013`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-013`, `SAT-033`, `SAT-038` | `IAT-AF-F2-COMPENSATED-CROSSHEAD-RATE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-026` | Formula F.2; p.50; PDF 56 | Formula | Calculate compensated crosshead separation rate by multiplying the requested estimated strain rate by the same compliance-equivalent-plus-parallel-length term used in Formula F.1. | `SCI-006`, `SCI-013`, `SCI-033`; `SAT-006`, `SAT-013`, `SAT-033` | `IAT-AF-F2-COMPENSATED-CROSSHEAD-RATE` | `IP-AF-F2-COMPENSATED-CROSSHEAD-RATE-FORMULA` | EXTRACTED / REVIEW-PENDING |

## Formula F.3 - Equipment-stiffness calibration and yielding route

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AF-027` | Annex F para.5 sentence 1; p.50; PDF 56 | Required calibration input | Require qualified `CM` for use of Formula F.1 or F.2; absent or mismatched stiffness blocks the optional result. | `SCI-003`, `SCI-010`, `SCI-033`; `SAT-003`, `SAT-010`, `SAT-033` | `IAT-AF-F3-STIFFNESS-CALIBRATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-028` | Annex F para.5 equipment list; p.50; PDF 56 | Complete system | Qualify stiffness for the complete used system, including testing rig, load cell and clamping system for the specimens to be tested. | `SCI-003`, `SCI-010`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-010`, `SAT-033`, `SAT-038` | `IAT-AF-F3-STIFFNESS-CALIBRATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-029` | Annex F calibration para.1; p.51; PDF 57 | Calibration specimen | Use a calibration test piece with the same geometry and similar properties to the subsequently tested material, retaining both comparisons. | `SCI-003`, `SCI-007`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-007`, `SAT-033`, `SAT-038` | `IAT-AF-F3-STIFFNESS-CALIBRATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-030` | Annex F calibration para.1; p.51; PDF 57 | Calibration rate | Test the calibration specimen at a slow, known, constant crosshead separation rate and retain the actual rate trace. | `SCI-003`, `SCI-013`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-013`, `SAT-033`, `SAT-038` | `IAT-AF-F3-STIFFNESS-CALIBRATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-031` | Annex F calibration item 1; p.51; PDF 57 | Slope measurement | Determine `m` around the point of interest from the stress-strain diagram and retain the evaluation interval. | `SCI-003`, `SCI-006`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-006`, `SAT-033`, `SAT-038` | `IAT-AF-F3-STIFFNESS-CALIBRATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-032` | Annex F calibration item 2; p.51; PDF 57 | Strain-rate measurement | Determine the resulting strain rate around the point of interest from the percentage-extension-time curve and retain its interval. | `SCI-003`, `SCI-013`, `SCI-033`, `SCI-038`; `SAT-003`, `SAT-013`, `SAT-033`, `SAT-038` | `IAT-AF-F3-STIFFNESS-CALIBRATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-033` | Formula F.3; p.51; PDF 57 | Formula | Calculate `CM` from slope times original area divided by crosshead-rate-over-strain-rate minus parallel length, preserving operation grouping and a valid denominator. | `SCI-005`, `SCI-006`, `SCI-010`, `SCI-033`; `SAT-005`, `SAT-006`, `SAT-010`, `SAT-033` | `IAT-AF-F3-STIFFNESS-CALIBRATION` | `IP-AF-F3-EQUIPMENT-STIFFNESS-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-034` | Annex F final para. sentence 1; p.51; PDF 57 | Applicability guidance | Preserve the recommendation that this calibration procedure be used only where discontinuous yielding is absent in the relevant range. | `SCI-001`, `SCI-003`, `SCI-033`, `SCI-039`; `SAT-001`, `SAT-003`, `SAT-033`, `SAT-039` | `IAT-AF-YIELDING-BEHAVIOR-ROUTE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AF-035` | Annex F final para. sentence 2; p.51; PDF 57 | Alternative route | For discontinuous or serrated yielding, omit the stiffness route and use estimated strain rate over `Lc` with simplified Formula (2), not Formula F.2, for `vc`. | `SCI-003`, `SCI-013`, `SCI-033`, `SCI-039`; `SAT-003`, `SAT-013`, `SAT-033`, `SAT-039` | `IAT-AF-YIELDING-BEHAVIOR-ROUTE` | `IP-FORMULA-VC` | EXTRACTED / REVIEW-PENDING |

## Package count and evidence boundary

- Atomic source items: **35** (`informative scope/compliance=11`, `optional procedure=4`, `F.1=8`, `F.2=3`, `F.3/calibration/yielding=9`).
- Parameter/formula records: **3** new Annex-F formulas; the simplified Formula (2) route reuses controlled `IP-FORMULA-VC` from package 1.
- Atomic acceptance variants: **8**.
- Coverage status: extraction and bidirectional family/test/parameter routing complete for informative Annex F and Formulas F.1-F.3; independent interpretation/parameter review and all executable evidence remain pending.
- Informative boundary: Annex F remains opt-in guidance, and none of its internal imperative wording independently changes normative method selection or creates an ISO conformity claim.
- Excluded from this package: Annexes G-L, detailed referenced-standard requirements and ASTM E8/E8M-15a.
