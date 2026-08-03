---
project: Universal Testing Machine (UTS)
document: EDR-0009
title: Hardware-Independent Driver, PLC Mapping, Simulation and Commissioning
version: 1.0
status: FROZEN
decision_date: 2026-08-03
classification: DEVICE-ARCHITECTURE
supersedes: none
related:
  - EDR-0001
  - EDR-0003
  - EDR-0004
  - EDR-0005
  - EDR-0007
  - EDR-0008
---

# EDR-0009 — Hardware-Independent Driver, PLC Mapping, Simulation and Commissioning

## Status boundary

This package is a Frozen architecture decision. Freezing the hardware-independent contract does not authorize physical motion and does not promote any legacy address, polarity, scale, timeout or command sequence to verified production data.

## Context

The Frozen Application boundary requires typed capabilities, status and acknowledged commands behind `IMachineDriver`. The legacy AG01 archive contains Facon/Fatek calls and addresses, but it is incomplete and directly couples UI, polling, conversion and PLC writes. It contains no sufficient evidence for command acknowledgement, stationary proof, final travel limits, overload protection, drive readiness, watchdog feedback or safe restart.

The project therefore needs a driver contract that can be implemented and tested before the current machine map is known, plus an explicit verification lifecycle that prevents historical addresses from being used as production configuration.

## Decision

UTS separates four concerns:

1. Application-owned semantic machine commands and state coordination;
2. a hardware-independent `IMachineDriver` contract;
3. adapter-owned transport/protocol and immutable mapping profiles;
4. deterministic Simulator and independent commissioning evidence.

Only the composition root may select an adapter. WPF, Analysis, Reporting and domain code never receive a PLC client, native address or vendor type.

## Adapter modes

| Mode | Permitted behavior | Physical motion |
|---|---|---|
| `Simulator` | deterministic status, samples, acknowledgements and injected faults | none |
| `PhysicalMonitorOnly` | connect, handshake and read explicitly approved diagnostic points | prohibited |
| `PhysicalCommissioning` | controlled tests under an approved commissioning plan | only within signed test step |
| `PhysicalProduction` | released capability/map profile and normal guarded commands | permitted by Application and Safety guards |

The default for every new or changed physical profile is `PhysicalMonitorOnly` with writes disabled.

## Mapping lifecycle

Every map profile and point has one status:

- `LegacyEvidence`: observed only in historical source;
- `DocumentVerified`: matched to controlled electrical/PLC/drive documents;
- `BenchVerified`: read/write behavior verified without production motion where applicable;
- `MachineVerified`: polarity, scaling, timing, acknowledgement and safe reaction verified on the identified machine;
- `Released`: independently reviewed, signed and immutable for production use;
- `Rejected` or `Retired`: prohibited for new sessions, retained for evidence.

No point may skip a lifecycle status. A command capability is not advertised unless every participating point and acknowledgement predicate is `Released`.

## Immutable hardware profile

A released `MachineHardwareProfileRevision` includes:

- machine identity and controller/drive identity;
- PLC program identity/hash and controlled drawing revisions;
- adapter/protocol version and connection parameters referenced through protected configuration;
- point definitions and grouped coherent-read rules;
- native data type, width, signedness, word/byte order and bit polarity;
- raw quantity/unit, scale/offset or approved conversion revision;
- engineering quantity/unit, valid range, resolution and update capability;
- command write semantics, pulse/level behavior, acknowledgement predicate and timeout policy reference;
- defined de-energized/safe expectation and restart/reconnect behavior;
- safety classification, provenance, verification status and evidence links;
- supported motion, control, hold, sampling and JOG capabilities;
- reviewer/approver, release time and canonical hash.

Profiles are immutable after release. Any PLC program, wiring, drive, sensor-path, scale, polarity, timing or adapter change requires a new revision and impact assessment.

## Driver lifecycle and trust

Driver connection health is separate from Machine state:

`Disconnected → Connecting → Handshaking → Monitoring → CommandReady`

`Degraded`, `ReconciliationRequired` and `DriverFaulted` may be entered from connected states. A reconnect returns to `Handshaking`; it never returns directly to `CommandReady` and never resumes or resends motion.

`CommandReady` requires:

- the intended released profile hash;
- controller/PLC/drive identity consistent with that profile;
- fresh coherent status;
- a proven non-motion safe handshake;
- no unresolved previous command;
- released capability and acknowledgement mappings.

Connection success alone never means Machine `Ready`.

## Status and measurement snapshots

Status and measurement acquisition are independent of WPF rendering. Every snapshot/frame carries:

- MachineId, driver session ID, profile revision/hash and adapter version;
- strictly increasing driver sequence and coherent scan identity;
- UTC receive time and monotonic acquisition/receive time;
- source timestamp when verified, otherwise explicit absence;
- freshness, completeness and quality;
- typed semantic values and per-value quality;
- raw frame/value provenance reference without exposing unrestricted frames to Presentation;
- communication counters and last-success/last-error identities.

Unknown, contradictory, partially read or stale safety-relevant values remain unknown/unsafe. They are never converted to false, zero or ready.

Raw acquisition values and declared source units are preserved. Scaling, sign and canonical conversion are versioned transformations under EDR-0005 and EDR-0007. Device force declared as `kgf` remains traceable and normalizes with `1 kgf = 9.80665 N`.

## Command protocol

The driver accepts typed semantic commands, never arbitrary address/value writes. No production `SetRegister`, `SetCoil` or generic Read/Write register operation exists. Each request contains RequestId, CorrelationId, MachineId, session/profile identity, command kind/version, typed parameters and an Application-issued deadline policy identity.

For a physical command the adapter:

1. validates session/profile/capability identity;
2. rejects unresolved or unreleased mapping;
3. records the local intent state outside the SQLite transaction boundary;
4. applies the exact released write sequence;
5. observes the released acknowledgement predicate and fresh status;
6. returns `Acknowledged`, `Rejected`, `TimedOut` or `Failed` with stable diagnostics.

`Acknowledged` proves only the defined predicate; it does not silently claim motion completion. Motion start/stop requires explicit observed predicates. A motion timeout enters reconciliation and is never automatically retried. Stop/JOG End use a priority path and remain idempotent, but their physical reaction still requires released mapping and stationary proof.

Arbitrary register read/write and vendor diagnostic consoles are limited to a separately authorized commissioning tool and are never reachable from production ViewModels or Application commands.

## JOG and test execution

- JOG remains Setup-only, press-and-hold and lease-based.
- The driver advertises only physically verified JOG rates; Application may request only the Frozen `0.1 / 1 / 10 mm/min` UI presets that the active profile supports.
- There is no software clutch command. Legacy M10/M11 evidence is not exposed as a capability.
- Loss of lease, heartbeat, focus proof, session, interlock freshness or direction permission requests stop.
- Test execution uses versioned semantic segment commands. Adapter details do not enter Test Method revisions.

## Watchdog and communication loss

The watchdog must be defined by the machine risk assessment and verified controller behavior. Its owner, toggle/pulse semantics, feedback, timing, reaction and recovery are profile data. The legacy one-way write to `M0` is insufficient evidence.

WPF render timers do not generate or validate heartbeat. Communication loss makes state uncertain, blocks new motion, invokes the assessed reaction and requires reconciliation.

## Deterministic simulator

The Simulator implements the same driver contract with no vendor dependency and no physical I/O. It uses a virtual monotonic clock, seeded deterministic scenarios and explicit fault injection. It must cover:

- connection/handshake/capability negotiation;
- coherent status and sample sequences;
- JOG lease expiry and direction limits;
- motion accepted/start/stationary acknowledgement;
- acknowledgement timeout and late acknowledgement;
- disconnect/reconnect with no auto-resend;
- stale/partial/contradictory status;
- E-stop, final limit, overload, sensor mismatch and calibration invalidity;
- dropped/duplicated/out-of-order sample batches;
- persistence backpressure and controlled shutdown/drain.

Simulator success is software evidence only and never substitutes for machine commissioning.

## Legacy map disposition

Every address found in AG01 is recorded in `DRIVER/HARDWARE_MAP.md` as `LEGACY-EVIDENCE` and `WRITE-DISABLED`. Notable evidence includes X14, M0/M4/M6/M10/M11/M20/M30/M31/M40-M42/M50-M52/M60-M64/M1941, R20/R21/R25/R32/R37/R500 and T55.

The legacy displacement expression `65535 × high + low`, raw force/extensometer factors, sign bits, speed multiplier, brake flag and command coils are not accepted without current PLC/drive documentation and measured verification.

## Commissioning gates

Physical production motion is blocked until all gates in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` pass, including:

1. identified machine/controller/drive and controlled PLC program hash;
2. current electrical, I/O and communication documentation;
3. machine risk assessment and safety-function validation boundary;
4. released point/command/acknowledgement map;
5. read-only comparison and scaling/polarity tests;
6. independent E-stop, final-limit and drive-disable proof;
7. controlled JOG, Stop, communication-loss and no-auto-restart tests;
8. sensor identity/range/overload and sampling verification;
9. fault-injection evidence and recovery/reconciliation tests;
10. signed commissioning and profile release.

Until then, physical adapter status is `BLOCKED-HARDWARE`; only Simulator and approved monitor-only work are permitted.

## Persistence impact

The initial schema can reference configuration revisions and command journals, but production implementation requires a reviewed forward migration for immutable hardware profile revisions, mapping points, verification evidence and driver-session/reconciliation records. No ad-hoc table or JSON file may bypass EDR-0007 migration policy.

## Consequences

### Positive

- Application, Simulator and physical adapters share one semantic contract.
- Legacy addresses cannot accidentally become production writes.
- capability advertisement is evidence-based and profile-specific.
- timeouts, reconnects and late acknowledgements cannot duplicate motion.
- commissioning evidence is traceable to a specific machine, PLC program and adapter build.

### Costs

- physical motion remains blocked until machine evidence is obtained;
- each hardware change requires a new profile revision and regression assessment;
- simulator, adapter conformance and commissioning tests must be maintained separately.

## Rejected alternatives

1. **Copy AG01 addresses into production code** — evidence is incomplete and unverified.
2. **Expose generic Read/Write register from Application** — bypasses semantic guards and hardware independence.
3. **Treat Connect as Ready** — ignores safe handshake, freshness and unresolved state.
4. **Retry timed-out motion automatically** — may duplicate an already executed command.
5. **Run heartbeat from a UI timer** — rendering delays cannot own communication safety.
6. **Use Simulator results as commissioning proof** — no physical safety or scaling behavior is validated.
7. **Preserve software clutch because legacy UI had it** — contradicts Frozen EDR-0003.

## Verification requirements

The Frozen document package is complete only while its RTM has no unstatused requirements and its document validator passes. Executable VB.NET adapter/simulator tests remain `PENDING-CODE`; machine-specific tests remain `BLOCKED-HARDWARE` until controlled evidence is supplied.

# End of EDR
