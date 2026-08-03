---
project: Universal Testing Machine (UTS)
document: APPLICATION_REQUIREMENTS_TRACEABILITY
version: 0.1
status: FROZEN
governing_edr: EDR-0008
last_revision: 2026-08-03
---

# Application/API Requirements Traceability Matrix

## Status legend

- `DESIGN-PASS`: the Frozen contract package contains an explicit design and static acceptance evidence.
- `IMPLEMENTATION-PENDING`: the design is complete but executable VB.NET proof belongs to the Solution scaffold.
- `HARDWARE-BLOCKED`: the contract is explicit but a numeric/mapping result waits for verified hardware evidence.

No row has an implicit or empty status. `DESIGN-PASS` does not claim that production code exists.

| ID | Requirement | Governing source and line | Contract location | Acceptance | Status |
|---|---|---|---|---|---|
| `APP-001` | Measurement stream and semantic events remain separate | EDR-0001:26 | EDR-0008 “Measurement and event paths” | `AT-APP-001` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-002` | Raw access is limited to acquisition persistence and controlled replay | EDR-0001:64 | Ports “Scientific stream ports” | `AT-APP-002` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-003` | Acquisition never depends on WPF thread | EDR-0001:104 | Contracts “Streaming ports” | `AT-APP-003` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-004` | Display decimation never reaches scientific analysis | EDR-0001:107 | Contracts `ILiveProjectionStream` | `AT-APP-004` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-005` | Released Test Method is immutable/versioned | EDR-0002:28 | Catalog `MTH.*` | `AT-APP-005` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-006` | Unsupported control mode blocks arming without fallback | EDR-0002:124 | Catalog `RUN.ARM`; Reason `DEVICE.CAPABILITY_UNSUPPORTED` | `AT-APP-006` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-007` | Arm requires complete persisted snapshot | EDR-0002:226-235; EDR-0007:72 | Catalog `RUN.CREATE_SNAPSHOT`/`RUN.ARM` | `AT-APP-007` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-008` | Only Application state-machine services accept commands/transitions | EDR-0003:23 | EDR-0008 “Machine/run orchestration” | `AT-APP-008` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-009` | Machine command outcomes use Accepted/Rejected/Failed/TimedOut | EDR-0003:102-107 | EDR-0008 “Command contract” | `AT-APP-009` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-010` | JOG Stop is available/idempotent | EDR-0003:118; EDR-0006:111 | Catalog `MAC.END_JOG` | `AT-APP-010` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-011` | Motion commands and transitions are correlated/audited | EDR-0003:147 | Contracts “Transaction boundaries” | `AT-APP-011` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-012` | PC/WPF is not the sole safety layer | EDR-0004:22 | EDR-0008 status/dependency boundary | `AT-APP-012` | DESIGN-PASS / HARDWARE-BLOCKED |
| `APP-013` | Each command guard uses immutable fresh InterlockSnapshot | EDR-0004:78-95 | command pipeline; `ISafetySupervisor` | `AT-APP-013` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-014` | JOG ends on release/focus/heartbeat/state/interlock loss | EDR-0004:130 | EDR-0008 “Machine/run orchestration” | `AT-APP-014` | DESIGN-PASS / HARDWARE-BLOCKED |
| `APP-015` | Exact JOG timeout/mapping is not invented | EDR-0004:177-191 | JOG lease contract | `AT-APP-015` | DESIGN-PASS / HARDWARE-BLOCKED |
| `APP-016` | Logical channel/sensor/installation/calibration/binding remain separate | EDR-0005:26 | Catalog CAL and run snapshot contracts | `AT-APP-016` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-017` | Validated values retain sequence/unit/quality/revision provenance | EDR-0005:129 | streaming ports and typed quantity | `AT-APP-017` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-018` | No implicit Extension-to-Stroke fallback | EDR-0005:158 | Reason `METROLOGY.EXTENSION_SOURCE_REQUIRED` | `AT-APP-018` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-019` | All required bindings/calibrations exist before Arm | EDR-0005:170-180 | `RUN.CREATE_SNAPSHOT`, `RUN.ARM` | `AT-APP-019` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-020` | UI requests commands/renders read models only | EDR-0006:30 | dependency direction/read models | `AT-APP-020` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-021` | Long-running safe actions are asynchronous/cancellable | EDR-0006:36 | EDR-0008 “Long-running work” | `AT-APP-021` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-022` | Handler repeats checks; CanRequest is usability only | EDR-0006:92 | processing pipeline | `AT-APP-022` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-023` | Permission identifiers, not role-name strings | EDR-0006:96 | authorization ports/catalog | `AT-APP-023` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-024` | No ViewModel writes PLC/register | EDR-0006:136 | project references/hardware ports | `AT-APP-024` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-025` | SQLite is the installation system of record | EDR-0007:28 | transaction/publication contract | `AT-APP-025` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-026` | Application owns transactions; no ad-hoc SQL outside Infrastructure | Database model:23 | project references/persistence session | `AT-APP-026` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-027` | State journal + event + current state update atomically | Database model:82 | Contracts “Transaction boundaries” | `AT-APP-027` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-028` | Canonical force is N; kgf source converts exactly | EDR-0007:109-114 | EDR-0008 “Typed quantities and units” | `AT-APP-028` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-029` | One Application writer; bounded raw transactions | EDR-0007:117-121 | Ports transaction rules | `AT-APP-029` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-030` | Event envelope is immutable/versioned/correlated | Event Dictionary:18-31 | event store/publisher contracts | `AT-APP-030` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-031` | Event consumers are idempotent by EventId | Event Dictionary:110 | post-commit dispatcher | `AT-APP-031` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-032` | Re-Test creates new Run; Re-Analyze creates new analysis lineage | EDR-0007:83-90 | Catalog `RUN.RETEST`/`ANA.REANALYZE` | `AT-APP-032` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-033` | Re-Analyze cannot reach hardware | EDR-0006:161 | Catalog Analysis boundary | `AT-APP-033` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-034` | Mutations use RequestId/idempotency and ExpectedRevision | EDR-0008 | command envelope/concurrency | `AT-APP-034` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-035` | Timeout requires reconciliation and no automatic resend | EDR-0003:107; EDR-0004:150-155 | machine command serialization | `AT-APP-035` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-036` | Stop/protective action cannot be cancelled after acceptance | Safety priority EDR-0004:55-66 | long-running/failure mapping | `AT-APP-036` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-037` | Queries are side-effect free read-only projections | EDR-0008 | Query contract/read models | `AT-APP-037` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-038` | No external listener/remote motion is enabled in v1 | EDR-0008 | External transport gate | `AT-APP-038` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-039` | Exceptions map to stable reason code and redact sensitive data | EDR-0006:142 | Reason catalog/non-disclosure | `AT-APP-039` | DESIGN-PASS / IMPLEMENTATION-PENDING |
| `APP-040` | Application contracts contain no WPF/SQLite/vendor types | GR-014; EDR-0006:30 | project references/core types | `AT-APP-040` | DESIGN-PASS / IMPLEMENTATION-PENDING |

## Persistence object links

The implementation maps Application use cases to the Frozen schema beginning at these exact lines:

- `test_run` 525;
- `run_configuration_snapshot` 545;
- `run_channel_binding` 572;
- `analysis_revision` 660;
- `domain_event` 708;
- `run_state_journal` 817;
- `command_journal` 833;
- `audit_log` 916.

All locations refer to `DATABASE/Migrations/0001_initial.sql` on the governing `main` baseline. Future migrations add new rows to this RTM rather than editing the released migration.
