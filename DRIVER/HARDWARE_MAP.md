---
project: Universal Testing Machine (UTS)
document: HARDWARE_MAP
version: 0.12
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
| `X14` | main E-stop input (per `.vb` source comment) | `MainModule.vb:1956` | **Owner-confirmed functional 2026-08-18:** owner states `X14` does function as the emergency stop in practice, describes the physical device as a large red pushbutton (visually consistent with the ISO 13850 mushroom-head red-button convention), and confirms the behavior is a complete shutdown of the whole device, manually triggered by the operator. **Circuit-level answers, owner-reported 2026-08-18:** (2) **not** dual-channel — single channel only; (3) **no** wire-break/line monitoring; (4) reset is **not automatic** — manual action only. **Polarity — corrected 2026-08-18:** owner first reported open (NO) while idle, then corrected to closed (NC) while idle after the fail-safe convention was explained; recorded as-is, not resolved by this document. **Two physical buttons — new 2026-08-18:** owner reports there are in fact **two separate E-stop pushbuttons** — one on the machine body, one on/near the PLC panel — not one. **Wiring relationship between the two is unknown** (owner unsure whether both feed a single input in series, as is common practice, or feed two separate PLC inputs). This means the single-channel/no-monitoring answers above may describe only one of two buttons, or may already account for both in series — not yet distinguishable. | 🟡 **Still requires qualified electrical/safety verification, not further chat description.** The polarity self-correction, combined with the newly reported second button whose wiring relationship to the first is unknown, means the picture here is incomplete, not just unverified — there may be a second, undocumented PLC input entirely. Independently of all of the above, the answer that this is not dual-channel (in the redundant-contact sense) and not monitored still stands for whichever circuit(s) exist. Only a qualified person physically tracing both buttons and the actual safety circuit (continuity in both button states, contact count per button, how the two buttons combine, monitoring circuit if any) against ISO 13849-1 category/PL requirements can settle this — not another verbal description. UNKNOWN polarity/topology/monitoring/button-count-and-wiring beyond what is stated here; cannot satisfy safety readiness |
| `M20` | panel E-stop flag | `MainModule.vb:1957` | LEGACY-EVIDENCE | UNKNOWN origin/polarity; cannot satisfy safety readiness |
| `M6` | manual handwheel | `MainModule.vb:1958` | LEGACY-EVIDENCE | not an approved UTS command mode |
| `R25` | test time raw | `/10` at `MainModule.vb:1962-1966` | LEGACY-EVIDENCE | unit/rollover/update rate unknown |
| `R26` | alternate test time | commented at `MainModule.vb:1966` | LEGACY-EVIDENCE | rejected unless independently rediscovered |
| `R32` | raw force count | `MainModule.vb:1968-1988` | LEGACY-EVIDENCE | data type/range/scale unknown; legacy INI factors prohibited. **Plausible, unconfirmed** per `ELECTRICAL_SCHEMATIC_REVIEW.md` Sheet 11: may correspond to load cell `11B3` on bridge-input module `11FBs-LC2` — schematic shows no register number, so this is not asserted as fact |
| `M41` | force sign | `MainModule.vb:1971,1987` | LEGACY-EVIDENCE | polarity and sign convention unverified |
| `R20/R21` | displacement low/high | `65535*high+low`, `MainModule.vb:1989-2002` | LEGACY-EVIDENCE | width/order/signedness and multiplier unverified; expression not accepted |
| `M40` | displacement sign | `MainModule.vb:1999-2001` | LEGACY-EVIDENCE | polarity and orientation unverified |
| `R37` | extensometer raw count | `MainModule.vb:2003-2018` | LEGACY-EVIDENCE | sensor mapping/data type/scale unknown. **Plausible, unconfirmed** per `ELECTRICAL_SCHEMATIC_REVIEW.md` Sheet 11: may correspond to extensometer `11B7` on bridge-input module `11FBs-LC5` — schematic shows no register number, so this is not asserted as fact |
| `M42` | extensometer sign | `MainModule.vb:2006,2017` | LEGACY-EVIDENCE | polarity and orientation unverified |
| `T55` | programmable hold timer | `MainModule.vb:2020-2022` | LEGACY-EVIDENCE | timer base/rollover/ownership unknown |
| `X0` | not referenced in reviewed `.vb` source | `Autograph_SVR.fcs` register list only | LEGACY-EVIDENCE | **Plausible, unconfirmed** per `ELECTRICAL_SCHEMATIC_REVIEW.md` Sheet 5: local terminal `X0` on the encoder module is wired to channel A of high-speed encoder "Mecaoion S48-8-2500ZT" (2500 pulses/rev). Fatek FBs PLCs assign global X-numbering by installed slot order, which this schematic set does not show — so this local terminal label is not confirmed to be the same global `X0` seen in the Facon tag list |
| `Y2` | not referenced in reviewed `.vb` source | `Autograph_SVR.fcs` register list only | LEGACY-EVIDENCE | **Plausible, unconfirmed** per `ELECTRICAL_SCHEMATIC_REVIEW.md` Sheet 8: local terminal `Y2` on the digital-output module drives "Servo Stop" to the servo drive I/O link. Coherent with `Y2` appearing in the Facon driver's `Group_read` (not `Group_write`) list — a PLC output coil driven by the controller's own ladder program, only monitored (not written) by the external application. Same slot-position caveat as `X0` applies |
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
| `M10/M11` | clutch Off/1:1/1:10 | `MainModule.vb:2109-2125`; duplicated in UI | Frozen EDR-0003 prohibits software clutch | REJECTED-FOR-UTS-COMMAND — **physically confirmed to exist** per `ELECTRICAL_SCHEMATIC_REVIEW.md` Sheet 12: real two-ratio magnetic clutch hardware (solenoids `12L3` "Clutch 1/10" and `12L4` "Clutch 1/1"), driven via relays from PLC outputs `Y8`/`Y9`. The hardware's existence does not lift the prohibition on exposing a software clutch control in UTS |

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

## Current-machine communication — resolved 2026-08-18

Initially reported as `192.168.2.200`, `192.168.2.100` and `192.168.2.200` were
found to describe two different hosts, not two candidates for one host. Owner
confirmed: `192.168.2.100` (matching every `.fcs` project file reviewed) is the
real, current PLC address; `192.168.2.200` was the operator PC's own address on the
same subnet, not the PLC's.

| Item | Value | Status |
|---|---|---|
| Communication medium/protocol | Ethernet/TCP via the `FaconSvr` ("FaSvr") intermediary driver | DOCUMENT-VERIFIED (screenshots, see below) |
| Current PLC target IP | `192.168.2.100` | DOCUMENT-VERIFIED — consistent across the legacy `Autograph.zip` archive (2011-2019), the live screenshot evidence (2026-08-20), and owner confirmation |
| Operator PC address (not the PLC) | `192.168.2.200` | OWNER-CONFIRMED, informational only — not a hardware-map point |

## Live screenshot evidence — 2026-08-20 (owner-provided)

Three screenshots of the running `Fatek Communication Server [Autograph_svr.fcs]`
application window were provided, alongside a re-upload of `Autograph_SVR.fcs`
(SHA-256 `6f67583ccafe65db2e3dd1cb1de0463a37889a434338535b9f3994bd977289ad` —
identical to the copy already reviewed in `AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md`, and
still targeting `192.168.2.100` internally; see the unresolved discrepancy below).
This is materially stronger than the prior `OWNER-CONFIRMED-LIVE` verbal report: it
is direct visual proof that the point list is live, enabled, and actively updating
on the currently running system, not only an archived source-code reference. Status:
`SCREENSHOT-VERIFIED-LIVE` — stronger than `LEGACY-EVIDENCE`, but not yet
`BENCH-VERIFIED`/`MACHINE-VERIFIED` per EDR-0009's point lifecycle, since no
independent reviewer/test procedure produced these screenshots.

**Group update configuration (new — not previously recorded):**

| Group | Priority | Update rate | Status | Last update shown |
|---|---|---|---|---|
| `Group_read` | Hi | 31 ms | Enabled | 20/08/2026 09:47:55 |
| `Group_write` | Normal | 110 ms | Enabled | 20/08/2026 09:47:55 |

This refines, and is distinct from, the `10 ms` `TimerReadTick.Interval` recorded
earlier — that value is the legacy VB6 application's own poll of FaSvr's cache;
these are FaSvr's own driver-to-PLC group update rates.

**Point-in-time value snapshot (evidence that every point is live and populated; not
a specification, not calibrated engineering values):**

| Group_read | Value | | Group_read | Value |
|---|---:|---|---|---:|
| `R3844` | 942 | | `R21` | 1 |
| `R4096` | 57140 | | `M41` | 1 |
| `R3845` | 2614 | | `R22` | 8544 |
| `R20` | 8396 | | `M42` | 1 |
| `M40` | 1 | | `R32` | 17 |
| `T55` | 0 | | `X14` | 1 |
| `X0` | 1 | | `R37` | 645 |
| `Y2` | 1 | | `R25` | 0 |
| | | | `R26` | 0 |
| | | | `M20` | 0 |
| | | | `M6` | 0 |

| Group_write | Value | | Group_write | Value |
|---|---:|---|---|---:|
| `R500` | 1000 | | `M30` | 0 |
| `M10` | 0 | | `M4` | 1 |
| `M11` | 1 | | `M0` | 1 |
| `M1941` | 0 | | `M31` | 0 |
| `M60` | 0 | | `M50` | 0 |
| `M61` | 0 | | `M51` | 0 |
| `M62` | 0 | | `M63` | 0 |
| | | | `M64` | 0 |

All previously `LEGACY-EVIDENCE` read/write points above are now confirmed live and
active. The three previously `UNCLASSIFIED` addresses (`R3844`, `R4096`, `R3845`)
are confirmed live and populated as well — their semantic meaning is still unknown,
classification is unchanged.

**Discrepancy resolved 2026-08-18 (owner-confirmed):** `192.168.2.100` (encoded in
this `.fcs` file) is the real, current PLC address — consistent with the legacy
archive and the live screenshots. `192.168.2.200` was the operator PC's own address
on the same subnet, not a second candidate PLC address; see the corrected
"Current-machine communication" section above.

## Electrical schematic and drive/sensor identity evidence — 2026-08-18

From `ELECTRICAL_SCHEMATIC_REVIEW.md` (source: `Auto_graph_90-07-14-1.pdf`, a
14-sheet site-specific schematic dated 2011, AtronicSaman Co., **current-revision
status unconfirmed**). This is the strongest evidence obtained so far — a real
electrical drawing, not source code or a communication-driver tag list — but it
predates today by 15 years and has not been checked against the physical machine.
Status: `DOCUMENT-VERIFIED` for what the drawing itself states; `LEGACY-EVIDENCE`
for whether it still matches the installed machine.

| Item | Value |
|---|---|
| Servo drive | `APD-VS20NL` |
| Servo motor | `APM-SF20MEK`, 2 kW / 1000 rpm, integrated encoder |
| Crosshead/position encoders (separate from the drive's own encoder) | Encoder 1: "Mecaoion S48-8-2500ZT", 2500 pulses/rev; Encoder 2: "Autonics ENH-100-2-T-24" |
| Load cell input module | `FBS_1LC` bridge-input module, tag `11B3` "Load" |
| Extensometer input module | Second `FBS_1LC` bridge-input module, tag `11B7` "Extensiometr" [sic] |
| Analog speed/torque reference to drive | `FBS_4A2D` module, `CH0`→"Servo SP" (speed), `CH1`→"Servo Trg" (trigger/torque) |
| Discrete servo control coils | `Y0` "Servo P-", `Y1` "Servo Din", `Y2` "Servo Stop", `Y4` "Servo ON", `Y5` "Servo EMG", `Y6` "Servo ALMRST" |

**Full detail, sheet-by-sheet extraction, and the important caveat about Fatek
FBs modules using slot-relative local addressing (so a local terminal label like
`X0` or `Y2` is not automatically the same point as the same label elsewhere) are
in `ELECTRICAL_SCHEMATIC_REVIEW.md` — not duplicated here.**

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
