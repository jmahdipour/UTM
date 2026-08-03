---
project: Universal Testing Machine (UTS)
document: REASON_CODE_CATALOG
version: 0.1
status: FROZEN
governing_edr: EDR-0008
last_revision: 2026-08-03
---

# Stable Reason Code Catalog

## Format and behavior

Codes use uppercase `DOMAIN.SPECIFIC_REASON`. They are stable API data, not localized UI text. Removing or changing a code's meaning is a breaking contract change. New codes may be added without renumbering existing codes.

| Code | Meaning / required handling |
|---|---|
| `SYSTEM.ACCEPTED` | responsibility durably accepted; observe operation/state for completion |
| `SYSTEM.UNEXPECTED_FAILURE` | correlated unexpected failure; no sensitive detail in response |
| `SYSTEM.OPERATION_NOT_CANCELLABLE` | cancellation is unsafe or past commit boundary |
| `AUTH.SESSION_REQUIRED` | no trusted active session |
| `AUTH.SESSION_EXPIRED` | trusted session is no longer valid |
| `AUTH.PERMISSION_DENIED` | required stable permission absent |
| `AUTH.SEPARATION_OF_DUTIES` | actor cannot approve own work under active policy |
| `VALIDATION.REQUIRED_VALUE_MISSING` | required field/input absent |
| `VALIDATION.INVALID_VALUE` | value outside declared non-safety validation contract |
| `VALIDATION.NONFINITE_NUMBER` | NaN or infinity rejected |
| `VALIDATION.QUANTITY_KIND_MISMATCH` | incompatible engineering quantity |
| `VALIDATION.UNIT_REQUIRED` | physical value has no declared unit |
| `VALIDATION.UNSUPPORTED_SCHEMA_VERSION` | payload version is unknown/future |
| `VALIDATION.CANONICAL_HASH_MISMATCH` | reviewed/released canonical content changed |
| `CONCURRENCY.REVISION_CONFLICT` | ExpectedRevision is stale |
| `CONCURRENCY.REQUEST_ID_PAYLOAD_MISMATCH` | same RequestId reused with different payload hash |
| `CONCURRENCY.MACHINE_COMMAND_IN_PROGRESS` | serialized machine lane is occupied by higher/equal priority work |
| `STATE.MACHINE_STATE_INVALID` | authoritative machine state rejects request |
| `STATE.RUN_STATE_INVALID` | authoritative run state rejects request |
| `STATE.ACTIVE_RUN_EXISTS` | mutually exclusive setup/calibration/maintenance request blocked |
| `STATE.SNAPSHOT_REQUIRED` | run snapshot not durably complete |
| `STATE.RECONCILIATION_REQUIRED` | state uncertain after timeout/restart/reconnect |
| `STATE.MOTION_NOT_CONFIRMED_STOPPED` | stationary proof not available |
| `SAFETY.ESTOP_ACTIVE` | physical safety chain reports E-stop active |
| `SAFETY.INTERLOCK_NOT_READY` | one or more required interlocks are false |
| `SAFETY.INTERLOCK_STATUS_STALE` | required snapshot exceeds freshness policy |
| `SAFETY.INTERLOCK_STATUS_UNKNOWN` | required status unavailable/contradictory |
| `SAFETY.DIRECTION_BLOCKED` | requested direction blocked by limit/interlock |
| `SAFETY.PROTECTIVE_STOP_ACTIVE` | protective stop condition is active/latched |
| `DEVICE.DISCONNECTED` | no trusted driver session |
| `DEVICE.INITIALIZING` | handshake/capability reconciliation incomplete |
| `DEVICE.CAPABILITY_UNSUPPORTED` | requested control/sampling/preset unsupported |
| `DEVICE.ACKNOWLEDGEMENT_TIMEOUT` | final command state uncertain; reconcile, never auto-resend |
| `DEVICE.COMMUNICATION_STALE` | heartbeat/status stale |
| `DEVICE.SENSOR_IDENTITY_MISMATCH` | observed identity conflicts with binding |
| `METROLOGY.BINDING_REQUIRED` | required logical channel unresolved |
| `METROLOGY.CALIBRATION_REQUIRED` | applicable Active calibration absent |
| `METROLOGY.CALIBRATION_INVALID` | expired/revoked/inapplicable revision |
| `METROLOGY.RANGE_EXCEEDED` | target/value outside verified usable range |
| `METROLOGY.EXTENSION_SOURCE_REQUIRED` | prohibited implicit Stroke fallback |
| `PERSISTENCE.TRANSACTION_FAILED` | atomic write rolled back |
| `PERSISTENCE.RAW_BUFFER_NOT_FINALIZED` | terminal transition/report/analysis dependency not complete |
| `PERSISTENCE.CHECKSUM_MISMATCH` | stored artifact/payload/migration checksum mismatch |
| `PERSISTENCE.DATABASE_VERSION_UNSUPPORTED` | database newer/incompatible with application |
| `IMPORT.SOURCE_UNIT_REQUIRED` | import did not declare source unit |
| `IMPORT.SOURCE_UNIT_INCOMPATIBLE` | declared unit incompatible with channel quantity |
| `IMPORT.PROFILE_UNSUPPORTED` | import profile/revision not available |
| `IMPORT.SOURCE_HASH_MISMATCH` | preserved artifact differs from declared input |
| `ANALYSIS.RUN_NOT_TERMINAL` | requested historical analysis before allowed state |
| `ANALYSIS.RAW_EVIDENCE_INCOMPLETE` | required chunks/gap finalization unavailable |
| `ANALYSIS.RECIPE_NOT_RELEASED` | immutable released recipe required |
| `ANALYSIS.DETERMINISTIC_INPUT_MISMATCH` | replay inputs do not match recorded hash/lineage |
| `ANALYSIS.FAILED` | durable analysis operation failed with correlated diagnostics |
| `REPORT.INPUT_REVISION_REQUIRED` | immutable analysis/template/acceptance input unresolved |
| `REPORT.GENERATION_FAILED` | durable generation failed; failed report evidence retained |
| `REPORT.ARTIFACT_WRITE_FAILED` | content-addressed artifact not safely committed |

## Non-disclosure rule

The receipt may include the reason code, safe field identifiers and CorrelationId. Stack traces, credentials, connection strings, PLC frames, filesystem roots and unrestricted SQL/provider messages are logging-only data under redaction policy and are never returned to Presentation as reason text.
