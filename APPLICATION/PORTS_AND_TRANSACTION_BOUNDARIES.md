---
project: Universal Testing Machine (UTS)
document: PORTS_AND_TRANSACTION_BOUNDARIES
version: 0.1
status: FROZEN
governing_edr: EDR-0008
last_revision: 2026-08-03
---

# Application Ports and Transaction Boundaries

## Inbound ports

Inbound ports are the handlers for cataloged commands and queries plus explicit read-model subscriptions. WPF receives them from the composition root. No ViewModel resolves repositories or drivers.

## Foundational outbound ports

| Port | Responsibility | Prohibited behavior |
|---|---|---|
| `IActorSessionService` | resolve trusted ActorContext and permission identifiers | trust role/identity supplied in payload |
| `IAuthorizationService` | evaluate stable permission and separation policy | role-name string comparisons |
| `IClock` | UTC and monotonic time | domain use of local wall clock for ordering |
| `IIdentityGenerator` | canonical lowercase GUID identities | database/provider-specific IDs |
| `ICanonicalSerializer` | deterministic versioned UTF-8 payload | culture-dependent numeric serialization |
| `IHashService` | SHA-256 identity/check | claim digital-signature assurance |
| `IUnitConversionService` | controlled conversion revision and typed quantities | heuristic unit guessing |
| `IApplicationPersistenceSession` | transaction/read-session ownership | expose SQLite connection to handlers/UI |
| `IAuditWriter` | append correlated immutable audit | update/delete prior audit |
| `IDomainEventStore` | append/read immutable event envelopes | high-rate sample transport |
| `IPostCommitDispatcher` | notify idempotent in-process consumers | publish uncommitted facts |
| `IArtifactStore` | temp-write, fsync, hash, atomic rename and metadata | absolute/unmanaged user path persistence |

## Domain repositories

Repositories are Application-owned interfaces grouped by aggregate/evidence:

- Order and Specimen;
- Test Method and Analysis Recipe;
- Material and Acceptance Profile;
- Sensor/Installation/Calibration/Correction;
- Test Run, Snapshot and Channel Binding;
- state/command journals;
- raw/derived chunk stores;
- Analysis/Event/Property/Acceptance;
- configuration/import/report records.

A repository loads/saves one aggregate boundary or streams one evidence type. There is no generic public repository and no method returning an unrestricted queryable provider object.

## Hardware and safety ports

| Port | Responsibility |
|---|---|
| `IMachineDriver` | typed capability/status and acknowledged low-level command contract; implementation belongs to driver adapter |
| `IMachineStatusSource` | fresh status/heartbeat snapshots independent of WPF rendering |
| `ISafetySupervisor` | aggregate immutable InterlockSnapshot and choose blocking/stop intent per Frozen policy |
| `IMachineCommandCoordinator` | serialize/prioritize/idempotently journal command requests per machine |
| `ITestRunCoordinator` | coordinate run state with method runner and driver without exposing registers |
| `IJogLeaseService` | begin/renew/end one fail-closed lease per machine |

`IMachineDriver` does not authorize requests or decide UI availability. It never becomes available to analysis, reporting or WPF projects.

## Scientific stream ports

`IRawSampleSink`, `IRawReplaySource`, `IValidatedMeasurementStream`, `IDerivedMeasurementStream` and `ILiveProjectionStream` are separate interfaces. The first four preserve complete scientific provenance; the live projection may decimate/coalesce and carries a marker that prohibits analytical reuse.

## Operation ports

Long-running analysis/import/report/export uses:

- `IOperationScheduler` to durably accept work;
- `IOperationRepository` to expose Queued/Running/Completed/Failed/Cancelled status;
- typed workers with explicit inputs and outputs;
- progress as disposable read-model updates, not audit evidence;
- immutable completion/failure domain events.

The exact scheduler persistence requires the forward migration named by EDR-0008 before unattended/retrying execution is enabled.

## Transaction rules

1. A handler opens at most one Application write session at a time.
2. Repository implementations participating in a use case share that session.
3. No driver/network/rendering wait occurs inside an open SQLite write transaction.
4. Durable intent is recorded before/around driver work according to coordinator state; acknowledgement and reconciliation are subsequent explicit records.
5. State journal + domain event + current run state are one transaction.
6. Snapshot + every required binding + hash are one transaction.
7. Terminal run state requires finalized raw evidence in the same guarded transaction.
8. Event dispatch occurs after commit. Failed dispatch is retried/replayed without reversing committed state.
9. Read queries use read-only sessions and bounded result/window sizes.
10. Raw chunks commit in short transactions and never wait for chart/report consumers.

## Failure mapping

| Failure origin | Boundary behavior |
|---|---|
| validation/authorization/guard | `Rejected`; no requested effect |
| optimistic concurrency | `Rejected`; return current revision identity where authorized |
| persistence before commit | rollback; `Failed` with correlation |
| driver rejection before accepted motion | recorded `Rejected` |
| acknowledgement timeout | `TimedOut`; close command lane and reconcile |
| post-commit subscriber | retain committed truth; retry/replay subscriber |
| analysis/report worker | durable Failed operation and versioned failure event |
| cancellation before safe commit | reject/cancel per declared operation policy |
| cancellation after Stop/protective acceptance | ignored for safety effect; caller may stop observing only |

## Composition and lifetime

- one application-wide composition root;
- one single-writer persistence service per installation;
- one machine command lane and JOG lease service per MachineId;
- short-lived handler/persistence sessions;
- bounded stream workers with explicit shutdown/drain behavior;
- ViewModels have no service-locator access.

Provider, DI-container and queue implementation choices remain implementation details constrained by .NET Framework 4.8 and x86.
