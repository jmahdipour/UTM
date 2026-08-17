---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_K_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-17
---

# ISO 6892-1:2019 Annex K Profile Parameters

## Control rules

Every entry remains review-pending; units, operators, source identity and authority are part of the parameter.

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AK-RPR-INTERVAL` | `estimate+/-half_width` | symmetric | K.1; p.64; PDF 70 | not an acceptance tolerance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-K1` | `u=s/sqrt(n)` | quantity unit | Formula K.1; p.64; PDF 70 | n positive; repeated-data provenance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-RECTANGULAR` | `equal_likelihood` | predicate | K.2.3; p.64; PDF 70 | justified distribution; half/full width | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-K2` | `u=a/sqrt(3)` | quantity unit | Formula K.2; p.64; PDF 70 | a>=0 and is half-width | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-K3` | `u(y)=sqrt(sum(u_i^2))` | compatible units | Formula K.3; p.65; PDF 71 | one/many components; dimensional validity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-UNITS` | `compatible(component_units)` | predicate | K.2-K.3; PDFs 71-72 | absolute/relative conversion | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-MATRIX` | `Table K.1` | source/property map | Table K.1; p.65; PDF 71 | all X/dash cells | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-EXAMPLES` | `1.4/2; 1/sqrt(3); RSS=0.91%` | information-only | K.3; p.65; PDF 71 | no profile defaults | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-EXAMPLE-TABLES` | `Tables K.2-K.4` | information-only | p.66; PDF 72 | all cells retain example authority | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-K4` | `uZ=sqrt((aS0/sqrt(3))^2+(aSu/sqrt(3))^2)` | relative percent | Formula K.4; p.66; PDF 72 | area identity and analytical result | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-EXPANDED` | `U=k*u_c` | declared k | K.3; p.66; PDF 72 | k provenance; k=2 example | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-FACTORS` | `seven listed factors` | candidate set | K.4; p.67; PDF 73 | complete applicability inventory | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AK-DISTRIBUTION` | `normal|rectangular|reviewed_other` | enum | K.4; p.67; PDF 73 | one-sigma conversion | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **13**.
- Annex K is informative; examples and named materials are not universal values or limits.
