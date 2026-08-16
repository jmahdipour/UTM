---
project: Universal Testing Machine (UTS)
document: SCIENTIFIC_SOURCE_COVERAGE_AUDIT
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
last_revision: 2026-08-09
---

# Scientific Source Coverage Audit

## Corrected finding

The existing 45 `SCI-*` rows provide complete **requirement-family routing** for ISO 6892-1:2019 and the selected derived calculations. They are not yet an atomic, paragraph/table/formula-level inventory of every normative condition. Likewise, the original one-line `SAT-*` list was an acceptance-criterion index, not a complete executable test design.

The test-design deficiency is now addressed by `TEST_CASE_SPECIFICATIONS.md` and `TEST_FIXTURE_CATALOG.md`. The following items remain open before `SG-02 Clause Traceability` can close:

1. atomize each normative shall/condition/table boundary into a controlled source-item ID;
2. record controlled PDF page plus clause/table/formula locator for every source item;
3. link every source item to a `SCI-*` family, one or more `SAT-*` variants and a profile parameter ID;
4. independently review every extracted numeric/table parameter;
5. create serialized fixtures and executable evidence.

Six controlled atomization packages are now present for ISO 6892-1:2019 Clauses 1-23, Figures 1-12 and Annexes A-C:

- 191 atomic source items covering scope, dependencies, terms/formulas, all 46 Table 1 symbols, environment, specimen/geometry, gauge length, apparatus and test-rate conditions;
- 53 parameter/formula candidates with exact printed-page/PDF-page locators and boundary semantics;
- 30 acceptance variants linked bidirectionally to the atomic rows and existing `SCI-*`/`SAT-*` families;
- 71 additional atomic source items for Clauses 11-16 and every routed construction point in Figures 2-7;
- 13 additional parameter/formula candidates and 21 acceptance variants for `ReH`, `ReL`, `Rp{x}`, `Rt{x}`, `Rr{x}` and `Ae`;
- 103 additional atomic source items for Clauses 17-23 and Figures 1 and 8-10, including maximum-force/fracture extensions, post-fracture workflows, area reduction, every Clause-22 report field/rounding quantum and Clause-23 uncertainty boundaries;
- 15 additional parameter/formula candidates and 26 acceptance variants, with controlled reuse of package-1 rate, designation, `A` and `Z` parameter authorities;
- 94 additional atomic source items for informative Annex A, Figures A.1-A.2 and Table A.1, including raw-data interfaces, minimum sampling recommendations, property interpolation/smoothing, fracture detection, elastic-slope selection and software validation;
- 19 additional parameter/formula candidates and 21 acceptance variants covering all Annex-A numeric/formula boundaries while preserving its informative status;
- 48 additional atomic source items for normative Annex B, Tables B.1-B.2 and shared Figure 11, including thin-product applicability, specimen shape/dimensions, preparation, width tolerances and `S0` accuracy;
- 19 additional parameter/formula candidates and 14 acceptance variants covering all Annex-B numeric/table boundaries while reusing the two controlled package-1 thickness limits;
- 25 additional atomic source items for normative Annex C, Formula C.1 and Figure 12, including unmachined-product applicability, both `L0` options, grip-distance rules, coiled-product preparation and `S0` routes;
- 10 additional parameter/formula candidates and 10 acceptance variants covering Annex-C numeric/formula boundaries while reusing the package-1 exclusive size limit;
- static validation of all six packages, counts, references, global parameter authority and cross-package identity uniqueness.

This is extraction/routing evidence, not independent approval. All 129 parameters remain `INDEPENDENT-REVIEW-PENDING`, all 122 acceptance variants remain `NOT-RUN`, and Figures 13-15, Annexes D-L plus the detailed ASTM package are still open.

Therefore, the accurate status is:

**Scientific architecture, scope and family-level routing Frozen; atomic source coverage, fixtures, implementation and execution Pending.**

## Controlled-source identity checked

| Source | Registered role | Audit observation |
|---|---|---|
| `REF-STD-ISO-6892-1-2019` | normative ISO analysis profile | supplied PDF identifies ISO 6892-1:2019(E), third edition, 86 PDF pages; Clauses 1-23 and Annexes A-L are present |
| `REF-STD-ASTM-E8-E8M-15A` | separate historical ASTM profile | supplied PDF identifies E8/E8M-15a, 29 PDF pages; it is not the current `-25` edition and SI/inch-pound values must remain separate |
| `REF-SCI-ASM-TENSILE-2004` | non-normative engineering reference | supports scientific rationale/independent review; it cannot create an ISO or ASTM conformity requirement by itself |

File hashes and redistribution controls remain governed by `REFERENCES/README.md`.

## ISO family routing audit

| Controlled source area | Routed requirement/test families | Present design coverage | Remaining atomic work |
|---|---|---|---|
| Clauses 1-2 | `SCI-001`, `SCI-002`, `SCI-010`; `SAT-001`, `SAT-002`, `SAT-010` | 6 source items atomized with controlled locators and dependency variants | independent dependency/revision review |
| Clauses 3-4 | `SCI-006`, `SCI-016`-`SCI-030`, `SCI-034`-`SCI-035`; paired tests | 42 definition/formula items plus all 46 Table 1 symbols atomized | independent interpretation/unit/schema review |
| Clause 5 | `SCI-011`; `SAT-011` | 7 principle/environment items and boundaries atomized | independent parameter review |
| Clause 6 | `SCI-007`; `SAT-007` | 23 specimen/applicability items and Table 2 routing atomized | independent interpretation/parameter review; Annex detail remains open |
| Clause 7 | `SCI-008`; `SAT-008` | 5 `S0` procedure/metrology items atomized | independent procedure review; Annex formulas remain open |
| Clause 8 | `SCI-009`; `SAT-009` | 10 `L0`, marking and `Le` items atomized | independent parameter/guidance review |
| Clause 9 | `SCI-010`; `SAT-010` | 3 apparatus class/range items atomized | independent dependency/class review |
| Clauses 10.1-10.2 | `SCI-012`; `SAT-012` | 6 zero, gripping, preload and correction items atomized | independent procedural review |
| Clause 10.3 | `SCI-013`-`SCI-015`; `SAT-013`-`SAT-015` | 43 Method A/B/rate/designation items atomized | independent rate/transition/designation review |
| Clauses 11-16 | `SCI-018`-`SCI-023`; paired tests | 71 source items, 13 parameters/formulas and 21 variants atomize `ReH`, `ReL`, `Rp{x}`, `Rt{x}`, `Rr{x}`, `Ae` and Figures 2-7 | independent interpretation/parameter review |
| Clauses 17-19 | `SCI-024`-`SCI-026`; paired tests | 24 source items atomize `Ag`, `Agt`, `At`, maximum/fracture relationships, plateau midpoint and Figure-1 constructions | independent interpretation/parameter review |
| Clauses 20-21 | `SCI-027`-`SCI-028`; paired tests | 39 source items atomize manual/extensometer `A`, fracture-position validity, conversion, `Z`, geometry measurement and accuracy guidance | independent interpretation/parameter review; Annex H-I detail remains open |
| Clause 22 | `SCI-001`, `SCI-015`, `SCI-037`; paired tests | 17 source items atomize every minimum field, applicability condition and property-specific rounding quantum | independent interpretation/rounding review; ISO 80000-1 dependency review remains open |
| Clause 23 | `SCI-036`; `SAT-036` | 8 source items atomize informational status, no-adjustment/no-combination rules and Annex K-L routing | independent interpretation review; Annex K-L detail remains open |
| Figures 1 and 8-10 | `SCI-013`-`SCI-018`, `SCI-024`-`SCI-027`, `SCI-030`, `SCI-038`-`SCI-041`; paired tests | 15 source items atomize property constructions, all `Rm` behavior classes, illustrated rate schedule and inadmissible rate discontinuity | independent figure/parameter review |
| Annex A | `SCI-001`-`SCI-006`, `SCI-010`, `SCI-013`-`SCI-021`, `SCI-024`-`SCI-027`, `SCI-030`-`SCI-031`, `SCI-034`-`SCI-045`; paired tests | 94 source items, 19 parameters/formulas and 21 variants atomize informative scope, raw-data structure, sampling, property landmarks, smoothing, fracture, elastic slope, Table-A.1 validation and machine-readable guidance | independent interpretation/parameter review; serialized fixtures; external TENSTAND/CWA/CRM evidence remains unadmitted |
| Annex B and Figure 11 | `SCI-001`, `SCI-003`, `SCI-006`-`SCI-010`, `SCI-012`, `SCI-018`, `SCI-020`, `SCI-027`, `SCI-032`, `SCI-036`, `SCI-038`-`SCI-039`; paired tests | 48 source items, 19 new parameters/formulas and 14 variants atomize thin-product applicability, rectangular geometry, all B.1/B.2 table rows, preparation, nominal-width eligibility and `S0` accuracy | independent interpretation/parameter review; serialized generated boundary fixtures |
| Annex C and Figure 12 | `SCI-001`, `SCI-003`, `SCI-005`-`SCI-009`, `SCI-012`, `SCI-016`, `SCI-027`, `SCI-032`, `SCI-036`, `SCI-038`-`SCI-039`; paired tests | 25 source items, 10 new parameters/formulas and 10 variants atomize unmachined-product applicability/geometry, both `L0` profiles, grip-distance bounds, straightening, circular measurement and Formula-C.1 `S0` routes | independent interpretation/parameter review, including the unresolved C.2 `b0` meaning; serialized generated boundary fixtures |
| Annexes D-E and Figures 13-15 | `SCI-007`, `SCI-008`, `SCI-032`; paired tests | normative specimen-family routing | row-by-row tables, formulas, tolerances and generated boundary cases |
| Annex F | `SCI-033`; `SAT-033` | opt-in informative estimator | formula/input itemization and informative-labelling assertions |
| Annex G | `SCI-010`, `SCI-034`-`SCI-037`; paired tests | equipment, procedure, evaluation, quality, uncertainty and report families | all equipment/rate/sampling/evaluation parameters and G.8 fields atomized |
| Annexes H-I | `SCI-027`; `SAT-027` | special elongation workflows | step-level/manual measurement and conversion cases |
| Annex J | `SCI-029`; `SAT-029` | optional `Awn` workflow | complete procedure inputs, restrictions and reporting evidence |
| Annex K | `SCI-036`; `SAT-036` | uncertainty evidence | Type A/Type B component inventory and reviewed examples |
| Annex L | `SCI-045`; `SAT-045` | interlaboratory evidence admission | approved dataset/use mapping; Annex L is evidence, not a universal acceptance tolerance |

## ASTM E8/E8M-15a gap

The isolated ASTM profile is architecturally Frozen, but detailed ASTM requirement traceability is not complete. `SCI-002`/`SAT-002` proves isolation only; it does not cover all E8/E8M-15a test specimens, apparatus, procedures, speed rules, yield methods, tensile strength, elongation, reduction of area, reporting, precision/bias and unit-system differences.

Before the ASTM profile can be represented as scientifically complete, it requires its own:

- atomic source inventory for the exact `15a` edition;
- separate E8 and E8M parameter sets where values are not equivalent;
- ASTM-specific Requirement IDs and acceptance variants;
- referenced-standard dependency register;
- controlled Golden/boundary fixtures and independent review;
- edition-difference review before adding any later edition such as `-25`.

Until that package exists, the allowed claim is **ASTM profile boundary defined; detailed ASTM implementation scope Pending**.

## Derived engineering coverage

| Derived family | Routing | Test-design status | Open evidence |
|---|---|---|---|
| logarithmic strain and uniform-region converted true stress | `SCI-042`; `SAT-042` | detailed analytical variants specified | serialized fixtures and independent implementation |
| engineering/true energy density and interval integration | `SCI-043`; `SAT-043` | closed-form and piecewise variants specified | selected production quadrature revision and executable comparison |
| post-necking validity/local-area path | `SCI-044`; `SAT-044` | missing/invalid/validated area variants specified | validated local-area channel/calibration contract and fixtures |

These are `Derived Scientific Property` outputs unless a separately mapped standard requirement says otherwise. They cannot be labelled as mandatory ISO 6892-1 results solely because they are useful tensile calculations.

## Gate assessment

| Gate | Current assessment | Closure blocker |
|---|---|---|
| `SG-01 Source Control` | design evidence present | independent integrity/review record still required for release closure |
| `SG-02 Clause Traceability` | OPEN - ISO packages 1-6 extracted | Clauses 1-23, Figures 1-12 and Annexes A-C independent review pending; Figures 13-15, Annexes D-L and ASTM detailed package absent |
| `SG-03` through `SG-10` | NOT STARTED / PENDING IMPLEMENTATION | fixtures, VB.NET implementation, execution, independent evidence and sign-off absent |

No Workbook or scientific-conformity claim may proceed on the basis of the 45 family rows alone.
