---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_CLAUSES_17_23_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic RTM - Clauses 17 to 23

## Control statement

This inventory paraphrases the controlled English third edition. It does not reproduce the standard. Printed-page and PDF-page locators identify the controlled local source. Figures 1 and 8-10 are included because they complete the property, rate and validity semantics used by Clauses 17-23 and the previously routed `Rm`/rate families.

`EXTRACTED / REVIEW-PENDING` means that the source item is independently addressable and cross-linked, but its interpretation and parameterization have not received independent scientific sign-off. No row is implementation or execution evidence.

## Figure 8 - Tensile-strength behavior referenced by the property model

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C03-F08-001` | Figure 8(a); p.26; PDF 32 | Behavior class | Represent a discontinuous-yield curve for which `ReH` is below `Rm`; retain both distinct selected landmarks. | `SCI-017`, `SCI-018`; `SAT-017`, `SAT-018` | `IAT-F08-RM-BEHAVIOR` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-F08-002` | Figure 8(b); p.26; PDF 32 | Behavior class | Represent a curve for which `ReH` exceeds `Rm`; do not assume that upper yield is always below tensile strength. | `SCI-017`, `SCI-018`; `SAT-017`, `SAT-018` | `IAT-F08-RM-BEHAVIOR` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-F08-003` | Figure 8(c); p.26; PDF 32 | Applicability | For the illustrated special stress-extension behavior, return no ISO-defined tensile strength rather than forcing a maximum-stress value. | `SCI-017`, `SCI-039`; `SAT-017`, `SAT-039` | `IAT-F08-RM-BEHAVIOR` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-F08-004` | Figure 8(c) note; p.26; PDF 32 | External agreement | Keep any separately agreed result for the special behavior outside the default ISO `Rm` path and retain the agreement authority. | `SCI-001`, `SCI-017`; `SAT-001`, `SAT-017` | `IAT-F08-RM-BEHAVIOR` | - | EXTRACTED / REVIEW-PENDING |

## Figures 9 and 10 - Rate schedule and discontinuity evidence

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C10-F09-001` | Figure 9(a); p.27; PDF 33 | Method A schedule | Preserve the illustrated Method A control-mode transitions across elastic, yield/proof and post-yield property regions. | `SCI-013`, `SCI-015`; `SAT-013`, `SAT-015` | `IAT-F09-RATE-SCHEDULE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F09-002` | Figure 9(a), range 1; p.27; PDF 33 | Numeric rate | Route illustrated Method A range 1 and its relative tolerance to the controlled rate parameters. | `SCI-013`; `SAT-013` | `IAT-F09-RATE-SCHEDULE` | `IP-RATE-A1`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F09-003` | Figure 9(a), range 2; p.27; PDF 33 | Numeric rate | Route illustrated Method A range 2 and its relative tolerance to the controlled rate parameters. | `SCI-013`; `SAT-013` | `IAT-F09-RATE-SCHEDULE` | `IP-RATE-A2`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F09-004` | Figure 9(a), range 3; p.27; PDF 33 | Numeric rate | Route illustrated Method A range 3 and its relative tolerance to the controlled rate parameters. | `SCI-013`; `SAT-013` | `IAT-F09-RATE-SCHEDULE` | `IP-RATE-A3`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F09-005` | Figure 9(a), range 4; p.27; PDF 33 | Numeric rate | Route illustrated Method A range 4, its per-minute equivalent and relative tolerance to the controlled rate parameters. | `SCI-013`; `SAT-013` | `IAT-F09-RATE-SCHEDULE` | `IP-RATE-A4`; `IP-RATE-A4-MIN`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F09-006` | Figure 9(b); p.27; PDF 33 | Method B schedule | Preserve the illustrated Method B stress-rate elastic stage, strain-rate post-yield stages and their property boundaries. | `SCI-014`, `SCI-015`; `SAT-014`, `SAT-015` | `IAT-F09-RATE-SCHEDULE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F09-007` | Figure 9 note 2; p.27; PDF 33 | Illustration assumption | Treat the stated steel modulus used to convert Method B stress rate to illustrated elastic strain rate as a figure assumption, not a universal measured `E` or `mE`. | `SCI-014`, `SCI-034`, `SCI-035`; `SAT-014`, `SAT-034`, `SAT-035` | `IAT-F09-RATE-SCHEDULE` | `IP-F09-METHOD-B-E-ILLUSTRATION` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F09-008` | Figure 9 note b; p.27; PDF 33 | Fallback route | Keep the expanded lower Method B range conditional on inability to measure or control strain rate and link it to the recorded fallback reason. | `SCI-014`, `SCI-015`; `SAT-014`, `SAT-015` | `IAT-F09-RATE-SCHEDULE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F10-001` | Figure 10; p.28; PDF 34 | Artifact class | Detect the illustrated abrupt strain-rate increase and retain its transition interval instead of treating it as material behavior. | `SCI-013`, `SCI-014`, `SCI-030`; `SAT-013`, `SAT-014`, `SAT-030` | `IAT-F10-DISCONTINUITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F10-002` | Figure 10; p.28; PDF 34 | Invalid property evidence | Mark property candidates caused by the abrupt rate discontinuity as inadmissible rather than reporting the illustrated false values. | `SCI-017`, `SCI-020`, `SCI-024`, `SCI-025`, `SCI-039`; `SAT-017`, `SAT-020`, `SAT-024`, `SAT-025`, `SAT-039` | `IAT-F10-DISCONTINUITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-F10-003` | Figure 10; p.28; PDF 34 | Provenance | Retain both the raw discontinuous trace and the qualified evaluation interval so later re-analysis cannot hide or smooth away the rate artifact. | `SCI-030`, `SCI-038`, `SCI-041`; `SAT-030`, `SAT-038`, `SAT-041` | `IAT-F10-DISCONTINUITY` | - | EXTRACTED / REVIEW-PENDING |

## Clause 17 - Percentage plastic extension at maximum force

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C17-001` | C17 para.1; p.17; PDF 23 | Measurement source | Determine `Ag` from a force-extension curve acquired with an extensometer; a crosshead-only curve is not silently equivalent. | `SCI-024`; `SAT-024` | `IAT-C17-AG-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-002` | C17 para.1; p.17; PDF 23 | Landmark | Select the qualified extension coordinate at maximum force and retain its sample or interpolation bracket. | `SCI-017`, `SCI-024`; `SAT-017`, `SAT-024` | `IAT-C17-AG-CALC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-003` | C17 para.1; p.17; PDF 23 | Elastic correction | Subtract the elastic strain contribution from total extension at maximum force to obtain plastic extension. | `SCI-024`, `SCI-035`; `SAT-024`, `SAT-035` | `IAT-C17-AG-CALC` | `IP-C17-FORMULA-AG` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-004` | C17 Formula 3; p.17; PDF 23 | Formula | Calculate `Ag` from maximum-force extension, `Le`, `Rm` and the declared elastic-part slope. | `SCI-024`; `SAT-024` | `IAT-C17-AG-CALC` | `IP-C17-FORMULA-AG` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-005` | C17 Formula 3; p.17; PDF 23 | Formula input | Use `DeltaLm` from the same qualified maximum-force event and curve revision as the result. | `SCI-017`, `SCI-024`; `SAT-017`, `SAT-024` | `IAT-C17-AG-CALC` | `IP-C17-FORMULA-AG` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-006` | C17 Formula 3; p.17; PDF 23 | Formula input | Use a positive, unit-compatible extensometer gauge length `Le`; do not substitute `L0` silently. | `SCI-006`, `SCI-024`; `SAT-006`, `SAT-024` | `IAT-C17-AG-CALC` | `IP-C17-FORMULA-AG` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-007` | C17 Formula 3; p.17; PDF 23 | Formula input | Use `Rm` from the same qualified run and preserve its applicability state. | `SCI-017`, `SCI-024`; `SAT-017`, `SAT-024` | `IAT-C17-AG-CALC` | `IP-C17-FORMULA-AG` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-008` | C17 Formula 3; p.17; PDF 23 | Formula input | Use the declared slope `mE` of the elastic part; do not substitute Annex G modulus `E` without explicit traced equivalence. | `SCI-024`, `SCI-035`; `SAT-024`, `SAT-035` | `IAT-C17-AG-CALC` | `IP-C17-FORMULA-AG` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-009` | C17 note; p.17; PDF 23 | Plateau rule | When maximum force forms a plateau, locate maximum-force extension at the plateau midpoint rather than an arbitrary first or last sample. | `SCI-017`, `SCI-024`; `SAT-017`, `SAT-024` | `IAT-C17-C18-PLATEAU` | `IP-C17-C18-PLATEAU-MIDPOINT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-F01-001` | Figure 1; p.21; PDF 27 | Figure construction | Retain `Rm`, the maximum-force extension line, the elastic-slope line and the plastic `Ag` span as linked construction objects. | `SCI-017`, `SCI-024`, `SCI-038`; `SAT-017`, `SAT-024`, `SAT-038` | `IAT-F01-EXTENSION-CONSTRUCTION` | `IP-C17-FORMULA-AG` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C17-F01-002` | Figure 1; p.21; PDF 27 | Plateau construction | Represent plateau extent `Deltae` and its half-width construction on each side of the selected midpoint. | `SCI-017`, `SCI-024`, `SCI-025`, `SCI-038`; `SAT-017`, `SAT-024`, `SAT-025`, `SAT-038` | `IAT-C17-C18-PLATEAU` | `IP-C17-C18-PLATEAU-MIDPOINT` | EXTRACTED / REVIEW-PENDING |

## Clause 18 - Percentage total extension at maximum force

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C18-001` | C18 para.1; p.17; PDF 23 | Measurement source | Determine `Agt` from a force-extension curve acquired with an extensometer. | `SCI-025`; `SAT-025` | `IAT-C18-AGT-CALC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C18-002` | C18 para.1; p.17; PDF 23 | Landmark | Select and retain the total extension coordinate at the qualified maximum-force event. | `SCI-017`, `SCI-025`; `SAT-017`, `SAT-025` | `IAT-C18-AGT-CALC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C18-003` | C18 Formula 4; p.17; PDF 23 | Formula | Calculate `Agt` as maximum-force extension divided by `Le`, expressed as percent. | `SCI-025`; `SAT-025` | `IAT-C18-AGT-CALC` | `IP-C18-FORMULA-AGT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C18-004` | C18 Formula 4; pp.17-18; PDFs 23-24 | Formula input | Use `DeltaLm` from the same qualified maximum-force event and curve revision. | `SCI-017`, `SCI-025`; `SAT-017`, `SAT-025` | `IAT-C18-AGT-CALC` | `IP-C18-FORMULA-AGT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C18-005` | C18 Formula 4; pp.17-18; PDFs 23-24 | Formula input | Require positive, unit-compatible `Le` and preserve its calibration identity. | `SCI-006`, `SCI-010`, `SCI-025`; `SAT-006`, `SAT-010`, `SAT-025` | `IAT-C18-AGT-CALC` | `IP-C18-FORMULA-AGT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C18-006` | C18 note; p.18; PDF 24 | Plateau rule | For a maximum-force plateau, use its midpoint extension for `Agt`. | `SCI-017`, `SCI-025`; `SAT-017`, `SAT-025` | `IAT-C17-C18-PLATEAU` | `IP-C17-C18-PLATEAU-MIDPOINT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C18-F01-001` | Figure 1; p.21; PDF 27 | Figure construction | Retain the total-extension `Agt` span from the corrected origin to the selected maximum-force extension line and keep it distinct from `Ag`. | `SCI-024`, `SCI-025`, `SCI-038`; `SAT-024`, `SAT-025`, `SAT-038` | `IAT-F01-EXTENSION-CONSTRUCTION` | `IP-C18-FORMULA-AGT` | EXTRACTED / REVIEW-PENDING |

## Clause 19 - Percentage total extension at fracture

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C19-001` | C19 para.1; p.18; PDF 24 | Measurement source | Determine `At` from an extensometer force-extension curve that continues to a qualified fracture event. | `SCI-026`, `SCI-030`; `SAT-026`, `SAT-030` | `IAT-C19-AT-FRACTURE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C19-002` | C19 para.1; p.18; PDF 24 | Landmark validity | Use the extension at the qualified fracture point; a truncated or unqualified endpoint does not yield `At`. | `SCI-026`, `SCI-030`, `SCI-039`; `SAT-026`, `SAT-030`, `SAT-039` | `IAT-C19-AT-FRACTURE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C19-003` | C19 Formula 5; p.18; PDF 24 | Formula | Calculate `At` as fracture extension divided by `Le`, expressed as percent. | `SCI-026`; `SAT-026` | `IAT-C19-AT-FRACTURE` | `IP-C19-FORMULA-AT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C19-004` | C19 Formula 5; p.18; PDF 24 | Formula input | Use `DeltaLf` from the selected fracture event and retain sample/interpolation provenance. | `SCI-026`, `SCI-030`; `SAT-026`, `SAT-030` | `IAT-C19-AT-FRACTURE` | `IP-C19-FORMULA-AT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C19-005` | C19 Formula 5; p.18; PDF 24 | Formula input | Require positive, unit-compatible `Le` from the governing extensometer configuration. | `SCI-006`, `SCI-010`, `SCI-026`; `SAT-006`, `SAT-010`, `SAT-026` | `IAT-C19-AT-FRACTURE` | `IP-C19-FORMULA-AT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C19-F01-001` | Figure 1; p.21; PDF 27 | Figure construction | Retain the fracture extension line and `At` span, and keep total extension at fracture distinct from post-fracture `A`. | `SCI-026`, `SCI-027`, `SCI-038`; `SAT-026`, `SAT-027`, `SAT-038` | `IAT-F01-EXTENSION-CONSTRUCTION` | `IP-C19-FORMULA-AT` | EXTRACTED / REVIEW-PENDING |

## Clause 20 - Percentage elongation after fracture

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C20-001` | 20.1 para.1; p.18; PDF 24 | Definition route | Determine manual post-fracture elongation using the controlled definition and its `Lu`/`L0` semantics. | `SCI-027`; `SAT-027` | `IAT-C20-MANUAL-REASSEMBLY` | `IP-FORMULA-A` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-002` | 20.1 para.2; p.18; PDF 24 | Reassembly | Fit the broken pieces together carefully before measuring final gauge length. | `SCI-027`; `SAT-027` | `IAT-C20-MANUAL-REASSEMBLY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-003` | 20.1 para.2; p.18; PDF 24 | Alignment | Align the reassembled specimen axes on one straight line. | `SCI-027`; `SAT-027` | `IAT-C20-MANUAL-REASSEMBLY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-004` | 20.1 para.3; p.18; PDF 24 | Contact | Apply a controlled contact procedure so the broken faces are properly seated during `Lu` measurement. | `SCI-027`; `SAT-027` | `IAT-C20-MANUAL-REASSEMBLY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-005` | 20.1 para.3; p.18; PDF 24 | Sensitivity | Flag small cross-sections and low-elongation specimens for heightened contact-control evidence. | `SCI-027`, `SCI-039`; `SAT-027`, `SAT-039` | `IAT-C20-MANUAL-REASSEMBLY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-006` | 20.1 Formula 6; p.18; PDF 24 | Formula | Calculate `A` from the increase in gauge length relative to original gauge length, expressed as percent. | `SCI-027`; `SAT-027` | `IAT-C20-MANUAL-METROLOGY` | `IP-FORMULA-A` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-007` | 20.1 Formula 6; p.18; PDF 24 | Formula input | Use the measured final gauge length `Lu` from the qualified reassembly. | `SCI-027`; `SAT-027` | `IAT-C20-MANUAL-METROLOGY` | `IP-FORMULA-A` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-008` | 20.1 Formula 6; p.18; PDF 24 | Formula input | Use positive original gauge length `L0` from the specimen revision; do not substitute `Le`. | `SCI-006`, `SCI-009`, `SCI-027`; `SAT-006`, `SAT-009`, `SAT-027` | `IAT-C20-MANUAL-METROLOGY` | `IP-FORMULA-A` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-009` | 20.1 para.5; p.18; PDF 24 | Resolution | Determine the length increase to the stated increment or better. | `SCI-010`, `SCI-027`; `SAT-010`, `SAT-027` | `IAT-C20-MANUAL-METROLOGY` | `IP-C20-LENGTH-INCREMENT-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-010` | 20.1 para.5; p.18; PDF 24 | Equipment eligibility | Require a measuring device with sufficient resolution for the selected increment; do not infer eligibility from a displayed rounded value. | `SCI-010`, `SCI-027`; `SAT-010`, `SAT-027` | `IAT-C20-MANUAL-METROLOGY` | `IP-C20-LENGTH-INCREMENT-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-011` | 20.1 para.6; p.18; PDF 24 | Low-elongation guidance | When the specified minimum elongation is below the stated threshold, route the procedure to Annex H precautions without treating the guidance as an automatic acceptance tolerance. | `SCI-027`; `SAT-027` | `IAT-C20-ANNEX-H-ROUTE` | `IP-C20-LOW-ELONGATION-THRESHOLD` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-012` | 20.1 para.6; p.18; PDF 24 | Fracture-position validity | Treat a manual result as position-valid when the fracture-to-nearest-mark distance meets the stated fraction of `L0`. | `SCI-027`, `SCI-039`; `SAT-027`, `SAT-039` | `IAT-C20-FRACTURE-VALIDITY` | `IP-C20-FRACTURE-DISTANCE-MIN` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-013` | 20.1 para.6; p.18; PDF 24 | Acceptance override | Regardless of fracture position, regard the result as valid when measured `A` is at least the specified value; retain the specification and comparison evidence. | `SCI-027`, `SCI-039`; `SAT-027`, `SAT-039` | `IAT-C20-FRACTURE-VALIDITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-014` | 20.1 para.6; p.18; PDF 24 | Agreed alternative | Permit Annex I only by prior agreement for otherwise position-invalid manual specimens and retain that authority. | `SCI-001`, `SCI-027`; `SAT-001`, `SAT-027` | `IAT-C20-ANNEX-I-ROUTE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-015` | 20.2 para.1; p.19; PDF 25 | Marking exception | Do not require gauge marks when post-fracture elongation is determined by an extensometer path. | `SCI-009`, `SCI-027`; `SAT-009`, `SAT-027` | `IAT-C20-EXTENSOMETER-CALC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-016` | 20.2 para.1; p.19; PDF 25 | Measurement source | Measure total extension at fracture from the qualified extensometer signal before converting it to post-fracture elongation. | `SCI-026`, `SCI-027`, `SCI-030`; `SAT-026`, `SAT-027`, `SAT-030` | `IAT-C20-EXTENSOMETER-CALC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-017` | 20.2 para.1; p.19; PDF 25 | Elastic correction | Deduct elastic extension from total extension at fracture to obtain extensometer-derived `A`. | `SCI-027`, `SCI-035`; `SAT-027`, `SAT-035` | `IAT-C20-EXTENSOMETER-CALC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-018` | 20.2 para.1; p.19; PDF 25 | Comparability adjustment | Allow only declared, verifiable adjustments needed for comparability with the manual path, including adequate dynamic and frequency response. | `SCI-010`, `SCI-027`, `SCI-031`; `SAT-010`, `SAT-027`, `SAT-031` | `IAT-C20-EXTENSOMETER-CALC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-019` | 20.2 para.2; p.19; PDF 25 | Fracture validity | Require the fracture location to lie inside `Le` for the ordinary extensometer result to be valid. | `SCI-027`, `SCI-030`, `SCI-039`; `SAT-027`, `SAT-030`, `SAT-039` | `IAT-C20-EXTENSOMETER-VALIDITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-020` | 20.2 para.2; p.19; PDF 25 | Necking validity | Require localized extension or necking to lie inside `Le` for the ordinary extensometer result to be valid. | `SCI-027`, `SCI-039`; `SAT-027`, `SAT-039` | `IAT-C20-EXTENSOMETER-VALIDITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-021` | 20.2 para.2; p.19; PDF 25 | Acceptance override | Regardless of fracture cross-section position, regard extensometer-derived `A` as valid when it is at least the specified value. | `SCI-027`, `SCI-039`; `SAT-027`, `SAT-039` | `IAT-C20-EXTENSOMETER-VALIDITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-022` | 20.2 para.2; p.19; PDF 25 | Gauge-length condition | When the product standard specifies `A` for a given gauge length, use an extensometer gauge length equal to that length unless a separately governed route applies. | `SCI-001`, `SCI-009`, `SCI-027`; `SAT-001`, `SAT-009`, `SAT-027` | `IAT-C20-EXTENSOMETER-VALIDITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-F01-001` | Figure 1; p.21; PDF 27 | Figure construction | Retain the `A` span after elastic correction and its relationship to `At`; do not label total extension at fracture as post-fracture elongation. | `SCI-026`, `SCI-027`, `SCI-038`; `SAT-026`, `SAT-027`, `SAT-038` | `IAT-F01-EXTENSION-CONSTRUCTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-024` | 20.3; p.19; PDF 25 | Conversion applicability | Permit conversion from a fixed measured length to a proportional gauge length only through an explicitly selected conversion path. | `SCI-027`; `SAT-027` | `IAT-C20-CONVERSION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-025` | 20.3; p.19; PDF 25 | Prior agreement | Require the conversion formula or table to be agreed before testing and retain its exact identity. | `SCI-001`, `SCI-027`; `SAT-001`, `SAT-027` | `IAT-C20-CONVERSION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-026` | 20.3; p.19; PDF 25 | External dependency | Treat ISO 2566-1/-2 as examples of separately controlled conversion authorities, not embedded defaults without source/version control. | `SCI-001`, `SCI-027`; `SAT-001`, `SAT-027` | `IAT-C20-CONVERSION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C20-027` | 20.3 note; p.19; PDF 25 | Comparability | Compare percentage elongation only for equivalent gauge-length, shape and area conditions, or when the proportionality coefficient `k` is the same. | `SCI-007`, `SCI-009`, `SCI-027`; `SAT-007`, `SAT-009`, `SAT-027` | `IAT-C20-CONVERSION` | - | EXTRACTED / REVIEW-PENDING |

## Clause 21 - Percentage reduction of area

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C21-001` | C21 para.1; p.19; PDF 25 | Definition route | Determine `Z` using the controlled reduction-of-area definition and valid `S0`/`Su` quantities. | `SCI-028`; `SAT-028` | `IAT-C21-Z-CALC` | `IP-FORMULA-Z` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-002` | C21 para.2; p.19; PDF 25 | Reassembly | When needed, fit the broken pieces together before measuring the reduced section. | `SCI-028`; `SAT-028` | `IAT-C21-Z-MEASUREMENT` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-003` | C21 para.2; p.19; PDF 25 | Alignment | Align the reassembled specimen axes on one straight line. | `SCI-028`; `SAT-028` | `IAT-C21-Z-MEASUREMENT` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-004` | C21 para.3; p.19; PDF 25 | Round-specimen measurement | For a round specimen, measure the minimum reduced section in two planes. | `SCI-028`; `SAT-028` | `IAT-C21-Z-MEASUREMENT` | `IP-C21-ROUND-PLANES` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-005` | C21 para.3; p.19; PDF 25 | Angular geometry | Orient the two round-specimen measurement planes at the stated right angle. | `SCI-028`; `SAT-028` | `IAT-C21-Z-MEASUREMENT` | `IP-C21-ROUND-PLANE-ANGLE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-006` | C21 para.3; p.19; PDF 25 | Aggregation | Use the average of the two orthogonal measurements in the `Z` calculation. | `SCI-028`; `SAT-028` | `IAT-C21-Z-MEASUREMENT` | `IP-C21-ROUND-PLANES` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-007` | C21 para.4; p.19; PDF 25 | Handling | Prevent displacement of the fracture surfaces while taking reduced-section readings. | `SCI-028`; `SAT-028` | `IAT-C21-Z-MEASUREMENT` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-008` | C21 Formula 7; p.19; PDF 25 | Formula | Calculate `Z` from the loss of area relative to `S0`, expressed as percent. | `SCI-028`; `SAT-028` | `IAT-C21-Z-CALC` | `IP-FORMULA-Z` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-009` | C21 Formula 7; p.19; PDF 25 | Formula input | Use positive original cross-sectional area `S0` from the governing specimen measurement revision. | `SCI-006`, `SCI-008`, `SCI-028`; `SAT-006`, `SAT-008`, `SAT-028` | `IAT-C21-Z-CALC` | `IP-FORMULA-Z` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-010` | C21 Formula 7; p.19; PDF 25 | Formula input | Use the minimum post-fracture cross-sectional area `Su` derived by the geometry-appropriate measurement path. | `SCI-006`, `SCI-028`; `SAT-006`, `SAT-028` | `IAT-C21-Z-CALC` | `IP-FORMULA-Z` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-011` | C21 para.6; p.19; PDF 25 | Accuracy guidance | Record whether the recommended `Su` measurement accuracy is achieved; guidance status must not be turned into an unreviewed universal rejection rule. | `SCI-010`, `SCI-028`; `SAT-010`, `SAT-028` | `IAT-C21-Z-MEASUREMENT` | `IP-C21-SU-ACCURACY-RECOMMENDED` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C21-012` | C21 para.7; p.19; PDF 25 | Feasibility | Represent inability to achieve the recommended accuracy for small round or other geometries explicitly rather than fabricating compliant precision. | `SCI-028`, `SCI-039`; `SAT-028`, `SAT-039` | `IAT-C21-Z-MEASUREMENT` | `IP-C21-SU-ACCURACY-RECOMMENDED` | EXTRACTED / REVIEW-PENDING |

## Clause 22 - Test report

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C22-001` | C22 opening; p.19; PDF 25 | Minimum content | Require the listed report information as the minimum unless the parties have a retained contrary agreement. | `SCI-001`, `SCI-037`; `SAT-001`, `SAT-037` | `IAT-C22-REPORT-FIELDS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-002` | C22(a); p.19; PDF 25 | Source identity | Report the governing ISO document identity and revision. | `SCI-001`, `SCI-037`; `SAT-001`, `SAT-037` | `IAT-C22-REPORT-FIELDS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-003` | C22(a); p.19; PDF 25 | Test designation | Extend the source identity with the recorded testing-condition designation from 10.3.4. | `SCI-015`, `SCI-037`; `SAT-015`, `SAT-037` | `IAT-C22-RATE-REPORTING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-004` | C22(a) example; p.19; PDF 25 | Designation example | Validate generated designation syntax against the illustrated ISO/edition/method/range form without hard-coding the example as the only allowed value. | `SCI-015`, `SCI-037`; `SAT-015`, `SAT-037` | `IAT-C22-RATE-REPORTING` | `IP-DESIGNATION-A-PHASES-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-005` | C22(b); p.19; PDF 25 | Specimen identity | Report the test-piece identity linked to the immutable specimen/run records. | `SCI-037`, `SCI-041`; `SAT-037`, `SAT-041` | `IAT-C22-REPORT-FIELDS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-006` | C22(c); p.19; PDF 25 | Material field | Report the specified material when known and preserve an explicit unknown state otherwise. | `SCI-037`; `SAT-037` | `IAT-C22-REPORT-FIELDS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-007` | C22(d); p.20; PDF 26 | Specimen type | Report the test-piece type/profile used for applicability and geometry calculations. | `SCI-007`, `SCI-037`; `SAT-007`, `SAT-037` | `IAT-C22-REPORT-FIELDS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-008` | C22(e); p.20; PDF 26 | Sampling location | Report sampling location when known and preserve unknown/not-supplied separately. | `SCI-037`; `SAT-037` | `IAT-C22-REPORT-FIELDS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-009` | C22(e); p.20; PDF 26 | Sampling direction | Report sampling direction when known and preserve unknown/not-supplied separately. | `SCI-037`; `SAT-037` | `IAT-C22-REPORT-FIELDS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-010` | C22(f); p.20; PDF 26 | Rate deviation field | When control modes or rates differ from the recommended methods/values, report the effective modes, rates or ranges and their provenance. | `SCI-013`, `SCI-014`, `SCI-015`, `SCI-037`; `SAT-013`, `SAT-014`, `SAT-015`, `SAT-037` | `IAT-C22-RATE-REPORTING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-011` | C22(g); p.20; PDF 26 | Results | Report every applicable requested result together with validity/not-applicable state; do not replace missing results with zero. | `SCI-037`, `SCI-039`; `SAT-037`, `SAT-039` | `IAT-C22-REPORT-FIELDS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-012` | C22(g); p.20; PDF 26 | Rounding authority | Apply the selected ISO 80000-1 rounding rule to report presentation while retaining unrounded canonical results. | `SCI-037`, `SCI-040`; `SAT-037`, `SAT-040` | `IAT-C22-ROUNDING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-013` | C22(g); p.20; PDF 26 | Override precedence | Permit equal-or-better precision and product-standard-specific precision without changing the stored canonical result or silently weakening precision. | `SCI-001`, `SCI-037`, `SCI-040`; `SAT-001`, `SAT-037`, `SAT-040` | `IAT-C22-ROUNDING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-014` | C22(g), strength; p.20; PDF 26 | Rounding quantum | Present strength results in megapascals to the stated whole-number quantum or better unless a governing product rule specifies otherwise. | `SCI-037`, `SCI-040`; `SAT-037`, `SAT-040` | `IAT-C22-ROUNDING` | `IP-C22-ROUND-STRENGTH` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-015` | C22(g), `Ae`; p.20; PDF 26 | Rounding quantum | Present `Ae` to the stated percentage quantum or better unless overridden by a governing product rule. | `SCI-023`, `SCI-037`, `SCI-040`; `SAT-023`, `SAT-037`, `SAT-040` | `IAT-C22-ROUNDING` | `IP-C22-ROUND-AE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-016` | C22(g), other extension/elongation; p.20; PDF 26 | Rounding quantum | Present all other percentage extension and elongation results to the stated quantum or better unless governed otherwise. | `SCI-024`, `SCI-025`, `SCI-026`, `SCI-027`, `SCI-037`, `SCI-040`; `SAT-024`, `SAT-025`, `SAT-026`, `SAT-027`, `SAT-037`, `SAT-040` | `IAT-C22-ROUNDING` | `IP-C22-ROUND-OTHER-EXTENSION` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C22-017` | C22(g), `Z`; p.20; PDF 26 | Rounding quantum | Present percentage reduction of area to the stated quantum or better unless governed otherwise. | `SCI-028`, `SCI-037`, `SCI-040`; `SAT-028`, `SAT-037`, `SAT-040` | `IAT-C22-ROUNDING` | `IP-C22-ROUND-Z` | EXTRACTED / REVIEW-PENDING |

## Clause 23 - Measurement uncertainty

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C23-001` | 23.1 para.1; p.20; PDF 26 | Purpose | Use uncertainty analysis to identify important sources of result inconsistency. | `SCI-036`; `SAT-036` | `IAT-C23-UNCERTAINTY-INFORMATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C23-002` | 23.1 para.2; p.20; PDF 26 | Context | Preserve the fact that product standards and historical material databases already contain an inherent uncertainty contribution from this and earlier editions. | `SCI-036`; `SAT-036` | `IAT-C23-UNCERTAINTY-INFORMATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C23-003` | 23.1 para.2; p.20; PDF 26 | Decision rule boundary | Do not apply an additional uncertainty adjustment that could turn an otherwise compliant product result into failure. | `SCI-036`, `SCI-039`; `SAT-036`, `SAT-039` | `IAT-C23-NO-CONFORMANCE-COMBINATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C23-004` | 23.1 para.2; p.20; PDF 26 | Information status | Label uncertainty estimates from this procedure as information, not as a default conformity adjustment. | `SCI-036`, `SCI-037`; `SAT-036`, `SAT-037` | `IAT-C23-UNCERTAINTY-INFORMATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C23-005` | 23.2; p.20; PDF 26 | Test-condition boundary | Do not modify the test conditions or their limits to account for measurement uncertainty. | `SCI-013`, `SCI-014`, `SCI-036`; `SAT-013`, `SAT-014`, `SAT-036` | `IAT-C23-NO-ADJUSTMENT` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C23-006` | 23.3 para.1; p.20; PDF 26 | Conformance boundary | Do not combine estimated measurement uncertainty with the measured result when assessing conformance to a product specification. | `SCI-036`, `SCI-039`; `SAT-036`, `SAT-039` | `IAT-C23-NO-CONFORMANCE-COMBINATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C23-007` | 23.3 para.2; p.20; PDF 26 | Guidance route | Route metrological-parameter uncertainty guidance to Annex K and keep it pending until that Annex is atomized and reviewed. | `SCI-036`; `SAT-036` | `IAT-C23-ANNEX-ROUTING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C23-008` | 23.3 para.2; p.20; PDF 26 | Evidence route | Route interlaboratory values for the described steel and aluminium groups to Annex L as evidence, not a universal acceptance tolerance. | `SCI-036`, `SCI-045`; `SAT-036`, `SAT-045` | `IAT-C23-ANNEX-ROUTING` | - | EXTRACTED / REVIEW-PENDING |

## Package count and evidence boundary

- Atomic source items: **103** (`C03/F08=4`, `C10/F09-F10=11`, `C17=11`, `C18=7`, `C19=6`, `C20=27`, `C21=12`, `C22=17`, `C23=8`).
- Parameter/formula records: **15** new records; Figure 9 and Clauses 20-22 also reuse reviewed-by-source candidates defined in package 1.
- Atomic acceptance variants: **26**.
- Coverage status: extraction and bidirectional family/test/parameter routing complete for Clauses 17-23 and Figures 1, 8-10; independent interpretation/parameter review and all executable evidence remain pending.
- Excluded from this package: Figures 11-15, Annexes A-L, detailed referenced-standard requirements and ASTM E8/E8M-15a.
