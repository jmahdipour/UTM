---
project: Universal Testing Machine (UTS)
document: COMMISSIONING_AND_ACTIVATION_GATES
version: 0.1
status: FROZEN
governing_edr: EDR-0009
physical_adapter_status: BLOCKED-HARDWARE
last_revision: 2026-08-03
---

# Physical Adapter Commissioning and Activation Gates

## Rule

Physical motion is prohibited until all applicable gates are `PASS` and the resulting hardware profile revision is independently reviewed and released. `N/A` requires a reason, approver and risk-assessment reference. Simulator evidence cannot close a physical gate.

## Gate register

| Gate | Required evidence | Current result |
|---|---|---|
| G01 Machine identity | serial/asset identity, controller, drive, installed options | BLOCKED-HARDWARE |
| G02 Controlled documents | current electrical schematic, I/O list, communication manual, drive manual | BLOCKED-HARDWARE |
| G03 PLC/drive software | source/export, version and cryptographic hash matching installed controller | BLOCKED-HARDWARE |
| G04 Risk/safety boundary | machine hazard analysis, required safety functions and validation responsibility | BLOCKED-HARDWARE |
| G05 Point map | reviewed type/polarity/word order/unit/scale/range/freshness for every used point | BLOCKED-HARDWARE |
| G06 Command semantics | write sequence, pulse/level, acknowledgement, timeout and safe-state behavior | BLOCKED-HARDWARE |
| G07 Monitor-only comparison | controlled read-only observation against independent instruments/HMI/PLC tools | BLOCKED-HARDWARE |
| G08 Measurement chain | Load/Stroke/Extension/Time identity, raw units, scaling, sign and sample timing | BLOCKED-HARDWARE |
| G09 Independent protections | E-stop, final limits and drive disable proven independently of PC application | BLOCKED-HARDWARE |
| G10 Controlled motion | direction, speed, stationary proof and Stop under approved low-risk procedure | BLOCKED-HARDWARE |
| G11 JOG | hold-to-run, lease expiry, release/focus loss and direction limits | BLOCKED-HARDWARE |
| G12 Communication loss | watchdog reaction, stale detection, reconnect and no auto-resume/resend | BLOCKED-HARDWARE |
| G13 Fault injection | drive fault, overload, contradictory/partial status and recovery | BLOCKED-HARDWARE |
| G14 Power/restart | power loss, application restart, reconciliation and no automatic energization | BLOCKED-HARDWARE |
| G15 Sampling endurance | rates, coherent frames, gaps, backpressure and x86 resource limits | BLOCKED-HARDWARE |
| G16 Traceability | test logs, actors, instruments, calibration, build/profile hashes and deviations | BLOCKED-HARDWARE |
| G17 Independent review | engineering/safety review and owner release signature | BLOCKED-HARDWARE |

## Activation progression

| Target mode | Minimum gates |
|---|---|
| `PhysicalMonitorOnly` | G01–G03, approved read-only subset of G05, no writes configured |
| `PhysicalCommissioning` | G01–G06 plus approved risk-controlled test procedure for each write |
| `PhysicalProduction` | G01–G17 all PASS and released profile |

## Change control

Changes to PLC program, wiring, drive parameters, communication layer, adapter build, map/scaling, sensor installation or safety configuration invalidate the affected gate evidence and require a new profile revision. The system falls back to monitor-only or blocked mode until impact assessment closes the gates.

## Evidence package

Each commissioning execution records MachineId, profile candidate hash, PLC/drive software hashes, application/adapter build, test procedure revision, date/time, actors, independent instruments and their calibration identities, raw observations, expected/actual results, deviations, attachments, reviewer and final disposition.
