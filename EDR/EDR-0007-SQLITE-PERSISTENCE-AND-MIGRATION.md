---
project: Universal Testing Machine (UTS)
document: EDR-0007
title: SQLite Persistence, Units and Migration Policy
version: 1.0
status: FROZEN
decision_date: 2026-08-02
classification: DATA-ARCHITECTURE
supersedes: none
related:
  - GR-001
  - GR-002
  - GR-003
  - GR-004
  - GR-006
  - EDR-0001
  - EDR-0002
  - EDR-0003
  - EDR-0004
  - EDR-0005
  - EDR-0006
---

# EDR-0007 — SQLite Persistence, Units and Migration Policy

## Decision

UTS uses one versioned SQLite database per installation as the transactional system of record. The database stores business records, immutable configuration revisions, run snapshots, measurement-chunk metadata and payloads, analysis lineage, events, results, acceptance, audit and configuration history.

Released or historical evidence is append-only. A correction, override, re-analysis or configuration change creates a new revision linked to its predecessor; it never overwrites the prior record.

The initial schema is defined by `DATABASE/Migrations/0001_initial.sql`. `DATABASE/REQUIREMENTS_TRACEABILITY.md` maps every persistence requirement to its governing source, SQL object and acceptance test.

## Database boundaries

SQLite owns:

- Order-rooted business records and specimen revisions;
- versioned Test Methods, execution phases/segments and immutable release snapshots;
- versioned Materials, Acceptance Profiles, Analysis Recipes and presentation/output profiles;
- machines, logical channels, sensors, installations and immutable calibration/correction revisions;
- Runs and exact configuration/measurement snapshots;
- chunked immutable raw and derived measurement series;
- state/command journals and immutable domain events;
- analysis revisions, detected events, calculated properties and acceptance evaluations;
- report metadata, audit records, configuration revisions and import provenance;
- ordered migration history with checksums.

Large report files, certificates and source attachments may be stored in a managed content-addressed artifact directory. SQLite stores their immutable identity, relative location, media type, byte length and SHA-256. Backup/restore must treat the database and artifact directory as one set. Absolute paths are prohibited.

## Aggregate and revision policy

Stable identities and revisions are separate:

| Stable aggregate | Immutable revision/evidence |
|---|---|
| Test Method | `test_method_revision`, phases, segments and requirements |
| Specimen | `specimen_revision` |
| Material | `material_revision` |
| Acceptance Profile | `acceptance_profile_revision` and rules |
| Analysis Recipe | `analysis_recipe_revision` |
| Sensor | `calibration_revision`, calibration points and certificates |
| Machine/configuration key | `configuration_revision` |
| Run | `run_configuration_snapshot`, bindings and correction selections |
| Raw acquisition | `raw_sample_chunk` |
| Analysis | `analysis_revision`, derived chunks, events and properties |

Draft revisions may be replaced through the application repository only while their lifecycle is Draft. Released/Approved/Active revisions are immutable. Database triggers provide a last-resort guard; application validation remains mandatory.

## Run and re-analysis lineage

A production run cannot enter `Armed` until exactly one complete `run_configuration_snapshot` is persisted and hashed. The snapshot resolves:

- released Test Method revision;
- specimen revision and actual geometry;
- optional Material and Acceptance revisions;
- Analysis Recipe, Chart Profile and Report Template revisions;
- machine, operator context and software build;
- every required logical channel binding;
- physical sensor installation, calibration, zero/tare and compliance correction revisions;
- source and canonical units.

`Re-Test` creates a new `test_run` and new raw chunks. `Re-Analyze` creates a new `analysis_revision` for the existing run, with `parent_analysis_revision_id`, deterministic input hash and pipeline/build identity. Neither operation overwrites the original run, samples, events, properties or acceptance result.

## Measurement storage

High-rate data is persisted in bounded chunks, not one SQL row per sample. Each chunk records codec/schema version, channel layout, sequence range, count, time range, quality summary, payload length and SHA-256.

Rules:

1. sequence ranges within a run must be monotonic and non-overlapping;
2. missing ranges are explicit quality evidence and domain events;
3. the chunk payload is immutable after insert;
4. raw and derived chunks use separate tables and namespaces;
5. display-decimated graph points are caches only and are never analytical inputs;
6. the binary codec is versioned and contract-tested before release;
7. x86 memory safety requires bounded read/write buffers and streaming chunk access.

## Units and kgf import

Every physical quantity stores a quantity kind and unit code. Unitless values are invalid except for declared dimensionless quantities.

UTS separates three concepts:

- **source unit** — the unit declared by hardware or an imported file;
- **canonical analysis unit** — the normalized unit used by the scientific pipeline;
- **display/export unit** — the user-selected output presentation.

Initial canonical units are N for force, mm for length/displacement, s for time, MPa for stress and dimensionless ratio for strain. Output profiles may display/export other compatible units without altering persisted canonical values.

Legacy/device files whose force column is `kgf` are imported with an explicit import profile. The original file bytes and SHA-256 are preserved, `kgf` remains the source unit, and normalization uses the conventional exact relationship `1 kgf = 9.80665 N`. The import is rejected if the source unit is unknown or incompatible; no heuristic unit guessing is permitted.

Conversion definitions are versioned reference data. A run/import snapshot records the conversion revision used. Changing an output unit never creates a new scientific result; changing a source-unit interpretation requires a new import/analysis lineage.

## SQLite operating profile

Every connection enables foreign keys. The production writer uses WAL mode, `synchronous=FULL` and a bounded busy timeout. One application persistence service owns writes; acquisition, UI and reports do not open competing ad-hoc writers.

Acquisition writes batches through a bounded queue and short transactions. Slow UI/report reads cannot block acquisition indefinitely. Buffer overflow or persistence failure becomes explicit run-quality/fault evidence.

The application pins and records the SQLite engine/provider version. Optional SQLite extensions are disabled unless separately reviewed. Schema behavior must not depend on JSON1 or another optional extension.

## Migration policy

- `schema_migration` is the authoritative ledger; `PRAGMA user_version` mirrors the highest applied numeric migration.
- Migration IDs are monotonic, zero-padded and immutable after release.
- Every migration records SHA-256, application build, UTC time and actor/service identity.
- Startup refuses a database newer than the application or a checksum mismatch.
- Migration runs only after an exclusive maintenance lock, successful WAL checkpoint and verified backup.
- Each migration is transactional unless SQLite itself requires an explicitly documented boundary.
- Post-migration checks include `foreign_key_check`, `integrity_check`, expected schema objects and domain invariants.
- In-place downgrade is unsupported. Recovery uses the verified pre-migration backup or an approved forward-fix migration.
- Destructive contraction is a later migration after an expand/migrate/verify period; released evidence is never dropped merely to simplify a schema.

The full operational procedure is `DATABASE/MIGRATION_POLICY.md`.

## Deletion and retention

Historical Runs, snapshots, raw chunks, released methods, approved calibrations, analysis results, acceptance evaluations, reports and audit records use `ON DELETE RESTRICT` and append-only guards. Business/UI deletion is retirement or tombstoning with reason and actor.

Physical purge requires a separately approved retention policy, verified export/archive, audit record and maintenance tool. No ordinary UI workflow executes cascading evidence deletion.

## Timestamps, identifiers and hashes

- persistent identities are lowercase canonical GUID strings generated by the application;
- audit timestamps are UTC ISO-8601 text with fractional seconds;
- run sample ordering uses integer sequence and monotonic elapsed nanoseconds/ticks, never UTC alone;
- money-free engineering numerics use SQLite `REAL` plus declared quantity/unit and validation constraints;
- SHA-256 values are lowercase 64-character hexadecimal text;
- canonical snapshots are UTF-8 text or versioned binary payloads with explicit schema and content hash.

## Security and integrity boundary

SQLite file encryption and user authentication mechanism are not silently assumed. Operating-system access control, credential handling, signing and optional database encryption require separate security decisions. The base schema still provides least-privilege application repositories, audit identity fields, immutable evidence and tamper-evident hashes.

A hash detects accidental or evident alteration; it is not a digital signature. Compliance claims require a later validation/security package.

## Consequences

### Positive

- deterministic replay and ISO/IEC 17025-oriented traceability have physical persistence support;
- kgf device data and selectable output units are explicit and auditable;
- immutable history survives Material, Acceptance, calibration and formula changes;
- chunked series avoid row-per-sample overhead and reduce x86 memory pressure;
- schema evolution is repeatable, checksummed and recoverable;
- UI, analysis and hardware remain separated by repository/application contracts.

### Costs

- revision tables and snapshots duplicate some descriptive data intentionally;
- the binary chunk codec and backup pair require dedicated validation;
- arbitrary SQL writes and direct ViewModel database access are prohibited;
- schema changes require migration and traceability maintenance.

## Rejected alternatives

1. **One mutable result row per specimen** — destroys replay, overrides and historical traceability.
2. **One SQL row per high-rate sample** — creates excessive index/page overhead for long tests on x86.
3. **Only store processed/display data** — violates immutable raw-data and graph-decimation rules.
4. **Store units only in UI settings** — makes imported kgf data ambiguous and non-reproducible.
5. **Auto-detect units from numeric magnitude** — unsafe and not auditable.
6. **Edit old migrations** — makes deployed database history unverifiable.
7. **Automatic downgrade SQL** — risks silent evidence loss; restore/forward-fix is safer and auditable.
8. **Database cascades for historical cleanup** — can erase legally/technically relevant evidence.

## Verification requirements

Before this decision becomes implemented, automated tests must prove:

- migration from an empty file produces the expected schema and ledger;
- replaying an applied migration is idempotently refused/skipped with checksum verification;
- foreign keys and integrity checks pass;
- released/approved evidence cannot be updated or deleted;
- raw chunks cannot overlap sequence ranges and cannot be changed after insert;
- a run cannot arm without a complete hashed snapshot and required bindings;
- Re-Test and Re-Analyze create distinct lineage;
- kgf-to-N normalization is exact within declared numerical tolerance and preserves source provenance;
- output-unit changes do not change canonical stored results;
- calibration expiration/revocation and sensor mismatch remain queryable for historical runs;
- WAL/backup/migration recovery is tested with fault injection;
- x86-bounded chunk streaming does not require loading a complete run into memory.

# End of EDR
