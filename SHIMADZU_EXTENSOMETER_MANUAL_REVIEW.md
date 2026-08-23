---
project: Universal Testing Machine (UTS)
document: SHIMADZU_EXTENSOMETER_MANUAL_REVIEW
version: 0.1
status: CONTROLLED
classification: ENGINEERING_EVIDENCE
source: REFERENCES/LEGACY/SHIMADZU/49fe84ad-053a-488d-a2b8-ddf24fb50e56.jpg
source_sha256: 506290c5287eb7818da3d9a80a512613a780f83f4cdbf6ace4c748b43c0b1879
analysis_date: 2026-08-18
related: DRIVER/HARDWARE_MAP.md, ELECTRICAL_SCHEMATIC_REVIEW.md, AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md
---

# Shimadzu Extensometer Manual Review

## Purpose and authority

This document extracts engineering evidence from one page of a Shimadzu
Corporation OEM manual, owner-identified as describing the physical machine's
extensometer. It does not freeze any implementation detail and does not close
any gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md`. Authority remains:
newest Frozen EDR, `AI_HANDOVER_SPECIFICATION.md`, current architecture
documents, migration registers, then legacy evidence — this document is legacy
evidence.

## OEM identity — new finding

Document title: "Strain-Gage Type Extensometer For Shimadzu Autograph AG-A
Series"; document number `CM22-0376`; sheet 8 of 19; revision A. This is the
first document in this repository to independently confirm the physical
machine's OEM lineage as a **Shimadzu Autograph AG-A Series** testing machine
(or a machine built around its control architecture). This retroactively
explains the "Autograph" project/application naming and the "AG01" naming
used throughout the legacy codebase and its analysis documents since the
original `AG01.zip` ingestion — neither was previously traced to a specific
OEM family.

## Wiring evidence from the page

Sheet 3, "Electrical Wiring": the extensometer connects through an external
connector to a connector labeled `DTF AMP (J8)`, entering the "Control unit"
enclosure. From there, per the diagram:

| Destination board | Connector(s) |
|---|---|
| SUB I/O board | `J53` |
| MAIN I/O board | `J32F` |
| LOAD AMP board | `J73` |
| SG AMP (strain-gage amplifier) board | `J78`, `J74`, `J71`, `J72` |

The extensometer signal is explicitly routed through a dedicated **SG AMP**
board, separate from the **LOAD AMP** board — confirming, from the original
OEM side, the same load/extensometer signal-path separation already found on
the retrofit side in `ELECTRICAL_SCHEMATIC_REVIEW.md` (separate `FBS_1LC`
modules for `11B3` "Load" and `11B7` "Extensiometr"). This is a second,
independent source agreeing that load and extensometer signals were always
kept on physically separate amplification paths — a detail worth preserving
for the eventual UTS sensor/calibration design (EDR-0005).

The page does not show component values, gain settings, excitation voltage,
or the connector pin-outs themselves — only the block-level routing. It is
not sufficient by itself to reconstruct or verify a working extensometer
signal chain.

## Reported operational issue — owner statement, 2026-08-18

Owner reports the extensometer channel "is currently facing a code issue and
reads zero during a specific range of the [test] loop" (i.e., the reading
drops to zero during part of a test cycle, not throughout).

**Legacy source code reviewed for a software-side cause:** `MainModule.vb`'s
`Read_Deformation` subroutine (extensometer read path) was checked. It reads
raw count `R37` and sign flag `M42` directly from the Facon driver every call,
multiplies by a fixed per-extensometer factor (`Extensometer_Factor_0/1/2`
selected once via `Extensometer_Number`, not changed mid-test), and applies
the sign. **No conditional statement in this subroutine, or elsewhere in the
reviewed source, ever sets `Deformation` or the underlying `R37` value to zero
directly.** This means: if the reading is genuinely zero during part of a
cycle, the most likely origin is that the raw register `R37` itself reads zero
at the PLC/communication-driver level during that range — not an arithmetic
or conditional defect in this VB routine.

**Plausible causes this document does NOT confirm (listed for the owner's
awareness, not as findings):** a physical wiring/connector issue at a specific
extensometer travel position (e.g. a strain-relief or cable-flex point failing
intermittently), a sensor range/saturation limit being reached, or an FaSvr
`Group_read` update-timing gap (recall `Group_read` updates at 31 ms per
`DRIVER/HARDWARE_MAP.md`'s live screenshot evidence). Distinguishing between
these requires either watching `R37` directly in the live FaSvr view while
reproducing the zero (as was done for the earlier live screenshot evidence) or
a physical inspection of the extensometer cable/connector during the affected
range of motion.

This is recorded as a known legacy operational issue, not resolved. It is also
directly the kind of failure `EDR-0005`'s mandatory quality flags
(`Missing`, `Stale`, `GapBefore`, `SensorMismatch`) are designed to make
visible rather than silently pass through as a valid zero reading — worth
keeping in mind when the UTS acquisition/quality-flag design (`EDR-0001`,
`EDR-0005`) is implemented, so the same failure mode does not silently
reappear as "valid" data.

## Disposition

No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changes state. This
document adds legacy/reference evidence (OEM identity, load/extensometer
signal-path separation) and records an open operational issue; it resolves
neither the extensometer zero-reading bug nor any hardware-map point.
