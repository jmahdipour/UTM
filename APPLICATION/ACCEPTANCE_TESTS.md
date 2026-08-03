---
project: Universal Testing Machine (UTS)
document: APPLICATION_CONTRACT_ACCEPTANCE_TESTS
version: 0.1
status: FROZEN
governing_edr: EDR-0008
last_revision: 2026-08-03
---

# Application/API Acceptance Tests

## Result legend

- `PASS-STATIC`: verified against this Frozen document package.
- `PENDING-CODE`: executable test must be added to the VB.NET Solution.
- `PENDING-HARDWARE`: simulator can cover contract behavior, but physical result needs verified hardware/commissioning evidence.

| ID | Acceptance scenario | Expected evidence | Current result |
|---|---|---|---|
| `AT-APP-001` | Inspect ports and event catalog | samples use stream ports; domain events contain semantic facts only | PASS-STATIC / PENDING-CODE |
| `AT-APP-002` | Attempt raw access from Report/UI/Property handler | compile/reference boundary or architecture test rejects dependency | PASS-STATIC / PENDING-CODE |
| `AT-APP-003` | Block WPF dispatcher while acquiring | bounded acquisition persists without UI progress | PASS-STATIC / PENDING-CODE |
| `AT-APP-004` | Feed decimated chart data toward analysis | type/reference boundary rejects it | PASS-STATIC / PENDING-CODE |
| `AT-APP-005` | Edit Released method | rejected; new Draft lineage required | PASS-STATIC / PENDING-CODE |
| `AT-APP-006` | Arm unsupported control mode/preset | `DEVICE.CAPABILITY_UNSUPPORTED`; no driver motion command | PASS-STATIC / PENDING-CODE |
| `AT-APP-007` | Arm without exact snapshot/bindings | `STATE.SNAPSHOT_REQUIRED`; no Armed transition | PASS-STATIC / PENDING-CODE |
| `AT-APP-008` | Bypass coordinator from UI/driver | compile/reference architecture test fails | PASS-STATIC / PENDING-CODE |
| `AT-APP-009` | Exercise command outcome paths | only Accepted/Rejected/Failed/TimedOut plus stable reason | PASS-STATIC / PENDING-CODE |
| `AT-APP-010` | Repeat JOG End and Stop | one safe stop effect; repeat returns recorded/idempotent outcome | PASS-STATIC / PENDING-CODE |
| `AT-APP-011` | Accept/reject/fail/timeout motion | journal contains correlation, actor, states, interlock and acknowledgement evidence | PASS-STATIC / PENDING-CODE |
| `AT-APP-012` | Terminate application during physical safety-chain test | E-stop/final protection works independently of PC | PASS-STATIC / PENDING-HARDWARE |
| `AT-APP-013` | Use stale/unknown interlock projection | command handler obtains fresh snapshot and rejects unsafe state | PASS-STATIC / PENDING-CODE |
| `AT-APP-014` | Release input/lose focus/heartbeat/interlock during JOG | End/lease expiry requests stop; no auto-resume | PASS-STATIC / PENDING-HARDWARE |
| `AT-APP-015` | Search contract for invented PLC/timeout numbers | none; exact values remain hardware-blocked/versioned | PASS-STATIC / PENDING-HARDWARE |
| `AT-APP-016` | Bind logical channel directly to display name | contract requires channel→installation→sensor→calibration | PASS-STATIC / PENDING-CODE |
| `AT-APP-017` | Process measurement frame | sequence/time/unit/raw reference/quality/revisions retained | PASS-STATIC / PENDING-CODE |
| `AT-APP-018` | Extension invalid while Stroke valid | no fallback; explicit stable rejection/termination | PASS-STATIC / PENDING-CODE |
| `AT-APP-019` | Calibration expired/revoked/mismatched | Arm rejected with metrology reason | PASS-STATIC / PENDING-CODE |
| `AT-APP-020` | Inspect WPF use-case surface | only Application commands/queries/read models | PASS-STATIC / PENDING-CODE |
| `AT-APP-021` | Submit Re-Analyze/report/import | Accepted OperationId then durable status/event | PASS-STATIC / PENDING-CODE |
| `AT-APP-022` | Send disabled UI command through alternate caller | handler repeats authorization/state/Safety checks | PASS-STATIC / PENDING-CODE |
| `AT-APP-023` | Rename role but keep permission bundle | authorization behavior unchanged | PASS-STATIC / PENDING-CODE |
| `AT-APP-024` | Scan Presentation references/source | no SQLite/PLC/vendor/register references | PASS-STATIC / PENDING-CODE |
| `AT-APP-025` | Restart after committed state | SQLite journal/event reconstructs authority; no UI flag authority | PASS-STATIC / PENDING-CODE |
| `AT-APP-026` | Scan non-Infrastructure projects for SQL/provider types | architecture test fails forbidden dependency | PASS-STATIC / PENDING-CODE |
| `AT-APP-027` | Inject failure between state writes | complete atomic transition or full rollback | PASS-STATIC / PENDING-CODE |
| `AT-APP-028` | Import `100 kgf` | source stays 100 kgf; canonical result is 980.665 N with conversion revision | PASS-STATIC / PENDING-CODE |
| `AT-APP-029` | Slow report/UI readers during acquisition | one writer and bounded chunks; no silent drop/deadlock | PASS-STATIC / PENDING-CODE |
| `AT-APP-030` | Append/correct event | correction is new versioned immutable event | PASS-STATIC / PENDING-CODE |
| `AT-APP-031` | Deliver same EventId twice | consumer effect occurs once/idempotently | PASS-STATIC / PENDING-CODE |
| `AT-APP-032` | Re-Test then Re-Analyze | first creates new Run/raw; second new analysis on existing Run | PASS-STATIC / PENDING-CODE |
| `AT-APP-033` | Resolve dependencies for Re-Analyze handler | no machine/driver/coordinator dependency | PASS-STATIC / PENDING-CODE |
| `AT-APP-034` | Repeat same RequestId then change payload | same payload returns prior outcome; changed hash is rejected | PASS-STATIC / PENDING-CODE |
| `AT-APP-035` | Driver acknowledgement timeout/reconnect | TimedOut, lane closed, reconcile, no automatic resend | PASS-STATIC / PENDING-CODE |
| `AT-APP-036` | Cancel caller after Stop accepted | stop remains active; only observation may cancel | PASS-STATIC / PENDING-CODE |
| `AT-APP-037` | Execute every query with write spy | zero writes/events/machine commands | PASS-STATIC / PENDING-CODE |
| `AT-APP-038` | Inspect default process listeners | no HTTP/gRPC/socket/remote motion listener | PASS-STATIC / PENDING-CODE |
| `AT-APP-039` | Throw provider/driver exception containing secret | receipt is redacted stable code + correlation; secure log captures controlled detail | PASS-STATIC / PENDING-CODE |
| `AT-APP-040` | Assembly dependency test | Contracts/Core contain no WPF/SQLite/vendor types | PASS-STATIC / PENDING-CODE |

## Static package result

The accompanying validator checks document presence, Frozen status, catalog identifiers, traceability/test bidirectionality, reason-code syntax, absence of unresolved placeholders, and the explicit remote-listener prohibition. It does not replace executable unit, integration, simulator, fault-injection or commissioning tests.
