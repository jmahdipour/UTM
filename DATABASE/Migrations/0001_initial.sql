-- UTS SQLite initial physical schema
-- Migration: 0001_initial
-- Governing decision: EDR-0007
-- The migration runner records the file SHA-256 in schema_migration.

PRAGMA foreign_keys = ON;

BEGIN IMMEDIATE;

CREATE TABLE schema_migration (
    migration_id              INTEGER PRIMARY KEY,
    migration_name            TEXT NOT NULL UNIQUE,
    sha256                     TEXT NOT NULL CHECK (length(sha256) = 64),
    application_build         TEXT NOT NULL,
    applied_by                TEXT NOT NULL,
    applied_utc               TEXT NOT NULL
);

CREATE TABLE unit_definition (
    unit_code                 TEXT PRIMARY KEY,
    quantity_kind             TEXT NOT NULL,
    symbol                    TEXT NOT NULL,
    canonical_unit_code       TEXT NOT NULL,
    scale_to_canonical        REAL NOT NULL,
    offset_to_canonical       REAL NOT NULL DEFAULT 0,
    definition_revision       INTEGER NOT NULL CHECK (definition_revision > 0),
    source_reference          TEXT NOT NULL,
    is_exact                  INTEGER NOT NULL CHECK (is_exact IN (0, 1)),
    is_active                 INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
    FOREIGN KEY (canonical_unit_code) REFERENCES unit_definition(unit_code) DEFERRABLE INITIALLY DEFERRED
);

INSERT INTO unit_definition
    (unit_code, quantity_kind, symbol, canonical_unit_code, scale_to_canonical, offset_to_canonical, definition_revision, source_reference, is_exact)
VALUES
    ('N',       'Force',   'N',   'N',     1.0,             0.0, 1, 'SI', 1),
    ('kN',      'Force',   'kN',  'N',  1000.0,             0.0, 1, 'SI', 1),
    ('kgf',     'Force',   'kgf', 'N',     9.80665,         0.0, 1, 'standard gravity conventional value', 1),
    ('lbf',     'Force',   'lbf', 'N',     4.4482216152605, 0.0, 1, 'international avoirdupois pound-force', 1),
    ('mm',      'Length',  'mm',  'mm',    1.0,             0.0, 1, 'SI derived', 1),
    ('um',      'Length',  'µm',  'mm',    0.001,           0.0, 1, 'SI derived', 1),
    ('in',      'Length',  'in',  'mm',   25.4,             0.0, 1, 'international inch', 1),
    ('s',       'Time',    's',   's',     1.0,             0.0, 1, 'SI', 1),
    ('min',     'Time',    'min', 's',    60.0,             0.0, 1, 'SI accepted unit', 1),
    ('MPa',     'Stress',  'MPa', 'MPa',   1.0,             0.0, 1, 'SI derived', 1),
    ('Pa',      'Stress',  'Pa',  'MPa',   0.000001,        0.0, 1, 'SI', 1),
    ('ratio',   'Strain',  '1',   'ratio', 1.0,             0.0, 1, 'dimensionless ratio', 1),
    ('percent', 'Strain',  '%',   'ratio', 0.01,            0.0, 1, 'percent', 1);

CREATE TABLE unit_conversion_definition (
    unit_conversion_definition_id TEXT PRIMARY KEY,
    source_unit_code          TEXT NOT NULL,
    target_unit_code          TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    scale                     REAL NOT NULL,
    offset                    REAL NOT NULL DEFAULT 0,
    source_reference          TEXT NOT NULL,
    is_exact                  INTEGER NOT NULL CHECK (is_exact IN (0, 1)),
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Superseded', 'Revoked')),
    definition_sha256         TEXT NOT NULL CHECK (length(definition_sha256) = 64),
    UNIQUE (source_unit_code, target_unit_code, revision_no),
    FOREIGN KEY (source_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (target_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT
);

INSERT INTO unit_conversion_definition
    (unit_conversion_definition_id, source_unit_code, target_unit_code, revision_no, scale, offset, source_reference, is_exact, status, definition_sha256)
VALUES
    ('conv-n-n-r1',             'N',       'N',     1,    1.0,             0.0, 'SI identity', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-kn-n-r1',            'kN',      'N',     1, 1000.0,             0.0, 'SI prefix', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-kgf-n-r1',           'kgf',     'N',     1,    9.80665,         0.0, 'standard gravity conventional value', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-lbf-n-r1',           'lbf',     'N',     1,    4.4482216152605, 0.0, 'international avoirdupois pound-force', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-mm-mm-r1',           'mm',      'mm',    1,    1.0,             0.0, 'SI derived identity', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-um-mm-r1',           'um',      'mm',    1,    0.001,           0.0, 'SI prefix', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-in-mm-r1',           'in',      'mm',    1,   25.4,             0.0, 'international inch', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-s-s-r1',             's',       's',     1,    1.0,             0.0, 'SI identity', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-min-s-r1',           'min',     's',     1,   60.0,             0.0, 'SI accepted unit', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-mpa-mpa-r1',         'MPa',     'MPa',   1,    1.0,             0.0, 'SI derived identity', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-pa-mpa-r1',          'Pa',      'MPa',   1,    0.000001,        0.0, 'SI prefix', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-ratio-ratio-r1',     'ratio',   'ratio', 1,    1.0,             0.0, 'dimensionless identity', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000'),
    ('conv-percent-ratio-r1',   'percent', 'ratio', 1,    0.01,            0.0, 'percent', 1, 'Active', '0000000000000000000000000000000000000000000000000000000000000000');

CREATE TABLE artifact (
    artifact_id               TEXT PRIMARY KEY,
    artifact_kind             TEXT NOT NULL,
    relative_path             TEXT NOT NULL UNIQUE CHECK (relative_path NOT LIKE '/%' AND relative_path NOT LIKE '%..%'),
    media_type                TEXT NOT NULL,
    byte_length               INTEGER NOT NULL CHECK (byte_length >= 0),
    sha256                     TEXT NOT NULL CHECK (length(sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    status                     TEXT NOT NULL DEFAULT 'Available' CHECK (status IN ('Pending', 'Available', 'Quarantined', 'Archived'))
);

CREATE TABLE customer_order (
    order_id                  TEXT PRIMARY KEY,
    order_number              TEXT NOT NULL UNIQUE,
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Open', 'InProgress', 'Completed', 'Cancelled', 'Archived')),
    received_utc              TEXT,
    due_utc                   TEXT,
    notes                     TEXT,
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    retired_utc               TEXT,
    retired_by                TEXT,
    retirement_reason         TEXT
);

CREATE TABLE order_customer (
    order_id                  TEXT PRIMARY KEY,
    customer_name             TEXT NOT NULL,
    customer_code             TEXT,
    contact_name              TEXT,
    contact_details           TEXT,
    specification_reference  TEXT,
    snapshot_sha256           TEXT NOT NULL CHECK (length(snapshot_sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id) ON DELETE RESTRICT
);

CREATE TABLE specimen (
    specimen_id               TEXT PRIMARY KEY,
    order_id                  TEXT NOT NULL,
    specimen_code             TEXT NOT NULL,
    lifecycle_status          TEXT NOT NULL CHECK (lifecycle_status IN ('Draft', 'Completed', 'Retired')),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    UNIQUE (order_id, specimen_code),
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id) ON DELETE RESTRICT
);

CREATE TABLE specimen_revision (
    specimen_revision_id      TEXT PRIMARY KEY,
    specimen_id               TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_revision_id   TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Released', 'Retired')),
    geometry_type             TEXT NOT NULL,
    geometry_payload          TEXT NOT NULL,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    released_utc              TEXT,
    released_by               TEXT,
    UNIQUE (specimen_id, revision_no),
    FOREIGN KEY (specimen_id) REFERENCES specimen(specimen_id) ON DELETE RESTRICT,
    FOREIGN KEY (predecessor_revision_id) REFERENCES specimen_revision(specimen_revision_id) ON DELETE RESTRICT
);

CREATE TABLE analysis_recipe (
    analysis_recipe_id        TEXT PRIMARY KEY,
    name                      TEXT NOT NULL UNIQUE,
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Retired')),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL
);

CREATE TABLE analysis_recipe_revision (
    analysis_recipe_revision_id TEXT PRIMARY KEY,
    analysis_recipe_id        TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_revision_id   TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Validated', 'Released', 'Retired')),
    schema_version            INTEGER NOT NULL CHECK (schema_version > 0),
    definition_payload        TEXT NOT NULL,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    released_utc              TEXT,
    released_by               TEXT,
    UNIQUE (analysis_recipe_id, revision_no),
    FOREIGN KEY (analysis_recipe_id) REFERENCES analysis_recipe(analysis_recipe_id) ON DELETE RESTRICT,
    FOREIGN KEY (predecessor_revision_id) REFERENCES analysis_recipe_revision(analysis_recipe_revision_id) ON DELETE RESTRICT
);

CREATE TABLE material (
    material_id               TEXT PRIMARY KEY,
    name                      TEXT NOT NULL UNIQUE,
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Retired')),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL
);

CREATE TABLE material_revision (
    material_revision_id      TEXT PRIMARY KEY,
    material_id               TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_revision_id   TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Released', 'Retired')),
    property_payload          TEXT NOT NULL,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    released_utc              TEXT,
    released_by               TEXT,
    UNIQUE (material_id, revision_no),
    FOREIGN KEY (material_id) REFERENCES material(material_id) ON DELETE RESTRICT,
    FOREIGN KEY (predecessor_revision_id) REFERENCES material_revision(material_revision_id) ON DELETE RESTRICT
);

CREATE TABLE acceptance_profile (
    acceptance_profile_id     TEXT PRIMARY KEY,
    name                      TEXT NOT NULL UNIQUE,
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Retired')),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL
);

CREATE TABLE acceptance_profile_revision (
    acceptance_profile_revision_id TEXT PRIMARY KEY,
    acceptance_profile_id     TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_revision_id   TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Validated', 'Released', 'Retired')),
    standard_reference        TEXT,
    decision_rule_code        TEXT,
    uncertainty_policy        TEXT,
    risk_policy               TEXT,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    released_utc              TEXT,
    released_by               TEXT,
    UNIQUE (acceptance_profile_id, revision_no),
    FOREIGN KEY (acceptance_profile_id) REFERENCES acceptance_profile(acceptance_profile_id) ON DELETE RESTRICT,
    FOREIGN KEY (predecessor_revision_id) REFERENCES acceptance_profile_revision(acceptance_profile_revision_id) ON DELETE RESTRICT
);

CREATE TABLE acceptance_rule (
    acceptance_rule_id        TEXT PRIMARY KEY,
    acceptance_profile_revision_id TEXT NOT NULL,
    ordinal                   INTEGER NOT NULL CHECK (ordinal >= 0),
    property_code             TEXT NOT NULL,
    operator_code             TEXT NOT NULL,
    lower_value               REAL,
    upper_value               REAL,
    quantity_kind             TEXT,
    unit_code                 TEXT,
    tolerance_value           REAL,
    enabled                   INTEGER NOT NULL CHECK (enabled IN (0, 1)),
    rule_payload              TEXT NOT NULL,
    UNIQUE (acceptance_profile_revision_id, ordinal),
    FOREIGN KEY (acceptance_profile_revision_id) REFERENCES acceptance_profile_revision(acceptance_profile_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT
);

CREATE TABLE chart_profile (
    chart_profile_id          TEXT PRIMARY KEY,
    name                      TEXT NOT NULL UNIQUE,
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Retired'))
);

CREATE TABLE chart_profile_revision (
    chart_profile_revision_id TEXT PRIMARY KEY,
    chart_profile_id          TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Released', 'Retired')),
    definition_payload        TEXT NOT NULL,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    UNIQUE (chart_profile_id, revision_no),
    FOREIGN KEY (chart_profile_id) REFERENCES chart_profile(chart_profile_id) ON DELETE RESTRICT
);

CREATE TABLE report_template (
    report_template_id        TEXT PRIMARY KEY,
    name                      TEXT NOT NULL UNIQUE,
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Retired'))
);

CREATE TABLE report_template_revision (
    report_template_revision_id TEXT PRIMARY KEY,
    report_template_id        TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Released', 'Retired')),
    template_artifact_id      TEXT,
    definition_payload        TEXT NOT NULL,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    UNIQUE (report_template_id, revision_no),
    FOREIGN KEY (report_template_id) REFERENCES report_template(report_template_id) ON DELETE RESTRICT,
    FOREIGN KEY (template_artifact_id) REFERENCES artifact(artifact_id) ON DELETE RESTRICT
);

CREATE TABLE test_method (
    test_method_id            TEXT PRIMARY KEY,
    name                      TEXT NOT NULL UNIQUE,
    method_family             TEXT NOT NULL,
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Retired')),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL
);

CREATE TABLE test_method_revision (
    test_method_revision_id   TEXT PRIMARY KEY,
    test_method_id            TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_revision_id   TEXT,
    lifecycle_status          TEXT NOT NULL CHECK (lifecycle_status IN ('Draft', 'Validated', 'Released', 'Retired')),
    standard_code             TEXT,
    standard_revision         TEXT,
    analysis_recipe_revision_id TEXT NOT NULL,
    default_chart_profile_revision_id TEXT,
    default_report_template_revision_id TEXT,
    canonical_payload         TEXT NOT NULL,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    released_utc              TEXT,
    released_by               TEXT,
    UNIQUE (test_method_id, revision_no),
    FOREIGN KEY (test_method_id) REFERENCES test_method(test_method_id) ON DELETE RESTRICT,
    FOREIGN KEY (predecessor_revision_id) REFERENCES test_method_revision(test_method_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (analysis_recipe_revision_id) REFERENCES analysis_recipe_revision(analysis_recipe_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (default_chart_profile_revision_id) REFERENCES chart_profile_revision(chart_profile_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (default_report_template_revision_id) REFERENCES report_template_revision(report_template_revision_id) ON DELETE RESTRICT
);

CREATE TABLE method_phase (
    method_phase_id           TEXT PRIMARY KEY,
    test_method_revision_id   TEXT NOT NULL,
    ordinal                   INTEGER NOT NULL CHECK (ordinal >= 0),
    phase_code                TEXT NOT NULL,
    purpose                   TEXT NOT NULL,
    UNIQUE (test_method_revision_id, ordinal),
    FOREIGN KEY (test_method_revision_id) REFERENCES test_method_revision(test_method_revision_id) ON DELETE RESTRICT
);

CREATE TABLE method_segment (
    method_segment_id         TEXT PRIMARY KEY,
    method_phase_id           TEXT NOT NULL,
    ordinal                   INTEGER NOT NULL CHECK (ordinal >= 0),
    purpose                   TEXT NOT NULL,
    control_mode              TEXT NOT NULL,
    direction                 TEXT NOT NULL CHECK (direction IN ('Positive', 'Negative', 'NotApplicable')),
    target_value              REAL,
    target_quantity_kind      TEXT,
    target_unit_code          TEXT,
    rate_value                REAL,
    rate_quantity_kind        TEXT,
    rate_unit_code            TEXT,
    transition_payload        TEXT NOT NULL,
    termination_payload       TEXT NOT NULL,
    recording_mode            TEXT NOT NULL CHECK (recording_mode IN ('Off', 'Record', 'Inherit')),
    sampling_policy           TEXT NOT NULL,
    sample_rate_hz            REAL CHECK (sample_rate_hz IS NULL OR sample_rate_hz > 0),
    repeat_count              INTEGER CHECK (repeat_count IS NULL OR repeat_count > 0),
    detector_references       TEXT NOT NULL,
    operator_prompt           TEXT,
    UNIQUE (method_phase_id, ordinal),
    FOREIGN KEY (method_phase_id) REFERENCES method_phase(method_phase_id) ON DELETE RESTRICT,
    FOREIGN KEY (target_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (rate_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    CHECK ((target_value IS NULL AND target_unit_code IS NULL AND target_quantity_kind IS NULL) OR
           (target_value IS NOT NULL AND target_unit_code IS NOT NULL AND target_quantity_kind IS NOT NULL)),
    CHECK ((rate_value IS NULL AND rate_unit_code IS NULL AND rate_quantity_kind IS NULL) OR
           (rate_value IS NOT NULL AND rate_unit_code IS NOT NULL AND rate_quantity_kind IS NOT NULL))
);

CREATE TABLE method_channel_requirement (
    method_channel_requirement_id TEXT PRIMARY KEY,
    test_method_revision_id   TEXT NOT NULL,
    logical_channel_code      TEXT NOT NULL,
    required                  INTEGER NOT NULL CHECK (required IN (0, 1)),
    capability_payload        TEXT NOT NULL,
    UNIQUE (test_method_revision_id, logical_channel_code),
    FOREIGN KEY (test_method_revision_id) REFERENCES test_method_revision(test_method_revision_id) ON DELETE RESTRICT
);

CREATE TABLE machine (
    machine_id                TEXT PRIMARY KEY,
    machine_code              TEXT NOT NULL UNIQUE,
    manufacturer              TEXT,
    model                     TEXT,
    serial_number             TEXT,
    normalized_positive_direction TEXT NOT NULL CHECK (normalized_positive_direction IN ('Up', 'Down')),
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Maintenance', 'Quarantined', 'Retired')),
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL
);

CREATE TABLE measurement_channel_definition (
    measurement_channel_definition_id TEXT PRIMARY KEY,
    channel_code              TEXT NOT NULL UNIQUE,
    quantity_kind             TEXT NOT NULL,
    canonical_unit_code       TEXT NOT NULL,
    channel_role              TEXT NOT NULL,
    is_core                   INTEGER NOT NULL CHECK (is_core IN (0, 1)),
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Retired')),
    FOREIGN KEY (canonical_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT
);

INSERT INTO measurement_channel_definition
    (measurement_channel_definition_id, channel_code, quantity_kind, canonical_unit_code, channel_role, is_core, status)
VALUES
    ('00000000-0000-0000-0000-000000000001', 'Load',      'Force',  'N',  'Measured', 1, 'Active'),
    ('00000000-0000-0000-0000-000000000002', 'Stroke',    'Length', 'mm', 'Measured', 1, 'Active'),
    ('00000000-0000-0000-0000-000000000003', 'Extension', 'Length', 'mm', 'Measured', 1, 'Active'),
    ('00000000-0000-0000-0000-000000000004', 'Time',      'Time',   's',  'Measured', 1, 'Active');

CREATE TABLE sensor (
    sensor_id                 TEXT PRIMARY KEY,
    sensor_type               TEXT NOT NULL,
    manufacturer              TEXT,
    model                     TEXT,
    serial_number             TEXT,
    nominal_capacity_value    REAL,
    nominal_capacity_quantity_kind TEXT,
    nominal_capacity_unit_code TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Active', 'Retired', 'Quarantined')),
    certificate_artifact_id   TEXT,
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    UNIQUE (manufacturer, model, serial_number),
    FOREIGN KEY (nominal_capacity_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (certificate_artifact_id) REFERENCES artifact(artifact_id) ON DELETE RESTRICT,
    CHECK ((nominal_capacity_value IS NULL AND nominal_capacity_unit_code IS NULL AND nominal_capacity_quantity_kind IS NULL) OR
           (nominal_capacity_value IS NOT NULL AND nominal_capacity_unit_code IS NOT NULL AND nominal_capacity_quantity_kind IS NOT NULL))
);

CREATE TABLE sensor_installation (
    sensor_installation_id    TEXT PRIMARY KEY,
    sensor_id                 TEXT NOT NULL,
    machine_id                TEXT NOT NULL,
    location_code             TEXT NOT NULL,
    orientation_code          TEXT NOT NULL,
    sign_multiplier           INTEGER NOT NULL CHECK (sign_multiplier IN (-1, 1)),
    effective_from_utc        TEXT NOT NULL,
    effective_to_utc          TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Installed', 'Removed', 'Quarantined')),
    installed_by              TEXT NOT NULL,
    evidence_artifact_id      TEXT,
    FOREIGN KEY (sensor_id) REFERENCES sensor(sensor_id) ON DELETE RESTRICT,
    FOREIGN KEY (machine_id) REFERENCES machine(machine_id) ON DELETE RESTRICT,
    FOREIGN KEY (evidence_artifact_id) REFERENCES artifact(artifact_id) ON DELETE RESTRICT
);

CREATE TABLE calibration_revision (
    calibration_revision_id   TEXT PRIMARY KEY,
    sensor_id                 TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_revision_id   TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Approved', 'Active', 'Expired', 'Superseded', 'Rejected', 'Revoked')),
    procedure_reference       TEXT NOT NULL,
    standard_reference        TEXT,
    calibrated_utc            TEXT NOT NULL,
    valid_from_utc            TEXT,
    valid_to_utc              TEXT,
    input_quantity_kind       TEXT NOT NULL,
    input_unit_code           TEXT NOT NULL,
    output_quantity_kind      TEXT NOT NULL,
    output_unit_code          TEXT NOT NULL,
    interpolation_rule        TEXT NOT NULL,
    uncertainty_payload       TEXT,
    restriction_payload       TEXT,
    certificate_artifact_id   TEXT,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    performed_by              TEXT NOT NULL,
    approved_by               TEXT,
    approved_utc              TEXT,
    UNIQUE (sensor_id, revision_no),
    FOREIGN KEY (sensor_id) REFERENCES sensor(sensor_id) ON DELETE RESTRICT,
    FOREIGN KEY (predecessor_revision_id) REFERENCES calibration_revision(calibration_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (input_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (output_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (certificate_artifact_id) REFERENCES artifact(artifact_id) ON DELETE RESTRICT
);

CREATE TABLE calibration_point (
    calibration_revision_id   TEXT NOT NULL,
    ordinal                   INTEGER NOT NULL CHECK (ordinal >= 0),
    input_value               REAL NOT NULL,
    output_value              REAL NOT NULL,
    uncertainty_value         REAL,
    PRIMARY KEY (calibration_revision_id, ordinal),
    FOREIGN KEY (calibration_revision_id) REFERENCES calibration_revision(calibration_revision_id) ON DELETE RESTRICT
) WITHOUT ROWID;

CREATE TABLE zero_tare_revision (
    zero_tare_revision_id     TEXT PRIMARY KEY,
    sensor_installation_id    TEXT NOT NULL,
    calibration_revision_id   TEXT NOT NULL,
    run_id_context            TEXT,
    before_value              REAL NOT NULL,
    after_value               REAL NOT NULL,
    quantity_kind             TEXT NOT NULL,
    unit_code                 TEXT NOT NULL,
    applied_utc               TEXT NOT NULL,
    applied_by                TEXT NOT NULL,
    machine_state             TEXT NOT NULL,
    reason                    TEXT NOT NULL,
    payload_sha256            TEXT NOT NULL CHECK (length(payload_sha256) = 64),
    FOREIGN KEY (sensor_installation_id) REFERENCES sensor_installation(sensor_installation_id) ON DELETE RESTRICT,
    FOREIGN KEY (calibration_revision_id) REFERENCES calibration_revision(calibration_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (run_id_context) REFERENCES test_run(run_id) ON DELETE RESTRICT
);

CREATE TABLE compliance_correction_revision (
    compliance_correction_revision_id TEXT PRIMARY KEY,
    machine_id                TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_revision_id   TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Approved', 'Active', 'Expired', 'Superseded', 'Revoked')),
    quantity_kind             TEXT NOT NULL,
    unit_code                 TEXT NOT NULL,
    correction_payload        BLOB NOT NULL,
    codec_version             INTEGER NOT NULL CHECK (codec_version > 0),
    payload_sha256            TEXT NOT NULL CHECK (length(payload_sha256) = 64),
    valid_from_utc            TEXT,
    valid_to_utc              TEXT,
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    approved_utc              TEXT,
    approved_by               TEXT,
    UNIQUE (machine_id, revision_no),
    FOREIGN KEY (machine_id) REFERENCES machine(machine_id) ON DELETE RESTRICT,
    FOREIGN KEY (predecessor_revision_id) REFERENCES compliance_correction_revision(compliance_correction_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT
);

CREATE TABLE test_run (
    run_id                    TEXT PRIMARY KEY,
    specimen_id               TEXT NOT NULL,
    run_number                INTEGER NOT NULL CHECK (run_number > 0),
    machine_id                TEXT NOT NULL,
    status                    TEXT NOT NULL CHECK (status IN ('Preparing', 'ReadyToArm', 'Armed', 'Running', 'Paused', 'Stopping', 'Completed', 'Aborted', 'Faulted', 'Cancelled')),
    end_reason_code           TEXT,
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    started_utc               TEXT,
    ended_utc                 TEXT,
    raw_finalized             INTEGER NOT NULL DEFAULT 0 CHECK (raw_finalized IN (0, 1)),
    last_committed_sequence   INTEGER,
    UNIQUE (specimen_id, run_number),
    FOREIGN KEY (specimen_id) REFERENCES specimen(specimen_id) ON DELETE RESTRICT,
    FOREIGN KEY (machine_id) REFERENCES machine(machine_id) ON DELETE RESTRICT,
    CHECK ((status IN ('Completed', 'Aborted', 'Faulted', 'Cancelled')) = (end_reason_code IS NOT NULL)),
    CHECK (last_committed_sequence IS NULL OR last_committed_sequence >= 0)
);

CREATE TABLE run_configuration_snapshot (
    run_configuration_snapshot_id TEXT PRIMARY KEY,
    run_id                    TEXT NOT NULL UNIQUE,
    test_method_revision_id   TEXT NOT NULL,
    specimen_revision_id      TEXT NOT NULL,
    material_revision_id      TEXT,
    acceptance_profile_revision_id TEXT,
    analysis_recipe_revision_id TEXT NOT NULL,
    chart_profile_revision_id TEXT,
    report_template_revision_id TEXT,
    application_build         TEXT NOT NULL,
    sqlite_engine_version     TEXT NOT NULL,
    operator_identity         TEXT NOT NULL,
    snapshot_schema_version   INTEGER NOT NULL CHECK (snapshot_schema_version > 0),
    canonical_payload         TEXT NOT NULL,
    snapshot_sha256           TEXT NOT NULL CHECK (length(snapshot_sha256) = 64),
    created_utc               TEXT NOT NULL,
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT,
    FOREIGN KEY (test_method_revision_id) REFERENCES test_method_revision(test_method_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (specimen_revision_id) REFERENCES specimen_revision(specimen_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (material_revision_id) REFERENCES material_revision(material_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (acceptance_profile_revision_id) REFERENCES acceptance_profile_revision(acceptance_profile_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (analysis_recipe_revision_id) REFERENCES analysis_recipe_revision(analysis_recipe_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (chart_profile_revision_id) REFERENCES chart_profile_revision(chart_profile_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (report_template_revision_id) REFERENCES report_template_revision(report_template_revision_id) ON DELETE RESTRICT
);

CREATE TABLE run_channel_binding (
    run_channel_binding_id    TEXT PRIMARY KEY,
    run_configuration_snapshot_id TEXT NOT NULL,
    logical_channel_code      TEXT NOT NULL,
    measurement_channel_definition_id TEXT NOT NULL,
    sensor_installation_id    TEXT,
    calibration_revision_id   TEXT,
    zero_tare_revision_id     TEXT,
    compliance_correction_revision_id TEXT,
    raw_source_identity       TEXT NOT NULL,
    source_quantity_kind      TEXT NOT NULL,
    source_unit_code          TEXT NOT NULL,
    canonical_quantity_kind   TEXT NOT NULL,
    canonical_unit_code       TEXT NOT NULL,
    unit_conversion_definition_id TEXT NOT NULL,
    sign_multiplier           INTEGER NOT NULL CHECK (sign_multiplier IN (-1, 1)),
    binding_source            TEXT NOT NULL CHECK (binding_source IN ('DeviceIdentity', 'OperatorConfirmed', 'Virtual', 'System')),
    operator_confirmation     TEXT,
    usable_range_payload      TEXT,
    quality_policy_payload    TEXT NOT NULL,
    UNIQUE (run_configuration_snapshot_id, logical_channel_code),
    FOREIGN KEY (run_configuration_snapshot_id) REFERENCES run_configuration_snapshot(run_configuration_snapshot_id) ON DELETE RESTRICT,
    FOREIGN KEY (measurement_channel_definition_id) REFERENCES measurement_channel_definition(measurement_channel_definition_id) ON DELETE RESTRICT,
    FOREIGN KEY (sensor_installation_id) REFERENCES sensor_installation(sensor_installation_id) ON DELETE RESTRICT,
    FOREIGN KEY (calibration_revision_id) REFERENCES calibration_revision(calibration_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (zero_tare_revision_id) REFERENCES zero_tare_revision(zero_tare_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (compliance_correction_revision_id) REFERENCES compliance_correction_revision(compliance_correction_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (source_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (canonical_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (unit_conversion_definition_id) REFERENCES unit_conversion_definition(unit_conversion_definition_id) ON DELETE RESTRICT,
    CHECK ((binding_source IN ('DeviceIdentity', 'OperatorConfirmed') AND sensor_installation_id IS NOT NULL AND calibration_revision_id IS NOT NULL) OR
           (binding_source IN ('Virtual', 'System')))
);

CREATE TABLE stream_metadata (
    stream_metadata_id        TEXT PRIMARY KEY,
    run_id                    TEXT NOT NULL,
    stream_id                 TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    effective_first_sequence  INTEGER NOT NULL CHECK (effective_first_sequence >= 0),
    sample_rate_hz            REAL NOT NULL CHECK (sample_rate_hz > 0),
    recording_mode            TEXT NOT NULL CHECK (recording_mode IN ('Off', 'Record')),
    channel_layout_payload    TEXT NOT NULL,
    layout_sha256             TEXT NOT NULL CHECK (length(layout_sha256) = 64),
    created_utc               TEXT NOT NULL,
    UNIQUE (run_id, stream_id, revision_no),
    UNIQUE (run_id, stream_id, effective_first_sequence),
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT
);

CREATE TABLE raw_sample_chunk (
    raw_sample_chunk_id       TEXT PRIMARY KEY,
    run_id                    TEXT NOT NULL,
    stream_id                 TEXT NOT NULL,
    stream_metadata_id        TEXT NOT NULL,
    codec_name                TEXT NOT NULL,
    codec_version             INTEGER NOT NULL CHECK (codec_version > 0),
    first_sequence            INTEGER NOT NULL CHECK (first_sequence >= 0),
    last_sequence             INTEGER NOT NULL CHECK (last_sequence >= first_sequence),
    sample_count              INTEGER NOT NULL CHECK (sample_count > 0),
    first_monotonic_ns        INTEGER NOT NULL CHECK (first_monotonic_ns >= 0),
    last_monotonic_ns         INTEGER NOT NULL CHECK (last_monotonic_ns >= first_monotonic_ns),
    captured_utc              TEXT NOT NULL,
    quality_mask              INTEGER NOT NULL DEFAULT 0,
    payload                   BLOB NOT NULL,
    payload_bytes             INTEGER NOT NULL CHECK (payload_bytes > 0),
    payload_sha256            TEXT NOT NULL CHECK (length(payload_sha256) = 64),
    committed_utc             TEXT NOT NULL,
    UNIQUE (run_id, stream_id, first_sequence),
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT,
    FOREIGN KEY (stream_metadata_id) REFERENCES stream_metadata(stream_metadata_id) ON DELETE RESTRICT,
    CHECK (sample_count = last_sequence - first_sequence + 1),
    CHECK (length(payload) = payload_bytes)
);

CREATE TABLE sample_gap (
    sample_gap_id             TEXT PRIMARY KEY,
    run_id                    TEXT NOT NULL,
    stream_id                 TEXT NOT NULL,
    missing_first_sequence    INTEGER NOT NULL CHECK (missing_first_sequence >= 0),
    missing_last_sequence     INTEGER NOT NULL CHECK (missing_last_sequence >= missing_first_sequence),
    detected_utc              TEXT NOT NULL,
    reason_code               TEXT NOT NULL,
    correlation_id            TEXT,
    UNIQUE (run_id, stream_id, missing_first_sequence, missing_last_sequence),
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT
);

CREATE TABLE analysis_revision (
    analysis_revision_id      TEXT PRIMARY KEY,
    run_id                    TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    parent_analysis_revision_id TEXT,
    analysis_recipe_revision_id TEXT NOT NULL,
    pipeline_revision         TEXT NOT NULL,
    application_build         TEXT NOT NULL,
    deterministic_input_sha256 TEXT NOT NULL CHECK (length(deterministic_input_sha256) = 64),
    status                    TEXT NOT NULL CHECK (status IN ('Pending', 'Running', 'Completed', 'Failed', 'Superseded')),
    is_current                INTEGER NOT NULL DEFAULT 0 CHECK (is_current IN (0, 1)),
    started_utc               TEXT,
    completed_utc             TEXT,
    failure_code              TEXT,
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    UNIQUE (run_id, revision_no),
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT,
    FOREIGN KEY (parent_analysis_revision_id) REFERENCES analysis_revision(analysis_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (analysis_recipe_revision_id) REFERENCES analysis_recipe_revision(analysis_recipe_revision_id) ON DELETE RESTRICT,
    CHECK ((status = 'Failed') = (failure_code IS NOT NULL))
);

CREATE UNIQUE INDEX ux_analysis_revision_current
    ON analysis_revision(run_id) WHERE is_current = 1;

CREATE TABLE derived_series_chunk (
    derived_series_chunk_id   TEXT PRIMARY KEY,
    analysis_revision_id      TEXT NOT NULL,
    channel_code              TEXT NOT NULL,
    codec_name                TEXT NOT NULL,
    codec_version             INTEGER NOT NULL CHECK (codec_version > 0),
    first_sequence            INTEGER NOT NULL CHECK (first_sequence >= 0),
    last_sequence             INTEGER NOT NULL CHECK (last_sequence >= first_sequence),
    sample_count              INTEGER NOT NULL CHECK (sample_count > 0),
    quantity_kind             TEXT NOT NULL,
    unit_code                 TEXT NOT NULL,
    quality_mask              INTEGER NOT NULL DEFAULT 0,
    payload                   BLOB NOT NULL,
    payload_bytes             INTEGER NOT NULL CHECK (payload_bytes > 0),
    payload_sha256            TEXT NOT NULL CHECK (length(payload_sha256) = 64),
    UNIQUE (analysis_revision_id, channel_code, first_sequence),
    FOREIGN KEY (analysis_revision_id) REFERENCES analysis_revision(analysis_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    CHECK (sample_count = last_sequence - first_sequence + 1),
    CHECK (length(payload) = payload_bytes)
);

CREATE TABLE domain_event (
    event_id                  TEXT PRIMARY KEY,
    event_type                TEXT NOT NULL,
    schema_version            INTEGER NOT NULL CHECK (schema_version > 0),
    occurred_utc              TEXT NOT NULL,
    monotonic_ns              INTEGER,
    correlation_id            TEXT NOT NULL,
    causation_id              TEXT,
    run_id                    TEXT,
    machine_id                TEXT,
    method_segment_id         TEXT,
    sensor_id                 TEXT,
    analysis_revision_id      TEXT,
    source_component          TEXT NOT NULL,
    source_first_sequence     INTEGER,
    source_last_sequence      INTEGER,
    severity                  TEXT NOT NULL CHECK (severity IN ('Information', 'Warning', 'ProtectiveStop', 'Fault', 'Emergency')),
    payload                   TEXT NOT NULL,
    payload_sha256            TEXT NOT NULL CHECK (length(payload_sha256) = 64),
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT,
    FOREIGN KEY (machine_id) REFERENCES machine(machine_id) ON DELETE RESTRICT,
    FOREIGN KEY (method_segment_id) REFERENCES method_segment(method_segment_id) ON DELETE RESTRICT,
    FOREIGN KEY (sensor_id) REFERENCES sensor(sensor_id) ON DELETE RESTRICT,
    FOREIGN KEY (analysis_revision_id) REFERENCES analysis_revision(analysis_revision_id) ON DELETE RESTRICT,
    CHECK ((source_first_sequence IS NULL AND source_last_sequence IS NULL) OR
           (source_first_sequence IS NOT NULL AND source_last_sequence IS NOT NULL AND source_last_sequence >= source_first_sequence))
);

CREATE TABLE detected_event (
    detected_event_id         TEXT PRIMARY KEY,
    analysis_revision_id      TEXT NOT NULL,
    event_type                TEXT NOT NULL,
    source_first_sequence     INTEGER NOT NULL CHECK (source_first_sequence >= 0),
    source_last_sequence      INTEGER NOT NULL CHECK (source_last_sequence >= source_first_sequence),
    detector_revision         TEXT NOT NULL,
    rule_revision             TEXT NOT NULL,
    parameter_payload         TEXT NOT NULL,
    confidence_value          REAL,
    quality_code              TEXT NOT NULL,
    event_value               REAL,
    event_quantity_kind       TEXT,
    event_unit_code           TEXT,
    operator_override_of_id   TEXT,
    override_reason           TEXT,
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    FOREIGN KEY (analysis_revision_id) REFERENCES analysis_revision(analysis_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (event_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (operator_override_of_id) REFERENCES detected_event(detected_event_id) ON DELETE RESTRICT,
    CHECK ((event_value IS NULL AND event_quantity_kind IS NULL AND event_unit_code IS NULL) OR
           (event_value IS NOT NULL AND event_quantity_kind IS NOT NULL AND event_unit_code IS NOT NULL))
);

CREATE TABLE calculated_property (
    calculated_property_id    TEXT PRIMARY KEY,
    analysis_revision_id      TEXT NOT NULL,
    property_code             TEXT NOT NULL,
    value_numeric             REAL,
    value_payload             TEXT,
    quantity_kind             TEXT,
    unit_code                 TEXT,
    quality_code              TEXT NOT NULL,
    source_first_sequence     INTEGER,
    source_last_sequence      INTEGER,
    formula_revision          TEXT NOT NULL,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    created_utc               TEXT NOT NULL,
    UNIQUE (analysis_revision_id, property_code),
    FOREIGN KEY (analysis_revision_id) REFERENCES analysis_revision(analysis_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    CHECK ((value_numeric IS NOT NULL) <> (value_payload IS NOT NULL)),
    CHECK ((value_numeric IS NULL AND quantity_kind IS NULL AND unit_code IS NULL) OR
           (value_numeric IS NOT NULL AND quantity_kind IS NOT NULL AND unit_code IS NOT NULL)),
    CHECK ((source_first_sequence IS NULL AND source_last_sequence IS NULL) OR
           (source_first_sequence IS NOT NULL AND source_last_sequence IS NOT NULL AND source_last_sequence >= source_first_sequence))
);

CREATE TABLE acceptance_evaluation (
    acceptance_evaluation_id TEXT PRIMARY KEY,
    analysis_revision_id      TEXT NOT NULL,
    acceptance_profile_revision_id TEXT NOT NULL,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_evaluation_id TEXT,
    verdict                   TEXT NOT NULL CHECK (verdict IN ('Pass', 'Fail', 'Indeterminate', 'NotEvaluated')),
    decision_rule_code        TEXT,
    uncertainty_payload       TEXT,
    risk_payload              TEXT,
    evaluated_utc             TEXT NOT NULL,
    evaluated_by              TEXT NOT NULL,
    canonical_payload_sha256  TEXT NOT NULL CHECK (length(canonical_payload_sha256) = 64),
    UNIQUE (analysis_revision_id, acceptance_profile_revision_id, revision_no),
    FOREIGN KEY (analysis_revision_id) REFERENCES analysis_revision(analysis_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (acceptance_profile_revision_id) REFERENCES acceptance_profile_revision(acceptance_profile_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (predecessor_evaluation_id) REFERENCES acceptance_evaluation(acceptance_evaluation_id) ON DELETE RESTRICT
);

CREATE TABLE acceptance_rule_result (
    acceptance_evaluation_id TEXT NOT NULL,
    acceptance_rule_id       TEXT NOT NULL,
    calculated_property_id   TEXT,
    verdict                   TEXT NOT NULL CHECK (verdict IN ('Pass', 'Fail', 'Indeterminate', 'NotEvaluated')),
    evaluated_value_payload   TEXT,
    reason_code               TEXT NOT NULL,
    PRIMARY KEY (acceptance_evaluation_id, acceptance_rule_id),
    FOREIGN KEY (acceptance_evaluation_id) REFERENCES acceptance_evaluation(acceptance_evaluation_id) ON DELETE RESTRICT,
    FOREIGN KEY (acceptance_rule_id) REFERENCES acceptance_rule(acceptance_rule_id) ON DELETE RESTRICT,
    FOREIGN KEY (calculated_property_id) REFERENCES calculated_property(calculated_property_id) ON DELETE RESTRICT
) WITHOUT ROWID;

CREATE TABLE run_state_journal (
    run_state_journal_id      TEXT PRIMARY KEY,
    run_id                    TEXT NOT NULL,
    transition_ordinal        INTEGER NOT NULL CHECK (transition_ordinal > 0),
    prior_state               TEXT,
    next_state                TEXT NOT NULL,
    reason_code               TEXT NOT NULL,
    correlation_id            TEXT NOT NULL,
    actor_identity            TEXT NOT NULL,
    occurred_utc              TEXT NOT NULL,
    monotonic_ns              INTEGER,
    device_ack_payload        TEXT,
    UNIQUE (run_id, transition_ordinal),
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT
);

CREATE TABLE command_journal (
    command_journal_id        TEXT PRIMARY KEY,
    command_type              TEXT NOT NULL,
    correlation_id            TEXT NOT NULL UNIQUE,
    causation_id              TEXT,
    machine_id                TEXT NOT NULL,
    run_id                    TEXT,
    method_segment_id         TEXT,
    machine_state             TEXT NOT NULL,
    run_state                 TEXT,
    requested_utc             TEXT NOT NULL,
    requested_monotonic_ns    INTEGER,
    requested_by              TEXT NOT NULL,
    outcome                   TEXT NOT NULL CHECK (outcome IN ('Accepted', 'Rejected', 'Failed', 'TimedOut')),
    reason_code               TEXT NOT NULL,
    interlock_snapshot_payload TEXT NOT NULL,
    device_ack_payload        TEXT,
    FOREIGN KEY (machine_id) REFERENCES machine(machine_id) ON DELETE RESTRICT,
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT,
    FOREIGN KEY (method_segment_id) REFERENCES method_segment(method_segment_id) ON DELETE RESTRICT
);

CREATE TABLE report_record (
    report_record_id          TEXT PRIMARY KEY,
    run_id                    TEXT NOT NULL,
    analysis_revision_id      TEXT NOT NULL,
    acceptance_evaluation_id  TEXT,
    report_template_revision_id TEXT NOT NULL,
    output_artifact_id        TEXT NOT NULL,
    generation_revision       INTEGER NOT NULL CHECK (generation_revision > 0),
    status                    TEXT NOT NULL CHECK (status IN ('Generated', 'Superseded', 'Failed')),
    input_snapshot_sha256     TEXT NOT NULL CHECK (length(input_snapshot_sha256) = 64),
    generated_utc             TEXT NOT NULL,
    generated_by              TEXT NOT NULL,
    FOREIGN KEY (run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT,
    FOREIGN KEY (analysis_revision_id) REFERENCES analysis_revision(analysis_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (acceptance_evaluation_id) REFERENCES acceptance_evaluation(acceptance_evaluation_id) ON DELETE RESTRICT,
    FOREIGN KEY (report_template_revision_id) REFERENCES report_template_revision(report_template_revision_id) ON DELETE RESTRICT,
    FOREIGN KEY (output_artifact_id) REFERENCES artifact(artifact_id) ON DELETE RESTRICT
);

CREATE TABLE configuration_revision (
    configuration_revision_id TEXT PRIMARY KEY,
    configuration_key         TEXT NOT NULL,
    scope_type                TEXT NOT NULL,
    scope_id                  TEXT,
    revision_no               INTEGER NOT NULL CHECK (revision_no > 0),
    predecessor_revision_id   TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Draft', 'Active', 'Superseded', 'Revoked')),
    value_payload             TEXT NOT NULL,
    value_sha256              TEXT NOT NULL CHECK (length(value_sha256) = 64),
    effective_from_utc        TEXT,
    effective_to_utc          TEXT,
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    approved_utc              TEXT,
    approved_by               TEXT,
    UNIQUE (configuration_key, scope_type, scope_id, revision_no),
    FOREIGN KEY (predecessor_revision_id) REFERENCES configuration_revision(configuration_revision_id) ON DELETE RESTRICT
);

CREATE TABLE import_record (
    import_record_id          TEXT PRIMARY KEY,
    source_artifact_id        TEXT NOT NULL,
    import_profile_code       TEXT NOT NULL,
    import_profile_revision   INTEGER NOT NULL CHECK (import_profile_revision > 0),
    source_format             TEXT NOT NULL,
    declared_force_unit_code  TEXT,
    declared_length_unit_code TEXT,
    unit_conversion_definition_id TEXT NOT NULL,
    imported_run_id           TEXT,
    status                    TEXT NOT NULL CHECK (status IN ('Pending', 'Imported', 'Rejected', 'Failed')),
    diagnostic_payload        TEXT NOT NULL,
    created_utc               TEXT NOT NULL,
    created_by                TEXT NOT NULL,
    FOREIGN KEY (source_artifact_id) REFERENCES artifact(artifact_id) ON DELETE RESTRICT,
    FOREIGN KEY (declared_force_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (declared_length_unit_code) REFERENCES unit_definition(unit_code) ON DELETE RESTRICT,
    FOREIGN KEY (unit_conversion_definition_id) REFERENCES unit_conversion_definition(unit_conversion_definition_id) ON DELETE RESTRICT,
    FOREIGN KEY (imported_run_id) REFERENCES test_run(run_id) ON DELETE RESTRICT
    CHECK (status <> 'Imported' OR declared_force_unit_code IS NOT NULL)
);

CREATE TABLE audit_log (
    audit_id                  TEXT PRIMARY KEY,
    occurred_utc              TEXT NOT NULL,
    actor_identity            TEXT NOT NULL,
    action_code               TEXT NOT NULL,
    aggregate_type            TEXT NOT NULL,
    aggregate_id              TEXT NOT NULL,
    aggregate_revision_id     TEXT,
    correlation_id            TEXT NOT NULL,
    causation_id              TEXT,
    prior_hash                TEXT CHECK (prior_hash IS NULL OR length(prior_hash) = 64),
    new_hash                  TEXT CHECK (new_hash IS NULL OR length(new_hash) = 64),
    reason_code               TEXT,
    detail_payload            TEXT NOT NULL
);

CREATE INDEX ix_order_status_received ON customer_order(status, received_utc);
CREATE INDEX ix_specimen_order ON specimen(order_id, lifecycle_status);
CREATE INDEX ix_specimen_revision_latest ON specimen_revision(specimen_id, revision_no DESC);
CREATE INDEX ix_method_revision_latest ON test_method_revision(test_method_id, revision_no DESC);
CREATE INDEX ix_calibration_sensor_status ON calibration_revision(sensor_id, status, valid_from_utc, valid_to_utc);
CREATE INDEX ix_sensor_installation_machine ON sensor_installation(machine_id, status, location_code);
CREATE INDEX ix_run_status_created ON test_run(status, created_utc);
CREATE INDEX ix_run_specimen ON test_run(specimen_id, run_number);
CREATE INDEX ix_raw_chunk_replay ON raw_sample_chunk(run_id, stream_id, first_sequence, last_sequence);
CREATE INDEX ix_gap_run_stream ON sample_gap(run_id, stream_id, missing_first_sequence);
CREATE INDEX ix_domain_event_run_type ON domain_event(run_id, event_type, monotonic_ns);
CREATE INDEX ix_domain_event_correlation ON domain_event(correlation_id);
CREATE INDEX ix_analysis_run_revision ON analysis_revision(run_id, revision_no DESC);
CREATE INDEX ix_property_analysis_code ON calculated_property(analysis_revision_id, property_code);
CREATE INDEX ix_state_run_ordinal ON run_state_journal(run_id, transition_ordinal);
CREATE INDEX ix_command_run_time ON command_journal(run_id, requested_utc);
CREATE INDEX ix_audit_aggregate_time ON audit_log(aggregate_type, aggregate_id, occurred_utc);
CREATE INDEX ix_audit_correlation ON audit_log(correlation_id);

CREATE TRIGGER trg_raw_sample_chunk_no_overlap
BEFORE INSERT ON raw_sample_chunk
WHEN EXISTS (
    SELECT 1 FROM raw_sample_chunk r
    WHERE r.run_id = NEW.run_id
      AND r.stream_id = NEW.stream_id
      AND NOT (NEW.last_sequence < r.first_sequence OR NEW.first_sequence > r.last_sequence)
)
BEGIN
    SELECT RAISE(ABORT, 'raw sample sequence range overlaps an existing chunk');
END;

CREATE TRIGGER trg_run_arm_requires_snapshot
BEFORE UPDATE OF status ON test_run
WHEN NEW.status IN ('Armed', 'Running', 'Paused', 'Stopping', 'Completed', 'Aborted', 'Faulted')
BEGIN
    SELECT CASE WHEN NOT EXISTS (
        SELECT 1 FROM run_configuration_snapshot s
        WHERE s.run_id = NEW.run_id AND length(s.snapshot_sha256) = 64
    ) THEN RAISE(ABORT, 'run cannot arm without a hashed configuration snapshot') END;

    SELECT CASE WHEN EXISTS (
        SELECT 1
        FROM run_configuration_snapshot s
        JOIN method_channel_requirement r
          ON r.test_method_revision_id = s.test_method_revision_id
         AND r.required = 1
        WHERE s.run_id = NEW.run_id
          AND NOT EXISTS (
              SELECT 1 FROM run_channel_binding b
              WHERE b.run_configuration_snapshot_id = s.run_configuration_snapshot_id
                AND b.logical_channel_code = r.logical_channel_code
          )
    ) THEN RAISE(ABORT, 'run cannot arm with unresolved required channels') END;

    SELECT CASE WHEN EXISTS (
        SELECT 1
        FROM run_configuration_snapshot s
        JOIN method_channel_requirement r
          ON r.test_method_revision_id = s.test_method_revision_id
         AND r.required = 1
        JOIN run_channel_binding b
          ON b.run_configuration_snapshot_id = s.run_configuration_snapshot_id
         AND b.logical_channel_code = r.logical_channel_code
        LEFT JOIN calibration_revision c ON c.calibration_revision_id = b.calibration_revision_id
        LEFT JOIN sensor_installation i ON i.sensor_installation_id = b.sensor_installation_id
        WHERE s.run_id = NEW.run_id
          AND b.binding_source IN ('DeviceIdentity', 'OperatorConfirmed')
          AND (c.status <> 'Active' OR i.status <> 'Installed')
    ) THEN RAISE(ABORT, 'run cannot arm with inactive calibration or sensor installation') END;
END;

CREATE TRIGGER trg_terminal_run_requires_finalized_raw
BEFORE UPDATE OF status ON test_run
WHEN NEW.status IN ('Completed', 'Aborted', 'Faulted') AND NEW.raw_finalized <> 1
BEGIN
    SELECT RAISE(ABORT, 'terminal run requires finalized raw persistence');
END;

-- Immutable evidence guards.
CREATE TRIGGER trg_raw_sample_chunk_no_update BEFORE UPDATE ON raw_sample_chunk BEGIN SELECT RAISE(ABORT, 'raw sample chunks are immutable'); END;
CREATE TRIGGER trg_raw_sample_chunk_no_delete BEFORE DELETE ON raw_sample_chunk BEGIN SELECT RAISE(ABORT, 'raw sample chunks are immutable'); END;
CREATE TRIGGER trg_stream_metadata_no_update BEFORE UPDATE ON stream_metadata BEGIN SELECT RAISE(ABORT, 'stream metadata is immutable'); END;
CREATE TRIGGER trg_stream_metadata_no_delete BEFORE DELETE ON stream_metadata BEGIN SELECT RAISE(ABORT, 'stream metadata is immutable'); END;
CREATE TRIGGER trg_unit_definition_no_update BEFORE UPDATE ON unit_definition BEGIN SELECT RAISE(ABORT, 'unit definitions are immutable'); END;
CREATE TRIGGER trg_unit_definition_no_delete BEFORE DELETE ON unit_definition BEGIN SELECT RAISE(ABORT, 'unit definitions are immutable'); END;
CREATE TRIGGER trg_unit_conversion_no_update BEFORE UPDATE ON unit_conversion_definition BEGIN SELECT RAISE(ABORT, 'unit conversions are immutable'); END;
CREATE TRIGGER trg_unit_conversion_no_delete BEFORE DELETE ON unit_conversion_definition BEGIN SELECT RAISE(ABORT, 'unit conversions are immutable'); END;
CREATE TRIGGER trg_run_snapshot_no_update BEFORE UPDATE ON run_configuration_snapshot BEGIN SELECT RAISE(ABORT, 'run configuration snapshots are immutable'); END;
CREATE TRIGGER trg_run_snapshot_no_delete BEFORE DELETE ON run_configuration_snapshot BEGIN SELECT RAISE(ABORT, 'run configuration snapshots are immutable'); END;
CREATE TRIGGER trg_run_binding_no_update BEFORE UPDATE ON run_channel_binding BEGIN SELECT RAISE(ABORT, 'run channel bindings are immutable'); END;
CREATE TRIGGER trg_run_binding_no_delete BEFORE DELETE ON run_channel_binding BEGIN SELECT RAISE(ABORT, 'run channel bindings are immutable'); END;
CREATE TRIGGER trg_domain_event_no_update BEFORE UPDATE ON domain_event BEGIN SELECT RAISE(ABORT, 'domain events are append-only'); END;
CREATE TRIGGER trg_domain_event_no_delete BEFORE DELETE ON domain_event BEGIN SELECT RAISE(ABORT, 'domain events are append-only'); END;
CREATE TRIGGER trg_run_state_journal_no_update BEFORE UPDATE ON run_state_journal BEGIN SELECT RAISE(ABORT, 'run state journal is append-only'); END;
CREATE TRIGGER trg_run_state_journal_no_delete BEFORE DELETE ON run_state_journal BEGIN SELECT RAISE(ABORT, 'run state journal is append-only'); END;
CREATE TRIGGER trg_command_journal_no_update BEFORE UPDATE ON command_journal BEGIN SELECT RAISE(ABORT, 'command journal is append-only'); END;
CREATE TRIGGER trg_command_journal_no_delete BEFORE DELETE ON command_journal BEGIN SELECT RAISE(ABORT, 'command journal is append-only'); END;
CREATE TRIGGER trg_audit_log_no_update BEFORE UPDATE ON audit_log BEGIN SELECT RAISE(ABORT, 'audit log is append-only'); END;
CREATE TRIGGER trg_audit_log_no_delete BEFORE DELETE ON audit_log BEGIN SELECT RAISE(ABORT, 'audit log is append-only'); END;
CREATE TRIGGER trg_analysis_completed_no_update
BEFORE UPDATE OF run_id, revision_no, parent_analysis_revision_id, analysis_recipe_revision_id,
                 pipeline_revision, application_build, deterministic_input_sha256, status,
                 started_utc, completed_utc, failure_code, created_utc, created_by
ON analysis_revision
WHEN OLD.status IN ('Completed', 'Failed', 'Superseded')
BEGIN SELECT RAISE(ABORT, 'published analysis revision is immutable'); END;
CREATE TRIGGER trg_analysis_completed_no_delete BEFORE DELETE ON analysis_revision WHEN OLD.status IN ('Completed', 'Failed', 'Superseded') BEGIN SELECT RAISE(ABORT, 'published analysis revision is immutable'); END;
CREATE TRIGGER trg_calibration_published_no_update
BEFORE UPDATE OF sensor_id, revision_no, predecessor_revision_id, procedure_reference, standard_reference,
                 calibrated_utc, valid_from_utc, valid_to_utc, input_quantity_kind, input_unit_code,
                 output_quantity_kind, output_unit_code, interpolation_rule, uncertainty_payload,
                 restriction_payload, certificate_artifact_id, canonical_payload_sha256, performed_by
ON calibration_revision WHEN OLD.status <> 'Draft'
BEGIN SELECT RAISE(ABORT, 'published calibration content is immutable'); END;
CREATE TRIGGER trg_calibration_published_no_delete BEFORE DELETE ON calibration_revision WHEN OLD.status <> 'Draft' BEGIN SELECT RAISE(ABORT, 'published calibration revision is immutable'); END;
CREATE TRIGGER trg_method_released_no_update
BEFORE UPDATE OF test_method_id, revision_no, predecessor_revision_id, standard_code, standard_revision,
                 analysis_recipe_revision_id, default_chart_profile_revision_id,
                 default_report_template_revision_id, canonical_payload, canonical_payload_sha256,
                 created_utc, created_by
ON test_method_revision WHEN OLD.lifecycle_status IN ('Released', 'Retired')
BEGIN SELECT RAISE(ABORT, 'released method content is immutable'); END;
CREATE TRIGGER trg_method_released_no_delete BEFORE DELETE ON test_method_revision WHEN OLD.lifecycle_status IN ('Released', 'Retired') BEGIN SELECT RAISE(ABORT, 'released method revision is immutable'); END;
CREATE TRIGGER trg_analysis_recipe_released_no_update
BEFORE UPDATE OF analysis_recipe_id, revision_no, predecessor_revision_id, schema_version,
                 definition_payload, canonical_payload_sha256, created_utc, created_by
ON analysis_recipe_revision WHEN OLD.status IN ('Released', 'Retired')
BEGIN SELECT RAISE(ABORT, 'released analysis recipe content is immutable'); END;
CREATE TRIGGER trg_analysis_recipe_released_no_delete BEFORE DELETE ON analysis_recipe_revision WHEN OLD.status IN ('Released', 'Retired') BEGIN SELECT RAISE(ABORT, 'released analysis recipe is immutable'); END;
CREATE TRIGGER trg_specimen_released_no_update
BEFORE UPDATE OF specimen_id, revision_no, predecessor_revision_id, geometry_type, geometry_payload,
                 canonical_payload_sha256, created_utc, created_by
ON specimen_revision WHEN OLD.status IN ('Released', 'Retired')
BEGIN SELECT RAISE(ABORT, 'released specimen content is immutable'); END;
CREATE TRIGGER trg_specimen_released_no_delete BEFORE DELETE ON specimen_revision WHEN OLD.status IN ('Released', 'Retired') BEGIN SELECT RAISE(ABORT, 'released specimen revision is immutable'); END;
CREATE TRIGGER trg_material_released_no_update
BEFORE UPDATE OF material_id, revision_no, predecessor_revision_id, property_payload,
                 canonical_payload_sha256, created_utc, created_by
ON material_revision WHEN OLD.status IN ('Released', 'Retired')
BEGIN SELECT RAISE(ABORT, 'released material content is immutable'); END;
CREATE TRIGGER trg_material_released_no_delete BEFORE DELETE ON material_revision WHEN OLD.status IN ('Released', 'Retired') BEGIN SELECT RAISE(ABORT, 'released material revision is immutable'); END;
CREATE TRIGGER trg_acceptance_released_no_update
BEFORE UPDATE OF acceptance_profile_id, revision_no, predecessor_revision_id, standard_reference,
                 decision_rule_code, uncertainty_policy, risk_policy, canonical_payload_sha256,
                 created_utc, created_by
ON acceptance_profile_revision WHEN OLD.status IN ('Released', 'Retired')
BEGIN SELECT RAISE(ABORT, 'released acceptance profile content is immutable'); END;
CREATE TRIGGER trg_acceptance_released_no_delete BEFORE DELETE ON acceptance_profile_revision WHEN OLD.status IN ('Released', 'Retired') BEGIN SELECT RAISE(ABORT, 'released acceptance profile is immutable'); END;
CREATE TRIGGER trg_calculated_property_no_update BEFORE UPDATE ON calculated_property BEGIN SELECT RAISE(ABORT, 'calculated properties are immutable'); END;
CREATE TRIGGER trg_calculated_property_no_delete BEFORE DELETE ON calculated_property BEGIN SELECT RAISE(ABORT, 'calculated properties are immutable'); END;
CREATE TRIGGER trg_detected_event_no_update BEFORE UPDATE ON detected_event BEGIN SELECT RAISE(ABORT, 'detected events are immutable'); END;
CREATE TRIGGER trg_detected_event_no_delete BEFORE DELETE ON detected_event BEGIN SELECT RAISE(ABORT, 'detected events are immutable'); END;
CREATE TRIGGER trg_acceptance_evaluation_no_update BEFORE UPDATE ON acceptance_evaluation BEGIN SELECT RAISE(ABORT, 'acceptance evaluations are immutable'); END;
CREATE TRIGGER trg_acceptance_evaluation_no_delete BEFORE DELETE ON acceptance_evaluation BEGIN SELECT RAISE(ABORT, 'acceptance evaluations are immutable'); END;
CREATE TRIGGER trg_derived_series_no_update BEFORE UPDATE ON derived_series_chunk BEGIN SELECT RAISE(ABORT, 'derived series chunks are immutable'); END;
CREATE TRIGGER trg_derived_series_no_delete BEFORE DELETE ON derived_series_chunk BEGIN SELECT RAISE(ABORT, 'derived series chunks are immutable'); END;
CREATE TRIGGER trg_sample_gap_no_update BEFORE UPDATE ON sample_gap BEGIN SELECT RAISE(ABORT, 'sample gaps are immutable evidence'); END;
CREATE TRIGGER trg_sample_gap_no_delete BEFORE DELETE ON sample_gap BEGIN SELECT RAISE(ABORT, 'sample gaps are immutable evidence'); END;
CREATE TRIGGER trg_zero_tare_no_update BEFORE UPDATE ON zero_tare_revision BEGIN SELECT RAISE(ABORT, 'zero/tare revisions are immutable'); END;
CREATE TRIGGER trg_zero_tare_no_delete BEFORE DELETE ON zero_tare_revision BEGIN SELECT RAISE(ABORT, 'zero/tare revisions are immutable'); END;
CREATE TRIGGER trg_acceptance_rule_result_no_update BEFORE UPDATE ON acceptance_rule_result BEGIN SELECT RAISE(ABORT, 'acceptance rule results are immutable'); END;
CREATE TRIGGER trg_acceptance_rule_result_no_delete BEFORE DELETE ON acceptance_rule_result BEGIN SELECT RAISE(ABORT, 'acceptance rule results are immutable'); END;
CREATE TRIGGER trg_report_record_no_update BEFORE UPDATE ON report_record BEGIN SELECT RAISE(ABORT, 'report records are immutable'); END;
CREATE TRIGGER trg_report_record_no_delete BEFORE DELETE ON report_record BEGIN SELECT RAISE(ABORT, 'report records are immutable'); END;

-- Released-parent child guards prevent mutation through normalized child tables.
CREATE TRIGGER trg_method_phase_released_insert BEFORE INSERT ON method_phase
WHEN EXISTS (SELECT 1 FROM test_method_revision r WHERE r.test_method_revision_id = NEW.test_method_revision_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_method_phase_released_update BEFORE UPDATE ON method_phase
WHEN EXISTS (SELECT 1 FROM test_method_revision r WHERE r.test_method_revision_id = OLD.test_method_revision_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_method_phase_released_delete BEFORE DELETE ON method_phase
WHEN EXISTS (SELECT 1 FROM test_method_revision r WHERE r.test_method_revision_id = OLD.test_method_revision_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_method_segment_released_insert BEFORE INSERT ON method_segment
WHEN EXISTS (SELECT 1 FROM method_phase p JOIN test_method_revision r ON r.test_method_revision_id=p.test_method_revision_id WHERE p.method_phase_id=NEW.method_phase_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_method_segment_released_update BEFORE UPDATE ON method_segment
WHEN EXISTS (SELECT 1 FROM method_phase p JOIN test_method_revision r ON r.test_method_revision_id=p.test_method_revision_id WHERE p.method_phase_id=OLD.method_phase_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_method_segment_released_delete BEFORE DELETE ON method_segment
WHEN EXISTS (SELECT 1 FROM method_phase p JOIN test_method_revision r ON r.test_method_revision_id=p.test_method_revision_id WHERE p.method_phase_id=OLD.method_phase_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_method_requirement_released_insert BEFORE INSERT ON method_channel_requirement
WHEN EXISTS (SELECT 1 FROM test_method_revision r WHERE r.test_method_revision_id=NEW.test_method_revision_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_method_requirement_released_update BEFORE UPDATE ON method_channel_requirement
WHEN EXISTS (SELECT 1 FROM test_method_revision r WHERE r.test_method_revision_id=OLD.test_method_revision_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_method_requirement_released_delete BEFORE DELETE ON method_channel_requirement
WHEN EXISTS (SELECT 1 FROM test_method_revision r WHERE r.test_method_revision_id=OLD.test_method_revision_id AND r.lifecycle_status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate children of a released method'); END;
CREATE TRIGGER trg_calibration_point_published_insert BEFORE INSERT ON calibration_point
WHEN EXISTS (SELECT 1 FROM calibration_revision r WHERE r.calibration_revision_id=NEW.calibration_revision_id AND r.status <> 'Draft')
BEGIN SELECT RAISE(ABORT, 'cannot mutate points of a published calibration'); END;
CREATE TRIGGER trg_calibration_point_published_update BEFORE UPDATE ON calibration_point
WHEN EXISTS (SELECT 1 FROM calibration_revision r WHERE r.calibration_revision_id=OLD.calibration_revision_id AND r.status <> 'Draft')
BEGIN SELECT RAISE(ABORT, 'cannot mutate points of a published calibration'); END;
CREATE TRIGGER trg_calibration_point_published_delete BEFORE DELETE ON calibration_point
WHEN EXISTS (SELECT 1 FROM calibration_revision r WHERE r.calibration_revision_id=OLD.calibration_revision_id AND r.status <> 'Draft')
BEGIN SELECT RAISE(ABORT, 'cannot mutate points of a published calibration'); END;
CREATE TRIGGER trg_acceptance_rule_released_insert BEFORE INSERT ON acceptance_rule
WHEN EXISTS (SELECT 1 FROM acceptance_profile_revision r WHERE r.acceptance_profile_revision_id=NEW.acceptance_profile_revision_id AND r.status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate rules of a released acceptance profile'); END;
CREATE TRIGGER trg_acceptance_rule_released_update BEFORE UPDATE ON acceptance_rule
WHEN EXISTS (SELECT 1 FROM acceptance_profile_revision r WHERE r.acceptance_profile_revision_id=OLD.acceptance_profile_revision_id AND r.status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate rules of a released acceptance profile'); END;
CREATE TRIGGER trg_acceptance_rule_released_delete BEFORE DELETE ON acceptance_rule
WHEN EXISTS (SELECT 1 FROM acceptance_profile_revision r WHERE r.acceptance_profile_revision_id=OLD.acceptance_profile_revision_id AND r.status IN ('Released', 'Retired'))
BEGIN SELECT RAISE(ABORT, 'cannot mutate rules of a released acceptance profile'); END;

PRAGMA user_version = 1;

COMMIT;
