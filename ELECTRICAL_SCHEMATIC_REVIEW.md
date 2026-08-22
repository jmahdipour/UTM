---
project: Universal Testing Machine (UTS)
document: ELECTRICAL_SCHEMATIC_REVIEW
version: 0.1
status: CONTROLLED
classification: ENGINEERING_EVIDENCE
source: REFERENCES/LEGACY/ELECTRICAL/Auto_graph_90-07-14-1.pdf
source_sha256: a4f990dc6954a87a30d26c4567c6080718cd27353eab63d430c4819a3247d25d
analysis_date: 2026-08-18
related: DRIVER/HARDWARE_MAP.md, AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md, DRIVER/COMMISSIONING_KICKOFF_PLAN.md
---

# Electrical Schematic Review

## Purpose and authority

This document extracts engineering evidence from the 14-sheet electrical schematic
`Auto_graph_90-07-14-1.pdf` (AtronicSaman Co., project "Auto graph", Eng. Zardi,
2011-08-15 through 2011-08-28), plus the accompanying Fatek vendor manuals. It does
not freeze any implementation detail and does not close any gate in
`DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md`. Authority remains: newest Frozen
EDR, `AI_HANDOVER_SPECIFICATION.md`, current architecture documents, migration
registers, then legacy evidence — this document is legacy/reference evidence.

**Open item — needs owner confirmation:** this schematic is dated 2011 and has not
been confirmed as the machine's current revision. Nothing below should be treated as
current-state fact until checked against the physical machine.

## Major finding: this resolves several previously-unclassified points

Cross-referencing this schematic against `DRIVER/HARDWARE_MAP.md` and
`AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md` resolves the semantics of points that were
`LEGACY-EVIDENCE`/`UNCLASSIFIED` with no known function:

| Point | Previous status | Resolved semantic (this schematic) |
|---|---|---|
| `X0`, `X1` | UNCLASSIFIED (read-only, unreferenced in `.vb` source) | High-speed counter inputs from Encoder 1 — "Mecaoion S48-8-2500ZT" (2500 pulses/rev), channels A/B (Sheet 5) |
| — (not previously named `X4`/`X5` in the map) | not recorded | High-speed counter inputs from Encoder 2 — "Autonics ENH-100-2-T-24", channels A/B, same module (Sheet 5) |
| `X14` | LEGACY-EVIDENCE, referenced in `MainModule.vb` but semantic unknown | Wired to switch `7S3` (circle/proximity symbol) on a second digital-input module (Sheet 7); exact function still not labeled in the schematic |
| `Y2` | UNCLASSIFIED (found only in the `.fcs` `Group_read` list) | Digital output "Servo Stop" to the servo drive I/O link (Sheet 8) |

**Important structural finding — the missing middle link is still missing.** The
`M`/`R` points the VB application and FaSvr actually read/write (`M10`, `M11`,
`M1941`, `M60`-`M64`, `M30`, `M4`, `M0`, `M31`, `M50`, `M51`, `R500`) do not appear
anywhere in this schematic's `Y0`-`Y11` physical output wiring, and the `Y`-coils
shown here do not appear in the `.fcs` tag list reviewed in
`AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md` (`Y2` is the sole exception, and it is
read-only in that list). This confirms the PLC's internal ladder-logic program is a
real, distinct, and still entirely missing translation layer between the
application-visible `M`/`R` points and the physically-wired `Y` outputs documented
here. Obtaining that ladder program export remains the outstanding G03 requirement;
see `AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md` § "Important distinction."

## Sheet-by-sheet extraction

**Sheet 1 — Incoming Power.** Three-phase mains (L1/L2/L3/N) through main
disconnect `1S0`, phase-failure relay/contactor `1PHC2`. Branch breakers: `1F2`
63 A (main), `1F3` 20 A → `L1/Drive`, `1F5` 6 A → transformer `1T5` → `L1/PLC`,
`1F7` 10 A → spare terminals `1X7`/`1X8`. Two DC supplies: `1G5` 24 V/2 A (labeled
`DC+`/`DC-`, feeds PLC/logic), `1G6` 24 V/5 A (labeled `Magnet/DC+`/`Magnet/DC-`,
feeds the magnetic clutch coils — see Sheet 12). Incoming ground `PE` at terminal
`X1`.

**Sheet 2 — Servo Drive Power Circuit.** Servo drive `2T4`, model **APD-VS20NL**,
fed from `L1/Drive`/`N`. Drives motor `2M4`, **2 kW / 1000 rpm, model
APM-SF20MEK**, with integrated encoder feedback.

**Sheet 3 — Servo Drive Cable Layout.** Drive `APD-VS20NL` terminals `L1/L2/L1C/
L2C/B1/B2/U/V/W/PE`, two regenerative resistors, and three connectors: `CN1`
(Control Signal → I/O Link), `CN2` (Encoder), `CN3` (Communication, not wired
further in this set).

**Sheet 4 — Servo Drive I/O Link (50-pin).** Maps PLC digital outputs to specific
I/O-link pins: pin 17 → `PLC/Y6`, pin 18 → `PLC/Y5`, pin 47 → `PLC/Y4`, pin 48 →
`PLC/Y3`. Analog channel `4A2D/01+`/`4A2D/01-` at pins 1/8, `4A2D/00+` at pin 27
(continues to Sheet 10's analog module).

**Sheet 5 — High Speed Input / Encoders (`FBs_32MCT`, module ref `4FBs_MC0`).**
Two rotary encoders wired to high-speed counter inputs: Encoder 1 "Mecaoion
S48-8-2500ZT" (2500 ppr) → `X0` (ch A) / `X1` (ch B); Encoder 2 "Autonics
ENH-100-2-T-24" → `X4` (ch A) / `X5` (ch B). Powered from `PLC/DC+`/`PLC/DC-`.

**Sheet 6 — Digital Inputs (`FBs_32MCT`, module ref `6FBs_MC0`).** `X2` ← switch
`6B3` (unlabeled function); `X5` ← switch `6S5` (circle symbol, unlabeled); `X7` ←
switch `6S6` (unlabeled); `X9` ← `6S8.1` "Manual Down"; `X10` ← `6S8.2` "Down";
`X11` ← `6S9` "Manual Up". Note this is a **separate module instance** from Sheet
5's encoder module — both use local terminal numbers `X0`-`X11`, so the same local
label (e.g. `X5`) refers to different physical points on different modules; actual
PLC-wide addressing depends on module slot position, which this schematic set does
not show explicitly.

**Sheet 7 — Digital Inputs continued (`FBs_32MCT`, module ref `7FBs_MC2`,
range `X12`-`X19`).** `X12` ← `7S2` "Manual Up"; `X14` ← `7S3` (circle symbol,
unlabeled function).

**Sheet 8 — Digital Outputs (`FBs_32MCT`, module ref `8FBs_MC0`).** `Y0` → "Servo
P-"; `Y1` → "Servo Din"; `Y2` → "Servo Stop"; `Y4` → "Servo ON"; `Y5` → "Servo
EMG"; `Y6` → "Servo ALMRST"; relay `8K9` on the `Y7` line (contacts referenced
forward to Sheet 13).

**Sheet 9 — Digital Outputs continued (`FBs_32MCT`, module ref `9FBs_MC2`,
range `Y8`-`Y11`).** `Y8` → relay `9K3.1`; `Y9` → relay `9K3.2`; `Y10` → relay
`9K4`; `Y11` → relay `9K5`. These four relays are the interface point to Sheets
12-14.

**Sheet 10 — Analog I/O (`FBS_4A2D`, module ref `10FBs-AD3`).** Titled "Analog
Outputs" but the module is a combined 4-input/2-output analog card. Inputs
`CH0`-`CH3` are not wired in this set (no signal shown). Outputs: `CH0` (`O0+`/
`O0-`) → "Servo SP+"/"Servo SP-" (servo speed reference); `CH1` (`O1+`/`O1-`) →
"Servo Trg+"/"Servo Trg-" (servo trigger).

**Sheet 11 — Load Cell Inputs (two `FBS_1LC` bridge-input modules, refs
`11FBs-LC2` and `11FBs-LC5`).** `11B3` "Load" (load cell) wired to the first
module's bridge excitation/signal terminals (`+EXC`/`-EXC`/`CH0+`/`CH0-`). `11B7`
"Extensiometr" [sic — Extensometer] wired identically to the second module. Both
powered from `PLC/DC+`/`PLC/DC-`. **Plausible but unconfirmed correlation:** these
two channels are likely what the existing `R32` ("raw force counts") and `R37`
("raw extensometer counts") points in `DRIVER/HARDWARE_MAP.md` represent — the
schematic does not show register numbers, so this is not asserted as fact.

**Sheet 12 — Magnetic Clutch.** **Direct physical confirmation of the software
clutch already flagged in `LEGACY_DECISION_MIGRATION_REGISTER.md`
(`TSX-SUP-001`) and `DRIVER/HARDWARE_MAP.md` (`M10`/`M11`,
`REJECTED-FOR-UTS-COMMAND`).** Relay `9K3.1` (driven by `Y8`, Sheet 9) energizes
solenoid `12L3`, labeled **"Clutch 1/10"**. Relay `9K3.2` (driven by `Y9`) energizes
solenoid `12L4`, labeled **"Clutch 1/1"**. Both paths route through contacts `X5`
and `X6` and a device `W06` before reaching the coil. This confirms the physical
mechanism exists as a real two-ratio magnetic clutch; it does not change the
existing prohibition on using it in UTS — EDR-0003 and EDR-0009 stand.

**Sheet 13 — Indicator LED.** Relay `8K9` contact → green LED `13H2`. Relay `9K5`
contact → red LED `13H4`.

**Sheet 14 — Lamp pushbutton.** Relay `9K4` → lamp pushbutton `14H4`.

## Vendor manual findings (generic reference, not machine-specific)

**Facon Server ActiveX/DDE interface manuals.** Confirm the object/path model
already observed in the live `.fcs` evidence: `FaconSvr.FaconServer` COM object,
paths of the form `ChannelN.StationN.GroupName`, methods `OpenProject`/
`SaveProject`/`Connect`/`Disconnect`/`AddGroup`/`EditGroup`/`DeleteGroup`/
`AddItem`/`DeleteItem`/`GetItem`/`SetItem`. Confirm `Channel.Type` can be
`RS232`/`MODEM`/`UDP`/`TCP` and that for `TCP`, `Channel.Parameter` holds the IP
address string — consistent with the `192.168.2.100` TCP evidence already on file.
Confirm group `Priority` values (`0`=highest, `1`=normal, `2`=lowest) and
`Group.Update`/`UpdateTime` semantics, consistent with the `Hi`/`Normal` priority
and `31 ms`/`110 ms` update rates seen in the live screenshots. This satisfies the
"communication manual" requirement of Gate G02.

**FBs-CM25/CM55/CBE Ethernet Module manual.** Generic Fatek documentation for the
Ethernet interface module family (10BaseT, `FATEK/TCP/UDP` or `Modbus/TCP`
protocol, default service port `500`, IP/subnet/gateway set via `ether_cfg.exe`).
**Not confirmed as the specific module installed on this machine** — no sheet in
the reviewed schematic set explicitly shows a network interface module or names its
model (`CM25E`/`CM55E`/`CBE`). Kept as background reference only.

## G02 status after this review

| Artifact | Status |
|---|---|
| Electrical schematic (14 sheets) | Obtained — dated 2011, **current-revision status unconfirmed** |
| Communication manual | Obtained (Facon Server ActiveX + DDE interface manuals) |
| I/O list | Partially derivable from Sheets 4-11; no standalone I/O list document obtained |
| Drive manual | Not obtained — only wiring/model (`APD-VS20NL`) is known, not the servo drive's own manual |

## Disposition

No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changes state as a result
of this review. `DRIVER/HARDWARE_MAP.md` is updated with the resolved semantics
above, all still under `LEGACY-EVIDENCE`/schematic-sourced status pending physical
confirmation that this 2011 schematic still matches the installed machine.
