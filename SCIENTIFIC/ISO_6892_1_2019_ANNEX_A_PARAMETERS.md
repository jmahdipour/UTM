---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_A_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex A

## Control rules

This register holds formulas, numeric values and boundary operators extracted from informative Annex A. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. Approximate recommendations remain approximate, and Table A.1 operator semantics require independent review before implementation.

## Sampling and property detection

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AA-FORMULA-FMIN-A` | `fmin = 100 * eDot * E / (ReH * q)` | `fmin` in s^-1; `eDot` in s^-1; `E`/`ReH` in MPa; `q` in percent; positive denominator | A.2.2 Formula A.1; pp.35-36; PDFs 41-42 | compatible units; zero/negative/missing `ReH` or `q`; `E` source identity; achieved sampling below/on/above result | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-NO-YIELD-FMIN-DIVISOR` | `2` | divisor; use `Rp0.2` in Formula A.1 branch and halve the required minimum | A.2.2 para.2; p.36; PDF 42 | yield phenomenon present/absent; `Rp0.2` valid/invalid; exact halving | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-FORMULA-FMIN-B` | `fmin = 100 * RDot / (ReH * q)` | `fmin` in s^-1; `RDot` in MPa/s; `ReH` in MPa; `q` in percent; positive denominator | A.2.2 Formula A.2; p.36; PDF 42 | Method B active/inactive; compatible units; invalid denominator; achieved sampling below/on/above result | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-REH-FORCE-DROP-MIN` | `0.5` | percent; reduction is inclusive at the stated minimum | A.3.2; p.36; PDF 42 | below / equal / above; noise/transient provenance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-REH-FOLLOWUP-STRAIN-MIN` | `0.05` | percent strain; follow-up interval is inclusive at the stated minimum | A.3.2; p.36; PDF 42 | below / equal / above; force re-exceeds prior maximum | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Fracture and elastic-slope recommendations

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AA-FRACTURE-DROP-MULTIPLIER` | `5` | strict comparison: `abs(DeltaF[n+1,n]) > 5 * abs(DeltaF[n,n-1])` | A.3.6.1(a) and Figure A.2; p.37; PDF 43 | below / equal / above; sign reversal; zero prior difference; figure/prose combination pending review | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-FRACTURE-RESIDUAL-FM-MAX` | `0.02 * Fm` | strict force boundary below 2 percent of maximum force | A.3.6.1(a-b) and Figure A.2; p.37; PDF 43 | below / equal / above; soft-material branch; qualified `Fm`; figure/prose combination pending review | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-RP02-SLOPE-LOWER-APPROX` | `~0.10 * Rp0.2` | approximate lower stress bound; not a universal hard acceptance limit | A.3.7 recommendation; p.38; PDF 44 | below/near/above; iterative revision; approximation retained | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-RP02-SLOPE-UPPER-APPROX` | `~0.40 * Rp0.2` | approximate upper stress bound; not a universal hard acceptance limit | A.3.7 recommendation; p.38; PDF 44 | below/near/above; iterative revision; approximation retained | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Software-validation statistics and limits

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AA-VALIDATION-N-MIN` | `5` | identical test pieces from one sample; inclusive minimum | A.4 para.2 and Table A.1; pp.38-39; PDFs 44-45 | fewer / exactly / more; specimen/sample identity mismatch | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-VALIDATION-DI-FORMULA` | `Di = Hi - Ri` | manual result minus computer result; property-compatible units | Table A.1 definition; p.39; PDF 45 | sign; zero; unit mismatch; paired specimen identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-VALIDATION-D-FORMULA` | `D = sum(Di) / n` | arithmetic mean over the qualified paired specimens | Table A.1 footnote a; p.39; PDF 45 | signed/absolute/relative evaluation; `n` below minimum; missing pair | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-VALIDATION-S-FORMULA` | `s = sqrt(sum((Di - D)^2) / (n - 1))` | sample standard deviation; property-compatible units or relative percent | Table A.1 footnote b; p.39; PDF 45 | denominator; precision; independent recomputation; relative conversion | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-LIMIT-RP02` | `Drel <= 0.5%; Dabs <= 2 MPa; srel <= 0.35%; sabs <= 2 MPa` | Table A.1 dual relative/absolute criteria; exact operator requires independent review | Table A.1 `Rp0.2`; p.39; PDF 45 | below / equal / above each component; highest-value footnote interpretation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-LIMIT-RP1` | `Drel <= 0.5%; Dabs <= 2 MPa; srel <= 0.35%; sabs <= 2 MPa` | Table A.1 dual relative/absolute criteria; property identity remains distinct | Table A.1 `Rp1`; p.39; PDF 45 | below / equal / above each component; highest-value footnote interpretation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-LIMIT-REH` | `Drel <= 1%; Dabs <= 4 MPa; srel <= 0.35%; sabs <= 2 MPa` | Table A.1 dual relative/absolute criteria | Table A.1 `ReH`; p.39; PDF 45 | below / equal / above each component; highest-value footnote interpretation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-LIMIT-REL` | `Drel <= 0.5%; Dabs <= 2 MPa; srel <= 0.35%; sabs <= 2 MPa` | Table A.1 dual relative/absolute criteria | Table A.1 `ReL`; p.39; PDF 45 | below / equal / above each component; highest-value footnote interpretation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-LIMIT-RM` | `Drel <= 0.5%; Dabs <= 2 MPa; srel <= 0.35%; sabs <= 2 MPa` | Table A.1 dual relative/absolute criteria | Table A.1 `Rm`; p.39; PDF 45 | below / equal / above each component; highest-value footnote interpretation | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AA-LIMIT-A` | `Dabs <= 2 percentage points; sabs <= 2 percentage points` | no relative criterion supplied by Table A.1 | Table A.1 `A`; p.39; PDF 45 | below / equal / above; attempted relative criterion rejected | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **19**.
- Formula/operator interpretations, the Figure-A.2 predicate combination and the Table-A.1 relative/absolute decision rule require independent comparison with the controlled PDF.
- Approximate slope-range recommendations are not converted into universal hard limits.
- External validation datasets and computer-readable formats are not admitted until their identity, license and evidence role are controlled separately.
