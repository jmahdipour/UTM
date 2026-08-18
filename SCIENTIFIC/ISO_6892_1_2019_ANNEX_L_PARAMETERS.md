---
project: Universal Testing Machine (UTS)
document: ISO_6892_1_2019_ANNEX_L_PARAMETERS
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ISO-6892-1-2019
last_revision: 2026-08-17
---

# ISO 6892-1:2019 Annex L Profile Parameters

## Control rules

Every entry remains review-pending; units, operators, source identity and authority are part of the parameter.

| Parameter | Value / expression | Unit / operator | Locator | Acceptance boundary | Status |
|---|---|---|---|---|---|
| `IP-AL-RPR` | `Rpr=(2*s/mean)*100` | percent | Annex L; p.68; PDF 74 | mean nonzero; property identity; deviation provenance | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AL-CONFIDENCE` | `confidence=95` | percent; contextual | Annex L; p.68; PDF 74 | declared coverage basis; no arbitrary-k equivalence | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AL-DATASET` | `material|code|mean|Rpr|reference` | information-only schema | Tables L.1-L.4; PDFs 75-79 | 70 observations; exact table/property identity | EXTRACTED / INDEPENDENT-REVIEW-PENDING |
| `IP-AL-ABSOLUTE` | `half_width=mean*(Rpr/100)` | property unit | Tables L.3-L.4 footnotes; PDFs 78-79 | relative/absolute distinction; rounding | EXTRACTED / INDEPENDENT-REVIEW-PENDING |

## Register count and approval boundary

- Parameter/formula records: **4**.
- Annex L mixes material and measurement scatter; no value is a universal acceptance tolerance.
