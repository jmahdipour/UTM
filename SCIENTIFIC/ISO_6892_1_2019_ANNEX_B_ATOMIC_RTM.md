---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_B_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic RTM - Annex B

## Control statement

This inventory paraphrases normative Annex B, Tables B.1-B.2 and the shared rectangular-specimen Figure 11 of the controlled English third edition. It does not reproduce the standard. Printed-page and PDF-page locators identify the controlled local source. Figure 11 is recorded once here; later Annex-D traceability shall reference these figure source items instead of duplicating them.

`EXTRACTED / REVIEW-PENDING` means that the source item is independently addressable and cross-linked, but its interpretation and parameterization have not received independent scientific sign-off. No row is implementation, validation execution or conformity evidence.

## Figure 11 - Shared rectangular-specimen geometry

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AB-F11-001` | Figure 11 caption; p.29; PDF 35 | Shared applicability | Use the figure as the geometry vocabulary for machined rectangular specimens governed by Annex B or Annex D; keep the selected annex profile explicit. | `SCI-001`, `SCI-007`, `SCI-032`; `SAT-001`, `SAT-007`, `SAT-032` | `IAT-AB-FIGURE11-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-F11-002` | Figure 11(a) and key; p.29; PDF 35 | Geometry identity | Distinguish original thickness `a0` from original parallel-width `b0` and retain their dimension sources. | `SCI-006`, `SCI-007`, `SCI-008`, `SCI-038`; `SAT-006`, `SAT-007`, `SAT-008`, `SAT-038` | `IAT-AB-FIGURE11-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-F11-003` | Figure 11(a) and key; p.29; PDF 35 | Length identity | Preserve `L0`, `Lc` and `Lt` as distinct geometry quantities; the drawing does not authorize substituting one for another. | `SCI-006`, `SCI-007`, `SCI-009`; `SAT-006`, `SAT-007`, `SAT-009` | `IAT-AB-FIGURE11-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-F11-004` | Figure 11(a) and key; p.29; PDF 35 | Area identity | Bind `S0` to the original cross-section of the parallel length and retain the dimensions used to determine it. | `SCI-006`, `SCI-008`, `SCI-038`; `SAT-006`, `SAT-008`, `SAT-038` | `IAT-AB-S0-DETERMINATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-F11-005` | Figure 11(a) key item 1; p.29; PDF 35 | Fixture context | Represent the gripped ends separately from the parallel length so grip geometry is not used as the measurement section. | `SCI-007`, `SCI-012`; `SAT-007`, `SAT-012` | `IAT-AB-FIGURE11-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-F11-006` | Figure 11(b) and key; p.29; PDF 35 | Post-fracture identity | Preserve final gauge length `Lu` as a post-fracture quantity distinct from the original geometry. | `SCI-006`, `SCI-027`, `SCI-038`; `SAT-006`, `SAT-027`, `SAT-038` | `IAT-AB-FIGURE11-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-F11-007` | Figure 11 note; p.29; PDF 35 | Drawing limitation | Treat the illustrated head shape as guidance only, not as an unlisted mandatory dimensional profile. | `SCI-001`, `SCI-007`, `SCI-032`; `SAT-001`, `SAT-007`, `SAT-032` | `IAT-AB-FIGURE11-GEOMETRY` | - | EXTRACTED / REVIEW-PENDING |

## B.1-B.2 - Applicability and shape

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AB-001` | Annex B title; p.40; PDF 46 | Normative profile | Select Annex B for sheets, strips and flats within the controlled thin-product thickness interval. | `SCI-001`, `SCI-007`, `SCI-032`; `SAT-001`, `SAT-007`, `SAT-032` | `IAT-AB-PROFILE-APPLICABILITY` | `IP-PRODUCT-B-THICKNESS-MIN`; `IP-PRODUCT-B-THICKNESS-MAX-EXCLUSIVE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-002` | B.1; p.40; PDF 46 | Thin-product caution | For product below the stated thickness, require a declared assessment of whether special precautions are needed. | `SCI-007`, `SCI-036`, `SCI-039`; `SAT-007`, `SAT-036`, `SAT-039` | `IAT-AB-SPECIAL-THIN-HANDLING` | `IP-AB-SPECIAL-PRECAUTION-THICKNESS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-003` | B.2 para.1 sentence 1; p.40; PDF 46 | Common shape | Support the common form with gripped ends wider than the parallel length without making it the only permitted form. | `SCI-007`, `SCI-032`; `SAT-007`, `SAT-032` | `IAT-AB-END-TRANSITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-004` | B.2 para.1 sentence 2; p.40; PDF 46 | Mandatory geometry | Require the parallel length to join the ends through transition curves meeting the stated minimum radius. | `SCI-007`, `SCI-032`; `SAT-007`, `SAT-032` | `IAT-AB-END-TRANSITION` | `IP-AB-TRANSITION-RADIUS-MIN` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-005` | B.2 para.1 sentence 3; p.40; PDF 46 | Recommended geometry | Preserve the recommended minimum end-width ratio as guidance and record deviations rather than silently treating it as an unconditional shall-limit. | `SCI-007`, `SCI-032`, `SCI-039`; `SAT-007`, `SAT-032`, `SAT-039` | `IAT-AB-END-TRANSITION` | `IP-AB-END-WIDTH-RATIO-MIN-RECOMMENDED` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-006` | B.2 para.2 sentence 1; p.40; PDF 46 | Agreement route | Permit a parallel-sided strip only when the governing agreement is retained with the specimen profile. | `SCI-001`, `SCI-003`, `SCI-007`, `SCI-032`; `SAT-001`, `SAT-003`, `SAT-007`, `SAT-032` | `IAT-AB-PARALLEL-SIDED-SELECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-007` | B.2 para.2 sentence 2; p.40; PDF 46 | Full-width option | For product no wider than the stated boundary, permit specimen width to equal product width while retaining the full-width route identity. | `SCI-007`, `SCI-008`, `SCI-032`; `SAT-007`, `SAT-008`, `SAT-032` | `IAT-AB-PARALLEL-SIDED-SELECTION` | `IP-AB-FULL-WIDTH-MAX` | EXTRACTED / REVIEW-PENDING |

## B.3 - Dimensions and profile selection

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AB-008` | B.3 para.1; p.40; PDF 46 | Profile catalog | Encode the three listed non-proportional specimen types as distinct profiles rather than a free-form nearest match. | `SCI-007`, `SCI-032`; `SAT-007`, `SAT-032` | `IAT-AB-TABLE-B1-PROFILES` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-009` | B.3 para.2; p.40; PDF 46 | Mandatory relation | Enforce the minimum parallel-length relation between `Lc`, `L0` and `b0`. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-032`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032` | `IAT-AB-LENGTH-RELATIONS` | `IP-AB-LC-MIN-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-010` | B.3 para.3; p.40; PDF 46 | Dispute guidance | In a dispute, apply the stated longer parallel-length recommendation unless available material is insufficient, and retain the exception decision. | `SCI-001`, `SCI-007`, `SCI-032`, `SCI-038`; `SAT-001`, `SAT-007`, `SAT-032`, `SAT-038` | `IAT-AB-LENGTH-RELATIONS` | `IP-AB-LC-DISPUTE-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-011` | B.3 para.4 sentence 1; p.40; PDF 46 | Default applicability | For a parallel-sided specimen below the stated width and absent another product-standard rule, use the Annex-B default `L0`. | `SCI-001`, `SCI-007`, `SCI-009`, `SCI-032`; `SAT-001`, `SAT-007`, `SAT-009`, `SAT-032` | `IAT-AB-PARALLEL-SIDED-SELECTION` | `IP-AB-PARALLEL-SIDED-WIDTH-MAX-EXCLUSIVE`; `IP-AB-PARALLEL-SIDED-L0-DEFAULT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-012` | B.3 para.4 sentence 1; p.40; PDF 46 | External authority | Permit a different gauge length only from a pinned product-standard rule; absence of authority does not create a user-defined silent override. | `SCI-001`, `SCI-002`, `SCI-003`, `SCI-009`; `SAT-001`, `SAT-002`, `SAT-003`, `SAT-009` | `IAT-AB-PARALLEL-SIDED-SELECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-013` | B.3 para.4 sentence 2; p.40; PDF 46 | Mandatory relation | For that parallel-sided route, calculate free length between grips from the stated `L0` and `b0` relation. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-032`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032` | `IAT-AB-LENGTH-RELATIONS` | `IP-AB-FREE-LENGTH-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-014` | B.3 para.5; p.40; PDF 46 | Shape control | Apply Table B.2 shape tolerances when individual specimen dimensions are measured. | `SCI-007`, `SCI-008`, `SCI-032`; `SAT-007`, `SAT-008`, `SAT-032` | `IAT-AB-WIDTH-TOLERANCE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-015` | B.3 para.6; p.40; PDF 46 | Measured-area route | Where specimen width equals product width, determine `S0` from measured specimen dimensions. | `SCI-007`, `SCI-008`, `SCI-032`, `SCI-038`; `SAT-007`, `SAT-008`, `SAT-032`, `SAT-038` | `IAT-AB-S0-DETERMINATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-016` | B.3 para.7; p.40; PDF 46 | Nominal-width route | Use nominal width without measuring each specimen only when both the applicable machining and shape tolerances are evidenced. | `SCI-003`, `SCI-007`, `SCI-008`, `SCI-032`; `SAT-003`, `SAT-007`, `SAT-008`, `SAT-032` | `IAT-AB-NOMINAL-WIDTH-ELIGIBILITY` | - | EXTRACTED / REVIEW-PENDING |

## Table B.1 - Standard non-proportional specimen types

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AB-TB1-001` | Table B.1 type 1; p.41; PDF 47 | Profile row | Preserve the complete type-1 width, gauge-length, parallel-length and parallel-sided free-length tuple as one controlled profile row. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-032`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032` | `IAT-AB-TABLE-B1-PROFILES` | `IP-AB-TYPE1-DIMENSIONS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-TB1-002` | Table B.1 type 2; p.41; PDF 47 | Profile row | Preserve the complete type-2 dimensional tuple independently from type 1. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-032`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032` | `IAT-AB-TABLE-B1-PROFILES` | `IP-AB-TYPE2-DIMENSIONS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-TB1-003` | Table B.1 type 3; p.41; PDF 47 | Profile row | Preserve the type-3 dimensional tuple, including the absence of a recommended `Lc` and the undefined parallel-sided free length. | `SCI-006`, `SCI-007`, `SCI-009`, `SCI-032`, `SCI-039`; `SAT-006`, `SAT-007`, `SAT-009`, `SAT-032`, `SAT-039` | `IAT-AB-TABLE-B1-PROFILES` | `IP-AB-TYPE3-DIMENSIONS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-TB1-004` | Table B.1 footnote a; p.41; PDF 47 | Result comparability | Retain the warning that type-3 length-to-width ratios can change elongation-after-fracture values and scatter relative to types 1 and 2. | `SCI-007`, `SCI-027`, `SCI-032`, `SCI-036`; `SAT-007`, `SAT-027`, `SAT-032`, `SAT-036` | `IAT-AB-TYPE3-COMPARABILITY` | - | EXTRACTED / REVIEW-PENDING |

## Table B.2 - Width machining and shape tolerances

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AB-TB2-001` | Table B.2 nominal width 12.5; p.41; PDF 47 | Tolerance row | Apply the machining and shape limits tied to the 12.5 mm nominal-width row without borrowing limits from another row. | `SCI-007`, `SCI-008`, `SCI-032`; `SAT-007`, `SAT-008`, `SAT-032` | `IAT-AB-WIDTH-TOLERANCE` | `IP-AB-B2-WIDTH-12-5-TOLERANCES` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-TB2-002` | Table B.2 nominal width 20; p.41; PDF 47 | Tolerance row | Apply the machining and shape limits tied to the 20 mm nominal-width row. | `SCI-007`, `SCI-008`, `SCI-032`; `SAT-007`, `SAT-008`, `SAT-032` | `IAT-AB-WIDTH-TOLERANCE` | `IP-AB-B2-WIDTH-20-TOLERANCES` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-TB2-003` | Table B.2 nominal width 25; p.41; PDF 47 | Tolerance row | Apply the machining and shape limits tied to the 25 mm nominal-width row. | `SCI-007`, `SCI-008`, `SCI-032`; `SAT-007`, `SAT-008`, `SAT-032` | `IAT-AB-WIDTH-TOLERANCE` | `IP-AB-B2-WIDTH-25-TOLERANCES` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-TB2-004` | Table B.2 footnote a; p.41; PDF 47 | Conditional authority | Treat machining tolerances as the gate for using nominal width in `S0`; they are not a general waiver of dimensional evidence. | `SCI-003`, `SCI-008`, `SCI-032`, `SCI-038`; `SAT-003`, `SAT-008`, `SAT-032`, `SAT-038` | `IAT-AB-NOMINAL-WIDTH-ELIGIBILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-TB2-005` | Table B.2 footnote b; p.41; PDF 47 | Shape definition | Evaluate shape tolerance as the maximum width deviation over measurements along the entire `Lc`. | `SCI-007`, `SCI-008`, `SCI-032`, `SCI-038`; `SAT-007`, `SAT-008`, `SAT-032`, `SAT-038` | `IAT-AB-WIDTH-TOLERANCE` | - | EXTRACTED / REVIEW-PENDING |

## B.4 - Preparation of specimens

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AB-017` | B.4 para.1 sentence 1; p.41; PDF 47 | Preparation integrity | Prepare specimens without altering the relevant properties of the sample. | `SCI-007`, `SCI-032`; `SAT-007`, `SAT-032` | `IAT-AB-PREPARATION-INTEGRITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-018` | B.4 para.1 sentence 2; p.41; PDF 47 | Conditional machining | Remove shear- or punch-hardened zones by machining when they would affect the properties. | `SCI-007`, `SCI-032`, `SCI-039`; `SAT-007`, `SAT-032`, `SAT-039` | `IAT-AB-PREPARATION-INTEGRITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-019` | B.4 para.2 sentence 1; p.41; PDF 47 | Product context | Keep the Annex-B preparation route associated with specimens predominantly taken from sheet or strip. | `SCI-007`, `SCI-032`; `SAT-007`, `SAT-032` | `IAT-AB-PREPARATION-INTEGRITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-020` | B.4 para.2 sentence 2; p.41; PDF 47 | Surface guidance | Where practicable, preserve as-rolled surfaces and record any removal rather than silently treating it as neutral. | `SCI-007`, `SCI-032`, `SCI-038`; `SAT-007`, `SAT-032`, `SAT-038` | `IAT-AB-PREPARATION-INTEGRITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-021` | B.4 para.3 sentence 1; p.41; PDF 47 | Preparation risk | Flag punching as capable of materially changing properties, particularly yield or proof strength through work hardening. | `SCI-007`, `SCI-018`, `SCI-020`, `SCI-032`, `SCI-036`; `SAT-007`, `SAT-018`, `SAT-020`, `SAT-032`, `SAT-036` | `IAT-AB-PREPARATION-INTEGRITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-022` | B.4 para.3 sentence 2; p.41; PDF 47 | Recommended preparation | For material with high work hardening, preserve milling, grinding or an equivalently justified route as the general recommendation. | `SCI-007`, `SCI-032`; `SAT-007`, `SAT-032` | `IAT-AB-PREPARATION-INTEGRITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-023` | B.4 para.4 sentence 1; p.41; PDF 47 | Very-thin preparation | For a selected very-thin-material workflow, cut strips to identical widths before bundling. | `SCI-003`, `SCI-007`, `SCI-032`; `SAT-003`, `SAT-007`, `SAT-032` | `IAT-AB-VERY-THIN-PREPARATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-024` | B.4 para.4 sentence 1; p.41; PDF 47 | Bundle separation | Use cutting-oil-resistant paper as intermediate layers in the described bundle workflow. | `SCI-003`, `SCI-007`, `SCI-032`; `SAT-003`, `SAT-007`, `SAT-032` | `IAT-AB-VERY-THIN-PREPARATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-025` | B.4 para.4 sentence 2; p.41; PDF 47 | Bundle support | Place a thicker support strip on each side of the small bundle before final machining. | `SCI-003`, `SCI-007`, `SCI-032`; `SAT-003`, `SAT-007`, `SAT-032` | `IAT-AB-VERY-THIN-PREPARATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-026` | B.4 para.5 and examples; p.41; PDF 47 | Inclusive tolerance example | For the illustrated nominal-width case, admit the two calculated endpoints and reject values outside them when nominal width is to replace individual measurement. | `SCI-007`, `SCI-008`, `SCI-032`; `SAT-007`, `SAT-008`, `SAT-032` | `IAT-AB-NOMINAL-WIDTH-ELIGIBILITY` | `IP-AB-NOMINAL-WIDTH-RANGE-FORMULA` | EXTRACTED / REVIEW-PENDING |

## B.5 - Original cross-sectional area

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AB-027` | B.5 para.1; p.42; PDF 48 | Area route | Determine `S0` from measured specimen dimensions or from the separately qualified good-machining route referenced by Table B.2. | `SCI-007`, `SCI-008`, `SCI-032`, `SCI-038`; `SAT-007`, `SAT-008`, `SAT-032`, `SAT-038` | `IAT-AB-S0-DETERMINATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-028` | B.5 para.2 sentence 1; p.42; PDF 48 | Mandatory accuracy | Enforce the stated maximum error for determining original cross-sectional area. | `SCI-008`, `SCI-010`, `SCI-032`, `SCI-036`; `SAT-008`, `SAT-010`, `SAT-032`, `SAT-036` | `IAT-AB-S0-ACCURACY` | `IP-AB-S0-ERROR-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-029` | B.5 para.2 sentence 2; p.42; PDF 48 | Error-source guidance | Retain thickness measurement as the normally dominant contributor instead of assuming width accuracy alone proves area accuracy. | `SCI-008`, `SCI-010`, `SCI-032`, `SCI-036`; `SAT-008`, `SAT-010`, `SAT-032`, `SAT-036` | `IAT-AB-S0-ACCURACY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-030` | B.5 para.2 sentence 2; p.42; PDF 48 | Mandatory accuracy | Enforce the stated maximum width-measurement error independently from the total `S0` error limit. | `SCI-008`, `SCI-010`, `SCI-032`; `SAT-008`, `SAT-010`, `SAT-032` | `IAT-AB-S0-ACCURACY` | `IP-AB-WIDTH-MEASUREMENT-ERROR-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-031` | B.5 para.3 sentence 1; p.42; PDF 48 | Reduced-uncertainty guidance | Preserve the more accurate recommended `S0` target as an uncertainty-reduction option, not a replacement for the mandatory ceiling. | `SCI-008`, `SCI-032`, `SCI-036`; `SAT-008`, `SAT-032`, `SAT-036` | `IAT-AB-S0-ACCURACY` | `IP-AB-S0-REDUCED-UNCERTAINTY-ACCURACY` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AB-032` | B.5 para.3 sentence 2; p.42; PDF 48 | Thin-material metrology | Require a declared decision on special measurement technique for thin material where ordinary dimensional measurement is inadequate. | `SCI-007`, `SCI-008`, `SCI-010`, `SCI-032`, `SCI-039`; `SAT-007`, `SAT-008`, `SAT-010`, `SAT-032`, `SAT-039` | `IAT-AB-SPECIAL-THIN-HANDLING` | - | EXTRACTED / REVIEW-PENDING |

## Package count and evidence boundary

- Atomic source items: **48** (`B.1-B.5=32`, `Figure 11=7`, `Table B.1=4`, `Table B.2=5`).
- Parameter/formula records: **19** new Annex-B records; the two thin-product applicability limits reuse controlled parameters from package 1.
- Atomic acceptance variants: **14**.
- Coverage status: extraction and bidirectional family/test/parameter routing complete for Annex B, Tables B.1-B.2 and Figure 11; independent interpretation/parameter review and all executable evidence remain pending.
- Review blocker: the general `Lc >= L0 + b0/2` relation and some Table-B.1 width/`Lc` combinations do not numerically agree across the full stated width range. Text/table precedence and footnote effect remain unresolved; no production rule is selected by this extraction.
- Excluded from this package: Figures 12-15, Annexes C-L, detailed referenced-standard requirements and ASTM E8/E8M-15a.
