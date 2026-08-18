---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_CLAUSES_17_23_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Clauses 17 to 23

## Control rules

This register holds the new formulas, numeric values and boundary operators referenced by the Clauses 17-23 atomic RTM. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration.

The package also reuses parameter candidates already defined by package 1 for Method A rates, designation syntax, `A`, and `Z`. A cross-package reference does not change the review status or create a duplicate parameter authority.

## Maximum-force and fracture extension

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-C17-FORMULA-AG` | `Ag = 100 * (DeltaLm / Le - Rm / mE)` | compatible extension/length and stress/slope ratios; output percent | C17 Formula 3; p.17; PDF 23 | exact/interpolated maximum; invalid `Le`, `mE` or `Rm`; `mE`/`E` identity mismatch | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C17-C18-PLATEAU-MIDPOINT` | `em = (eStart + eEnd) / 2` for the qualified maximum-force plateau | midpoint; both plateau boundaries required | C17-C18 notes and Figure 1; pp.17-18,21; PDFs 23-24,27 | no plateau / exact / between-sample bounds / ambiguous plateau | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C18-FORMULA-AGT` | `Agt = 100 * DeltaLm / Le` | compatible lengths and positive `Le`; output percent | C18 Formula 4; pp.17-18; PDFs 23-24 | exact/interpolated maximum; non-positive `Le`; incompatible units | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C19-FORMULA-AT` | `At = 100 * DeltaLf / Le` | compatible lengths and positive `Le`; output percent | C19 Formula 5; p.18; PDF 24 | qualified/unqualified fracture; exact/interpolated endpoint; invalid `Le` | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Post-fracture measurement and area reduction

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-C20-LENGTH-INCREMENT-MAX` | `0.25` | mm, maximum reporting/measurement increment; better resolution permitted | 20.1 para.5; p.18; PDF 24 | worse / equal / better resolution; display versus device resolution | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C20-LOW-ELONGATION-THRESHOLD` | `5` | percent; Annex H precaution route when specified minimum is strictly below | 20.1 para.6; p.18; PDF 24 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C20-FRACTURE-DISTANCE-MIN` | `L0 / 3` | length; ordinary manual-position validity includes equality | 20.1 para.6; p.18; PDF 24 | below / equal / above; nearest-mark identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C21-ROUND-PLANES` | `2` | measurement planes for round specimens | C21 para.3; p.19; PDF 25 | missing / one / exactly two / extra retained readings | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C21-ROUND-PLANE-ANGLE` | `90` | degrees between the two planes | C21 para.3; p.19; PDF 25 | below / equal / above with angular uncertainty evidence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C21-SU-ACCURACY-RECOMMENDED` | `2` | percent, symmetric recommended accuracy; not an automatic universal rejection limit | C21 paras.6-7; p.19; PDF 25 | achieved / not achieved / unknown; small or non-round geometry | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Reporting and figure assumptions

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-C22-ROUND-STRENGTH` | `1` | MPa reporting quantum, nearest; better precision or governing override allowed | C22(g); p.20; PDF 26 | halfway cases; sign; better precision; product override | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C22-ROUND-AE` | `0.1` | percentage-point reporting quantum, nearest; better precision or governing override allowed | C22(g); p.20; PDF 26 | halfway cases; better precision; product override | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C22-ROUND-OTHER-EXTENSION` | `0.5` | percentage-point reporting quantum for other extension/elongation results | C22(g); p.20; PDF 26 | halfway cases; property classification; better precision; override | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-C22-ROUND-Z` | `1` | percentage-point reporting quantum for `Z` | C22(g); p.20; PDF 26 | halfway cases; better precision; product override | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-F09-METHOD-B-E-ILLUSTRATION` | `210000` | MPa; steel modulus used only for the Figure 9 Method B illustration | Figure 9 note 2; p.27; PDF 33 | illustration-only identity; never silently reused as measured `E` or `mE` | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **15**.
- Formula/operator interpretations, rounding tie policy and inclusive boundaries require independent comparison with the controlled PDF and relevant referenced standard.
- Recommended accuracy and illustrative modulus values retain their source status; they are not universal acceptance defaults.
- Canonical unrounded values must remain available even when report presentation applies a controlled rounding quantum.
