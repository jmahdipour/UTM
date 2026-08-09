# Controlled References

This directory separates controlled scientific and standards sources from
legacy project evidence.

## Authority and use

- A controlled standard revision may define normative requirements only after
  clause-by-clause migration into the Requirements Traceability Matrix and
  approval through project governance.
- Engineering books support interpretation, algorithm design and independent
  verification. They are not conformity standards.
- Possession of a source PDF does not itself prove implementation or
  conformity.
- Licensed/copyrighted PDFs under `CONTROLLED/` are local working sources and
  are intentionally excluded from Git. Do not redistribute them without the
  rights holder's permission.
- `LEGACY/` remains engineering evidence only and cannot override a Frozen EDR.

## Source register

| ID | Controlled local path | Source identity | Role | Pages | SHA-256 | Status |
|---|---|---|---|---:|---|---|
| `REF-STD-ISO-6892-1-2019` | `CONTROLLED/STANDARDS/ISO_6892-1_2019.pdf` | ISO 6892-1:2019(E), third edition, November 2019 | Controlled normative source for the ISO profile after clause-level traceability | 86 | `9f53b6751810d9bc4aceef11ab7d9a1c610743a6d2b5fceeb43cf1f8372510e6` | Supplied; integrity and edition recorded |
| `REF-SCI-ASM-TENSILE-2004` | `CONTROLLED/SCIENTIFIC/ASM_Tensile_Testing_2nd_Ed_Davis_2004.pdf` | J. R. Davis (ed.), *Tensile Testing*, 2nd ed., ASM International, 2004 | Scientific and engineering reference; non-normative | 283 | `b512153ba95792823476faada11a6ff12aa0c3639b44d84c6d445f7d55f5d05c` | Supplied; integrity recorded |
| `REF-STD-ASTM-E8-E8M-15A` | `CONTROLLED/STANDARDS/ASTM_E8_E8M-15a.pdf` | ASTM E8/E8M-15a | Controlled standard revision; normative only for methods explicitly pinned to this revision | 29 | `2a50ff1e6627f842fe4b9b0e309dde23f8476ae1aabc08055f2e13524a3174a8` | Supplied; integrity recorded; historical revision |

## Version warning

The supplied ISO file is the English third edition `ISO 6892-1:2019(E)`. It is
the pinned source for `ISO6892_1_2019AnalysisProfile`; another edition cannot
silently replace it.

The supplied ASTM file is revision `E8/E8M-15a`. It must not be labelled or
used as `E8/E8M-25`. A test method must pin its exact governing revision, and
differences between revisions must be reviewed before reusing requirements,
formulas, tolerances, specimen rules or reporting rules.

## Integrity verification

Run from the repository root:

```bash
sha256sum \
  REFERENCES/CONTROLLED/STANDARDS/ISO_6892-1_2019.pdf \
  REFERENCES/CONTROLLED/SCIENTIFIC/ASM_Tensile_Testing_2nd_Ed_Davis_2004.pdf \
  REFERENCES/CONTROLLED/STANDARDS/ASTM_E8_E8M-15a.pdf
```

The calculated hashes must exactly match the source register above.
