---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_I_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-09
---

# ISO 6892-1:2019 Profile Parameters - Annex I

## Control rules

This register holds subdivision, parity, mark-offset and elongation formulas extracted from informative Annex I. Every entry is `EXTRACTED / INDEPENDENT-REVIEW-PENDING`; none is approved production configuration. Integer parity and exact mark identity select one and only one formula branch.

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AI-SUBDIVISION-LENGTH-RECOMMENDED` | `d = 5` | mm; recommended equal subdivision length | I.1 item a; p.61; PDF 67 | exact recommendation; compatible units; recommendation not mandate | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-SUBDIVISION-LENGTH-MAX` | `d <= 10` | mm; inclusive stated upper end | I.1 item a; p.61; PDF 67 | below / equal / above; equal-length evidence and operator review | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-SUBDIVISION-COUNT-FORMULA` | `N = L0 / d` | integer count; compatible lengths; exact partition required | I.1 item a and Figure-I.1 key; pp.61-62; PDFs 67-68 | integer/noninteger quotient; sum equals `L0`; wrong length identity; unit conversion | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-EVEN-BRANCH-PREDICATE` | `(N - n) mod 2 = 0` | integer parity predicate | I.2 item a; p.61; PDF 67 | even / odd / negative / noninteger; exactly one branch | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-ODD-BRANCH-PREDICATE` | `(N - n) mod 2 = 1` | nonnegative integer parity predicate | I.2 item b; p.61; PDF 67 | odd / even / negative / noninteger; exactly one branch | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-EVEN-Z-OFFSET-FORMULA` | `offset_Z = (N - n) / 2` | subdivision intervals beyond Y; integer output | I.2 item a; p.61; PDF 67 | analytical even cases; off-by-one; direction and mark identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-I1-ELONGATION-FORMULA` | `A = ((lXY + 2*lYZ - L0) / L0) * 100` | compatible lengths; output percent | Formula I.1; p.61; PDF 67 | analytical values; grouping/factor; `L0 > 0`; even-route and mark provenance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-ODD-Z-PRIME-OFFSET-FORMULA` | `offset_Z_prime = (N - n - 1) / 2` | subdivision intervals beyond Y; integer output | I.2 item b; p.61; PDF 67 | analytical odd cases; lower offset; off-by-one and direction | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-ODD-Z-DOUBLE-PRIME-OFFSET-FORMULA` | `offset_Z_double_prime = (N - n + 1) / 2` | subdivision intervals beyond Y; integer output | I.2 item b; p.61; PDF 67 | analytical odd cases; upper offset; exactly one interval above lower mark | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AI-I2-ELONGATION-FORMULA` | `A = ((lXY + lYZ_prime + lYZ_double_prime - L0) / L0) * 100` | compatible lengths; output percent | Formula I.2; p.61; PDF 67 | analytical values; grouping; `L0 > 0`; odd-route and mark provenance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **10**.
- `N` and `n` are nonnegative integer counts with `0 <= n <= N`; a noninteger partition or offset blocks the Annex-I result.
- Even and odd routes are mutually exclusive and collectively exhaustive only after valid integer inputs; neither formula may be selected by rounding parity inputs.
- The 5 mm value is recommended and 10 mm is the stated upper end; this interpretation remains independently review-pending.
- Annex I remains informative and cannot independently convert an otherwise inapplicable fracture result into a conformity claim.
