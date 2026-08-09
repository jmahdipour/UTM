---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_CLAUSES_11_16_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic RTM - Clauses 11 to 16

## Control statement

This inventory paraphrases the controlled English third edition. It does not reproduce the standard. Printed-page locators are the page numbers printed by ISO; PDF locators refer to the registered 86-page controlled file. Figures 2 through 7 are routed because their construction points are part of the algorithm and evidence contract.

`EXTRACTED / REVIEW-PENDING` means that the source item is independently addressable and cross-linked, but its interpretation and parameterization have not received the independent scientific sign-off required to close `SG-02`. No row is implementation or execution evidence.

## Clause 11 - Upper yield strength

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C11-001` | C11; p.15; PDF 21 | Input/evaluation path | Determine `ReH` from the force-extension curve or a qualified peak-load indication without changing the property definition. | `SCI-018`; `SAT-018` | `IAT-C11-REH-DETECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C11-002` | C11; p.15; PDF 21 | Landmark rule | Select the maximum stress before the first decrease in force; retain the decrease evidence rather than selecting a later or global peak. | `SCI-018`; `SAT-018` | `IAT-C11-REH-DETECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C11-003` | C11; p.15; PDF 21 | Formula | Calculate `ReH` from its selected force and original cross-sectional area `S0`. | `SCI-018`; `SAT-018` | `IAT-C11-REH-DETECTION` | `IP-C11-FORMULA-REH` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C11-F02-001` | Figure 2(a-d); p.22; PDF 28 | Figure behavior | Cover every illustrated discontinuous-yield curve family; do not assume one fixed pre-yield or yield-plateau shape. | `SCI-018`; `SAT-018` | `IAT-F02-YIELD-CURVES` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C11-F02-002` | Figure 2(a-d); p.22; PDF 28 | Figure construction | Retain the selected `ReH` coordinate, its source sample or interpolation bracket and the immediately following qualifying force-decrease evidence. | `SCI-018`; `SAT-018` | `IAT-F02-YIELD-CURVES` | - | EXTRACTED / REVIEW-PENDING |

## Clause 12 - Lower yield strength

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C12-001` | C12 para.1; p.16; PDF 22 | Input/evaluation path | Determine `ReL` from the force-extension curve. | `SCI-019`; `SAT-019` | `IAT-C12-REL-DETECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-002` | C12 para.1; p.16; PDF 22 | Landmark rule | Select the lowest stress within the qualified plastic-yielding interval, not a minimum outside that interval. | `SCI-019`; `SAT-019` | `IAT-C12-REL-DETECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-003` | C12 para.1; p.16; PDF 22 | Exclusion rule | Exclude initial transient effects from the eligible `ReL` candidate set and retain the excluded interval. | `SCI-019`; `SAT-019` | `IAT-C12-REL-DETECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-004` | C12 para.1; p.16; PDF 22 | Formula | Calculate `ReL` from its selected force and original cross-sectional area `S0`. | `SCI-019`; `SAT-019` | `IAT-C12-REL-DETECTION` | `IP-C12-FORMULA-REL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-005` | C12 para.2; p.16; PDF 22 | Short-procedure applicability | Permit the shortened `ReL` procedure only for material behavior that exhibits a yield phenomenon. | `SCI-019`; `SAT-019` | `IAT-C12-REL-SHORT` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-006` | C12 para.2; p.16; PDF 22 | Short-procedure applicability | Permit the shortened procedure only when `Ae` is not to be determined. | `SCI-019`, `SCI-023`; `SAT-019`, `SAT-023` | `IAT-C12-REL-SHORT` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-007` | C12 para.2; p.16; PDF 22 | Short-procedure window | For the shortened path, select the lowest qualified stress within the first 0.25 percent strain after `ReH`, still excluding initial transients. | `SCI-019`; `SAT-019` | `IAT-C12-REL-SHORT` | `IP-C12-SHORT-WINDOW-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-008` | C12 para.2; p.16; PDF 22 | Rate transition | Only after shortened-path `ReL` is determined may the test rate move to the applicable post-yield condition in 10.3.2.4 or 10.3.3.3. | `SCI-013`, `SCI-014`, `SCI-019`; `SAT-013`, `SAT-014`, `SAT-019` | `IAT-C12-REL-SHORT` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-009` | C12 para.2; p.16; PDF 22 | Reporting | Record use of the shortened `ReL` procedure in the test report. | `SCI-019`, `SCI-037`; `SAT-019`, `SAT-037` | `IAT-C11-C16-REPORTING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C12-F02-001` | Figure 2(a-d); p.22; PDF 28 | Figure construction | Retain the qualified yielding interval, excluded initial transient where present, selected `ReL` coordinate and explicit absence when an illustrated curve has no valid lower-yield point. | `SCI-019`; `SAT-019` | `IAT-F02-YIELD-CURVES` | - | EXTRACTED / REVIEW-PENDING |

## Clause 13 - Proof strength, plastic extension

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C13-001` | 13.1 para.1; p.16; PDF 22 | Primary path | Determine `Rp{x}` from the force-extension curve using the requested plastic-extension percentage. | `SCI-020`; `SAT-020` | `IAT-C13-RP-PRIMARY` | `IP-C13-RP-OFFSET-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-002` | 13.1 para.1; p.16; PDF 22 | Construction | Establish the qualified linear portion of the curve and retain the line/slope evidence. | `SCI-020`; `SAT-020` | `IAT-C13-RP-PRIMARY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-003` | 13.1 para.1; p.16; PDF 22 | Construction | Draw the proof line parallel to the qualified linear portion and offset it along the extension axis by the requested plastic percentage. | `SCI-020`; `SAT-020` | `IAT-C13-RP-PRIMARY` | `IP-C13-RP-OFFSET-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-004` | 13.1 para.1; p.16; PDF 22 | Intersection | Use the proof-line/curve intersection as the force coordinate for `Rp{x}`; record exact-sample or interpolation provenance. | `SCI-020`; `SAT-020` | `IAT-C13-RP-PRIMARY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-005` | 13.1 para.1; p.16; PDF 22 | Formula | Calculate `Rp{x}` by dividing the intersection force by `S0`. | `SCI-020`; `SAT-020` | `IAT-C13-RP-PRIMARY` | `IP-C13-FORMULA-RP` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-006` | 13.1 para.2; p.16; PDF 22 | Alternative trigger | Use the recommended hysteresis path only when the straight portion is insufficiently defined for a precise primary construction. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-007` | 13.1 para.3; p.16; PDF 22 | Alternative sequence | Begin the unload/reload operation only after the presumed proof strength has been exceeded. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-008` | 13.1 para.3; p.16; PDF 22 | Alternative parameter | Reduce force to approximately 10 percent of the previously obtained force and retain the actual reversal force. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | `IP-C13-HYSTERESIS-UNLOAD-FRACTION-APPROX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-009` | 13.1 para.3; p.16; PDF 22 | Alternative sequence | Reload until force exceeds the originally obtained value and retain the complete hysteresis interval. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-010` | 13.1 para.3; p.16; PDF 22 | Alternative construction | Determine and retain the reference line through the hysteresis loop. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-011` | 13.1 para.3; p.16; PDF 22 | Alternative construction | From the corrected origin, construct a line parallel to the hysteresis reference and offset by the requested plastic percentage. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | `IP-C13-RP-OFFSET-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-012` | 13.1 para.3; p.16; PDF 22 | Alternative intersection | Use the alternative proof-line/curve intersection as the force coordinate and retain its bracket/rule provenance. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-013` | 13.1 para.3; p.16; PDF 22 | Formula | Calculate alternative-path `Rp{x}` from the selected intersection force and `S0`, using the same property identity as the requested primary result. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | `IP-C13-FORMULA-RP` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-014` | 13.1 Note; p.16; PDF 22 | Corrected-origin construction | Permit the documented corrected-origin method that moves a line parallel to the hysteresis reference until tangent to the force-extension curve. | `SCI-020`; `SAT-020` | `IAT-F06-RP-CONSTRUCTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-015` | 13.1 Note; p.16; PDF 22 | Corrected-origin landmark | Use the tangent line's abscissa crossing as the corrected origin and retain the tangent/crossing coordinates. | `SCI-020`; `SAT-020` | `IAT-F06-RP-CONSTRUCTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-016` | 13.1 para.4; p.16; PDF 22 | Timing constraint | Perform the hysteresis only after the final requested proof strength has been passed. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-017` | 13.1 para.4; p.16; PDF 22 | Timing guidance | Perform the hysteresis at the lowest practicable extension and retain its start extension. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-018` | 13.1 para.4; p.16; PDF 22 | Quality warning | Treat excessive hysteresis extension as adverse to the derived slope and expose the selected extension/quality decision. | `SCI-020`; `SAT-020` | `IAT-C13-RP-HYSTERESIS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-019` | 13.1 para.5; p.16; PDF 22 | Applicability | Do not determine proof strength during or after discontinuous yielding unless a governing product standard or customer agreement explicitly specifies it. | `SCI-020`; `SAT-020` | `IAT-C13-RP-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-020` | 13.2; p.16; PDF 22 | Automatic path | Permit automatic determination without plotting only through a method whose construction/evidence remains equivalent and is routed to Annex A. | `SCI-020`, `SCI-031`; `SAT-020`, `SAT-031` | `IAT-C13-C14-AUTOMATIC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-021` | 13.2 Note; p.16; PDF 22 | Informative external method | Treat the referenced GB/T 228 method as an unimplemented external option; it cannot enter the ISO profile without controlled source identity, separate traceability and explicit selection. | `SCI-001`, `SCI-020`; `SAT-001`, `SAT-020` | `IAT-C13-EXTERNAL-METHOD` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-F03-001` | Figure 3; p.23; PDF 29 | Figure construction | Retain the elastic reference line, plastic-offset distance `ep`, parallel proof line and `Rp` intersection as separate linked construction objects. | `SCI-020`, `SCI-038`; `SAT-020`, `SAT-038` | `IAT-F03-RP-CONSTRUCTION` | `IP-C13-RP-OFFSET-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C13-F06-001` | Figure 6; p.24; PDF 30 | Figure construction | Retain the unload/reload loop, loop reference, tangent/corrected origin, offset line and alternative `Rp` intersection as separate linked construction objects. | `SCI-020`, `SCI-038`; `SAT-020`, `SAT-038` | `IAT-F06-RP-CONSTRUCTION` | `IP-C13-HYSTERESIS-UNLOAD-FRACTION-APPROX`; `IP-C13-RP-OFFSET-PERCENT` | EXTRACTED / REVIEW-PENDING |

## Clause 14 - Proof strength, total extension

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C14-001` | 14.1; p.16; PDF 22 | Input/correction | Determine `Rt{x}` from the force-extension curve while applying the declared preliminary-force correction required by 10.2. | `SCI-012`, `SCI-021`; `SAT-012`, `SAT-021` | `IAT-C14-RT-CONSTRUCTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C14-002` | 14.1; p.16; PDF 22 | Construction | Draw a line parallel to the force axis at the requested total percentage extension. | `SCI-021`; `SAT-021` | `IAT-C14-RT-CONSTRUCTION` | `IP-C14-RT-TOTAL-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C14-003` | 14.1; p.16; PDF 22 | Parameterization | Preserve the requested total-extension percentage in the `Rt{x}` property identity and construction evidence. | `SCI-021`; `SAT-021` | `IAT-C14-RT-CONSTRUCTION` | `IP-C14-RT-TOTAL-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C14-004` | 14.1; p.16; PDF 22 | Intersection | Use the vertical-line/curve intersection as the force coordinate and retain exact-sample or interpolation provenance. | `SCI-021`; `SAT-021` | `IAT-C14-RT-CONSTRUCTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C14-005` | 14.1; p.16; PDF 22 | Formula | Calculate `Rt{x}` by dividing the intersection force by `S0`. | `SCI-021`; `SAT-021` | `IAT-C14-RT-CONSTRUCTION` | `IP-C14-FORMULA-RT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C14-006` | 14.2; p.16; PDF 22 | Automatic path | Permit automatic determination without plotting only through an equivalent evidenced construction routed to Annex A. | `SCI-021`, `SCI-031`; `SAT-021`, `SAT-031` | `IAT-C13-C14-AUTOMATIC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C14-F04-001` | Figure 4; p.23; PDF 29 | Figure construction | Retain the prescribed total-extension coordinate `et`, its vertical line and the curve intersection as separate linked construction objects. | `SCI-021`, `SCI-038`; `SAT-021`, `SAT-038` | `IAT-F04-RT-CONSTRUCTION` | `IP-C14-RT-TOTAL-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C14-F04-002` | Figure 4; p.23; PDF 29 | Semantic boundary | Keep total-extension construction distinct from the plastic-offset construction used for `Rp{x}`; do not reuse the wrong line/origin semantics. | `SCI-020`, `SCI-021`; `SAT-020`, `SAT-021` | `IAT-F04-RT-CONSTRUCTION` | - | EXTRACTED / REVIEW-PENDING |

## Clause 15 - Permanent-set strength verification

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C15-001` | C15 para.1; p.17; PDF 23 | Input | Obtain the specified verification stress and its source before executing the permanent-set procedure. | `SCI-022`; `SAT-022` | `IAT-C15-RR-PROCEDURE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-002` | C15 para.1; p.17; PDF 23 | Formula | Calculate the target force from specified stress multiplied by original area `S0`. | `SCI-022`; `SAT-022` | `IAT-C15-RR-PROCEDURE` | `IP-C15-FORMULA-FORCE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-003` | C15 para.1; p.17; PDF 23 | Procedure | Load the specimen to the calculated target force and retain the attained force/stress evidence. | `SCI-022`; `SAT-022` | `IAT-C15-RR-PROCEDURE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-004` | C15 para.1; p.17; PDF 23 | Hold interval | Hold the target condition for 10 s to 12 s and retain actual entry, exit and duration evidence. | `SCI-022`; `SAT-022` | `IAT-C15-RR-PROCEDURE` | `IP-C15-HOLD-MIN`; `IP-C15-HOLD-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-005` | C15 para.1; p.17; PDF 23 | Procedure | Remove the force through a qualified unload and retain the unload endpoint; incomplete unloading is not a pass. | `SCI-022`; `SAT-022` | `IAT-C15-RR-PROCEDURE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-006` | C15 para.1; p.17; PDF 23 | Measurement | Measure the residual permanent extension or elongation on the declared `Le` or `L0` basis after unload. | `SCI-022`; `SAT-022` | `IAT-C15-RR-DECISION` | `IP-C15-PERMANENT-SET-LIMIT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-007` | C15 para.1; p.17; PDF 23 | Decision boundary | Pass only when residual permanent set is less than or equal to the specified percentage; equality is included. | `SCI-022`; `SAT-022` | `IAT-C15-RR-DECISION` | `IP-C15-PERMANENT-SET-LIMIT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-008` | C15 Note; p.17; PDF 23 | Parameter authority | Obtain both applied stress and permissible permanent-set percentage from the product specification or requester; do not invent defaults. | `SCI-022`; `SAT-022` | `IAT-C15-RR-DECISION` | `IP-C15-PERMANENT-SET-LIMIT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-009` | C15 Note; p.17; PDF 23 | Applicability | Treat this as a distinct pass/fail procedure that is not automatically part of the ordinary tensile test. | `SCI-022`; `SAT-022` | `IAT-C15-RR-PROCEDURE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-010` | C15 Note; p.17; PDF 23 | Reporting | Report the requested suffix/basis, applied stress and Pass/Fail outcome together; a Pass result is not a measured `Rr` search value. | `SCI-022`, `SCI-037`; `SAT-022`, `SAT-037` | `IAT-C11-C16-REPORTING` | `IP-C15-PERMANENT-SET-LIMIT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C15-F05-001` | Figure 5; p.24; PDF 30 | Figure construction | Retain the load target, hold interval, unloading path, zero-force endpoint and residual-set coordinate `er` as linked procedure evidence. | `SCI-022`, `SCI-038`; `SAT-022`, `SAT-038` | `IAT-F05-RR-CONSTRUCTION` | `IP-C15-HOLD-MIN`; `IP-C15-HOLD-MAX`; `IP-C15-PERMANENT-SET-LIMIT` | EXTRACTED / REVIEW-PENDING |

## Clause 16 - Percentage yield-point extension

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C16-001` | C16 para.1; p.17; PDF 23 | Applicability | Determine `Ae` only for material behavior that exhibits discontinuous yielding. | `SCI-023`; `SAT-023` | `IAT-C16-AE-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-002` | C16 para.1; p.17; PDF 23 | Start landmark | Use the extension coordinate at `ReH` as the start boundary of `Ae`. | `SCI-018`, `SCI-023`; `SAT-018`, `SAT-023` | `IAT-C16-AE-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-003` | C16 para.1; p.17; PDF 23 | End landmark | Use the constructed start of uniform work-hardening as the end boundary of `Ae`. | `SCI-023`; `SAT-023` | `IAT-C16-AE-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-004` | C16 para.1; p.17; PDF 23 | Formula | Subtract start extension from end extension and express the difference as a percentage of `Le`. | `SCI-023`; `SAT-023` | `IAT-C16-AE-APPLICABILITY` | `IP-C16-FORMULA-AE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-005` | C16 para.1; p.17; PDF 23 | Horizontal method landmark | Identify the last local minimum before uniform work-hardening and retain its candidate/selection evidence. | `SCI-023`; `SAT-023` | `IAT-C16-AE-HORIZONTAL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-006` | C16 para.1; p.17; PDF 23 | Horizontal method construction | Construct a horizontal line through the selected last local minimum. | `SCI-023`; `SAT-023` | `IAT-C16-AE-HORIZONTAL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-007` | C16 para.1; p.17; PDF 23 | Horizontal method intersection | Intersect the horizontal line with the line of highest slope at the start of uniform work-hardening to determine the end coordinate. | `SCI-023`; `SAT-023` | `IAT-C16-AE-HORIZONTAL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-008` | C16 para.1; p.17; PDF 23 | Regression method range | Select and retain the yielding range before uniform work-hardening used by the regression alternative. | `SCI-023`; `SAT-023` | `IAT-C16-AE-REGRESSION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-009` | C16 para.1; p.17; PDF 23 | Regression method construction | Fit the declared regression line through the selected yielding range and retain included samples, fit rule and revision. | `SCI-023`; `SAT-023` | `IAT-C16-AE-REGRESSION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-010` | C16 para.1; p.17; PDF 23 | Regression method intersection | Intersect the regression line with the line of highest slope at uniform work-hardening onset to determine the end coordinate. | `SCI-023`; `SAT-023` | `IAT-C16-AE-REGRESSION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-011` | C16 para.1; p.17; PDF 23 | Highest-slope landmark | Determine and retain the curve line corresponding to the highest slope at the start of uniform work-hardening. | `SCI-023`; `SAT-023` | `IAT-F07-AE-CONSTRUCTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-012` | C16 para.2; p.17; PDF 23 | Reporting | Record whether the horizontal-line or regression construction was used; do not switch methods silently. | `SCI-023`, `SCI-037`; `SAT-023`, `SAT-037` | `IAT-C11-C16-REPORTING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-F07-001` | Figure 7(a); p.25; PDF 31 | Figure construction | For the horizontal method, retain `ReH`, last local minimum, horizontal line, highest-slope line, intersection and resulting `Ae` span as linked objects. | `SCI-023`, `SCI-038`; `SAT-023`, `SAT-038` | `IAT-F07-AE-CONSTRUCTION` | `IP-C16-FORMULA-AE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C16-F07-002` | Figure 7(b); p.25; PDF 31 | Figure construction | For the regression method, retain `ReH`, selected yielding range, regression line, highest-slope line, intersection and resulting `Ae` span as linked objects distinct from method (a). | `SCI-023`, `SCI-038`; `SAT-023`, `SAT-038` | `IAT-F07-AE-CONSTRUCTION` | `IP-C16-FORMULA-AE` | EXTRACTED / REVIEW-PENDING |

## Package count and evidence boundary

- Atomic source items: **71** (`C11=5`, `C12=10`, `C13=23`, `C14=8`, `C15=11`, `C16=14`).
- Parameter/formula records: **13**.
- Atomic acceptance variants: **21**.
- Coverage status: extraction and bidirectional family/test/parameter routing complete for this package; independent interpretation/parameter review and all executable evidence remain pending.
- Excluded from this package: Clauses 17-23, Annexes A-L, detailed referenced-standard requirements and ASTM E8/E8M-15a.
