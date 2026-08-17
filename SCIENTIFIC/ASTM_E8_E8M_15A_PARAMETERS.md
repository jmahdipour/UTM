---
project: Universal Testing Machine (UTS)
document: ASTM_E8_E8M_15A_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ASTM-E8-E8M-15A
last_revision: 2026-08-17
---

# ASTM E8/E8M-15a Profile Parameters

## Control rules

Every entry remains review-pending; units, operators, source identity and authority are part of the parameter.

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `AP-ASTM15-PROFILE` | `edition=15a; system=E8|E8M; 10<=T<=38 C` | profile predicates | 1.1-1.6; PDF 1 | exact edition; no mixed units; product overrides | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-DEPENDENCIES` | `A356/A356M|A370|B557|B557M|E4|E6|E29|E83|E345|E691|E1012|D1566|E1856|E2658` | revision register | 2.1; PDFs 1-2 | missing/wrong revision blocks affected route | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-APPARATUS` | `E4 range|alignment|device resolution|E83 class` | qualification set | Section 5; PDFs 2-3 | certificate/range/class/gauge identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-SPECIMEN-CATALOG` | `Figures 1-20 and Section-6 routes` | E8/E8M geometry catalog | Section 6; PDFs 3-16 | form/size/thickness/tolerance and unit isolation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-DIMENSION-BANDS` | `>=5:0.02; 2.5-5:0.01; 0.5-2.5:0.002; <0.5:1% and >=0.002` | mm piecewise | 7.2.1; PDF 10 | strict/inclusive boundaries; paired inch values | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-AREA` | `geometry-selected S0` | area | 7.2.2; PDFs 10-12 | positive dimensions; correct specimen route | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-TUBE-AREA` | `exact; if D/W>6 exact or W*T` | area | 7.2.3 Formulas 1-2; PDF 12 | D/W boundary; radians; exact/approx route | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-GAUGE` | `G by specimen catalog` | length | 7.3.1; PDF 12 | mark timing/depth/spacing and fracture influence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-SPEED-MODE` | `strain|stress|loaded_crosshead|elapsed|free_running` | explicit enum | 7.6.1-7.6.2.5; PDFs 12-13 | mode/unit/event identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-PRE-YIELD` | `min(0.5*min_yield,0.25*min_tensile)` | stress | 7.6.3; PDF 15 | specification provenance and analytical values | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-METHOD-A` | `1.15<=stress_rate<=11.5` | MPa/s | 7.6.3.1; PDF 15 | elastic region; no force chasing through yield | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-METHOD-B` | `strain_rate=0.015+/-0.006` | 1/min | 7.6.3.2; PDF 16 | feedback/safety; specified 0.005 override | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-METHOD-C` | `crosshead=(0.015+/-0.003)*Lref` | length/min | 7.6.3.3; PDF 16 | A/2A/grip-distance branch | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-TENSILE-SPEED` | `0.05<=normalized_speed<=0.5` | 1/min | 7.6.4; PDF 16 | A>5%; <=5% exception; product override | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-OFFSET` | `stress at offset-line intersection` | stress | 7.7.1; PDF 17 | declared offset; verified range; X5 nonideal cases | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-EUL` | `stress at specified total extension` | stress | 7.7.2; PDF 17 | B2/Class-C disclosure and strain of interest | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-YPE` | `defined landmark interval` | percent | 7.8; PDF 18 | plateau/inflection/no-YPE | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-UNIFORM` | `extension at qualified Fmax` | percent | 7.9; PDFs 18-19 | plateau/fracture and elastic+plastic | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-RM` | `Rm=Fmax/S0` | stress | 7.10; PDF 19 | positive S0; Fmax identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-A` | `A=((Lu-L0)/L0)*100` | percent | 7.11; PDFs 19-20 | at/after method; L0>0; fracture event | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-Z` | `Z=((S0-Su)/S0)*100` | percent | 7.12; PDF 20 | circular/rectangular Su and fracture location | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-ROUNDING` | `E29 + property/product rules` | quantum | 7.13; PDF 20 | final-step only; product precedence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-REPORT` | `8.2 applicable + 8.3 on-request` | field schema | Section 8; PDFs 20-21 | method/gauge/speed/replacement provenance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-PRECISION` | `Section 9 and Tables X1.1-X1.6` | information-only | PDFs 21-24 | property/unit/material identity; no duplicate-test limit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `AP-ASTM15-APPENDIX` | `X1-X5 nonmandatory` | authority enum | PDFs 21-28 | no silent normative promotion | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **25**.
- Exact edition 15a is isolated from ISO and later ASTM editions; E8 and E8M values cannot be mixed in one conformity claim.
