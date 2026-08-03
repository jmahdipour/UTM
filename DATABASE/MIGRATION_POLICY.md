# SQLite Migration Policy

Status: Frozen under EDR-0007  
Version: 1.0  
Date: 2026-08-02

## Naming and ledger

Migration filenames use `NNNN_description.sql`. The numeric prefix is permanent and strictly increasing. `schema_migration` stores the ID, name, SHA-256 of the exact UTF-8 bytes, application build, actor/service identity and UTC application time.

Released migration files are immutable. A defect is corrected by the next migration, never by editing deployed history.

`PRAGMA user_version` mirrors the highest numeric migration for diagnostics only. The table ledger and checksums are authoritative.

## Startup compatibility

The application refuses normal startup when:

- the database contains a migration unknown to the application;
- a stored checksum differs from the packaged migration;
- a partially completed maintenance marker exists;
- `foreign_key_check` or `integrity_check` fails;
- the SQLite provider/engine is below the minimum validated version;
- required schema objects are missing.

Failure opens Diagnostics/Recovery only. The application must not attempt a best-effort run.

## Pre-migration gate

1. prevent new Run preparation/arming;
2. prove no Run is Armed, Running, Paused or Stopping;
3. stop the writer and drain/finalize accepted acquisition buffers;
4. acquire the exclusive application maintenance lock;
5. record current application, provider and schema versions;
6. execute `PRAGMA wal_checkpoint(FULL)` and confirm completion;
7. create the database + artifact backup set and manifest;
8. restore that backup to a temporary validation location;
9. run integrity, foreign-key and hash checks on the restored copy;
10. only then begin migration.

An unverified backup blocks migration.

## Migration transaction

The migrator enables `foreign_keys`, uses an immediate/exclusive transaction appropriate to the packaged migration and applies one migration at a time.

For each migration:

1. verify its packaged SHA-256;
2. verify it has not already been applied with a different hash;
3. execute the SQL;
4. insert the ledger row in the same transaction;
5. set `user_version`;
6. run migration-specific invariant queries;
7. commit;
8. reopen connections and run global post-checks.

SQLite operations that cannot share the main transaction must be isolated in a documented maintenance step with explicit resume/recovery markers and tests.

## Expand–migrate–contract

Schema evolution follows three releases when compatibility or data transformation is material:

- **Expand:** add nullable/new structures and dual-read support.
- **Migrate:** backfill in bounded batches, record progress and verify counts/hashes.
- **Contract:** stop using the old structure; remove it only when retention and restore policy permit.

Released evidence columns/tables are not contracted merely because the current UI no longer displays them.

## Failure and recovery

- Before commit: roll back, retain diagnostics and keep the pre-migration database untouched.
- After commit but before verification: mark maintenance failure, stop normal startup and restore the verified backup or deploy a reviewed forward-fix.
- No automatic in-place downgrade is supported.
- Recovery records actor, reason, source/target schema versions, backup manifest and verification outcome in audit history.

## Post-migration gate

Required checks:

- `PRAGMA quick_check` during routine startup and `integrity_check` for migration/restore validation;
- `PRAGMA foreign_key_check` returns no row;
- ledger IDs/checksums match the packaged manifest;
- expected tables, indexes and triggers exist;
- invariant acceptance SQL passes;
- representative run/replay/report read paths succeed;
- artifact references resolve and hashes match;
- application build and schema version are recorded in Diagnostics.

## Backup/restore validation cadence

Every released application version must pass automated migration tests from:

- empty database;
- previous supported production schema;
- a representative large database;
- interrupted/fault-injected migration checkpoints;
- restored database + artifact backup set.

Production restore drills and retention periods remain subject to the later reporting/release and quality-system decisions.
