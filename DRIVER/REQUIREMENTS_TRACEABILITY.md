---
project: Universal Testing Machine (UTS)
document: DRIVER_REQUIREMENTS_TRACEABILITY
version: 0.1
status: FROZEN
governing_edr: EDR-0009
last_revision: 2026-08-03
---

# Driver Requirements Traceability Matrix

Status vocabulary: `PASS-DOC` means the Frozen design explicitly satisfies the source requirement; `PENDING-CODE` requires executable VB.NET evidence; `BLOCKED-HARDWARE` requires current-machine evidence. No row is intentionally blank.

| ID | Governing source and line(s) | Requirement | Design location | Test | Status |
|---|---|---|---|---|---|
| DRV-001 | EDR-0003:21-23 | state authority remains Application, not PLC/UI | EDR-0009 Decision; Architecture boundary | DAT-001 | PASS-DOC |
| DRV-002 | EDR-0003:29-40 | driver supports explicit connection/fault observations for machine states | Driver Contract Status snapshot | DAT-002 | PENDING-CODE |
| DRV-003 | EDR-0003:64-70 | fault/restart cannot resume motion | EDR-0009 Driver lifecycle/Reconciliation | DAT-003 | PENDING-CODE |
| DRV-004 | EDR-0003:102-107 | four command outcomes and reconciliation | EDR-0009 Command protocol; Driver receipts | DAT-004 | PENDING-CODE |
| DRV-005 | EDR-0003:117-126 | JOG/Stop/Arm/Start/Hold guards use typed capability/status | Driver commands and capabilities | DAT-005 | PENDING-CODE |
| DRV-006 | EDR-0003:132-137 | press-and-hold JOG; 0.1/1/10 only when verified; no clutch | EDR-0009 JOG; Hardware map M10/M11 | DAT-006 | PASS-DOC |
| DRV-007 | EDR-0003:147-156 | commands/transitions retain correlation and device acknowledgement | Driver receipts; commissioning evidence | DAT-007 | PENDING-CODE |
| DRV-008 | EDR-0004:22-26 | PC not sole safety layer; restart never energizes | EDR-0009 modes/gates | DAT-008 | BLOCKED-HARDWARE |
| DRV-009 | EDR-0004:43-48 | typed driver heartbeat/ack and layered responsibility | Driver Contract; Architecture | DAT-009 | PENDING-CODE |
| DRV-010 | EDR-0004:52-64 | safety priority cannot be masked | command lane/Simulator fault cases | DAT-010 | PENDING-CODE |
| DRV-011 | EDR-0004:68-74 | stop intent does not claim unverified certified category | EDR-0009 command kinds/map warning | DAT-011 | PASS-DOC |
| DRV-012 | EDR-0004:78-95 | immutable fresh interlock inputs; unknown blocks motion | Status snapshot | DAT-012 | PENDING-CODE |
| DRV-013 | EDR-0004:99-114 | Arm/Start require positive readiness | capability/profile release and status | DAT-013 | PENDING-CODE |
| DRV-014 | EDR-0004:118-130 | JOG loses motion on lease/heartbeat/interlock loss | Simulator fault catalog | DAT-014 | PENDING-CODE |
| DRV-015 | EDR-0004:134-140 | force-jump threshold/reaction hardware-specific | Hardware profile/checklist | DAT-015 | BLOCKED-HARDWARE |
| DRV-016 | EDR-0004:144-148 | heartbeat outside UI; reconnect initializes; no resend | EDR-0009 Watchdog/lifecycle | DAT-016 | PENDING-CODE |
| DRV-017 | EDR-0004:152-154 | physical cause/reset not emulated in software | Driver command exclusions | DAT-017 | PASS-DOC |
| DRV-018 | EDR-0004:164-177 | twelve physical verification gates precede motion | Commissioning Gates | DAT-018 | BLOCKED-HARDWARE |
| DRV-019 | EDR-0004:181-191 | hardware topology/map/timing remain open | Hardware Map missing-evidence section | DAT-019 | BLOCKED-HARDWARE |
| DRV-020 | EDR-0005:48-54 | sensor/install/calibration/binding remain separate | Hardware profile and measurement frame | DAT-020 | PENDING-CODE |
| DRV-021 | EDR-0005:70 | legacy sensor inventory not Frozen | Hardware Map warning/missing sensor identity | DAT-021 | PASS-DOC |
| DRV-022 | EDR-0005:115-125 | binding includes address, unit, sign, sample capability and identity match | profile point checklist | DAT-022 | BLOCKED-HARDWARE |
| DRV-023 | EDR-0005:131-141 | frames include sequence/provenance/quality; unknown not zero | Driver measurement frame | DAT-023 | PENDING-CODE |
| DRV-024 | EDR-0005:147-151 | zero/tare is versioned and never calibration rewrite | ApplyZeroTare semantic command | DAT-024 | PENDING-CODE |
| DRV-025 | EDR-0005:163-166 | range/overload per binding and persisted | profile capability; Simulator overload | DAT-025 | BLOCKED-HARDWARE |
| DRV-026 | EDR-0005:168-178 | arming resolves calibration/range/sampling capability | driver capabilities/status | DAT-026 | PENDING-CODE |
| DRV-027 | EDR-0006:30,37 | UI has no PLC ownership; driver workers independent of rendering | Architecture assemblies/concurrency | DAT-027 | PENDING-CODE |
| DRV-028 | EDR-0006:136-140 | no VM PLC write; dialog/navigation/focus cannot sustain JOG | adapter isolation/JOG lease | DAT-028 | PENDING-CODE |
| DRV-029 | EDR-0007:87-94 | bounded immutable raw chunks separate from display | measurement sink contract | DAT-029 | PENDING-CODE |
| DRV-030 | EDR-0007:105 and EDR-0008:157-161 | source unit preserved; canonical typed conversion | measurement frame/profile | DAT-030 | PENDING-CODE |
| DRV-031 | EDR-0007:117-119 | bounded writer/backpressure failures explicit | Simulator sink-backpressure case | DAT-031 | PENDING-CODE |
| DRV-032 | EDR-0008:28-36 | stable port before Simulator; no remote motion API | Architecture/Driver Contract | DAT-032 | PASS-DOC |
| DRV-033 | EDR-0008:79-82 | duplicate motion idempotent; Stop priority | Driver conformance rules | DAT-033 | PENDING-CODE |
| DRV-034 | EDR-0008:112-120 | coordinator owns motion; JOG lease; mapping open for EDR-0009 | EDR-0009 throughout | DAT-034 | PASS-DOC |
| DRV-035 | EDR-0008:124-132 | samples bypass command/event bus; Re-Analyze no driver | Architecture data paths | DAT-035 | PENDING-CODE |
| DRV-036 | Ports:53-60 | typed IMachineDriver/status/safety/coordinator ports and isolation | Driver Contract/Architecture | DAT-036 | PASS-DOC |
| DRV-037 | Ports:82-89 | no driver wait in DB transaction; explicit intent/ack/reconciliation | Architecture concurrency/reconciliation | DAT-037 | PENDING-CODE |
| DRV-038 | Reason Codes:47-52 | stable device disconnect/init/capability/timeout/stale/mismatch handling | receipts/status/conformance | DAT-038 | PENDING-CODE |
| DRV-039 | AG01 Analysis:51,68 | define driver+simulator; addresses reference-only | EDR-0009; Hardware Map | DAT-039 | PASS-DOC |
| DRV-040 | AG01 Analysis:82-85 | verify installed hardware, map and safety reactions | Commissioning Gates | DAT-040 | BLOCKED-HARDWARE |
| DRV-041 | AG01 MainModule.vb:1949-1952 | isolate Facon COM/project/session inside adapter | Architecture assembly intent | DAT-041 | PENDING-CODE |
| DRV-042 | AG01 MainModule.vb:1956-2021 | revalidate every read data type/polarity/scale/timing | Hardware Map read evidence | DAT-042 | BLOCKED-HARDWARE |
| DRV-043 | AG01 MainModule.vb:2023-2125 | revalidate every write, ack and safe state; reject clutch | Hardware Map write evidence | DAT-043 | BLOCKED-HARDWARE |
| DRV-044 | AG01 MDIParent.vb:139-204 | sampling/watchdog/status cannot remain UI-timer-coupled | Architecture concurrency; watchdog rule | DAT-044 | PENDING-CODE |
| DRV-045 | EDR-0004:177 | adapter monitor-only until verification gates pass | modes and gate progression | DAT-045 | PASS-DOC |

## Coverage summary

- total requirements: 45
- `PASS-DOC`: 10
- `PENDING-CODE`: 26
- `BLOCKED-HARDWARE`: 9
- requirements without status: 0
