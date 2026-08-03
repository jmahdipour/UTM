---
project: Universal Testing Machine (UTS)
document: APPLICATION_COMMAND_QUERY_CATALOG
version: 0.1
status: FROZEN
governing_edr: EDR-0008
last_revision: 2026-08-03
---

# Application Command and Query Catalog

## Rules

- IDs and payload schema versions are stable contracts.
- `P` means a permission is required; `None` means the command is intentionally permissionless.
- Every command still passes state, validation, concurrency and Safety guards.
- Stop/JOG End are not denied by role.
- Commands marked `Job` return an OperationId and finish asynchronously.
- Internal transitions are callable only by an Application coordinator, never directly by WPF.

## Reception, Order and Specimen

| ID | v | Command | Permission | Principal result |
|---|---:|---|---|---|
| `ORD.CREATE` | 1 | Create an Order-rooted reception record and customer snapshot | `orders.edit` | OrderId, revision |
| `ORD.UPDATE` | 1 | Update mutable Order intake data with ExpectedRevision | `orders.edit` | new revision |
| `ORD.RETIRE` | 1 | Tombstone an unused/closed Order with reason | `orders.edit` | retirement audit |
| `SPC.CREATE_DRAFT` | 1 | Create Draft specimen under one Order | `orders.edit` | SpecimenId |
| `SPC.REVISE_DRAFT` | 1 | Create/update a Draft specimen revision | `orders.edit` | SpecimenRevisionId |
| `SPC.RETIRE_DRAFT` | 1 | Tombstone an untested Draft specimen | `orders.edit` | retirement audit |
| `SPC.MARK_COMPLETED_FROM_RUN` | 1 | Internal transition after first valid terminal test evidence | Internal | Completed lifecycle event |

Queries: `ORD.GET`, `ORD.SEARCH`, `ORD.GET_WORKSPACE`, `SPC.GET_HISTORY`, `SPC.GET_RUNS`.

Customer information remains an Order-owned snapshot. No command creates Customer as an aggregate that owns Orders.

## Test Method

| ID | v | Command | Permission | Principal result |
|---|---:|---|---|---|
| `MTH.CREATE_DRAFT` | 1 | Create method aggregate and Draft revision | `methods.editDraft` | MethodRevisionId |
| `MTH.REVISE_DRAFT` | 1 | Edit phases/segments/requirements using ExpectedRevision | `methods.editDraft` | new Draft revision/hash |
| `MTH.VALIDATE` | 1 | Run deterministic release validation | `methods.validate` | validation report |
| `MTH.RELEASE` | 1 | Release the exact validated hash | `methods.release` | immutable Released revision |
| `MTH.CREATE_VERSION` | 1 | Fork Released/Retired revision into a new Draft | `methods.editDraft` | lineage |
| `MTH.RETIRE` | 1 | Retire Released revision without deleting history | `methods.retire` | retirement event |

Queries: `MTH.GET`, `MTH.SEARCH`, `MTH.GET_REVISION`, `MTH.GET_VALIDATION`, `MTH.GET_DEPLOYMENT_READINESS`.

Material, Acceptance, physical calibration and safety configuration are prohibited in method payloads.

## Calibration and measurement configuration

| ID | v | Command | Permission | Principal result |
|---|---:|---|---|---|
| `CAL.CREATE_DRAFT` | 1 | Create calibration revision and points | `calibration.perform` | Draft revision |
| `CAL.SUBMIT_REVIEW` | 1 | Freeze Draft content for review | `calibration.perform` | reviewed hash |
| `CAL.APPROVE` | 1 | Approve applicable revision under separation policy | `calibration.approve` | Approved/Active revision |
| `CAL.REVOKE` | 1 | Revoke with reason and evidence | `calibration.revoke` | revocation lineage |
| `CAL.APPLY_ZERO_TARE` | 1 | Create reversible zero/tare revision | `measurements.zeroTare` | ZeroTareRevisionId |
| `CAL.SELECT_COMPLIANCE` | 1 | Select/disable correction for preparation snapshot | `calibration.perform` | selection revision |

Queries: `CAL.GET_SENSOR`, `CAL.GET_HISTORY`, `CAL.GET_READINESS`, `CAL.SEARCH_INVENTORY`, `CAL.GET_DIAGNOSTICS`.

No command silently falls back from Extension to Stroke or updates raw/calibration data in place.

## Machine setup and JOG

| ID | v | Command | Permission | State/notes |
|---|---:|---|---|---|
| `MAC.CONNECT` | 1 | Connect/initialize | `machine.connect` | Disconnected only; no motion |
| `MAC.ENTER_SETUP` | 1 | Enter Setup | `machine.enterSetup` | Ready/no active run |
| `MAC.EXIT_SETUP` | 1 | Exit Setup | `machine.enterSetup` | Setup; stationary proof |
| `MAC.BEGIN_JOG` | 1 | Begin renewable hold-to-run lease | `machine.jog` | Setup; typed 0.1/1/10 mm/min; fresh interlocks |
| `MAC.RENEW_JOG` | 1 | Renew same lease with input proof | `machine.jog` | active lease only |
| `MAC.END_JOG` | 1 | Stop/close lease | None | any connected state; idempotent/priority |
| `MAC.ACK_FAULT` | 1 | Record authorized acknowledgement | configured permission | cause-clear and stationary proof |
| `MAC.ACK_ESTOP_RESET` | 1 | Acknowledge observed physical reset | configured permission | never emulates physical reset |

Queries: `MAC.GET_STATUS`, `MAC.GET_CAPABILITIES`, `MAC.GET_INTERLOCKS`, `MAC.GET_COMMAND_AVAILABILITY`, `MAC.GET_ACTIVE_JOG_LEASE`.

## Test Run

| ID | v | Command | Permission | Principal result |
|---|---:|---|---|---|
| `RUN.PREPARE` | 1 | Create Preparing run and resolve selected revisions | `machine.arm` | RunId/readiness report |
| `RUN.UPDATE_PREPARATION` | 1 | Change unresolved selections before snapshot | `machine.arm` | preparation revision |
| `RUN.CREATE_SNAPSHOT` | 1 | Persist canonical snapshot and all channel bindings | `machine.arm` | SnapshotId/hash |
| `RUN.ARM` | 1 | Arm exact persisted snapshot | `machine.arm` | guarded machine/run transition |
| `RUN.START` | 1 | Start first segment after final guard | `machine.start` | accepted operation |
| `RUN.HOLD` | 1 | Request operator pause | `machine.hold` | Running → Paused |
| `RUN.RESUME` | 1 | Resume after all guards re-evaluate | `machine.resume` | Paused → Running |
| `RUN.STOP` | 1 | Request controlled/protective stop as assessed | None | idempotent priority operation |
| `RUN.CANCEL_PREPARATION` | 1 | Cancel before Arm | `machine.arm` | Cancelled EndReason |
| `RUN.RETEST` | 1 | Create a new Run linked to historical run context | `results.retest` | new RunId; no copied raw data |
| `RUN.FINALIZE_RAW` | 1 | Internal drain/finalize raw evidence | Internal | final sequence/count |
| `RUN.COMPLETE` | 1 | Internal normal terminal transaction | Internal | Completed + typed EndReason |
| `RUN.FAULT` | 1 | Internal fault terminal transaction | Internal | Faulted + evidence |

Queries: `RUN.GET`, `RUN.GET_PREPARATION`, `RUN.GET_SNAPSHOT_REVIEW`, `RUN.GET_LIVE`, `RUN.GET_STATE_JOURNAL`, `RUN.GET_COMMAND_JOURNAL`, `RUN.SEARCH_HISTORY`.

## Analysis, markers and acceptance

| ID | v | Command | Permission | Principal result |
|---|---:|---|---|---|
| `ANA.START_INITIAL` | 1 | Analyze finalized run with snapshotted recipe | Internal | Job/AnalysisRevisionId |
| `ANA.REANALYZE` | 1 | Create new analysis lineage from controlled raw replay | `analysis.reanalyze` | Job/new AnalysisRevisionId |
| `ANA.ADD_MARKER` | 1 | Add audited operator marker with sample provenance | `analysis.override` | new analysis lineage |
| `ANA.APPLY_OVERRIDE` | 1 | Preserve original and create reasoned replacement | `analysis.override` | new derived result/revision |
| `ANA.RESET_OVERRIDE` | 1 | Reset by creating a lineage event; never delete | `analysis.resetOverride` | restored-current lineage |
| `ACC.EVALUATE` | 1 | Evaluate one analysis revision against one Acceptance revision | configured analysis permission | immutable evaluation |
| `RES.INVALIDATE` | 1 | Mark result status invalid with reason; retain evidence | `results.invalidate` | audit/status revision |

Queries: `ANA.GET_OPERATION`, `ANA.GET_REVISION`, `ANA.GET_LINEAGE`, `ANA.GET_SERIES_WINDOW`, `ANA.GET_EVENTS`, `ANA.GET_PROPERTIES`, `ACC.GET_EVALUATION`.

`ANA.REANALYZE` and all override commands have no machine/driver port. Series-window queries are bounded and never return display data as analysis input.

## Settings and units

| ID | v | Command | Permission | Principal result |
|---|---:|---|---|---|
| `CFG.CREATE_DRAFT` | 1 | Create versioned configuration change | `settings.edit` | Draft revision |
| `CFG.ACTIVATE` | 1 | Activate reviewed configuration in stationary non-running state | `settings.edit` | Active revision/reinitialize flag |
| `CFG.REVOKE` | 1 | Revoke configuration with reason | `settings.edit` | predecessor restored only by new revision |
| `CFG.SET_OUTPUT_UNITS` | 1 | Activate display/export unit profile | `settings.edit` | presentation revision only |

Queries: `CFG.GET_EFFECTIVE`, `CFG.GET_HISTORY`, `CFG.GET_OUTPUT_UNITS`, `UNIT.GET_CATALOG`, `UNIT.GET_CONVERSION_PROVENANCE`.

Safety-impacting configuration cannot be weakened by Test Method and may require reinitialization. Output-unit changes never change canonical results.

## Import

| ID | v | Command | Permission | Principal result |
|---|---:|---|---|---|
| `IMP.IMPORT_RUN` | 1 | Import preserved artifact using explicit versioned profile | configured import permission | Job/ImportRecordId |
| `IMP.RETRY` | 1 | Create a new import attempt after corrected declaration/profile | configured import permission | new attempt/lineage |

Queries: `IMP.GET_OPERATION`, `IMP.GET_DIAGNOSTICS`, `IMP.GET_PROVENANCE`.

Unknown/incompatible source units are rejected. Numeric magnitude is never used to guess a unit. For device force in `kgf`, source bytes and unit remain preserved while analysis normalizes to N.

## Report and export

| ID | v | Command | Permission | Principal result |
|---|---:|---|---|---|
| `RPT.GENERATE` | 1 | Generate from immutable run/analysis/acceptance/template revisions | `reports.generate` | Job/ReportRecordId |
| `RPT.EXPORT` | 1 | Export immutable result/report under output profile | `reports.export` | Job/ArtifactId |
| `RPT.CREATE_TEMPLATE_DRAFT` | 1 | Create template Draft | `reports.design` | Draft revision |
| `RPT.RELEASE_TEMPLATE` | 1 | Release validated immutable template | `reports.design` | Released revision |

Queries: `RPT.GET_OPERATION`, `RPT.GET_RECORD`, `RPT.SEARCH`, `RPT.GET_TEMPLATE`, `RPT.GET_AUDIT_REFERENCES`.

Report generation cannot calculate directly from raw measurements and must name every immutable input revision/hash.

## Audit and diagnostics

Queries: `AUD.SEARCH` (`audit.view`), `AUD.GET_CORRELATION` (`audit.view`), `SYS.GET_HEALTH` (authorized diagnostics), and `SYS.GET_BUILD_INFO`.

Audit projections redact credentials/secrets and expose stable codes plus governed details. Diagnostics never provide a hidden motion path.
