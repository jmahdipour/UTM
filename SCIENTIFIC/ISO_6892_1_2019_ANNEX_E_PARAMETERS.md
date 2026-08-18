---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_E_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex E

## Control rules

This register holds numeric values, formulas and boundary operators extracted from normative Annex E. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. Routing of machined tube-wall specimens below or at/above 3 mm reuses `IP-PRODUCT-B-THICKNESS-MAX-EXCLUSIVE` and `IP-PRODUCT-D-FLAT-MIN` from the Clauses 1-10 package.

## Specimen selection and plug geometry

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AE-LONGITUDINAL-STRIP-THICKNESS-GENERAL-MIN-EXCLUSIVE` | `a0 > 0.5` | mm; strict general-use guidance, not unconditional eligibility | E.1 para.2; p.48; PDF 54 | below / equal / above; guidance retained/converted to mandate | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-PLUG-CLEARANCE-ORDINARY-MIN-EXCLUSIVE-FORMULA` | `clearance > D0 / 4` | compatible lengths; strict lower bound for each plug-to-nearest-mark distance | E.2.1 sentence 2; p.48; PDF 54 | below / equal / above for each end; wrong diameter identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-PLUG-CLEARANCE-DISPUTE-FORMULA` | `clearance = D0` | compatible lengths; exact dispute value when material is sufficient | E.2.1 dispute sentence; p.48; PDF 54 | below / exact / above; sufficient material absent/present | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-PLUG-PROJECTION-MAX-FORMULA` | `projection <= D0` | compatible lengths; inclusive maximum toward the gauge marks | E.2.1 para.2; p.48; PDF 54 | below / equal / above; wrong direction or diameter | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Original-area accuracy and formulas

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AE-S0-ACCURACY-MAX` | `1` | percent; symmetric inclusive maximum absolute error or better | E.3 para.1; p.48; PDF 54 | below / equal / above; sign, unit and evidence handling | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-E1-MASS-DENSITY-S0-FORMULA` | `S0 = 1000 * m / (rho * Lt)` | `m` in g; `rho` in g/cm3; `Lt` in mm; output mm2 | Formula E.1 and where list; pp.48-49; PDFs 54-55 | analytical values / exact scaling / zero-negative-nonfinite denominator / missing or wrong input | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-E2-LONGITUDINAL-S0-FORMULA` | `S0 = (b0/4)*sqrt(D0^2-b0^2) + (D0^2/4)*asin(b0/D0) - (b0/4)*sqrt((D0-2*a0)^2-b0^2) - ((D0-2*a0)/2)^2*asin(b0/(D0-2*a0))` | compatible length inputs; output area; radians for inverse-sine terms | Formula E.2 and where list; p.49; PDF 55 | analytical geometry / grouping / real-domain boundaries / missing, nonpositive or incompatible input | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-E3-CURVATURE-S0-FORMULA` | `S0 = a0*b0*(1 + b0^2/(6*D0*(D0-2*a0)))` | compatible lengths; output area; curvature-corrected optional branch | Formula E.3 first branch; p.49; PDF 55 | analytical values / denominator and unit validation / wrong branch | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-E3-CURVATURE-RATIO-MAX-EXCLUSIVE` | `b0 / D0 < 0.25` | dimensionless; strict upper condition | Formula E.3 first condition; p.49; PDF 55 | below / equal / above; unit normalization | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-E3-PRODUCT-S0-FORMULA` | `S0 = a0 * b0` | compatible lengths; output area; direct-product optional branch | Formula E.3 second branch; p.49; PDF 55 | analytical values / wrong branch / missing or incompatible input | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-E3-PRODUCT-RATIO-MAX-EXCLUSIVE` | `b0 / D0 < 0.10` | dimensionless; strict upper condition; overlaps first condition | Formula E.3 second condition; p.49; PDF 55 | below / equal / above; overlap selection evidence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AE-E4-TUBE-S0-FORMULA` | `S0 = pi * a0 * (D0 - a0)` | compatible lengths; output area of complete tube wall | Formula E.4; p.49; PDF 55 | analytical values / positive annular geometry / wrong area formula or unit | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **12**.
- Annex-B and Annex-D tube-wall routing at 3 mm reuses the controlled package-1 applicability parameters and remains independently review-pending.
- The Formula-E.1 scaling, Formula-E.2 operation grouping and Formula-E.4 annular identity require independent dimensional and high-precision comparison.
- Formula E.3 states two overlapping strict conditions. This register retains both branches and requires explicit selection evidence; it does not invent exclusive intervals or automatic precedence.
- Mandatory, permissive, general-use and dispute operators remain distinct and cannot be collapsed into one default route.
