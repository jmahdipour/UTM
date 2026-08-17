---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_I_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Atomic RTM - Annex I

## Control statement

This inventory paraphrases informative Annex I, Formulas I.1-I.2 and Figure I.1 of the controlled English third edition. It does not reproduce the standard. Printed-page and PDF-page locators identify the controlled local source. Annex I is a permitted subdivision-based alternative for a specific fracture-position case; it does not silently override Clause 20.1 or create an independent conformity requirement.

`EXTRACTED / REVIEW-PENDING` means that the source item is independently addressable and cross-linked, but its interpretation and parameterization have not received independent scientific sign-off. No row is implementation, validation execution or conformity evidence.

## I.1 - Informative applicability and pre-test subdivision

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AI-001` | Annex I status; p.61; PDF 67 | Source role | Preserve Annex I as informative, explicitly selected guidance rather than an unconditional elongation method. | `SCI-001`, `SCI-027`; `SAT-001`, `SAT-027` | `IAT-AI-INFORMATIVE-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-002` | Annex I title; p.61; PDF 67 | Purpose | Scope the method to percentage elongation after fracture based on subdivision of original gauge length. | `SCI-003`, `SCI-009`, `SCI-027`; `SAT-003`, `SAT-009`, `SAT-027` | `IAT-AI-INFORMATIVE-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-003` | I.1 opening condition 1; p.61; PDF 67 | Applicability | Admit the route only when fracture position does not comply with Clause-20.1 conditions. | `SCI-027`, `SCI-039`; `SAT-027`, `SAT-039` | `IAT-AI-INFORMATIVE-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-004` | I.1 opening condition 2; p.61; PDF 67 | Applicability | Also require complete necking to occur inside the original gauge length. | `SCI-009`, `SCI-027`, `SCI-030`, `SCI-039`; `SAT-009`, `SAT-027`, `SAT-030`, `SAT-039` | `IAT-AI-INFORMATIVE-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-005` | I.1 opening conclusion; p.61; PDF 67 | Permission | Permit the Annex-I route to avoid automatic rejection only when both applicability conditions are evidenced. | `SCI-001`, `SCI-027`, `SCI-039`; `SAT-001`, `SAT-027`, `SAT-039` | `IAT-AI-INFORMATIVE-APPLICABILITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-006` | I.1 item a timing; p.61; PDF 67 | Lifecycle | Complete subdivision marks before the tensile test. | `SCI-003`, `SCI-009`, `SCI-027`; `SAT-003`, `SAT-009`, `SAT-027` | `IAT-AI-SUBDIVISION-MARKING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-007` | I.1 item a quantity; p.61; PDF 67 | Geometry | Subdivide the declared original gauge length `L0`, not another length quantity. | `SCI-005`, `SCI-006`, `SCI-009`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027` | `IAT-AI-SUBDIVISION-MARKING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-008` | I.1 item a count; p.61; PDF 67 | Partition | Create `N` equal subdivision lengths whose aggregate reproduces `L0`. | `SCI-005`, `SCI-006`, `SCI-009`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027` | `IAT-AI-SUBDIVISION-MARKING` | `IP-AI-SUBDIVISION-COUNT-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-009` | I.1 item a interval; p.61; PDF 67 | Interval guidance | Retain 5 mm as the recommended subdivision length and 10 mm as the stated upper end without inventing other intervals. | `SCI-006`, `SCI-009`, `SCI-027`, `SCI-039`; `SAT-006`, `SAT-009`, `SAT-027`, `SAT-039` | `IAT-AI-SUBDIVISION-MARKING` | `IP-AI-SUBDIVISION-LENGTH-RECOMMENDED`, `IP-AI-SUBDIVISION-LENGTH-MAX` | EXTRACTED / REVIEW-PENDING |

## I.1-I.2 - Post-test X/Y selection and parity input

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AI-010` | I.1 item b timing; p.61; PDF 67 | Lifecycle | Select X and Y only after the test and qualified fracture. | `SCI-003`, `SCI-027`, `SCI-030`; `SAT-003`, `SAT-027`, `SAT-030` | `IAT-AI-XY-SYMMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-011` | I.1 item b `X`; p.61; PDF 67 | Mark identity | Assign X to the gauge mark on the shorter broken part. | `SCI-006`, `SCI-027`, `SCI-038`; `SAT-006`, `SAT-027`, `SAT-038` | `IAT-AI-XY-SYMMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-012` | I.1 item b `Y`; p.61; PDF 67 | Mark identity | Assign Y to a gauge mark on the longer broken part. | `SCI-006`, `SCI-027`, `SCI-038`; `SAT-006`, `SAT-027`, `SAT-038` | `IAT-AI-XY-SYMMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-013` | I.1 item b symmetry; p.61; PDF 67 | Fracture symmetry | Choose Y at the same distance from fracture as X and retain the distance comparison. | `SCI-005`, `SCI-006`, `SCI-027`, `SCI-030`; `SAT-005`, `SAT-006`, `SAT-027`, `SAT-030` | `IAT-AI-XY-SYMMETRY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-014` | I.2 opening; p.61; PDF 67 | Count identity | Bind `n` to the integer number of subdivision intervals between X and Y. | `SCI-005`, `SCI-006`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-027` | `IAT-AI-PARITY-ROUTING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-015` | I.2 routing; p.61; PDF 67 | Route predicate | Select exactly one calculation branch from the parity of integer `N - n`. | `SCI-005`, `SCI-006`, `SCI-027`, `SCI-039`; `SAT-005`, `SAT-006`, `SAT-027`, `SAT-039` | `IAT-AI-PARITY-ROUTING` | `IP-AI-EVEN-BRANCH-PREDICATE`, `IP-AI-ODD-BRANCH-PREDICATE` | EXTRACTED / REVIEW-PENDING |

## I.2 a) - Even branch and Formula I.1

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AI-016` | I.2 item a condition; p.61; PDF 67 | Even route | Use Figure-I.1 a) and Formula I.1 only when `N - n` is even. | `SCI-005`, `SCI-027`, `SCI-038`; `SAT-005`, `SAT-027`, `SAT-038` | `IAT-AI-EVEN-FORMULA` | `IP-AI-EVEN-BRANCH-PREDICATE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-017` | I.2 item a `lXY`; p.61; PDF 67 | Measurement | Measure the distance `lXY` between selected marks X and Y. | `SCI-005`, `SCI-006`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-027` | `IAT-AI-EVEN-FORMULA` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-018` | I.2 item a `Z`; p.61; PDF 67 | Mark position | Locate Z exactly `(N - n)/2` subdivision intervals beyond Y. | `SCI-005`, `SCI-006`, `SCI-009`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027` | `IAT-AI-EVEN-FORMULA` | `IP-AI-EVEN-Z-OFFSET-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-019` | I.2 item a `lYZ`; p.61; PDF 67 | Measurement | Measure `lYZ` from Y to the qualified Z mark. | `SCI-005`, `SCI-006`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-027` | `IAT-AI-EVEN-FORMULA` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-020` | Formula I.1; p.61; PDF 67 | Formula | Calculate `A` from `lXY + 2*lYZ - L0`, divided by `L0` and multiplied by 100. | `SCI-005`, `SCI-006`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-027` | `IAT-AI-EVEN-FORMULA` | `IP-AI-I1-ELONGATION-FORMULA` | EXTRACTED / REVIEW-PENDING |

## I.2 b) - Odd branch and Formula I.2

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AI-021` | I.2 item b condition; p.61; PDF 67 | Odd route | Use Figure-I.1 b) and Formula I.2 only when `N - n` is odd. | `SCI-005`, `SCI-027`, `SCI-038`; `SAT-005`, `SAT-027`, `SAT-038` | `IAT-AI-ODD-FORMULA` | `IP-AI-ODD-BRANCH-PREDICATE` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-022` | I.2 item b `lXY`; p.61; PDF 67 | Measurement | Measure `lXY` between selected X and Y for the odd branch. | `SCI-005`, `SCI-006`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-027` | `IAT-AI-ODD-FORMULA` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-023` | I.2 item b `Z'`; p.61; PDF 67 | Mark position | Locate `Z'` exactly `(N - n - 1)/2` subdivision intervals beyond Y. | `SCI-005`, `SCI-006`, `SCI-009`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027` | `IAT-AI-ODD-FORMULA` | `IP-AI-ODD-Z-PRIME-OFFSET-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-024` | I.2 item b `Z''`; p.61; PDF 67 | Mark position | Locate `Z''` exactly `(N - n + 1)/2` subdivision intervals beyond Y. | `SCI-005`, `SCI-006`, `SCI-009`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-009`, `SAT-027` | `IAT-AI-ODD-FORMULA` | `IP-AI-ODD-Z-DOUBLE-PRIME-OFFSET-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-025` | I.2 item b `lYZ'`; p.61; PDF 67 | Measurement | Measure `lYZ'` from Y to the qualified `Z'` mark. | `SCI-005`, `SCI-006`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-027` | `IAT-AI-ODD-FORMULA` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-026` | I.2 item b `lYZ''`; p.61; PDF 67 | Measurement | Measure `lYZ''` from Y to the qualified `Z''` mark. | `SCI-005`, `SCI-006`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-027` | `IAT-AI-ODD-FORMULA` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-027` | Formula I.2; p.61; PDF 67 | Formula | Calculate `A` from `lXY + lYZ' + lYZ'' - L0`, divided by `L0` and multiplied by 100. | `SCI-005`, `SCI-006`, `SCI-027`; `SAT-005`, `SAT-006`, `SAT-027` | `IAT-AI-ODD-FORMULA` | `IP-AI-I2-ELONGATION-FORMULA` | EXTRACTED / REVIEW-PENDING |

## Figure I.1 - Construction identity

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AI-028` | Figure I.1 a); p.62; PDF 68 | Even construction | Preserve the illustrated even geometry, including X/Y/Z order, `n`, `(N-n)/2`, `lXY` and `lYZ`. | `SCI-006`, `SCI-009`, `SCI-027`, `SCI-038`; `SAT-006`, `SAT-009`, `SAT-027`, `SAT-038` | `IAT-AI-FIGURE-IDENTITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-029` | Figure I.1 b); p.62; PDF 68 | Odd construction | Preserve the illustrated odd geometry, including X/Y/Z'/Z'' order, both offsets and both Y-to-Z distances. | `SCI-006`, `SCI-009`, `SCI-027`, `SCI-038`; `SAT-006`, `SAT-009`, `SAT-027`, `SAT-038` | `IAT-AI-FIGURE-IDENTITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-030` | Figure I.1 key `n`; p.62; PDF 68 | Key identity | Bind `n` to the number of intervals between X and Y. | `SCI-006`, `SCI-027`; `SAT-006`, `SAT-027` | `IAT-AI-FIGURE-IDENTITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-031` | Figure I.1 key `N`; p.62; PDF 68 | Key identity | Bind `N` to the total number of equal lengths in `L0`. | `SCI-006`, `SCI-009`, `SCI-027`; `SAT-006`, `SAT-009`, `SAT-027` | `IAT-AI-FIGURE-IDENTITY` | `IP-AI-SUBDIVISION-COUNT-FORMULA` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-032` | Figure I.1 key `X`; p.62; PDF 68 | Key identity | Bind X to the gauge mark on the shorter broken part. | `SCI-006`, `SCI-027`, `SCI-038`; `SAT-006`, `SAT-027`, `SAT-038` | `IAT-AI-FIGURE-IDENTITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-033` | Figure I.1 key `Y`; p.62; PDF 68 | Key identity | Bind Y to the selected gauge mark on the longer broken part. | `SCI-006`, `SCI-027`, `SCI-038`; `SAT-006`, `SAT-027`, `SAT-038` | `IAT-AI-FIGURE-IDENTITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-034` | Figure I.1 key `Z/Z'/Z''`; p.62; PDF 68 | Key identity | Preserve Z, `Z'` and `Z''` as distinct parity-specific gauge marks. | `SCI-006`, `SCI-027`, `SCI-038`; `SAT-006`, `SAT-027`, `SAT-038` | `IAT-AI-FIGURE-IDENTITY` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AI-035` | Figure I.1 Note; p.62; PDF 68 | Figure guidance | Treat the illustrated test-piece head shape as guidance only and never as a specimen-eligibility geometry. | `SCI-001`, `SCI-007`, `SCI-027`, `SCI-039`; `SAT-001`, `SAT-007`, `SAT-027`, `SAT-039` | `IAT-AI-FIGURE-IDENTITY` | - | EXTRACTED / REVIEW-PENDING |

## Package count and evidence boundary

- Atomic source items: **35** (`scope/subdivision=9`, `X/Y/parity=6`, `even=5`, `odd=7`, `Figure I.1=8`).
- Parameter/formula records: **10**.
- Atomic acceptance variants: **7**.
- Coverage status: extraction and bidirectional family/test/parameter routing complete for informative Annex I, Formulas I.1-I.2 and Figure I.1; independent interpretation/parameter review and all executable evidence remain pending.
- Informative boundary: Annex I remains a permitted alternative for the joint failed-fracture-position/complete-in-gauge-necking case; equal-length marking, parity, mark selection and formula inputs must be evidenced and cannot silently rescue an inapplicable specimen.
- Excluded from this package: Annexes J-L, detailed referenced-standard requirements and ASTM E8/E8M-15a.
