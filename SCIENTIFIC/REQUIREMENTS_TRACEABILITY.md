---
project: Universal Testing Machine (UTS)
document: SCIENTIFIC_REQUIREMENTS_TRACEABILITY
version: 1.0
status: FROZEN
governing_edr: EDR-0014
last_revision: 2026-08-09
---

# Scientific Requirements Traceability

This matrix is the controlled requirement-family routing baseline. It paraphrases requirements and does not reproduce the licensed standards. `DESIGN-PASS / IMPLEMENTATION-PENDING` means the family is routed but no atomic-coverage, implementation or conformity claim is made. Atomic paragraph/table/formula coverage is governed by `SOURCE_COVERAGE_AUDIT.md` and remains open.

| ID | Requirement | Governing source | Implementation target | Acceptance | Status |
|---|---|---|---|---|---|
| `SCI-001` | Pin exact standard/profile/algorithm revisions in every Method and Analysis Revision | EDR-0014; ISO 6892-1:2019 Clause 22 | profile registry and snapshot | `SAT-001` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-002` | Keep ISO, ASTM and derived-engineering applicability/report rules isolated | EDR-0014 | profile boundary tests | `SAT-002` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-003` | Freeze geometry, channel binding, calibration, rates and analysis parameters before Arm | EDR-0002; EDR-0005; EDR-0014 | Run Configuration Snapshot | `SAT-003` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-004` | Use immutable raw evidence and revisioned deterministic replay | EDR-0001; EDR-0007; EDR-0014 | replay pipeline | `SAT-004` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-005` | Reject or qualify non-finite, missing, gapped, stale, saturated, out-of-range or unsynchronized input | EDR-0005; EDR-0014 | measurement validator | `SAT-005` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-006` | Represent every Clause 4 symbol with typed units and preserve source/canonical/display units | ISO 6892-1:2019 Clauses 3-4; EDR-0007 | scientific quantities/catalog | `SAT-006` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-007` | Support specimen shape/dimension/preparation applicability | ISO 6892-1:2019 Clause 6 | specimen geometry service | `SAT-007` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-008` | Determine and validate original cross-sectional area `S0` by selected specimen geometry | ISO 6892-1:2019 Clause 7; Annexes B-E | geometry calculators | `SAT-008` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-009` | Validate `L0`, marking, `Le` and their relation to requested properties | ISO 6892-1:2019 Clause 8 | gauge-length validator | `SAT-009` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-010` | Gate results on force/extensometer equipment accuracy evidence | ISO 6892-1:2019 Clause 9; ISO 7500-1; ISO 9513 | metrology eligibility | `SAT-010` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-011` | Record temperature applicability and out-of-range assessment | ISO 6892-1:2019 Clause 5 | environment evidence | `SAT-011` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-012` | Apply and record force-zero and gripping/alignment conditions | ISO 6892-1:2019 Clauses 10.1-10.2 | run preparation evidence | `SAT-012` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-013` | Execute and evidence Method A strain-rate stages without silent control fallback | ISO 6892-1:2019 Clause 10.3.2 | method/rate controller | `SAT-013` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-014` | Execute and evidence Method B stress-rate stages without silent control fallback | ISO 6892-1:2019 Clause 10.3.3 | method/rate controller | `SAT-014` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-015` | Record selected testing-condition designation and all effective rate transitions | ISO 6892-1:2019 Clauses 10.3.1 and 10.3.4 | run/report evidence | `SAT-015` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-016` | Calculate force, extension, engineering stress/strain and declared rate series with sample provenance | ISO 6892-1:2019 Clauses 3-4; EDR-0014 | series calculators | `SAT-016` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-017` | Determine `Fm` and `Rm` under continuous/discontinuous-yield and plateau applicability rules | ISO 6892-1:2019 Clauses 3.9, 3.10.1; Figures 1 and 8 | maximum/tensile detector | `SAT-017` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-018` | Determine `ReH` with first-force-decrease provenance | ISO 6892-1:2019 Clause 11; Annex A.3.2 | yield detector | `SAT-018` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-019` | Determine `ReL`, reject initial transient effects and record any allowed shortened procedure | ISO 6892-1:2019 Clause 12 | yield detector | `SAT-019` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-020` | Determine parameterized `Rp{x}` using the declared slope/origin construction and hysteresis procedure where applicable | ISO 6892-1:2019 Clause 13; Annex A.3.3 | proof-strength detector | `SAT-020` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-021` | Determine parameterized `Rt{x}` from total extension | ISO 6892-1:2019 Clause 14; Annex A.3.3 | proof-strength detector | `SAT-021` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-022` | Execute parameterized `Rr{x}` load-hold-unload verification and return pass/fail evidence | ISO 6892-1:2019 Clause 15 | permanent-set procedure | `SAT-022` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-023` | Determine `Ae` by the selected permitted construction and record the method | ISO 6892-1:2019 Clause 16 | yield-extension detector | `SAT-023` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-024` | Determine `Ag` with `Delta Lm`, `Rm` and `mE`, including maximum-force plateau handling | ISO 6892-1:2019 Clause 17; Annex A.3.5 | extension calculator | `SAT-024` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-025` | Determine `Agt` with maximum-force plateau handling | ISO 6892-1:2019 Clause 18; Annex A.3.4 | extension calculator | `SAT-025` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-026` | Determine `At` from a qualified fracture point and `Delta Lf` | ISO 6892-1:2019 Clause 19; Annex A.3.6 | fracture-extension calculator | `SAT-026` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-027` | Determine `A` by manual or qualified extensometer path with fracture-location validity and declared conversions | ISO 6892-1:2019 Clauses 20.1-20.3; Annexes H-I | post-fracture elongation | `SAT-027` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-028` | Determine `Z` from valid `S0`/`Su` measurements and geometry-specific rules | ISO 6892-1:2019 Clause 21 | reduction-of-area calculator | `SAT-028` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-029` | Support `Awn` only when the Annex J informative method is explicitly selected | ISO 6892-1:2019 Annex J | optional elongation calculator | `SAT-029` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-030` | Detect fracture under a versioned, profile-qualified rule and preserve the full source interval | ISO 6892-1:2019 Clause 3.11; Annex A.2 | fracture detector | `SAT-030` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-031` | Implement Annex A computer-controlled calculation guidance, interpolation controls and software validation evidence | ISO 6892-1:2019 Annex A | detector policies and validation suite | `SAT-031` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-032` | Encode normative specimen families for thin products, small wire/bars/sections, larger products and tubes | ISO 6892-1:2019 Annexes B-E | specimen profile catalog | `SAT-032` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-033` | Support Annex F crosshead-rate estimation as informative, explicitly selected guidance | ISO 6892-1:2019 Annex F | rate estimator | `SAT-033` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-034` | Determine Annex G modulus `E` using eligible equipment, procedure and evaluation range | ISO 6892-1:2019 Annex G.1-G.6 | modulus engine | `SAT-034` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-035` | Report Annex G fit bounds/count and quality outputs `R2`, `Sm`, `Sm(rel)`; never equate `mE` and `E` implicitly | ISO 6892-1:2019 Clauses 3.13-3.17; Annex G.6 and G.8 | modulus quality/result contract | `SAT-035` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-036` | Estimate and report applicable measurement uncertainty with method and confidence evidence | ISO 6892-1:2019 Clause 23; Annexes G.7 and K | uncertainty engine | `SAT-036` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-037` | Populate every required Clause 22 and Annex G.8 report field from immutable evidence | ISO 6892-1:2019 Clause 22; Annex G.8; EDR-0012 | report input bundle | `SAT-037` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-038` | Store each point/property value, coordinate, sample range, method, quality and revision provenance | EDR-0001; EDR-0014 | result/point contract | `SAT-038` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-039` | Return explicit `Valid`, `Warning`, `Invalid` or `NotApplicable`; never fabricate/default failed outputs | EDR-0014 | result state model | `SAT-039` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-040` | Prohibit hidden fallback, display-decimation reuse, smoothing, interpolation or graph correction | EDR-0001; EDR-0005; EDR-0014 | pipeline boundary tests | `SAT-040` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-041` | Re-analysis and manual correction create immutable revisions and preserve automatic/prior results | EDR-0001; EDR-0007; EDR-0014 | Analysis Revision service | `SAT-041` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-042` | Calculate logarithmic strain and valid uniform-region true stress as derived, non-ISO series | EDR-0014; ASM tensile reference | derived engineering engine | `SAT-042` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-043` | Calculate cumulative/interval engineering and true-curve energy with declared bounds, units and integration revision | EDR-0014; ASM tensile reference | energy integration engine | `SAT-043` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-044` | Stop or qualify simple true-stress conversion after necking unless validated local-area data exists | EDR-0014 | true-curve validity policy | `SAT-044` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `SCI-045` | Validate against analytical, Golden, boundary, corrupted and Annex L/interlaboratory evidence plus an independent implementation/review | ISO 6892-1:2019 Annexes A.4 and L; EDR-0014 | scientific verification suite | `SAT-045` | DESIGN-PASS / IMPLEMENTATION-PENDING |

## Coverage statement

The matrix routes ISO 6892-1:2019 Clauses 3-23 and Annexes A-L to controlled requirement/test families. Clauses 1-2 identify scope and referenced standards and are routed through source/profile pinning and metrology dependencies. This is not yet a one-row-per-normative-condition inventory; numeric/table/formula parameter extraction and independent review remain pending. It does not constitute implementation or conformity evidence.
