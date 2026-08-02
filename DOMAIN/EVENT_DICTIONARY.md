---
project: Universal Testing Machine (UTS)
document: EVENT_DICTIONARY
version: 0.2
status: FROZEN
classification: DOMAIN
governing_edr:
  - EDR-0001
  - EDR-0003
  - EDR-0004
  - EDR-0005
---

# Event Dictionary

## Envelope

Every domain/integration event contains:

- `EventId`;
- `EventType`;
- `SchemaVersion`;
- `OccurredAtUtc`;
- monotonic occurrence time when run-related;
- `CorrelationId` and optional `CausationId`;
- optional `RunId`, `MachineId`, `SegmentId`, `SensorId`;
- source component;
- payload;
- quality/provenance metadata.

Event names describe completed facts in past tense. Payload changes require a new schema version. Events are immutable and append-only; corrections are new events.

High-rate samples are not domain events.

## Machine and command events

| Event | Minimum meaning |
|---|---|
| `MachineConnectionEstablished` | Trusted driver session established |
| `MachineConnectionLost` | Trusted session lost/stale |
| `MachineInitializationCompleted` | Safe handshake completed |
| `MachineStateChanged` | Authoritative prior/next machine state and reason |
| `MachineCommandAccepted` | Guarded command accepted |
| `MachineCommandRejected` | Command denied with stable reason code |
| `MachineCommandFailed` | Accepted command failed/was not acknowledged |
| `MotionStarted` | Verified motion began |
| `MotionStopped` | Verified stationary state reached |
| `JogStarted` | Setup JOG began with direction/speed |
| `JogStopped` | JOG stopped with reason |
| `FaultRaised` | Typed latched fault raised |
| `FaultCauseCleared` | Physical/logical cause no longer observed |
| `FaultAcknowledged` | Authorized acknowledgement recorded |
| `EmergencyStopActivated` | Physical safety-chain E-stop observed |
| `EmergencyStopResetObserved` | Physical reset observed; no motion implied |
| `InterlockChanged` | Named interlock changed with snapshot provenance |

## Test Run events

| Event | Minimum meaning |
|---|---|
| `RunPreparationStarted` | Run assembly began |
| `RunConfigurationSnapshotted` | Immutable configuration persisted |
| `RunArmed` | Machine/run armed |
| `RunStarted` | First execution segment accepted |
| `SegmentStarted` | Segment revision and acquisition profile active |
| `SamplingProfileChanged` | Explicit sampling/recording boundary |
| `SegmentCompleted` | Transition condition satisfied |
| `RunPaused` | Operator Hold accepted |
| `RunResumed` | Guarded resume accepted |
| `RunStopRequested` | Stop intent and requester recorded |
| `RunCompleted` | Normal method completion with EndReason |
| `RunAborted` | Non-normal operator/process termination |
| `RunFaulted` | Fault terminated the run |
| `RunCancelled` | Preparation cancelled before arming |

## Measurement-quality events

| Event | Minimum meaning |
|---|---|
| `SampleGapDetected` | Missing sequence range |
| `AcquisitionOverflowDetected` | Buffer overflow/drop evidence |
| `MeasurementBecameStale` | Required value exceeded freshness policy |
| `SensorSaturationDetected` | Sensor/raw channel saturated |
| `MeasurementOverRangeDetected` | Engineering/calibrated range exceeded |
| `SensorMismatchDetected` | Installed/observed sensor conflicts with binding |
| `CalibrationBecameInvalid` | Required revision expired/revoked/not applicable |
| `ZeroTareApplied` | Versioned zero/tare correction created |
| `ComplianceCorrectionApplied` | Versioned correction selected |

## Analysis and result events

| Event | Provenance requirement |
|---|---|
| `BreakDetected` | Source sequence/range, detector/rule and pipeline revision |
| `YieldDetected` | Source sequence/range, method/algorithm and confidence |
| `MaximumLoadDetected` | Source sequence and calculated value/unit |
| `OperatorMarkerAdded` | Source sequence/time, user and note |
| `AnalysisStarted` | Raw/run snapshot and pipeline revision |
| `AnalysisCompleted` | Output revision and deterministic-input lineage |
| `AnalysisFailed` | Stable reason and incomplete-output handling |
| `ManualOverrideApplied` | Original result, replacement, user and reason |
| `ManualOverrideReset` | Override removed; original revision restored |
| `AcceptanceEvaluated` | Property revision, Acceptance Profile revision and verdict |
| `ReportGenerated` | Report template/input revision and output identity |

## Severity and handling

Events may carry `Information`, `Warning`, `ProtectiveStop`, `Fault` or `Emergency` severity. Severity does not decide the safety reaction by itself; EDR-0004 and the authoritative state/interlock policy do.

Consumers must be idempotent by EventId. Ordering is guaranteed only within an explicitly defined aggregate/run stream; consumers must not infer global ordering from UTC timestamps.

## Open payload work

Concrete VB.NET DTOs and persistence serialization are produced with the Solution scaffold. Event schema changes will be versioned and contract-tested.
