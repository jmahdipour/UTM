# Database Requirements Traceability Matrix

Baseline checked: GitHub `main` merge commit `73ddafb64a0d4b95401d1ae867ca3bed273a2c85`  
Design package: EDR-0007 Frozen  
Validation date: 2026-08-02

No row may have a blank status. `SQL-PASS` means the initial migration compiled in SQLite, `foreign_key_check` returned no row, `integrity_check` returned `ok`, and the listed SQL acceptance test passed. It does not mean the future VB.NET repository/integration test is complete.

| Requirement | Governing source (document:lines) | Physical implementation | Acceptance evidence | Status |
|---|---|---|---|---|
| DBR-001 SQLite is the installation system of record | EDR-0007:28-32 | migration-ledger plus 51-table schema | DBAT-001/002 | SQL-PASS; EDR FROZEN |
| DBR-002 Historical evidence is append-only and correction creates a revision | EDR-0007:30-32, 51-68 | immutable/revision tables and 68 triggers | DBAT-003 | SQL-PASS; VB integration pending |
| DBR-003 Order is the business root and customer/specimen belong to Order | EDR-0007:36-40; AI_HANDOVER_SPECIFICATION.md:77-113 (GR-001) | `customer_order`, `order_customer`, `specimen` | FK check | SQL-PASS |
| DBR-004 Method, Material and Acceptance remain separately versioned | EDR-0007:38-46, 51-68 | separate aggregate/revision tables | FK check/schema inspection | SQL-PASS |
| DBR-005 A Run snapshots the exact released configuration before arming | EDR-0007:70-81 | `run_configuration_snapshot`, `run_channel_binding`, arm trigger | DBAT-009/010 | SQL-PASS; transition test pending |
| DBR-006 Re-Test creates a new Run; Re-Analyze creates linked analysis revision | EDR-0007:83 | `test_run`; `analysis_revision.parent_analysis_revision_id` | uniqueness/FK inspection | SQL-PASS; deterministic replay pending |
| DBR-007 Raw and derived series are stored as immutable versioned chunks | EDR-0007:85-97 | `stream_metadata`, `raw_sample_chunk`, `derived_series_chunk` | DBAT-003/007/008 | SQL-PASS; codec test pending |
| DBR-008 Sequence ranges are monotonic/non-overlapping and gaps explicit | EDR-0007:89-94 | overlap trigger; `sample_gap`; range checks | DBAT-007 | SQL-PASS; concurrency test pending |
| DBR-009 Graph decimation cannot become scientific input | EDR-0007:95 | no display-cache FK accepted by analysis tables | schema inspection | DESIGN-PASS; application test pending |
| DBR-010 Every physical value declares quantity and unit | EDR-0007:99-109 | typed quantity/unit columns and FKs | DBAT-005/006 | SQL-PASS |
| DBR-011 kgf source is preserved and normalized exactly to N | EDR-0007:111 | `unit_definition`, `import_record`, run binding source/canonical units | DBAT-005/014 | SQL-PASS; import fixture pending |
| DBR-012 Output-unit selection does not mutate canonical results | EDR-0007:103-113 | canonical units in bindings/properties; presentation revisions separate | schema inspection | DESIGN-PASS; application test pending |
| DBR-013 SQLite uses controlled single-writer/WAL operating profile | EDR-0007:115-121 | repository boundary; migration policy | architecture review | DESIGN-PASS; load/fault test pending |
| DBR-014 Migrations are ordered, checksummed, backed up and verified | EDR-0007:123-135 | `schema_migration`, `user_version`, Migration Policy | DBAT-001/004 | SQL-PASS; migrator implementation pending |
| DBR-015 In-place downgrade is prohibited; restore or forward-fix is used | EDR-0007:125-135 | Migration Policy failure/recovery section | document review | POLICY-PASS; recovery drill pending |
| DBR-016 Historical data cannot be cascade-deleted by ordinary workflows | EDR-0007:137-141 | `ON DELETE RESTRICT`, immutable triggers, retirement fields | FK/trigger inspection | SQL-PASS; purge policy open |
| DBR-017 UTC audit time and monotonic sample order are separate | EDR-0007:143-150 | UTC text plus sequence/monotonic integer columns | schema inspection | SQL-PASS; clock/restart test pending |
| DBR-018 Artifacts are relative, hashed and part of the backup set | EDR-0007:49 | `artifact`, hash/path checks, backup policy | DBAT-013 | SQL-PASS; backup tool pending |
| DBR-019 Terminal Runs require finalized raw persistence | EDR-0007:85-97 | terminal-run trigger and `raw_finalized` | DBAT-011 | SQL-PASS; buffer fault test pending |
| DBR-020 Audit/state/command/domain-event journals remain immutable | EDR-0007:28-32, 137-141 | append-only journal tables/triggers | DBAT-003 | SQL-PASS; application transaction test pending |

## Executed validation result

| Check | Result |
|---|---|
| Migration compiled from empty in-memory database | PASS |
| Tables created | PASS — 51 |
| Explicit indexes created | PASS — 19 |
| Triggers created | PASS — 68 |
| `PRAGMA foreign_key_check` | PASS — zero violations |
| `PRAGMA integrity_check` | PASS — `ok` |
| `PRAGMA user_version` | PASS — `1` |
| Controlled kgf scale | PASS — `9.80665` |
| DBAT-001 through DBAT-014 on empty baseline | PASS — 14/14 |
| Dynamic trigger/lineage fixture DBDT-001 through DBDT-010 | PASS — 10/10 |

## Open acceptance work

Every pending item already has a status and owner phase:

- VB.NET repository, migration-runner and transaction tests — Application/API contracts + Solution scaffold;
- binary chunk codec, deterministic replay and large-run/x86 streaming — Measurement/Analysis implementation;
- kgf device-file import fixture — Import/Analysis implementation using the supplied sample file;
- WAL fault injection, backup/restore and interrupted migration — Reporting/Validation/Release phase;
- physical purge/retention and security/encryption — later approved quality/security EDRs.
