-- Read-only invariant checks for a database created by 0001_initial.sql.
-- A row with status FAIL blocks release/migration completion.

DROP TABLE IF EXISTS temp.database_acceptance_result;
CREATE TEMP TABLE database_acceptance_result (
    test_id       TEXT PRIMARY KEY,
    status        TEXT NOT NULL,
    evidence      TEXT NOT NULL
);

INSERT INTO database_acceptance_result
SELECT 'DBAT-001',
       CASE WHEN (SELECT user_version FROM pragma_user_version) = 1 THEN 'PASS' ELSE 'FAIL' END,
       'PRAGMA user_version must equal 1';

INSERT INTO database_acceptance_result
SELECT 'DBAT-002',
       CASE WHEN COUNT(*) = 12 THEN 'PASS' ELSE 'FAIL' END,
       'all critical evidence tables exist'
FROM sqlite_master
WHERE type = 'table'
  AND name IN (
      'schema_migration', 'test_run', 'run_configuration_snapshot', 'run_channel_binding',
      'stream_metadata', 'raw_sample_chunk', 'analysis_revision', 'derived_series_chunk',
      'domain_event', 'calculated_property', 'acceptance_evaluation', 'audit_log'
  );

INSERT INTO database_acceptance_result
SELECT 'DBAT-003',
       CASE WHEN COUNT(*) = 8 THEN 'PASS' ELSE 'FAIL' END,
       'critical immutability/arming/overlap triggers exist'
FROM sqlite_master
WHERE type = 'trigger'
  AND name IN (
      'trg_raw_sample_chunk_no_overlap', 'trg_run_arm_requires_snapshot',
      'trg_terminal_run_requires_finalized_raw', 'trg_raw_sample_chunk_no_update',
      'trg_raw_sample_chunk_no_delete', 'trg_run_snapshot_no_update',
      'trg_domain_event_no_update', 'trg_audit_log_no_delete'
  );

INSERT INTO database_acceptance_result
SELECT 'DBAT-004',
       CASE WHEN NOT EXISTS (SELECT 1 FROM pragma_foreign_key_check) THEN 'PASS' ELSE 'FAIL' END,
       'PRAGMA foreign_key_check returns no violation';

INSERT INTO database_acceptance_result
SELECT 'DBAT-005',
       CASE WHEN EXISTS (
           SELECT 1 FROM unit_definition
           WHERE unit_code = 'kgf'
             AND quantity_kind = 'Force'
             AND canonical_unit_code = 'N'
             AND scale_to_canonical = 9.80665
             AND offset_to_canonical = 0
             AND is_exact = 1
       ) THEN 'PASS' ELSE 'FAIL' END,
       'kgf conversion is explicit and exact: 1 kgf = 9.80665 N';

INSERT INTO database_acceptance_result
SELECT 'DBAT-006',
       CASE WHEN COUNT(*) = 4 THEN 'PASS' ELSE 'FAIL' END,
       'Load, Stroke, Extension and Time core channels exist'
FROM measurement_channel_definition
WHERE is_core = 1 AND status = 'Active'
  AND channel_code IN ('Load', 'Stroke', 'Extension', 'Time');

INSERT INTO database_acceptance_result
SELECT 'DBAT-007',
       CASE WHEN NOT EXISTS (
           SELECT 1
           FROM raw_sample_chunk a
           JOIN raw_sample_chunk b
             ON a.run_id = b.run_id
            AND a.stream_id = b.stream_id
            AND a.raw_sample_chunk_id < b.raw_sample_chunk_id
            AND NOT (a.last_sequence < b.first_sequence OR a.first_sequence > b.last_sequence)
       ) THEN 'PASS' ELSE 'FAIL' END,
       'raw sample sequence ranges do not overlap';

INSERT INTO database_acceptance_result
SELECT 'DBAT-008',
       CASE WHEN NOT EXISTS (
           SELECT 1 FROM raw_sample_chunk
           WHERE length(payload) <> payload_bytes OR length(payload_sha256) <> 64
       ) THEN 'PASS' ELSE 'FAIL' END,
       'raw chunk payload length/hash metadata is structurally valid';

INSERT INTO database_acceptance_result
SELECT 'DBAT-009',
       CASE WHEN NOT EXISTS (
           SELECT run_id FROM run_configuration_snapshot GROUP BY run_id HAVING COUNT(*) <> 1
       ) THEN 'PASS' ELSE 'FAIL' END,
       'at most one immutable configuration snapshot exists per run';

INSERT INTO database_acceptance_result
SELECT 'DBAT-010',
       CASE WHEN NOT EXISTS (
           SELECT 1
           FROM test_run r
           WHERE r.status IN ('Armed', 'Running', 'Paused', 'Stopping', 'Completed', 'Aborted', 'Faulted')
             AND NOT EXISTS (SELECT 1 FROM run_configuration_snapshot s WHERE s.run_id = r.run_id)
       ) THEN 'PASS' ELSE 'FAIL' END,
       'every armed-or-later run has a configuration snapshot';

INSERT INTO database_acceptance_result
SELECT 'DBAT-011',
       CASE WHEN NOT EXISTS (
           SELECT 1 FROM test_run
           WHERE status IN ('Completed', 'Aborted', 'Faulted') AND raw_finalized <> 1
       ) THEN 'PASS' ELSE 'FAIL' END,
       'terminal runs have finalized raw persistence';

INSERT INTO database_acceptance_result
SELECT 'DBAT-012',
       CASE WHEN NOT EXISTS (
           SELECT run_id FROM analysis_revision WHERE is_current = 1 GROUP BY run_id HAVING COUNT(*) > 1
       ) THEN 'PASS' ELSE 'FAIL' END,
       'a run has at most one explicitly current analysis revision';

INSERT INTO database_acceptance_result
SELECT 'DBAT-013',
       CASE WHEN NOT EXISTS (
           SELECT 1 FROM artifact WHERE relative_path LIKE '/%' OR relative_path LIKE '%..%'
       ) THEN 'PASS' ELSE 'FAIL' END,
       'artifact paths are relative and cannot contain parent traversal';

INSERT INTO database_acceptance_result
SELECT 'DBAT-014',
       CASE WHEN NOT EXISTS (
           SELECT 1 FROM import_record i
           WHERE i.status = 'Imported' AND i.declared_force_unit_code IS NULL
       ) THEN 'PASS' ELSE 'FAIL' END,
       'an imported force dataset cannot omit its declared source force unit';

SELECT test_id, status, evidence
FROM database_acceptance_result
ORDER BY test_id;

SELECT 'SUMMARY' AS test_id,
       CASE WHEN EXISTS (SELECT 1 FROM database_acceptance_result WHERE status = 'FAIL') THEN 'FAIL' ELSE 'PASS' END AS status,
       printf('%d passed; %d failed',
              SUM(CASE WHEN status = 'PASS' THEN 1 ELSE 0 END),
              SUM(CASE WHEN status = 'FAIL' THEN 1 ELSE 0 END)) AS evidence
FROM database_acceptance_result;

