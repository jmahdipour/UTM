---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_K_ATOMIC_RTM
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-17
---

# ISO 6892-1:2019 Annex K Atomic RTM

## Control statement

Paraphrases informative Annex K, Formulas K.1-K.4 and Tables K.1-K.4 while separating uncertainty, material scatter and examples.

`EXTRACTED / REVIEW-PENDING` identifies routed design evidence only; it is not independent approval, executable validation, implementation or conformity evidence.

## K.1-K.4 - complete uncertainty workflow

| Source item | Locator | Class | Controlled paraphrase | SCI / SAT | Atomic acceptance | Parameter | Status |
|---|---|---|---|---|---|---|---|
| `ISO19-AK-001` | Annex K status/title; p.64; PDF 70 | Authority | Keep Annex K informative uncertainty guidance. | `SCI-001`; `SAT-001` | `IAT-AK-SCOPE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-002` | K.1; p.64; PDF 70 | Purpose | Estimate uncertainty for results determined under the ISO profile. | `SCI-036`; `SAT-036` | `IAT-AK-SCOPE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-003` | K.1; p.64; PDF 70 | Limitation | Reject a universal absolute uncertainty because material-independent and material-dependent parts coexist. | `SCI-036`; `SAT-036` | `IAT-AK-SCOPE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-004` | K.1; p.64; PDF 70 | Dependency | Revision-control the uncertainty-budget references. | `SCI-002`; `SAT-002` | `IAT-AK-SCOPE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-005` | K.1; p.64; PDF 70 | Material boundary | Separate method/measurement scatter from material inhomogeneity. | `SCI-036`; `SAT-036` | `IAT-AK-SCOPE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-006` | K.1; p.64; PDF 70 | Interval | Interpret cited reproducibility as symmetric plus/minus half-width. | `SCI-036`; `SAT-036` | `IAT-AK-SCOPE` | `IP-AK-RPR-INTERVAL` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-007` | K.2.1; p.64; PDF 70 | Routing | Classify each component as Type A or Type B by evidence origin. | `SCI-036`; `SAT-036` | `IAT-AK-TYPE-ROUTING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-008` | K.2.2; p.64; PDF 70 | Type A | Use repeated-measurement evidence for Type A. | `SCI-036`; `SAT-036` | `IAT-AK-K1` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-009` | Formula K.1; p.64; PDF 70 | Formula | Compute `u=s/sqrt(n)` with sample-deviation and averaging-count provenance. | `SCI-005`; `SAT-005` | `IAT-AK-K1` | `IP-AK-K1` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-010` | K.2.3; p.64; PDF 70 | Type B | Use certificates, tolerances or other qualified sources for Type B. | `SCI-036`; `SAT-036` | `IAT-AK-K2` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-011` | K.2.3; p.64; PDF 70 | Distribution | Use rectangular distribution only with equal-likelihood justification. | `SCI-036`; `SAT-036` | `IAT-AK-K2` | `IP-AK-RECTANGULAR` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-012` | Formula K.2; p.64; PDF 70 | Formula | Compute `u=a/sqrt(3)` where `a` is interval half-width. | `SCI-005`; `SAT-005` | `IAT-AK-K2` | `IP-AK-K2` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-013` | K.2 continuation; p.65; PDF 71 | Combination | Include every measured-input contribution used by the output. | `SCI-036`; `SAT-036` | `IAT-AK-K3` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-014` | Formula K.3; p.65; PDF 71 | Formula | Combine independent components by root-sum-square. | `SCI-005`; `SAT-005` | `IAT-AK-K3` | `IP-AK-K3` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-015` | K.2-K.3; pp.65-66; PDFs 71-72 | Units | Combine only compatible absolute units or consistently relative components. | `SCI-006`; `SAT-006` | `IAT-AK-K3` | `IP-AK-UNITS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-016` | Table K.1; p.65; PDF 71 | Matrix | Preserve Force relevance for ReH/ReL/Rm/Rp and all not-relevant cells. | `SCI-036`; `SAT-036` | `IAT-AK-MATRIX` | `IP-AK-MATRIX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-017` | Table K.1; p.65; PDF 71 | Matrix | Preserve Extension relevance for Rp/A and all not-relevant cells. | `SCI-036`; `SAT-036` | `IAT-AK-MATRIX` | `IP-AK-MATRIX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-018` | Table K.1; p.65; PDF 71 | Matrix | Preserve Gauge length relevance for Rp/A and all not-relevant cells. | `SCI-036`; `SAT-036` | `IAT-AK-MATRIX` | `IP-AK-MATRIX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-019` | Table K.1; p.65; PDF 71 | Matrix | Preserve S0 relevance for ReH/ReL/Rm/Rp/Z and all not-relevant cells. | `SCI-036`; `SAT-036` | `IAT-AK-MATRIX` | `IP-AK-MATRIX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-020` | Table K.1; p.65; PDF 71 | Matrix | Preserve Su relevance for Z and all not-relevant cells. | `SCI-036`; `SAT-036` | `IAT-AK-MATRIX` | `IP-AK-MATRIX` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-021` | K.3; p.65; PDF 71 | Certificate | Use actual current certificate uncertainty rather than nominal class alone. | `SCI-010`; `SAT-010` | `IAT-AK-CERTIFICATE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-022` | K.3; p.65; PDF 71 | Class limitation | Do not equate Class 1.0 with one-percent standard uncertainty. | `SCI-010`; `SAT-010` | `IAT-AK-CERTIFICATE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-023` | K.3; p.65; PDF 71 | Drift/environment | Include justified drift and environmental contributions. | `SCI-011`; `SAT-011` | `IAT-AK-CERTIFICATE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-024` | K.3 example; p.65; PDF 71 | Example | Keep the 1.4-percent/one-percent worked inputs as information-only. | `SCI-036`; `SAT-036` | `IAT-AK-EXAMPLES` | `IP-AK-EXAMPLES` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-025` | K.3 example; p.65; PDF 71 | Example | Keep the worked 0.91-percent combination as information-only. | `SCI-036`; `SAT-036` | `IAT-AK-EXAMPLES` | `IP-AK-EXAMPLES` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-026` | K.3 Rp; pp.65-66; PDFs 71-72 | Curve sensitivity | Estimate Rp contribution from the actual force-extension curve and elastic slope. | `SCI-020`; `SAT-020` | `IAT-AK-RP` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-027` | Tables K.2-K.4; p.66; PDF 72 | Example tables | Keep every cell information-only and property-specific. | `SCI-036`; `SAT-036` | `IAT-AK-EXAMPLES` | `IP-AK-EXAMPLE-TABLES` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-028` | Formula K.4; p.66; PDF 72 | Formula | Combine S0/Su relative contributions for Z by RSS. | `SCI-005`; `SAT-005` | `IAT-AK-K4` | `IP-AK-K4` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-029` | K.3 coverage; p.66; PDF 72 | Expanded uncertainty | Compute `U=k*u_c` with declared coverage basis; keep k=2 as example. | `SCI-036`; `SAT-036` | `IAT-AK-EXPANDED` | `IP-AK-EXPANDED` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-030` | K.3 final; p.66; PDF 72 | Monitoring | Keep scheduled reference-sample charting as a recommendation. | `SCI-036`; `SAT-036` | `IAT-AK-MONITORING` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-031` | K.4 factor list; p.67; PDF 73 | Factor | Retain temperature as a candidate material/procedure-dependent influence. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | `IP-AK-FACTORS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-032` | K.4 factor list; p.67; PDF 73 | Factor | Retain testing rate as a candidate material/procedure-dependent influence. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | `IP-AK-FACTORS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-033` | K.4 factor list; p.67; PDF 73 | Factor | Retain geometry/machining as a candidate material/procedure-dependent influence. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | `IP-AK-FACTORS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-034` | K.4 factor list; p.67; PDF 73 | Factor | Retain gripping/axiality as a candidate material/procedure-dependent influence. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | `IP-AK-FACTORS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-035` | K.4 factor list; p.67; PDF 73 | Factor | Retain machine stiffness/drive/control as a candidate material/procedure-dependent influence. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | `IP-AK-FACTORS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-036` | K.4 factor list; p.67; PDF 73 | Factor | Retain human/software error as a candidate material/procedure-dependent influence. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | `IP-AK-FACTORS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-037` | K.4 factor list; p.67; PDF 73 | Factor | Retain extensometer mounting as a candidate material/procedure-dependent influence. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | `IP-AK-FACTORS` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-038` | K.4; p.67; PDF 73 | Source inventory | Identify all additional direct/indirect significant sources for each result. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-039` | K.4; p.67; PDF 73 | Distribution | Justify each source distribution and convert it to one-sigma standard uncertainty. | `SCI-036`; `SAT-036` | `IAT-AK-FACTORS` | `IP-AK-DISTRIBUTION` | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-040` | K.4; p.67; PDF 73 | Interlaboratory limitation | Do not treat overall interlaboratory scatter as separated material/method effects. | `SCI-045`; `SAT-045` | `IAT-AK-EVIDENCE` | - | EXTRACTED / REVIEW-PENDING |
| `ISO19-AK-041` | K.4; p.67; PDF 73 | Reference evidence | Admit CRM, controlled in-house material or intercomparison only with suitability/provenance. | `SCI-036`; `SAT-036` | `IAT-AK-EVIDENCE` | - | EXTRACTED / REVIEW-PENDING |

## Package count and evidence boundary

- Atomic source items: **41**.
- Parameter/formula records: **13**.
- Atomic acceptance variants: **14**.
- Authority boundary: Annex K is informative; examples and named materials are not universal values or limits.
- Excluded from this package: external GUM/CWA/CRM requirements, Annex L and ASTM E8/E8M-15a
