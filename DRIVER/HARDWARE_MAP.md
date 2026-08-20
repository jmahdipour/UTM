---
project: Universal Testing Machine (UTS)
document: HARDWARE_MAP
version: 0.3
status: CONTROLLED-DRAFT
governing_edr: EDR-0009
machine_profile: UNASSIGNED
physical_adapter_status: BLOCKED-HARDWARE
last_revision: 2026-08-18
---

# Hardware Map and Verification Register

## Authority warning

Every row below comes only from legacy source: `REFERENCES/LEGACY/AG01/` (original `AG01.zip`) and `REFERENCES/LEGACY/AUTOGRAPH/` (`Autograph.zip`, a fuller cross-verifying snapshot of the same codebase; see `AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md`). All are `LEGACY-EVIDENCE`, not verified current-machine mappings. All writes are disabled. Neither the old name nor the old behavior proves electrical polarity, scaling, safety function, acknowledgement or present PLC-program identity.

## Legacy read evidence

| Point | Legacy semantic | Legacy expression/source | Verification status | Production disposition |
|---|---|---|---|---|
| `X14` | main E-stop input | `MainModule.vb:1956` | LEGACY-EVIDENCE | UNKNOWN polarity/topology; cannot satisfy safety readiness |
| `M20` | panel E-stop flag | `MainModule.vb:1957` | LEGACY-EVIDENCE | UNKNOWN origin/polarity; cannot satisfy safety readiness |
| `M6` | manual handwheel | `MainModule.vb:1958` | LEGACY-EVIDENCE | not an approved UTS command mode |
| `R25` | test time raw | `/10` at `MainModule.vb:1962-1966` | LEGACY-EVIDENCE | unit/rollover/update rate unknown |
| `R26` | alternate test time | commented at `MainModule.vb:1966` | LEGACY-EVIDENCE | rejected unless independently rediscovered |
| `R32` | raw force count | `MainModule.vb:1968-1988` | LEGACY-EVIDENCE | data type/range/scale unknown; legacy INI factors prohibited |
| `M41` | force sign | `MainModule.vb:1971,1987` | LEGACY-EVIDENCE | polarity and sign convention unverified |
| `R20/R21` | displacement low/high | `65535*high+low`, `MainModule.vb:1989-2002` | LEGACY-EVIDENCE | width/order/signedness and multiplier unverified; expression not accepted |
| `M40` | displacement sign | `MainModule.vb:1999-2001` | LEGACY-EVIDENCE | polarity and orientation unverified |
| `R37` | extensometer raw count | `MainModule.vb:2003-2018` | LEGACY-EVIDENCE | sensor mapping/data type/scale unknown |
| `M42` | extensometer sign | `MainModule.vb:2006,2017` | LEGACY-EVIDENCE | polarity and orientation unverified |
| `T55` | programmable hold timer | `MainModule.vb:2020-2022` | LEGACY-EVIDENCE | timer base/rollover/ownership unknown |
| `X0` | not referenced in reviewed `.vb` source | `Autograph_SVR.fcs` register list only | LEGACY-EVIDENCE | semantic unknown; found only in communication-driver tag list |
| `Y2` | not referenced in reviewed `.vb` source | `Autograph_SVR.fcs` register list only | LEGACY-EVIDENCE | semantic unknown; found only in communication-driver tag list |
| `R22` | not referenced in reviewed `.vb` source | `Autograph_SVR.fcs` register list only | LEGACY-EVIDENCE | possible third displacement-related word alongside R20/R21; unconfirmed |

## Unclassified communication-driver addresses

`R3844`, `R4096` and `R3845` appear in the `.fcs` communication-driver tag list (see
`AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md`) as a distinct block, positioned before the rest
of the itemized point list and not referenced in any reviewed `.vb` source. They may
be Facon-driver-internal buffer/configuration addresses rather than live machine I/O.
No semantic, direction or disposition is assigned; do not treat as read or write
evidence until independently classified.

## Legacy write evidence — all disabled

| Point(s) | Legacy operation | Source | Missing production evidence | Status |
|---|---|---|---|---|
| `M61/M62` | crosshead Up/Down | `MainModule.vb:2023-2032` | polarity, mutual exclusion, pulse/level, acknowledgement, limits, actual direction | WRITE-DISABLED |
| `M63/M64` | cleared during both stops | `MainModule.vb:2033-2049` | no setting-to-1 use in archive; semantic unknown | WRITE-DISABLED |
| `M4` | legacy stop “Break/NoBreak” selector | `MainModule.vb:2033-2049` | drive/brake meaning, safe state, stop category and acknowledgement | WRITE-DISABLED |
| `M0` | watchdog reset/write | `MainModule.vb:2051-2055` | owner, pulse/toggle, feedback, timeout and reaction | WRITE-DISABLED |
| `M1941` | displacement reset | `MainModule.vb:2057-2060` | pulse semantics, acknowledgement and effect on raw/canonical data | WRITE-DISABLED |
| `M31` | deformation reset | `MainModule.vb:2061-2064` | pulse semantics, acknowledgement and sensor scope | WRITE-DISABLED |
| `M30` | force reset | `MainModule.vb:2066-2070` | pulse semantics, acknowledgement and distinction from zero/tare | WRITE-DISABLED |
| `M50` | test timer start/stop | `MainModule.vb:2072-2079` | timer ownership, acknowledgement and restart behavior | WRITE-DISABLED |
| `M51` | test timer reset | `MainModule.vb:2080-2083` | pulse reset/acknowledgement | WRITE-DISABLED |
| `M52` | programmable hold timer start/stop | `MainModule.vb:2084-2093` | method ownership, timer base and acknowledgement | WRITE-DISABLED |
| `M60` | test/manual mode | `MainModule.vb:2095-2102` | controller-state model, safe transition and acknowledgement | WRITE-DISABLED |
| `R500` | crosshead speed setpoint | `speed*10`, `MainModule.vb:2103-2108` | data type, unit, scale, range, gearing and applied-value feedback | WRITE-DISABLED |
| `M10/M11` | clutch Off/1:1/1:10 | `MainModule.vb:2109-2125`; duplicated in UI | Frozen EDR-0003 prohibits software clutch | REJECTED-FOR-UTS-COMMAND |

## Legacy communication topology evidence

From `AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md`. Both binary Facon driver project files
identify as `Fatek Facon PLC Server File Format 1` and configure Ethernet/TCP
targets, not a serial link — previously unrecorded in this map.

| Item | Value | Status |
|---|---|---|
| Active target IP (`Autograph_SVR.fcs`, opened by code) | `192.168.2.100` | LEGACY-EVIDENCE, unverified against current machine |
| Alternate target IP (`Autograph_SVR2.fcs`, commented out) | `10.50.10.100` | LEGACY-EVIDENCE, not code-referenced |
| PLC read-poll interval (`MDIParent.Designer.vb:825`) | `TimerReadTick.Interval = 10` (ms) | LEGACY-EVIDENCE |

These items must be explicitly checked against the physical machine during the
active G01-G03 evidence-gathering track (`DRIVER/COMMISSIONING_KICKOFF_PLAN.md`) —
communication medium may have changed since 2011-2019.

## Current-machine communication — owner-confirmed, live, 2026-08-18

Reported directly by the project owner while the physical machine was actively
communicating, not extracted from the archive. This is a step above
`LEGACY-EVIDENCE` (it describes the machine as it exists today) but is not yet
`DOCUMENT-VERIFIED` per EDR-0009's point lifecycle — no screenshot, log export, or
network capture has been filed yet to back it.

| Item | Value | Status |
|---|---|---|
| Communication medium/protocol | Ethernet/TCP via the `FaconSvr` ("FaSvr") intermediary driver — same driver family as `Autograph_SVR.fcs`/`Autograph_SVR2.fcs` | OWNER-CONFIRMED-LIVE, undocumented |
| Current target IP | `192.168.2.200` | OWNER-CONFIRMED-LIVE, undocumented — differs from both addresses in the legacy archive (`192.168.2.100` active, `10.50.10.100` unused); confirms the subnet (`192.168.2.0/24`) but not the exact host, and confirms the IP has changed at least once since the archived `.fcs` files were authored |

**To advance this from `OWNER-CONFIRMED-LIVE` to `DOCUMENT-VERIFIED`:** capture a
screenshot or export of the running `FaSvr` connection/status screen showing the
`192.168.2.200` target, the adapter/interface it binds to, and the connection state,
and file it as a G02 artifact per `DRIVER/COMMISSIONING_KICKOFF_PLAN.md`.

## Required current-machine points not established by AG01

| Semantic requirement | Why required | Current status |
|---|---|---|
| drive/servo ready and drive fault | initialization, Arm/Start and fault transition | MISSING-HARDWARE-EVIDENCE |
| stationary and direction/motion proof | Stop completion, fault acknowledge and JOG | MISSING-HARDWARE-EVIDENCE |
| upper/lower final limits | independent travel protection/direction blocking | MISSING-HARDWARE-EVIDENCE |
| overload and protective-stop state | load protection and safe reaction | MISSING-HARDWARE-EVIDENCE |
| safety-chain healthy/reset state | positive readiness, not inferred from UI flag | MISSING-HARDWARE-EVIDENCE |
| watchdog feedback/health | communication-loss reaction proof | MISSING-HARDWARE-EVIDENCE |
| command/program acknowledgement | deterministic command receipts | MISSING-HARDWARE-EVIDENCE |
| PLC/drive program identity | bind map to exact controller software | MISSING-HARDWARE-EVIDENCE (communication-driver tag list is legacy-evidenced per `AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md`; the controller's own program export is still missing) |
| installed sensor identity/range | run binding and mismatch detection | MISSING-HARDWARE-EVIDENCE |
| coherent scan/sample sequence | freshness/gap/atomicity evidence | MISSING-HARDWARE-EVIDENCE |

## Point definition checklist

Before a point reaches `Released`, record: MachineId; PLC/drive identity and program hash; native address; semantic ID; read/write direction; type/width/signedness; byte/word order; polarity; pulse/level behavior; raw unit; scale/offset/conversion; engineering unit; valid range; resolution; scan/update rate; freshness threshold; coherent group; command sequence; acknowledgement predicate; safe-state expectation; safety classification; evidence artifacts; test IDs; verifier; reviewer and canonical profile hash.

## Current conclusion

The actual hardware map is not yet verified. The Facon/Fatek adapter may only be Simulator-backed or explicitly monitor-only until the missing documents and machine tests close every relevant row.
