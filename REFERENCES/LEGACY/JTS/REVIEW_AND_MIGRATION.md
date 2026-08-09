---
project: Universal Testing Machine (UTS)
document: JTS_REVIEW_AND_MIGRATION
version: 0.1
status: CONTROLLED
classification: ENGINEERING-REVIEW
review_date: 2026-08-09
source_sha256: 334e9341ba5be8980fce5c140b1d59a5be660bd1338d90f10aabc4da8c52f8ce
---

# JTS review and migration

## Review conclusion

The archive is a useful requirements-discovery source, but it is not a release-ready architecture baseline. Directly merging its top-level documents or its claimed Frozen decisions into the current repository would regress already-governed UTS decisions.

The controlled disposition is therefore:

| Content | Disposition | Reason |
|---|---|---|
| Original ZIP | `REFERENCE-ONLY` | Preserve exact provenance and source identity. |
| Extracted Markdown | `REFERENCE-ONLY` | Enable Git search and line-level traceability without granting authority. |
| Current `README`, AI Handover, Changelog and Roadmap | `SUPERSEDED` in JTS | JTS copies are documentation v0.1 and omit EDR-0001 through EDR-0009. |
| Statements compatible with current EDRs | `MIGRATED-ALREADY` | Retain as corroborating evidence; do not duplicate governing text. |
| New reporting, security, audit, maintenance, standards and release ideas | `CANDIDATE-EDR` | Require dedicated scope, sources, traceability and acceptance tests. |
| Numeric examples, controller/device names and performance values | `REFERENCE-ONLY` / `UNVERIFIED` | No physical-machine or benchmark evidence accompanies the values. |
| Claimed EDRs and permanent Frozen decisions inside JTS | `NON-AUTHORITATIVE` | No matching released records exist in current `UTM/main`. |

No EDR is created or Frozen by this intake.

## Verified facts about the archive

1. The archive contains 87 Markdown files and no executable code.
2. It contains 82 numbered architecture chapters, `ARCH-000` through `ARCH-081`.
3. All 82 chapters declare their own status as `FROZEN`.
4. The chapters cite 82 legacy EDR identifiers ranging up to `EDR-086`; these are not the current repository's released `EDR-0001` through `EDR-0009` series.
5. The content is internally repetitive: later chapters restate and expand subjects already covered by earlier chapters.
6. The original ZIP is preserved byte-for-byte; the searchable extraction is content-equivalent after deterministic CRLF-to-LF normalization, as enforced by `validate_jts_intake.py`.

## Direct conflicts and superseded claims

| ID | JTS evidence | Problem | Governing current source | Disposition |
|---|---|---|---|---|
| JTS-SUP-001 | `SOURCE/README.md` and `SOURCE/AI_HANDOVER_SPECIFICATION.md` identify Documentation v0.1 and list Event Dictionary, State Machine, physical database, UI, PLC and API as pending. | These items were subsequently governed through EDR-0001 to EDR-0009. Replacing current files would remove released history. | `FROZEN_DECISIONS.md`, current AI Handover and Changelog | `SUPERSEDED` |
| JTS-SUP-002 | `SOURCE/00.md` and the archived AI Handover require every downstream engine to consume Events and prohibit calculation directly from raw measurements. | The wording collapses continuous numerical streams and semantic events. | EDR-0001 amends GR-013: validated/derived streams and domain events are separate, connected flows. | `SUPERSEDED` |
| JTS-SUP-003 | `SOURCE/Chapter 42.md:58-76, 684-714` declares `Customer -> Project -> Order -> Specimen -> Test` permanent. | It reverses the business root and contradicts another file in the same archive (`Chapter 01.md:46-103`). | GR-001: Order is the highest business object; Customer information belongs to Order. | `SUPERSEDED` |
| JTS-SUP-004 | `SOURCE/Chapter 71.md`, `Chapter 80.md` and `Chapter 81.md:2093-2119` declare SQLite Schema v1.1 permanent and authoritative. | The detailed JTS SQL contains 29 tables, 21 indexes and 7 triggers and models Customer/Project ownership differently. | EDR-0007 and `DATABASE/Migrations/0001_initial.sql`: governed migration 0001 has 51 tables, 19 explicit indexes and 68 protective triggers. | `SUPERSEDED`; never execute as a migration |
| JTS-SUP-005 | All 82 chapters claim `FROZEN` and cite legacy `EDR-*` numbers. | A source-local label is not proof of approval or integration into current `main`. | `DOCUMENTATION_GOVERNANCE.md` decision lifecycle and `FROZEN_DECISIONS.md` | `NON-AUTHORITATIVE` |
| JTS-SUP-006 | Chapters 22 and 44 list REST/API/cloud integrations as extension targets. | A public listener is not part of the v1 application boundary. | EDR-0008 prohibits v1 public HTTP/REST/gRPC/socket/scripting listeners absent a separate security and safety EDR. | `FUTURE-CANDIDATE`; prohibited in v1 |

## Compatible material already governed

The following recurring JTS themes agree at a high level with current decisions and therefore need no duplicate merge:

| Theme | Representative JTS chapters | Current authority |
|---|---|---|
| VB.NET, .NET Framework 4.8, WPF/MVVM, SQLite, x86 | 00, 60, 70, 71, 80, 81 | AI Handover §3 |
| UI/Application isolation from PLC and SQLite | 10, 27, 46, 53, 62, 64, 70, 78 | EDR-0006, EDR-0008, EDR-0009 |
| Immutable raw data and derived/re-analysis lineage | 34, 54, 66, 67, 74, 79 | EDR-0001 and EDR-0007 |
| Logical channels, physical sensors and calibration snapshots | 4, 33, 36, 49, 66, 75, 76 | EDR-0005 |
| Canonical force in N with source-unit provenance such as kgf | 13, 36, 71, 74, 75 | EDR-0007 |
| Separate machine/test states and guarded motion commands | 7, 29, 35, 53, 65, 69, 73, 78 | EDR-0003, EDR-0004, EDR-0008, EDR-0009 |
| Immutable/versioned Test Method and run snapshots | 2, 16, 52, 53, 68, 77 | EDR-0002 and EDR-0007 |
| Safety remains fail-closed and independent of normal WPF operation | 35, 50, 53, 65, 69, 73, 78 | EDR-0004 and EDR-0009 |

These matches are conceptual corroboration only. Detailed wording, identifiers and contracts in current EDRs govern implementation.

## Duplicate topic clusters inside JTS

| Topic | Overlapping chapters |
|---|---|
| Business/order/specimen | 1, 17, 28, 42 |
| Test Method and standards | 2, 16, 52, 57, 68, 77 |
| Material and acceptance | 3, 8, 18-21, 40, 51, 57 |
| Measurement/acquisition/data pipeline | 4, 12, 13, 34, 36, 54, 66, 67, 74, 75, 79 |
| Analysis/events/mechanical properties | 5, 6, 14, 39, 56, 77 |
| State, runtime and motion control | 7, 29, 35, 53, 65, 69, 73, 78 |
| Graph, live display and UI | 10, 15, 37, 38, 55, 60, 61, 70 |
| Hardware, communication and HAL | 11, 35, 45, 46, 64, 69 |
| Database, repositories, migration and backup | 23-26, 43, 63, 71, 80, 81 |
| Services/workflow/event bus | 27, 28, 30, 62, 72 |
| Logging, diagnostics, audit and security | 31, 32, 48, 58, 59 |
| Calibration | 33, 49, 75, 76 |
| Reporting | 9, 41 |
| Plugins/extensions | 22, 44 |

This duplication is why the chapters should not be copied into the current `ARCHITECTURE/` directory as parallel authoritative specifications.

## New candidate work extracted from JTS

| Candidate | Evidence | Required controlled resolution |
|---|---|---|
| JTS-CEDR-001 Reporting, report versioning and release validation | Chapters 9 and 41 | Fold into the already-open reporting/validation/release EDR; define sources, immutable report snapshots, signatures, templates, exports and acceptance tests. |
| JTS-CEDR-002 Audit trail and electronic signatures | Chapters 31, 58 and 59 | Define regulated scope, identity assurance, signature meaning, audit retention and threat model; do not claim ISO/IEC 17025 conformity from architecture text alone. |
| JTS-CEDR-003 Standards library governance | Chapters 52, 57, 68 and 77 | Bind each algorithm/requirement to a controlled purchased standard revision and verification evidence. |
| JTS-CEDR-004 Machine verification and preventive maintenance | Chapter 50 | Define equipment-specific schedules, lock policy, permissions and commissioning evidence. |
| JTS-CEDR-005 Graph/curve analysis contract | Chapters 15, 37, 38 and 55 | Define raw-versus-display datasets, decimation, markers, corrections, re-analysis and export traceability. |
| JTS-CEDR-006 Plugin and external integration boundary | Chapters 22 and 44 | Keep outside v1 unless a security/safety EDR defines trust, signing, permissions, isolation and remote-motion prohibitions. |
| JTS-CEDR-007 Acquisition performance profile | Chapters 34, 66, 74 and 79 | Treat example sampling/UI rates, queue sizes, timeouts and batch sizes as unverified until code benchmarks and physical DAQ/PLC evidence exist. |

## Hardware and numeric evidence boundary

References to Fatek, Facon, `VS20NL-P1`, PLC/drive addresses, controller channels, example sensor identifiers, sampling rates, UI refresh rates, queue sizes, retry counts and timeouts remain `UNVERIFIED`.

They do not amend `DRIVER/HARDWARE_MAP.md`, do not remove `WRITE-DISABLED`, and do not change the physical adapter's `BLOCKED-HARDWARE` state. No physical motion is authorized by this intake.

## Database boundary

The SQL-like content in Chapter 81 was reviewed as legacy design evidence only. It must not be extracted into `DATABASE/Migrations/`, executed against a UTS database or used to downgrade schema version 1. The current migration and its acceptance tests remain the only governed physical baseline.

Potential concepts not already represented in the current schema must first receive a requirement ID, authority/source citation, proposed mapping, migration design and acceptance test.

## Next use

Use this archive as an input when drafting the next official reporting, validation and release architecture. Every adopted requirement must be moved into the normal EDR/RTM/acceptance workflow; citing a JTS chapter alone is insufficient for `PASS-DOC` or implementation approval.
