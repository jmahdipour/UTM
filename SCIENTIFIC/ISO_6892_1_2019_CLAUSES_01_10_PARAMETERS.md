---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_CLAUSES_01_10_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Clauses 1 to 10

## Control rules

This register holds the numeric values, formulas, boundary operators and serialization limits referenced by the Clauses 1-10 atomic RTM. Decimal values use invariant notation here; the profile must retain source units and convert to canonical units without changing boundary semantics.

Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`. It is not approved production configuration. A reviewer shall compare the value, unit, inclusivity, applicability and locator directly with the controlled PDF and record identity/date/signature before the parameter can become `REVIEWED`.

## Environment and general geometry

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-TEMP-ROOM-MIN` | `10` | degC, inclusive | C5; p.8; PDF 14 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-TEMP-ROOM-MAX` | `35` | degC, inclusive | C5; p.8; PDF 14 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-TEMP-CONTROLLED-NOMINAL` | `23` | degC | C5; p.8; PDF 14 | exact nominal | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-TEMP-CONTROLLED-TOL` | `5` | degC, symmetric inclusive | C5; p.8; PDF 14 | nominal minus/equal/plus tolerance and just outside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-K-PREFERRED` | `5.65` | dimensionless | 6.1.1; pp.8-9; PDFs 14-15 | exact and alternative coefficient | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-K-ALTERNATE-PREFERRED` | `11.3` | dimensionless, preferred alternative | 6.1.1; p.9; PDF 15 | exact and non-proportional alternative | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-L0-MIN` | `15` | mm, inclusive minimum | 6.1.1; p.8; PDF 14 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-L0-UNCERTAINTY-THRESHOLD` | `20` | mm, below triggers warning | 6.1.1 Note; p.9; PDF 15 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-PRODUCT-B-THICKNESS-MIN` | `0.1` | mm, inclusive | Table 2; p.10; PDF 16 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-PRODUCT-B-THICKNESS-MAX-EXCLUSIVE` | `3` | mm, exclusive | Table 2; p.10; PDF 16 | below / equal | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-PRODUCT-C-SIZE-MAX-EXCLUSIVE` | `4` | mm diameter/side, exclusive | Table 2; p.10; PDF 16 | below / equal | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-PRODUCT-D-FLAT-MIN` | `3` | mm, inclusive | Table 2; p.10; PDF 16 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-PRODUCT-D-SIZE-MIN` | `4` | mm diameter/side, inclusive | Table 2; p.10; PDF 16 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-S0-SECTION-COUNT-RECOMMENDED` | `3` | count, recommended minimum | C7; p.10; PDF 16 | 2 / 3 / 4 with procedure state | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Gauge marking and extensometer geometry

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-L0-MARK-REL-TOL` | `1` | percent, symmetric inclusive | 8.2; p.11; PDF 17 | inside / equal / outside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-L0-ROUND-INCREMENT` | `5` | mm, nearest multiple | 8.2; p.11; PDF 17 | values around half increment | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-L0-ROUND-DIFF-MAX-EXCLUSIVE` | `10` | percent of `L0`, exclusive | 8.2; p.11; PDF 17 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-LE-L0-MIN-EXCLUSIVE` | `0.50` | ratio `Le/L0`, preferred exclusive lower bound | 8.3; p.11; PDF 17 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-LE-LC-MAX-APPROX` | `0.90` | ratio `Le/Lc`, approximate preferred upper bound | 8.3; p.11; PDF 17 | below / equal / above with guidance state | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-LE-L0-TARGET-RATIO` | `1.0` | approximate ratio `Le/L0` for at/after-maximum properties | 8.3; p.11; PDF 17 | declared tolerance policy required | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Apparatus and gripping

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-FORCE-CLASS-MAX` | `1` | ISO 7500-1 class; 1 or better | C9; p.11; PDF 17 | eligible / worse / missing / wrong range | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-EXT-PROOF-CLASS-MAX` | `1` | ISO 9513 class; 1 or better | C9; p.11; PDF 17 | eligible / worse / missing / wrong range | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-EXT-OTHER-CLASS-MAX` | `2` | ISO 9513 class; conditional maximum | C9; p.11; PDF 17 | class 1 / 2 / worse | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-EXT-CLASS2-THRESHOLD` | `5` | percent extension, strictly greater | C9; p.11; PDF 17 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-PRELOAD-YIELD-FRACTION-MAX` | `0.05` | fraction of specified/expected yield, inclusive maximum | 10.2; pp.11-12; PDFs 17-18 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Method A and Method B rates

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-RATE-PREYIELD-FRACTION` | `0.5` | fraction of expected/specified yield | 10.3.2.1(a), 10.3.3.1; pp.12,14; PDFs 18,20 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-A1` | `0.00007` | s-1 | 10.3.2.2; p.13; PDF 19 | tolerance edges and outside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-A2` | `0.00025` | s-1 | 10.3.2.2-10.3.2.4; pp.13-14; PDFs 19-20 | tolerance edges and outside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-A3` | `0.002` | s-1 | 10.3.2.3-10.3.2.4; pp.13-14; PDFs 19-20 | tolerance edges and outside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-A4` | `0.0067` | s-1 | 10.3.2.4; p.14; PDF 20 | tolerance edges and outside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-A4-MIN` | `0.4` | min-1, displayed equivalent | 10.3.2.4; p.14; PDF 20 | unit-conversion consistency | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-A-REL-TOL` | `20` | percent, symmetric inclusive | 10.3.2.2-10.3.2.4; pp.13-14; PDFs 19-20 | lower/equal/upper and just outside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-E-BOUNDARY` | `150000` | MPa; lower band `<`, upper band `>=` | Table 3; p.14; PDF 20 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-LOWE-MIN` | `2` | MPa/s, inclusive | Table 3; p.14; PDF 20 | below / equal / inside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-LOWE-MAX` | `20` | MPa/s, inclusive | Table 3; p.14; PDF 20 | inside / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-HIGHE-MIN` | `6` | MPa/s, inclusive | Table 3; p.14; PDF 20 | below / equal / inside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-HIGHE-MAX` | `60` | MPa/s, inclusive | Table 3; p.14; PDF 20 | inside / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-REL-MIN` | `0.00025` | s-1, inclusive | 10.3.3.2.2; pp.14-15; PDFs 20-21 | below / equal / inside | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-REL-MAX` | `0.0025` | s-1, inclusive | 10.3.3.2.2; pp.14-15; PDFs 20-21 | inside / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-PROOF-MAX` | `0.0025` | s-1, inclusive maximum | 10.3.3.2.4; p.15; PDF 21 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-RATE-B-POSTYIELD-MAX` | `0.008` | s-1, inclusive maximum | 10.3.3.3; p.15; PDF 21 | below / equal / above | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-DESIGNATION-A-PHASES-MAX` | `3` | characters/rate phases, inclusive maximum | 10.3.4; p.15; PDF 21 | 0 / 1 / 3 / 4 characters | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Formula and parameterization registry

| Parameter | Canonical expression / rule | Input and output contract | Locator | Status |
|---|---|---|---|---|
| `IP-FORMULA-A` | `A = 100 * (Lu - L0) / L0` | lengths in compatible units; output percent | 3.4.2; p.2; PDF 8 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-FORMULA-E` | `e = 100 * DeltaLe / Le` | extension and `Le` in compatible units; output percent | 3.6.1; p.2; PDF 8 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-FORMULA-Z` | `Z = 100 * (S0 - Su) / S0` | positive compatible areas; output percent | 3.8; p.4; PDF 10 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-FORMULA-R` | `R = F / S0` | force and area; output engineering stress | 3.10; p.4; PDF 10 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-FORMULA-E-MODULUS` | `E = 100 * DeltaR / Deltae` | stress change and percentage-extension change; output stress unit | 3.13; p.5; PDF 11 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-E-ROUND-GPA` | nearest `0.1` | GPa reporting increment | 3.13 Note; p.5; PDF 11 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-FORMULA-SMREL` | `SmRel = 100 * Sm / E` | compatible slope units; output percent | 3.17; p.6; PDF 12 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-FORMULA-L0` | `L0 = k * sqrt(S0)` | `S0` in square-length units; output corresponding length | 6.1.1 and Formula 1; pp.8-10; PDFs 14-16 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-FORMULA-S0-AVERAGE` | `S0 = sum(Si) / n` | geometry-specific section areas; output area | C7; p.10; PDF 16 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-FORMULA-VC` | `vc = Lc * eDotLc` | length times inverse time; output length/time | Formula 2; p.13; PDF 19 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-PROPERTY-SUFFIX-PERCENT` | finite positive requested percentage preserved in property identity | applies separately to `Rp{x}`, `Rt{x}`, `Rr{x}` with `Rr` basis recorded | 3.10.3-3.10.5; p.5; PDF 11 | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **53**.
- Numeric source values are not approved merely because they match this extraction.
- Approximate or recommended bounds remain typed guidance; they must not be silently converted into hard invalidation thresholds.
- The reviewer must resolve whether each referenced dependency edition/profile is available before approving an executable ISO profile.
