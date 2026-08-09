---
project: Universal Testing Machine (UTS)
document: JTS_LEGACY_SOURCE_INTAKE
version: 0.1
status: CONTROLLED-EVIDENCE
classification: LEGACY-REFERENCE
received_date: 2026-08-09
---

# JTS legacy source intake

This directory preserves the supplied `jts.zip` and an LF-normalized searchable extraction of its Markdown files.

## Source identity

- Supplied filename: `jts.zip`
- SHA-256: `334e9341ba5be8980fce5c140b1d59a5be660bd1338d90f10aabc4da8c52f8ce`
- ZIP integrity: passed (`unzip -t`)
- Archive members: 87 regular Markdown files under `jts/`
- Architecture chapters: 82 (`Chapter 00.md` through `Chapter 81.md`)
- Total logical lines: 83,359
- Total extracted bytes: 1,013,987
- Executable files, symlinks and nested archives: none detected

The received date records intake into this repository. It is not evidence of when the source documents were authored.

## Authority boundary

Everything in `SOURCE/`, including statements marked `FROZEN`, is `LEGACY-EVIDENCE` only. The archive does not contain approvals, merge records or authoritative links proving that its `ARCH-*` or `EDR-*` identifiers were released in the current UTS repository.

Authority remains, in order:

1. the newest non-superseded EDR marked `FROZEN` on `main`;
2. current Frozen Golden Rules;
3. approved current architecture/domain specifications;
4. this controlled intake and its source files as evidence only.

No content here may overwrite a current EDR, enable a PLC write, define a physical hardware value, introduce a production schema migration, create an external API, or provide a normative standard formula without the applicable verification and governed decision.

## Directory contents

- `jts.zip` — unmodified supplied archive.
- `SOURCE/` — content-equivalent Markdown normalized from CRLF to LF for Git review, search and line-level traceability.
- `SOURCE_MANIFEST.tsv` — archive/source sizes and SHA-256 values plus logical line counts for every extracted file.
- `REVIEW_AND_MIGRATION.md` — conflict findings, duplicate topic map and controlled dispositions.
- `validate_jts_intake.py` — deterministic integrity and authority-boundary validator.

The governing migration status is also recorded in the root `LEGACY_DECISION_MIGRATION_REGISTER.md`.
