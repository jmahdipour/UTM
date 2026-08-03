---
project: Universal Testing Machine (UTS)
document: DRIVER_CONTRACT
version: 0.1
status: FROZEN
governing_edr: EDR-0009
last_revision: 2026-08-03
---

# Machine Driver Contract

## Contract rules

- Contracts use immutable VB.NET DTOs with constructor validation and `ReadOnly` properties.
- Physical values use `EngineeringQuantity`; unitless `Double` is prohibited.
- Enums are serialized by stable names/versions, not provider integers.
- Every receipt and snapshot carries DriverSessionId, MachineId, profile hash and correlation.
- Cancellation stops waiting; it does not imply cancellation of a physical Stop/protective action.

## Principal port shape

The future VB.NET interface has these semantic operations:

```vbnet
Public Interface IMachineDriver
    Function ConnectAsync(request As DriverConnectRequest,
                          cancellation As Threading.CancellationToken) As Task(Of DriverConnectReceipt)
    Function DisconnectAsync(request As DriverDisconnectRequest,
                             cancellation As Threading.CancellationToken) As Task(Of DriverDisconnectReceipt)
    Function GetCapabilitiesAsync(cancellation As Threading.CancellationToken) As Task(Of DriverCapabilities)
    Function ReadStatusAsync(cancellation As Threading.CancellationToken) As Task(Of DriverStatusSnapshot)
    Function ExecuteAsync(command As DriverCommand,
                          cancellation As Threading.CancellationToken) As Task(Of DriverCommandReceipt)
    Sub AttachMeasurementSink(sink As IRawMeasurementFrameSink)
End Interface
```

This is a contract shape, not executable production code. Streaming uses a bounded sink/callback abstraction compatible with .NET Framework 4.8; it does not require `IAsyncEnumerable`.

## Driver commands

Initial semantic command kinds are:

| Kind | Required typed fields | Completion observation |
|---|---|---|
| `RequestControlledStop` | stop intent and command identity | stationary predicate |
| `BeginJog` | direction, verified speed quantity, lease identity | motion-start predicate |
| `RenewJog` | same lease identity and input proof | accepted lease refresh |
| `EndJog` | lease/correlation identity | stationary predicate |
| `ArmProgram` | immutable run snapshot/program hash | armed acknowledgement |
| `StartProgram` | program/session identity | execution-start predicate |
| `HoldProgram` | run/segment identity | holding predicate |
| `ResumeProgram` | run/segment identity | execution predicate |
| `ApplyZeroTare` | resolved channel binding and correction intent | new zero/tare observation/receipt |

No `SetRegister`, `SetCoil`, `SetClutch` or untyped `Execute(name, value)` command exists.

## Receipts

`DriverCommandReceipt.Status` is one of:

- `Acknowledged` — the released predicate was observed;
- `Rejected` — no requested effect was issued;
- `TimedOut` — final state is uncertain; reconciliation required;
- `Failed` — transport/adapter failure with correlated redacted diagnostic.

The receipt includes RequestId, CorrelationId, CommandKind/Version, IssuedAt/CompletedAt monotonic evidence, profile/session identity, acknowledgement predicate identity, observed status sequence and stable reason code. It never contains credentials, unrestricted PLC frames or vendor exceptions.

## Status snapshot

`DriverStatusSnapshot` contains explicit quality for:

- connection health and profile match;
- E-stop/safety-chain observation;
- drive ready/fault and stationary/motion proof;
- upper/lower hard and soft direction permissions;
- overload/protective-stop state;
- watchdog/heartbeat freshness;
- observed controller mode/program state;
- sensor identity/validity and measurement-channel availability;
- active command and late/unmatched acknowledgement indicators.

If the installed hardware cannot provide a field, it is `Unavailable` and blocks any capability that requires it.

## Measurement frame

Each batch includes session/profile, stream and scan identity; first/last sequence; monotonic times; raw point identity/value/unit; per-channel quality; and source-to-canonical transformation revision. Samples are delivered to a bounded sink. Overflow, gaps, duplicates and out-of-order data are reported explicitly and never hidden by interpolation at this boundary.

## Conformance rules

Every adapter, including Simulator, must pass the same contract suite:

- stable identity/version validation;
- immutable snapshots and ordered sequences;
- no capability over-advertisement;
- idempotent duplicate command behavior;
- timeout/late-ack reconciliation;
- priority Stop and no automatic motion retry;
- disconnect/reconnect without automatic Ready/resume;
- stale/partial/unknown propagation;
- redacted diagnostics;
- deterministic shutdown/drain.
