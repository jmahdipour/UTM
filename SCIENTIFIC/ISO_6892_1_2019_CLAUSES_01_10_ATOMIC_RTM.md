---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_CLAUSES_01_10_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic RTM - Clauses 1 to 10

## Control statement

This inventory paraphrases the controlled English third edition. It does not reproduce the standard. Printed-page locators are the page numbers printed by ISO; PDF locators refer to the registered 86-page controlled file. Each row is linked to an existing `SCI-*` family, a detailed `SAT-*` case, an atomic acceptance variant and, where applicable, an exact profile-parameter record.

`EXTRACTED / REVIEW-PENDING` means that the source item has been independently addressable and cross-linked, but its interpretation and numeric parameters have not yet received the independent scientific sign-off required to close `SG-02`. No row is implementation or execution evidence.

## Clauses 1 and 2 - Scope and normative dependencies

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C01-001` | C1; p.1; PDF 7 | Scope | Limit the profile to tensile testing of metallic materials and room-temperature mechanical properties defined by this edition. | `SCI-001`; `SAT-001` | `IAT-SCOPE-PROFILE` | `IP-TEMP-ROOM-MIN`; `IP-TEMP-ROOM-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C01-002` | C1 Note; p.1; PDF 7 | Informative routing | Treat Annex A as computer-control guidance, not as an additional material scope. | `SCI-031`; `SAT-031` | `IAT-SCOPE-PROFILE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C02-001` | C2 opening; p.1; PDF 7 | Dependency rule | Resolve referenced documents as requirement-bearing dependencies where the ISO text invokes their content. | `SCI-001`; `SAT-001` | `IAT-SOURCE-DEPENDENCY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C02-002` | C2 opening; p.1; PDF 7 | Revision rule | Preserve dated-reference editions and resolve undated references under a controlled dependency-revision policy; never silently migrate a released Method. | `SCI-001`; `SAT-001` | `IAT-SOURCE-DEPENDENCY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C02-003` | C2; p.1; PDF 7 | Normative dependency | Route force-system calibration and verification to ISO 7500-1. | `SCI-010`; `SAT-010` | `IAT-SOURCE-DEPENDENCY` | `IP-FORCE-CLASS-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C02-004` | C2; p.1; PDF 7 | Normative dependency | Route extensometer-system calibration to ISO 9513. | `SCI-010`; `SAT-010` | `IAT-SOURCE-DEPENDENCY` | `IP-EXT-PROOF-CLASS-MAX`; `IP-EXT-OTHER-CLASS-MAX` | EXTRACTED / REVIEW-PENDING |

## Clause 3 - Terms, definitions and formulas

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C03-001` | 3.1; p.1; PDF 7 | Definition | `L` is the active length of the parallel portion over which elongation is measured. | `SCI-006`; `SAT-006` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-002` | 3.1.1; p.1; PDF 7 | Definition | `L0` is the pre-test room-temperature distance between gauge marks. | `SCI-006`; `SAT-006` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-003` | 3.1.2; p.1; PDF 7 | Definition | `Lu` is the post-fracture room-temperature distance between gauge marks after axial reassembly. | `SCI-027`; `SAT-027` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-004` | 3.2; p.2; PDF 8 | Definition | `Lc` is the length of the parallel reduced section; for unmachined pieces the distance between grips replaces this concept. | `SCI-006`; `SAT-006` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-005` | 3.3; p.2; PDF 8 | Definition | Elongation is the increase in original gauge length at a point during the test. | `SCI-006`; `SAT-006` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-006` | 3.4; p.2; PDF 8 | Definition | Percentage elongation expresses elongation relative to `L0`. | `SCI-006`; `SAT-006` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-007` | 3.4.1; p.2; PDF 8 | Definition | Percentage permanent elongation is the retained increase in `L0` after removal of a specified stress. | `SCI-022`; `SAT-022` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-008` | 3.4.2; p.2; PDF 8 | Definition/formula | `A` is `100 * (Lu - L0) / L0` after fracture and valid reassembly. | `SCI-027`; `SAT-027` | `IAT-CALC-FORMULA` | `IP-FORMULA-A` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-009` | 3.5; p.2; PDF 8 | Definition | `Le` is the initial extensometer gauge length. | `SCI-006`; `SAT-006` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-010` | 3.5 Notes; p.2; PDF 8 | Applicability | Require an extensometer for extension-dependent properties such as `Rp`, `Ae` and `Ag`. | `SCI-009`; `SAT-009` | `IAT-GAUGE-EXTENSOMETER` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-011` | 3.6; p.2; PDF 8 | Definition | Extension is the increase in `Le` at a point during the test. | `SCI-016`; `SAT-016` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-012` | 3.6.1; p.2; PDF 8 | Definition/formula | Engineering strain `e` is extension expressed relative to `Le`. | `SCI-016`; `SAT-016` | `IAT-CALC-FORMULA` | `IP-FORMULA-E` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-013` | 3.6.2; p.2; PDF 8 | Definition | Percentage permanent extension is retained extension relative to `Le` after removal of specified stress. | `SCI-022`; `SAT-022` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-014` | 3.6.3; p.3; PDF 9 | Definition | `Ae` applies to discontinuous yielding and spans from yield start to uniform work-hardening start, relative to `Le`. | `SCI-023`; `SAT-023` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-015` | 3.6.4; p.3; PDF 9 | Definition | `Agt` is total elastic-plus-plastic extension at `Fm`, relative to `Le`. | `SCI-025`; `SAT-025` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-016` | 3.6.5; p.3; PDF 9 | Definition | `Ag` is plastic extension at `Fm`, relative to `Le`. | `SCI-024`; `SAT-024` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-017` | 3.6.6; p.3; PDF 9 | Definition | `At` is total elastic-plus-plastic extension at fracture, relative to `Le`. | `SCI-026`; `SAT-026` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-018` | 3.7; p.3; PDF 9 | Definition | Testing rate is the rate or sequence of rates used during the test. | `SCI-015`; `SAT-015` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-019` | 3.7.1; p.3; PDF 9 | Definition | Strain rate is the time rate of strain measured over `Le`. | `SCI-013`; `SAT-013` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-020` | 3.7.2; p.3; PDF 9 | Definition | Estimated strain rate over `Lc` is derived from crosshead separation rate and parallel length. | `SCI-013`; `SAT-013` | `IAT-SCHEMA-DEFINITION` | `IP-FORMULA-VC` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-021` | 3.7.3; p.3; PDF 9 | Definition | `vc` is crosshead displacement per time. | `SCI-013`; `SAT-013` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-022` | 3.7.4; p.3; PDF 9 | Definition/applicability | Stress rate is the time rate of engineering stress and is used only in the elastic Method B region. | `SCI-014`; `SAT-014` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-023` | 3.8; p.4; PDF 10 | Definition/formula | `Z` is `100 * (S0 - Su) / S0`. | `SCI-028`; `SAT-028` | `IAT-CALC-FORMULA` | `IP-FORMULA-Z` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-024` | 3.9.1; p.4; PDF 10 | Definition | For continuous yielding, `Fm` is the highest force carried during the test. | `SCI-017`; `SAT-017` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-025` | 3.9.2; p.4; PDF 10 | Definition | For discontinuous yielding, `Fm` is the highest force after work-hardening begins. | `SCI-017`; `SAT-017` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-026` | 3.9.2 Note 1; p.4; PDF 10 | Applicability | Return `NotApplicable` for ISO `Fm` where discontinuous yielding occurs without established work-hardening. | `SCI-017`; `SAT-017` | `IAT-RESULT-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-027` | 3.10; p.4; PDF 10 | Definition/formula | Engineering stress `R` is force divided by `S0`; do not label it true stress. | `SCI-016`; `SAT-016` | `IAT-CALC-FORMULA` | `IP-FORMULA-R` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-028` | 3.10.1; p.4; PDF 10 | Definition | `Rm` is engineering stress corresponding to the applicable `Fm`. | `SCI-017`; `SAT-017` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-029` | 3.10.2; p.4; PDF 10 | Definition | Yield strength applies where plastic deformation progresses without force increase. | `SCI-018`; `SAT-018` | `IAT-RESULT-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-030` | 3.10.2.1; p.4; PDF 10 | Definition | `ReH` is the maximum engineering stress before the first force decrease. | `SCI-018`; `SAT-018` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-031` | 3.10.2.2; p.4; PDF 10 | Definition | `ReL` is the lowest engineering stress during plastic yielding after excluding initial transients. | `SCI-019`; `SAT-019` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-032` | 3.10.3; p.5; PDF 11 | Definition/parameterization | `Rp{x}` is the stress at the specified plastic-extension percentage of `Le`; preserve the requested suffix value. | `SCI-020`; `SAT-020` | `IAT-SCHEMA-DEFINITION` | `IP-PROPERTY-SUFFIX-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-033` | 3.10.4; p.5; PDF 11 | Definition/parameterization | `Rt{x}` is the stress at the specified total-extension percentage of `Le`; preserve the requested suffix value. | `SCI-021`; `SAT-021` | `IAT-SCHEMA-DEFINITION` | `IP-PROPERTY-SUFFIX-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-034` | 3.10.5; p.5; PDF 11 | Definition/parameterization | `Rr{x}` verifies that specified permanent elongation or extension is not exceeded after unloading; record whether the basis is `L0` or `Le`. | `SCI-022`; `SAT-022` | `IAT-SCHEMA-DEFINITION` | `IP-PROPERTY-SUFFIX-PERCENT` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-035` | 3.11; p.5; PDF 11 | Definition | Fracture is total separation; computer-controlled detection criteria route to Annex A.2. | `SCI-030`; `SAT-030` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-036` | 3.12; p.5; PDF 11 | Definition | A computer-controlled tensile machine uses computer control/monitoring, measurement and data processing. | `SCI-031`; `SAT-031` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-037` | 3.13; p.5; PDF 11 | Definition/formula | Annex G modulus `E` is `100 * DeltaR / Deltae` when percentage extension is used. | `SCI-034`; `SAT-034` | `IAT-CALC-FORMULA` | `IP-FORMULA-E-MODULUS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-038` | 3.13 Note; p.5; PDF 11 | Reporting guidance | When reported in GPa, round `E` to 0.1 GPa under the cited quantity-rounding convention. | `SCI-035`; `SAT-035` | `IAT-REPORT-ROUNDING` | `IP-E-ROUND-GPA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-039` | 3.14; p.5; PDF 11 | Definition | A default value is a lower/upper stress or strain bound used to describe the modulus evaluation range. | `SCI-034`; `SAT-034` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-040` | 3.15; p.6; PDF 12 | Definition | Regression `R2` is the coefficient of determination and must not be confused with upper stress bound `R2`. | `SCI-035`; `SAT-035` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-041` | 3.16; p.6; PDF 12 | Definition | `Sm` is the slope standard deviation associated with fit residuals in the evaluation range. | `SCI-035`; `SAT-035` | `IAT-SCHEMA-DEFINITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C03-042` | 3.17; p.6; PDF 12 | Definition/formula | `Sm(rel)` is `100 * Sm / E`. | `SCI-035`; `SAT-035` | `IAT-CALC-FORMULA` | `IP-FORMULA-SMREL` | EXTRACTED / REVIEW-PENDING |

## Clause 4 - Atomic symbol catalog from Table 1

Every row below is a distinct typed quantity identity. Symbols that are visually similar (`R2` upper stress and regression `R2`) require distinct internal IDs.

| Source item | Locator | Symbol / unit / designation | SCI / SAT | Atomic acceptance | Status |
|---|---|---|---|---|---|
| `ISO19-C04-T01-001` | Table 1; p.6; PDF 12 | `a0` or `Ta` / mm / flat thickness or tube wall thickness | `SCI-006`; `SAT-006` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-002` | Table 1; p.6; PDF 12 | `b0` / mm / original width | `SCI-006`; `SAT-006` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-003` | Table 1; p.6; PDF 12 | `d0` / mm / original circular diameter or tube internal diameter | `SCI-006`; `SAT-006` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-004` | Table 1; p.6; PDF 12 | `D0` / mm / tube external diameter | `SCI-006`; `SAT-006` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-005` | Table 1; p.6; PDF 12 | `L0` / mm / original gauge length | `SCI-006`; `SAT-006` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-006` | Table 1; p.6; PDF 12 | `L'0` / mm / initial gauge length for `Awn` | `SCI-029`; `SAT-029` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-007` | Table 1; p.6; PDF 12 | `Lc` / mm / parallel length | `SCI-006`; `SAT-006` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-008` | Table 1; p.6; PDF 12 | `Le` / mm / extensometer gauge length | `SCI-006`; `SAT-006` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-009` | Table 1; p.6; PDF 12 | `Lt` / mm / total test-piece length | `SCI-006`; `SAT-006` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-010` | Table 1; p.6; PDF 12 | `Lu` / mm / final gauge length after fracture | `SCI-027`; `SAT-027` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-011` | Table 1; p.6; PDF 12 | `L'u` / mm / final gauge length for `Awn` | `SCI-029`; `SAT-029` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-012` | Table 1; p.7; PDF 13 | `S0` / mm2 / original parallel cross-sectional area | `SCI-008`; `SAT-008` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-013` | Table 1; p.7; PDF 13 | `Su` / mm2 / minimum area after fracture | `SCI-028`; `SAT-028` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-014` | Table 1; p.7; PDF 13 | `k` / dimensionless / proportionality coefficient | `SCI-007`; `SAT-007` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-015` | Table 1; p.7; PDF 13 | `Z` / % / reduction of area | `SCI-028`; `SAT-028` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-016` | Table 1; p.7; PDF 13 | `A` / % / elongation after fracture | `SCI-027`; `SAT-027` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-017` | Table 1; p.7; PDF 13 | `Awn` / % / plastic elongation without necking | `SCI-029`; `SAT-029` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-018` | Table 1; p.7; PDF 13 | `e` / % / engineering extension/strain | `SCI-016`; `SAT-016` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-019` | Table 1; p.7; PDF 13 | `Ae` / % / yield-point extension | `SCI-023`; `SAT-023` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-020` | Table 1; p.7; PDF 13 | `Ag` / % / plastic extension at `Fm` | `SCI-024`; `SAT-024` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-021` | Table 1; p.7; PDF 13 | `Agt` / % / total extension at `Fm` | `SCI-025`; `SAT-025` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-022` | Table 1; p.7; PDF 13 | `At` / % / total extension at fracture | `SCI-026`; `SAT-026` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-023` | Table 1; p.7; PDF 13 | `DeltaLm` / mm / extension at maximum force | `SCI-024`; `SAT-024` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-024` | Table 1; p.7; PDF 13 | `DeltaLf` / mm / extension at fracture | `SCI-026`; `SAT-026` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-025` | Table 1; p.7; PDF 13 | `eDotLe` / s-1 / measured strain rate | `SCI-013`; `SAT-013` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-026` | Table 1; p.7; PDF 13 | `eDotLc` / s-1 / estimated strain rate over `Lc` | `SCI-013`; `SAT-013` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-027` | Table 1; p.7; PDF 13 | `RDot` / MPa/s / stress rate | `SCI-014`; `SAT-014` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-028` | Table 1; p.7; PDF 13 | `vc` / mm/s / crosshead separation rate | `SCI-013`; `SAT-013` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-029` | Table 1; p.7; PDF 13 | `Fm` / N / maximum force | `SCI-017`; `SAT-017` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-030` | Table 1; p.7; PDF 13 | `R` / MPa / engineering stress | `SCI-016`; `SAT-016` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-031` | Table 1; p.7; PDF 13 | `ReH` / MPa / upper yield strength | `SCI-018`; `SAT-018` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-032` | Table 1; p.7; PDF 13 | `ReL` / MPa / lower yield strength | `SCI-019`; `SAT-019` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-033` | Table 1; p.7; PDF 13 | `Rm` / MPa / tensile strength | `SCI-017`; `SAT-017` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-034` | Table 1; p.7; PDF 13 | `Rp` / MPa / proof strength, plastic extension | `SCI-020`; `SAT-020` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-035` | Table 1; p.7; PDF 13 | `Rr` / MPa / specified permanent-set strength | `SCI-022`; `SAT-022` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-036` | Table 1; p.7; PDF 13 | `Rt` / MPa / proof strength, total extension | `SCI-021`; `SAT-021` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-037` | Table 1; p.7; PDF 13 | `E` / GPa / Annex G modulus | `SCI-034`; `SAT-034` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-038` | Table 1; p.7; PDF 13 | `m` / MPa / instantaneous stress-percentage-extension slope | `SCI-035`; `SAT-035` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-039` | Table 1; p.7; PDF 13 | `mE` / MPa / elastic-part slope, not implicitly `E` | `SCI-035`; `SAT-035` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-040` | Table 1; p.7; PDF 13 | `R1` / MPa / lower stress bound | `SCI-034`; `SAT-034` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-041` | Table 1; p.7; PDF 13 | `R2Stress` / MPa / upper stress bound | `SCI-034`; `SAT-034` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-042` | Table 1; p.8; PDF 14 | `e1` / % / lower strain bound | `SCI-034`; `SAT-034` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-043` | Table 1; p.8; PDF 14 | `e2` / % / upper strain bound | `SCI-034`; `SAT-034` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-044` | Table 1; p.8; PDF 14 | `R2Fit` / dimensionless / coefficient of determination | `SCI-035`; `SAT-035` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-045` | Table 1; p.8; PDF 14 | `Sm` / MPa / slope standard deviation | `SCI-035`; `SAT-035` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C04-T01-046` | Table 1; p.8; PDF 14 | `SmRel` / % / relative slope standard deviation | `SCI-035`; `SAT-035` | `IAT-SCHEMA-SYMBOL` | EXTRACTED / REVIEW-PENDING |

## Clauses 5 to 9 - Environment, specimen, geometry, gauge length and apparatus

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C05-001` | C5; p.8; PDF 14 | Principle | Apply tensile force, generally to fracture, to determine one or more Clause 3 properties. | `SCI-001`; `SAT-001` | `IAT-SCOPE-PROFILE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C05-002` | C5; p.8; PDF 14 | Mandatory environment | Use the general room-temperature band unless another condition is specified. | `SCI-011`; `SAT-011` | `IAT-ENV-TEMPERATURE` | `IP-TEMP-ROOM-MIN`; `IP-TEMP-ROOM-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C05-003` | C5; p.8; PDF 14 | Mandatory assessment | When operating outside the general band, assess impact on testing and calibration data. | `SCI-011`; `SAT-011` | `IAT-ENV-TEMPERATURE` | `IP-TEMP-ROOM-MIN`; `IP-TEMP-ROOM-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C05-004` | C5; p.8; PDF 14 | Mandatory report | Record and report temperature for testing/calibration outside the general band. | `SCI-011`; `SAT-011` | `IAT-REPORT-ENVIRONMENT` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C05-005` | C5; p.8; PDF 14 | Risk condition | Preserve a warning/uncertainty assessment where significant temperature gradients may affect results or tolerance. | `SCI-036`; `SAT-036` | `IAT-ENV-TEMPERATURE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C05-006` | C5; p.8; PDF 14 | Controlled condition | For controlled-condition tests, use 23 degC with a plus/minus 5 degC band. | `SCI-011`; `SAT-011` | `IAT-ENV-TEMPERATURE` | `IP-TEMP-CONTROLLED-NOMINAL`; `IP-TEMP-CONTROLLED-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C05-007` | C5; p.8; PDF 14 | Applicability | When modulus is requested in the tensile test, route determination to Annex G. | `SCI-034`; `SAT-034` | `IAT-RESULT-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-001` | 6.1.1; p.8; PDF 14 | Applicability | Derive specimen shape/dimensions from the source product and selected product/specimen profile. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-002` | 6.1.1; pp.8-9; PDFs 14-15 | Permitted form | Support machined specimens and qualified uniform-section/as-cast unmachined specimens. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-003` | 6.1.1; p.8; PDF 14 | Shape catalog | Support circular, square, rectangular, annular and explicitly qualified other uniform cross-sections. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-004` | 6.1.1; pp.8-9; PDFs 14-15 | Formula | For proportional specimens calculate `L0 = k * sqrt(S0)`. | `SCI-007`; `SAT-007` | `IAT-CALC-FORMULA` | `IP-FORMULA-L0` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-005` | 6.1.1; p.8; PDF 14 | Preferred parameter | Use internationally adopted `k = 5.65` for the preferred proportional specimen. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | `IP-K-PREFERRED` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-006` | 6.1.1; p.8; PDF 14 | Mandatory limit | A proportional specimen's `L0` shall not be below 15 mm. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | `IP-L0-MIN` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-007` | 6.1.1; p.9; PDF 15 | Alternative | If `k = 5.65` would violate minimum `L0`, permit higher `k` (preferably 11.3) or a non-proportional specimen. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | `IP-K-ALTERNATE-PREFERRED`; `IP-L0-MIN` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-008` | 6.1.1 Note; p.9; PDF 15 | Uncertainty warning | Flag increased uncertainty for elongation-after-fracture where `L0` is below 20 mm. | `SCI-036`; `SAT-036` | `IAT-GEO-SPECIMEN` | `IP-L0-UNCERTAINTY-THRESHOLD` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-009` | 6.1.1; p.9; PDF 15 | Definition | For non-proportional specimens, treat `L0` as independent of `S0`. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-010` | 6.1.1; p.9; PDF 15 | Mandatory dependency | Validate dimensional tolerances against the applicable Annex B-E profile. | `SCI-032`; `SAT-032` | `IAT-GEO-PROFILE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-011` | 6.1.1; p.9; PDF 15 | Controlled exception | Permit other standardized specimen types only through an explicit customer agreement and pinned governing source. | `SCI-007`; `SAT-007` | `IAT-GEO-PROFILE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-012` | 6.1.2; p.9; PDF 15 | Mandatory geometry | Where machined gripped ends and parallel length differ, require the applicable transition radius. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-013` | 6.1.2; p.9; PDF 15 | Mandatory alignment | Require the specimen axis to coincide with the applied-force axis. | `SCI-012`; `SAT-012` | `IAT-PROC-GRIPPING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-014` | 6.1.2; p.9; PDF 15 | Mandatory geometry | Require `Lc`, or free grip distance without transition radii, to exceed `L0`. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-015` | 6.1.3; p.9; PDF 15 | Mandatory geometry | For unmachined product/test bars, provide sufficient free length to keep gauge marks suitably away from grips. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-016` | 6.1.3; p.9; PDF 15 | Mandatory geometry | Require an applicable transition radius for as-cast specimens. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-017` | 6.1.3; p.9; PDF 15 | Mandatory alignment | Require as-cast gripping geometry to centre the specimen on the force axis. | `SCI-012`; `SAT-012` | `IAT-PROC-GRIPPING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-018` | 6.1.3; p.9; PDF 15 | Mandatory geometry | Require as-cast `Lc` to exceed `L0`. | `SCI-007`; `SAT-007` | `IAT-GEO-SPECIMEN` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-019` | 6.2 Table 2; p.10; PDF 16 | Applicability table | Route flat products with `0.1 <= a < 3 mm` to Annex B. | `SCI-032`; `SAT-032` | `IAT-GEO-PROFILE` | `IP-PRODUCT-B-THICKNESS-MIN`; `IP-PRODUCT-B-THICKNESS-MAX-EXCLUSIVE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-020` | 6.2 Table 2; p.10; PDF 16 | Applicability table | Route wire/bars/sections with diameter or side below 4 mm to Annex C. | `SCI-032`; `SAT-032` | `IAT-GEO-PROFILE` | `IP-PRODUCT-C-SIZE-MAX-EXCLUSIVE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-021` | 6.2 Table 2; p.10; PDF 16 | Applicability table | Route flat products at least 3 mm thick and wire/bars/sections at least 4 mm to Annex D. | `SCI-032`; `SAT-032` | `IAT-GEO-PROFILE` | `IP-PRODUCT-D-FLAT-MIN`; `IP-PRODUCT-D-SIZE-MIN` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-022` | 6.2 Table 2; p.10; PDF 16 | Applicability table | Route tube products to Annex E. | `SCI-032`; `SAT-032` | `IAT-GEO-PROFILE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C06-023` | 6.3; p.10; PDF 16 | Mandatory preparation | Prepare and take specimens under the applicable material/product standard, with its identity retained. | `SCI-007`; `SAT-007` | `IAT-GEO-PROFILE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C07-001` | C7; p.10; PDF 16 | Measurement procedure | Measure applicable dimensions at sufficient cross-sections normal to the axis in the central parallel region. | `SCI-008`; `SAT-008` | `IAT-GEO-S0` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C07-002` | C7; p.10; PDF 16 | Recommendation | Configure at least three cross-sections as the recommended default while allowing a reviewed procedure override. | `SCI-008`; `SAT-008` | `IAT-GEO-S0` | `IP-S0-SECTION-COUNT-RECOMMENDED` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C07-003` | C7; p.10; PDF 16 | Mandatory formula | Calculate `S0` as the average of cross-sectional areas derived from the appropriate measured dimensions. | `SCI-008`; `SAT-008` | `IAT-GEO-S0` | `IP-FORMULA-S0-AVERAGE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C07-004` | C7; p.10; PDF 16 | Mandatory dependency | Apply Annex B-E geometry-specific evaluation and dimensional accuracy rules. | `SCI-008`; `SAT-008` | `IAT-GEO-S0` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C07-005` | C7; p.10; PDF 16 | Mandatory metrology | Require calibrated dimensional devices with traceability to an appropriate national measurement system. | `SCI-010`; `SAT-010` | `IAT-MET-DIMENSIONAL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-001` | 8.1; p.10; PDF 16 | Label rule | If a proportional `L0` does not use `k = 5.65`, suffix `A` with the actual proportionality coefficient. | `SCI-009`; `SAT-009` | `IAT-GAUGE-LENGTH` | `IP-K-PREFERRED` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-002` | 8.1 Formula 1; p.10; PDF 16 | Formula/example | Preserve `A11.3` semantics for `L0 = 11.3 * sqrt(S0)` rather than treating all `A` results as equivalent. | `SCI-027`; `SAT-027` | `IAT-CALC-FORMULA` | `IP-K-ALTERNATE-PREFERRED`; `IP-FORMULA-L0` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-003` | 8.1; p.10; PDF 16 | Label rule | For non-proportional specimens, suffix `A` with the actual `L0` in millimetres. | `SCI-027`; `SAT-027` | `IAT-GAUGE-LENGTH` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-004` | 8.2; p.11; PDF 17 | Mandatory marking | For manual `A`, mark both ends of `L0` using marks that do not introduce premature fracture. | `SCI-009`; `SAT-009` | `IAT-GAUGE-MARKING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-005` | 8.2; p.11; PDF 17 | Mandatory tolerance | Mark `L0` to plus/minus 1 percent accuracy. | `SCI-009`; `SAT-009` | `IAT-GAUGE-MARKING` | `IP-L0-MARK-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-006` | 8.2; p.11; PDF 17 | Conditional rounding | For proportional specimens, permit rounding calculated `L0` to the nearest 5 mm only when calculated-to-marked difference is below 10 percent of `L0`. | `SCI-009`; `SAT-009` | `IAT-GAUGE-MARKING` | `IP-L0-ROUND-INCREMENT`; `IP-L0-ROUND-DIFF-MAX-EXCLUSIVE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-007` | 8.2; p.11; PDF 17 | Optional marking | Permit overlapping gauge lengths where `Lc` is much greater than `L0`; retain the selected pattern. | `SCI-009`; `SAT-009` | `IAT-GAUGE-MARKING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-008` | 8.3; p.11; PDF 17 | Extensometer guidance | For yield/proof properties, maximize `Le` coverage of the parallel region and evaluate it against the preferred bounds. | `SCI-009`; `SAT-009` | `IAT-GAUGE-EXTENSOMETER` | `IP-LE-L0-MIN-EXCLUSIVE`; `IP-LE-LC-MAX-APPROX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-009` | 8.3; p.11; PDF 17 | Preferred bounds | Prefer `Le > 0.50 * L0` and approximately `Le < 0.90 * Lc` for yield-event coverage. | `SCI-009`; `SAT-009` | `IAT-GAUGE-EXTENSOMETER` | `IP-LE-L0-MIN-EXCLUSIVE`; `IP-LE-LC-MAX-APPROX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C08-010` | 8.3; p.11; PDF 17 | Property-specific guidance | For properties at or after maximum force, prefer `Le` approximately equal to `L0`. | `SCI-009`; `SAT-009` | `IAT-GAUGE-EXTENSOMETER` | `IP-LE-L0-TARGET-RATIO` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C09-001` | C9; p.11; PDF 17 | Mandatory metrology | Require the force-measuring system to satisfy ISO 7500-1 class 1 or better. | `SCI-010`; `SAT-010` | `IAT-MET-FORCE` | `IP-FORCE-CLASS-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C09-002` | C9; p.11; PDF 17 | Mandatory metrology | For `Rp`/`Rt`, require ISO 9513 class 1 or better in the relevant range. | `SCI-010`; `SAT-010` | `IAT-MET-EXTENSOMETER` | `IP-EXT-PROOF-CLASS-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C09-003` | C9; p.11; PDF 17 | Conditional metrology | For other properties whose extensions exceed 5 percent, permit ISO 9513 class 2 in the relevant range. | `SCI-010`; `SAT-010` | `IAT-MET-EXTENSOMETER` | `IP-EXT-OTHER-CLASS-MAX`; `IP-EXT-CLASS2-THRESHOLD` | EXTRACTED / REVIEW-PENDING |

## Clause 10 - Test preparation and rates

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-C10-001` | 10.1; p.11; PDF 17 | Mandatory procedure | Set force zero after assembling the loading train and before gripping both specimen ends. | `SCI-012`; `SAT-012` | `IAT-PROC-ZERO` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-002` | 10.1; p.11; PDF 17 | Mandatory immutability | Do not alter the force-measuring system after zero is set during the test. | `SCI-012`; `SAT-012` | `IAT-PROC-ZERO` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-003` | 10.2; p.11; PDF 17 | Mandatory procedure | Use a suitable, declared gripping method. | `SCI-012`; `SAT-012` | `IAT-PROC-GRIPPING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-004` | 10.2; p.11; PDF 17 | Alignment control | Minimize bending by applying force as axially as possible, with heightened relevance for brittle/yield/proof tests. | `SCI-012`; `SAT-012` | `IAT-PROC-GRIPPING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-005` | 10.2; pp.11-12; PDFs 17-18 | Conditional preload | Permit preliminary alignment force only up to 5 percent of specified or expected yield strength. | `SCI-012`; `SAT-012` | `IAT-PROC-GRIPPING` | `IP-PRELOAD-YIELD-FRACTION-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-006` | 10.2; p.12; PDF 18 | Mandatory correction | Correct extension for the effect of any preliminary force. | `SCI-012`; `SAT-012` | `IAT-PROC-GRIPPING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-007` | 10.3.1; p.12; PDF 18 | Method selection | Unless otherwise agreed, permit A1, A2 or B only when the selected rates satisfy this edition. | `SCI-015`; `SAT-015` | `IAT-RATE-METHOD-SELECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-008` | 10.3.1 Note 2; p.12; PDF 18 | Controlled override | Permit product/test-standard rate overrides only when their source and effective values are pinned in the Method. | `SCI-015`; `SAT-015` | `IAT-RATE-METHOD-SELECTION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-009` | 10.3.2.1; p.12; PDF 18 | Control-mode definition | Define A1 as closed-loop control using extensometer strain-rate feedback. | `SCI-013`; `SAT-013` | `IAT-RATE-A-CONTROL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-010` | 10.3.2.1; p.12; PDF 18 | Control-mode definition | Define A2 as open-loop estimated `Lc` strain-rate control using calculated crosshead separation rate. | `SCI-013`; `SAT-013` | `IAT-RATE-A-CONTROL` | `IP-FORMULA-VC` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-011` | 10.3.2.1 Note; p.12; PDF 18 | Informative routing | Treat Annex F as the optional more rigorous A2 estimation path and label its use. | `SCI-033`; `SAT-033` | `IAT-RATE-A-CONTROL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-012` | 10.3.2.1; p.12; PDF 18 | Applicability warning | Do not assume measured `Le` rate and estimated `Lc` rate are equivalent during discontinuous/serrated yielding or necking. | `SCI-013`; `SAT-013` | `IAT-RATE-A-CONTROL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-013` | 10.3.2.1(a); p.12; PDF 18 | Pre-property rate | Unless otherwise specified, permit convenient speed only up to one-half expected yield strength. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | `IP-RATE-PREYIELD-FRACTION` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-014` | 10.3.2.1(a); p.12; PDF 18 | Mandatory rate | Above one-half expected yield and through `ReH`, `Rp` or `Rt`, apply the specified A rate/control source. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | `IP-RATE-PREYIELD-FRACTION` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-015` | 10.3.2.1(a); p.12; PDF 18 | Control eligibility | Require an extensometer for accurate strain-rate control; use A2 where direct strain-rate control is unavailable. | `SCI-013`; `SAT-013` | `IAT-RATE-A-CONTROL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-016` | 10.3.2.1(b); p.13; PDF 19 | Yield control | During discontinuous yielding, apply estimated `Lc` strain rate using constant `vc` open-loop control. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-017` | 10.3.2.1 Formula 2; p.13; PDF 19 | Formula | Calculate `vc = Lc * eDotLc` for A2 control. | `SCI-013`; `SAT-013` | `IAT-CALC-FORMULA` | `IP-FORMULA-VC` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-018` | 10.3.2.1(c); p.13; PDF 19 | Post-yield control | After `Rp`/`Rt` or yield completion, permit measured `Le` or estimated `Lc` rate; prefer `Lc` control to reduce out-of-gauge necking issues. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-019` | 10.3.2.1; p.13; PDF 19 | Mandatory duration | Maintain each specified rate while its relevant property is being determined. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-020` | 10.3.2.1; p.13; PDF 19 | Transition quality | Prevent property-distorting discontinuities during rate/control changes and use a controlled gradual transition where needed. | `SCI-013`; `SAT-013` | `IAT-RATE-A-TRANSITION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-021` | 10.3.2.1; p.13; PDF 19 | Evidence | Record the testing rate used through the work-hardening region. | `SCI-015`; `SAT-015` | `IAT-RATE-DESIGNATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-022` | 10.3.2.2; p.13; PDF 19 | Mandatory rate | Keep `eDotLe` as constant as possible through `ReH`, `Rp` or `Rt`. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-023` | 10.3.2.2 Range 1; p.13; PDF 19 | Numeric band | A Range 1 is `0.00007 s-1` with plus/minus 20 percent relative tolerance. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | `IP-RATE-A1`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-024` | 10.3.2.2 Range 2; p.13; PDF 19 | Numeric band | A Range 2 is `0.00025 s-1` with plus/minus 20 percent relative tolerance and is the default recommendation unless specified otherwise. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | `IP-RATE-A2`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-025` | 10.3.2.2; p.13; PDF 19 | Fallback | If direct strain-rate control is unavailable, use A2 rather than an undeclared fallback. | `SCI-013`; `SAT-013` | `IAT-RATE-A-CONTROL` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-026` | 10.3.2.3; p.13; PDF 19 | Mandatory duration | After `ReH`, maintain the selected estimated `Lc` rate until discontinuous yielding ends. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-027` | 10.3.2.3 Range 2; p.13; PDF 19 | Numeric band | For `ReL`/`Ae`, Range 2 is `0.00025 s-1` plus/minus 20 percent and is recommended when `ReL` is determined. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | `IP-RATE-A2`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-028` | 10.3.2.3 Range 3; p.13; PDF 19 | Numeric band | For `ReL`/`Ae`, Range 3 is `0.002 s-1` plus/minus 20 percent. | `SCI-013`; `SAT-013` | `IAT-RATE-A-PROPERTY` | `IP-RATE-A3`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-029` | 10.3.2.4 Range 2; p.14; PDF 20 | Numeric band | For post-yield properties, permit Range 2 at `0.00025 s-1` plus/minus 20 percent. | `SCI-013`; `SAT-013` | `IAT-RATE-A-POSTYIELD` | `IP-RATE-A2`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-030` | 10.3.2.4 Range 3; p.14; PDF 20 | Numeric band | For post-yield properties, permit Range 3 at `0.002 s-1` plus/minus 20 percent. | `SCI-013`; `SAT-013` | `IAT-RATE-A-POSTYIELD` | `IP-RATE-A3`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-031` | 10.3.2.4 Range 4; p.14; PDF 20 | Numeric band | For post-yield properties, Range 4 is `0.0067 s-1` (equivalent displayed as `0.4 min-1`) plus/minus 20 percent and is recommended unless specified otherwise. | `SCI-013`; `SAT-013` | `IAT-RATE-A-POSTYIELD` | `IP-RATE-A4`; `IP-RATE-A4-MIN`; `IP-RATE-A-REL-TOL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-032` | 10.3.2.4; p.14; PDF 20 | Special path | For an `Rm`-only test, permit Range 3 or 4 throughout the test. | `SCI-013`; `SAT-013` | `IAT-RATE-A-POSTYIELD` | `IP-RATE-A3`; `IP-RATE-A4` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-033` | 10.3.3.1; p.14; PDF 20 | Pre-property rate | Under Method B, permit convenient speed only up to one-half specified yield strength unless otherwise specified. | `SCI-014`; `SAT-014` | `IAT-RATE-B-ELASTIC` | `IP-RATE-PREYIELD-FRACTION` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-034` | 10.3.3.1 Note; p.14; PDF 20 | Control constraint | Set Method B crosshead speed from the elastic-region target stress rate; do not closed-loop force-control through yielding. | `SCI-014`; `SAT-014` | `IAT-RATE-B-ELASTIC` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-035` | 10.3.3.2.1; p.14; PDF 20 | Mandatory control | For `ReH`, keep crosshead separation rate as constant as possible within the Table 3 stress-rate limits. | `SCI-014`; `SAT-014` | `IAT-RATE-B-YIELD` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-036` | Table 3 row 1; p.14; PDF 20 | Numeric table | For `E < 150000 MPa`, use elastic stress rate from 2 to 20 MPa/s. | `SCI-014`; `SAT-014` | `IAT-RATE-B-ELASTIC` | `IP-RATE-B-E-BOUNDARY`; `IP-RATE-B-LOWE-MIN`; `IP-RATE-B-LOWE-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-037` | Table 3 row 2; p.14; PDF 20 | Numeric table | For `E >= 150000 MPa`, use elastic stress rate from 6 to 60 MPa/s. | `SCI-014`; `SAT-014` | `IAT-RATE-B-ELASTIC` | `IP-RATE-B-E-BOUNDARY`; `IP-RATE-B-HIGHE-MIN`; `IP-RATE-B-HIGHE-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-038` | 10.3.3.2.2; pp.14-15; PDFs 20-21 | Numeric band | For `ReL` alone, keep parallel-length strain rate between `0.00025` and `0.0025 s-1`, as constant as possible. | `SCI-014`; `SAT-014` | `IAT-RATE-B-YIELD` | `IP-RATE-B-REL-MIN`; `IP-RATE-B-REL-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-039` | 10.3.3.2.2; p.15; PDF 21 | Fallback | If the `ReL` strain rate cannot be regulated directly, establish it via pre-yield stress-rate control and do not readjust controls until yield completes. | `SCI-014`; `SAT-014` | `IAT-RATE-B-YIELD` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-040` | 10.3.3.2.2; p.15; PDF 21 | Mandatory ceiling | Never exceed the applicable Table 3 maximum stress rate in the elastic range. | `SCI-014`; `SAT-014` | `IAT-RATE-B-ELASTIC` | `IP-RATE-B-LOWE-MAX`; `IP-RATE-B-HIGHE-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-041` | 10.3.3.2.3; p.15; PDF 21 | Combined-property rule | When both `ReH` and `ReL` are determined, apply the `ReL` conditions. | `SCI-014`; `SAT-014` | `IAT-RATE-B-YIELD` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-042` | 10.3.3.2.4; p.15; PDF 21 | Mandatory control | For `Rp`/`Rt`, hold crosshead separation rate within Table 3 limits through proof determination. | `SCI-014`; `SAT-014` | `IAT-RATE-B-PROOF` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-043` | 10.3.3.2.4; p.15; PDF 21 | Mandatory ceiling | During Method B proof determination, strain rate shall not exceed `0.0025 s-1`. | `SCI-014`; `SAT-014` | `IAT-RATE-B-PROOF` | `IP-RATE-B-PROOF-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-044` | 10.3.3.2.5; p.15; PDF 21 | Fallback | If strain rate cannot be measured/controlled, use Table-3-equivalent crosshead separation rate until yielding completes. | `SCI-014`; `SAT-014` | `IAT-RATE-B-YIELD` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-045` | 10.3.3.3; p.15; PDF 21 | Post-yield ceiling | After yield/proof determination, limit strain rate or equivalent crosshead rate to `0.008 s-1`. | `SCI-014`; `SAT-014` | `IAT-RATE-B-POSTYIELD` | `IP-RATE-B-POSTYIELD-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-046` | 10.3.3.3; p.15; PDF 21 | `Rm`-only ceiling | For an `Rm`-only test, permit one rate throughout but cap it at `0.008 s-1`. | `SCI-014`; `SAT-014` | `IAT-RATE-B-POSTYIELD` | `IP-RATE-B-POSTYIELD-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-047` | 10.3.4; p.15; PDF 21 | Designation syntax | Represent Method A as `ISO 6892-1 Annn`, with up to three rate-range characters for the test phases. | `SCI-015`; `SAT-015` | `IAT-RATE-DESIGNATION` | `IP-DESIGNATION-A-PHASES-MAX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-048` | 10.3.4; p.15; PDF 21 | Designation syntax | Represent Method B as `ISO 6892-1 Bn`, optionally including the selected nominal elastic stress rate. | `SCI-015`; `SAT-015` | `IAT-RATE-DESIGNATION` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-C10-049` | 10.3.4 examples; p.15; PDF 21 | Serialization examples | Validate `A224`, `B30` and unsuffixed `B` as distinct designations with distinct effective rate evidence. | `SCI-015`; `SAT-015` | `IAT-RATE-DESIGNATION` | - | EXTRACTED / REVIEW-PENDING |

## Package count and boundary

- Atomic source items: **191** (`6` in Clauses 1-2, `42` definitions/formulas, `46` Table 1 symbols, `48` in Clauses 5-9, and `49` in Clause 10).
- Controlled printed pages: **1-15**; controlled PDF pages: **7-21**.
- Coverage status: extraction and bidirectional family/test/parameter routing complete for this package; independent interpretation/parameter review and all executable evidence remain pending.
- Excluded from this package: Clauses 11-23, Annexes A-L, detailed referenced-standard requirements, and ASTM E8/E8M-15a.
