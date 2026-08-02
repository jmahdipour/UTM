---
project: Universal Testing Machine (UTS)
document: EDR-0004
title: Safety and Interlock Architecture
version: 1.0
status: FROZEN
decision_date: 2026-08-02
classification: SAFETY-ARCHITECTURE
supersedes: none
resolves:
  - CEDR-005 safety portion
partially_resolves:
  - CEDR-006
related:
  - EDR-0003
---

# EDR-0004 — Safety and Interlock Architecture

## Safety boundary

The Windows PC, WPF UI and ordinary application process are not assumed to be safety-rated. They may supervise, inhibit commands, log and display status, but they are not the sole implementation of any safety function required to reduce risk.

Emergency stop, final travel protection, drive disable and other required safety functions must be implemented in verified hardware/safety-related control layers selected by the machine risk assessment.

Software reset or application restart must never energize motion.

## Standards basis and limitation

The architecture is guided by:

- [ISO 12100:2010](https://www.iso.org/standard/51528.html) for machinery risk assessment and risk reduction;
- [ISO 13849-1:2023](https://www.iso.org/standard/73481.html) for design/integration methodology of safety-related parts of control systems;
- [ISO 13850:2015](https://www.iso.org/standard/59970.html) for emergency-stop design principles;
- [IEC 60204-1:2016+A1:2021](https://webstore.iec.ch/en/publication/71256) for electrical equipment of machines.

This EDR does not claim conformity. Required safety functions, Performance Level, architecture category, stop behavior, diagnostic coverage and response time must come from a documented machine-specific risk assessment and validation.

## Layered responsibilities

| Layer | Responsibility |
|---|---|
| Physical safety chain | E-stop devices, final limit devices, drive contactors/STO or equivalent verified functions |
| PLC/drive control | Deterministic motion control, watchdog, hard interlocks and safe reaction implemented according to assessed hardware capability |
| Driver boundary | Typed commands/status, heartbeat and acknowledgement; fail closed on uncertain state |
| `SafetySupervisor` | Aggregates verified status, blocks commands, requests protective/controlled stop and publishes auditable snapshots |
| State machines | Enforce state/command guards and fault transitions |
| UI | Clearly displays state/interlocks and requests commands; never bypasses or substitutes the safety chain |

## Safety priority

When simultaneous conditions exist, the highest applicable priority wins:

1. emergency-stop / verified safety-chain trip;
2. drive or hardware safety fault;
3. overload or final travel protection;
4. communication loss / watchdog timeout;
5. protective application conditions such as soft limit or validated force-jump stop;
6. operator Stop;
7. method termination;
8. normal segment transition;
9. new motion command.

Lower-priority requests cannot clear or mask a higher-priority condition.

## Stop intents

| Intent | Use | Reset behavior |
|---|---|---|
| Emergency safe reaction | Imminent/actual hazardous condition or physical E-stop | Physical chain reset plus acknowledgement and reinitialization; no auto-resume |
| Protective stop | Overload warning boundary, soft limit, force jump, invalid sensor or guard condition | Cause cleared, stationary proof and acknowledgement |
| Controlled stop | Operator Stop, normal completion or method termination | Finish defined deceleration/finalization if still safe |

The final electrical/drive implementation and formal stop category remain open until hardware inspection and risk assessment. Application names must not imply a certified stop category.

## Interlock snapshot

Every command evaluation uses one immutable `InterlockSnapshot` containing at least:

- safety-chain/E-stop status;
- drive/servo ready and fault status;
- stationary/motion proof;
- upper/lower final limit status;
- upper/lower soft-limit status;
- load/overload status;
- force-jump monitor status;
- communication heartbeat/watchdog status;
- active sensor identity/validity;
- calibration validity where required;
- machine capability and direction permission;
- fixture/guard signals when physically available;
- current machine/run state;
- snapshot timestamp, freshness and source quality.

Unknown, stale, contradictory or unavailable required status is unsafe for starting motion and blocks the command.

## Start/arm interlocks

Arming and Start require all applicable conditions to be positively true:

- physical E-stop/safety chain reset;
- no latched fault;
- machine stationary;
- drive ready;
- verified communication freshness;
- valid released method and persisted run snapshot;
- compatible resolved sensors;
- applicable calibration validity;
- method control/sampling capability supported;
- travel position within permitted start region;
- operator permission;
- all required acknowledgements/prompts complete.

No "assume safe" defaults are allowed.

## JOG interlocks

JOG is permitted only when:

- Machine state is `Setup`;
- no Test Run is Armed/Running/Paused;
- operator holds Up or Down;
- approved preset `0.1 / 1 / 10` mm/min is selected and verified against drive capability;
- communication and drive are healthy;
- requested direction is not blocked by hard/soft limits;
- load channel is valid;
- force-jump protective monitoring is armed;
- overload and safety chain are clear.

Release, explicit Stop, lost focus/input capture, stale command heartbeat, state change or any interlock loss requests immediate stop. A UI key/button latch must never sustain JOG by itself.

## Force-jump protection

Automatic stop on an unexpected load increase during setup/return motion is required as a supplementary protective function.

- Thresholds are machine/sensor/configuration specific and versioned.
- Threshold source, units, rate window, debounce and reaction path require hardware validation.
- A PC-only implementation is not claimed as a safety-related control function.
- Detection status and unavailable/invalid state are visible.
- The function cannot replace overload protection, travel limits or E-stop.

## Communication and watchdog

- Heartbeat is generated and checked outside the WPF rendering path.
- Missing/stale acknowledgements make motion state uncertain and trigger the assessed stop reaction.
- The driver reports connection quality separately from machine readiness.
- Reconnection enters `Initializing`, not `Ready`.
- Pending motion commands are never automatically resent after reconnect.

## Fault acknowledgement

Acknowledgement records operator intent; it does not clear a physical cause. A fault can leave its latched state only after cause-clear proof, stationary proof, fresh status and permission checks.

Emergency-stop reset is a physical action. Software may acknowledge the observed reset but may not emulate it.

## Safety configuration

Safety-related configuration is versioned, permission-controlled and audited. Numeric limits require engineering units, valid ranges, provenance and effective dates. Changes take effect only in a stationary non-running state and may require reinitialization.

Test Method values may be stricter process termination values, but they cannot weaken machine/sensor safety limits.

## Verification gates before physical motion

1. machine-specific hazard analysis and risk assessment;
2. electrical/PLC/drive schematic inspection;
3. verified I/O and register map;
4. identified safety functions and required performance;
5. traceable validation plan;
6. E-stop and final-limit tests independent of the PC;
7. communication-loss/watchdog test;
8. overload and force-jump protective tests;
9. JOG hold-to-run and release tests;
10. power loss, restart and reconnect tests;
11. fault injection and no-auto-restart proof;
12. signed commissioning record.

Until these gates pass, the physical adapter may operate only in read-only monitoring or explicitly controlled engineering test modes.

## Open hardware decisions

- actual E-stop and drive-disable topology;
- final-limit wiring and direction interlocks;
- safety PLC/relay/drive capabilities;
- required Performance Level and validation method;
- formal stop categories and response times;
- safe torque/energy removal behavior;
- overload thresholds and sensor-independent protection;
- force-jump thresholds and reaction layer;
- watchdog location and timeout;
- fixture/guard devices;
- verified Facon/Fatek mapping and command acknowledgement.

# End of EDR
