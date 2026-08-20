---
project: Universal Testing Machine (UTS)
document: AUTOGRAPH_LEGACY_ARCHIVE_REVIEW
version: 0.1
status: CONTROLLED
classification: ENGINEERING_EVIDENCE
source: REFERENCES/LEGACY/AUTOGRAPH/Autograph.zip
source_sha256: d6cf28306a546fca9ed8fb9ea929d0be2e502b513b80e877658871023a6666a4
analysis_date: 2026-08-18
related: DRIVER/HARDWARE_MAP.md, AG01_LEGACY_CODE_ANALYSIS.md, DRIVER/COMMISSIONING_KICKOFF_PLAN.md
---

# Autograph Legacy Archive Review

## Purpose and authority

This document extracts engineering evidence from `Autograph.zip`, uploaded by the
project owner as the software that currently operates the physical machine. It does
not freeze any implementation detail and does not close any gate in
`DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md`. Authority remains: newest Frozen
EDR, `AI_HANDOVER_SPECIFICATION.md`, current architecture documents, migration
registers, then legacy evidence — this document is legacy evidence.

## Relationship to prior evidence

`Autograph.zip` contains the same `AG01` codebase family already reviewed in
`AG01_LEGACY_CODE_ANALYSIS.md`, but as a fuller, more complete source snapshot (54
VB.NET source files / 18,084 lines, versus the 32 files / 12,502 lines in the
originally ingested `AG01.zip`), plus a `Backup/AG01/` older revision and compiled
artifacts not previously available. The archive is treated as a **cross-verification
and extension** of the existing evidence, not a replacement — no previously recorded
point, semantic, or disposition in `DRIVER/HARDWARE_MAP.md` is contradicted; the ones
this review re-derives from `MainModule.vb` match exactly.

## New evidence this archive adds

### 1. PLC communication driver identity and protocol

Two binary Facon communication-driver project files were found (referenced from
`MainModule.vb:1949-1951`; only `Autograph_SVR.fcs` is actually opened by code, the
`Autograph_SVR2.fcs` line is commented out):

| File | SHA-256 | Status |
|---|---|---|
| `Autograph_SVR.fcs` (active) | `6f67583ccafe65db2e3dd1cb1de0463a37889a434338535b9f3994bd977289ad` | LEGACY-EVIDENCE |
| `Autograph_SVR2.fcs` (unused alternate) | `3a25142de927c1545dac915c19774bdd55bf84a6c0a43ee7175df9b23a56553f` | LEGACY-EVIDENCE, not code-referenced |

Both identify themselves with the literal header text `Fatek Facon PLC Server File
Format 1`, confirming the vendor/protocol family already named in EDR-0009
(`Facon`/`Fatek`) from an independent binary source rather than only from VB.NET
call sites.

### 2. Communication topology — previously unknown

Both files configure Ethernet/TCP targets, not a serial link:

| File | Target IP | In-code status |
|---|---|---|
| `Autograph_SVR.fcs` | `192.168.2.100` | Active (opened by `Initialize_PLC_Connection`) |
| `Autograph_SVR2.fcs` | `10.50.10.100` | Inactive (commented out) |

Neither IP is verified against the machine as it exists today. This is new
information relative to `DRIVER/HARDWARE_MAP.md`, which did not previously record
whether communication was serial or network-based. **This should be an explicit item
in the G02 controlled-documents check** (`DRIVER/COMMISSIONING_KICKOFF_PLAN.md`):
confirm current communication medium, adapter, and IP/subnet before assuming either
address is still valid.

### 3. Poll interval — previously unknown

`MDIParent.Designer.vb:825` sets `Me.TimerReadTick.Interval = 10` (milliseconds) —
the legacy application's PLC read-poll rate. LEGACY-EVIDENCE only; no confirmation
this is an achievable or intended sample rate for UTS's own acquisition design
(`EDR-0001`, `DRIVER/SIMULATOR_AND_FAULT_INJECTION.md`).

### 4. Register list — full structured extraction, cross-verified and extended

The `.fcs` binary is a structured tag list (`Channel0.Station0.Group_read` /
`Group_write`), not free text. Every point already in `DRIVER/HARDWARE_MAP.md`'s
Legacy read/write tables is present here identically. Three points appear in the
`Group_read` list that are **not yet recorded** in `DRIVER/HARDWARE_MAP.md`:

| Point | Group | Note |
|---|---|---|
| `X0` | Group_read | Not referenced anywhere in the reviewed `.vb` source; semantic unknown |
| `Y2` | Group_read | Not referenced anywhere in the reviewed `.vb` source; semantic unknown |
| `R22` | Group_read | Not referenced anywhere in the reviewed `.vb` source; possible third displacement-related word alongside `R20`/`R21`, unconfirmed |

Additionally, three registers (`R3844`, `R4096`, `R3845`) appear as a distinct block
positioned before the rest of `Group_read` in both `.fcs` files. Their address
pattern and position are inconsistent with the rest of the itemized point list and
they are not referenced in any reviewed `.vb` source file. They are recorded as
**UNCLASSIFIED** — possibly Facon-driver-internal buffer/configuration addresses
rather than live machine I/O. No semantic, direction, or disposition is assigned.

### 5. Application-level configuration cross-check

`Autograph.INI` (both `bin/Debug` and `bin/Release` copies) confirms, from a second
independent source, the `clutch_State` configuration key already flagged as
`SUPERSEDED` via `TSX-SUP-001` in `LEGACY_DECISION_MIGRATION_REGISTER.md` (software
JOG clutch, prohibited by EDR-0003/EDR-0009). The `Release` copy holds all-zero
placeholder values; the `Debug` copy holds nonzero but unverified example values
(e.g. `Force_Factor_10T=0.4079`, `Displacement_Factor=0.004`) — neither is
production evidence per the existing prohibition on legacy INI calibration factors
in `DRIVER/HARDWARE_MAP.md`.

## Important distinction: communication-driver tag list, not PLC program source

The `.fcs` files define which registers the **PC-side communication driver** polls
and writes — they are not an export of the **PLC's own ladder-logic program**
running inside the Fatek controller. Gate G03 (`DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md`)
requires the controller's own program source/export with a hash matching the
currently installed controller; that artifact is not present in this archive and
must still be obtained directly from the PLC (e.g. via the vendor's programming
software) during the active G01-G03 evidence-gathering track.

## Explicitly excluded

`DataBase/Plc_DB.mdb`, despite its name, contains the application's real business
data (Customer, Order, Order_Sample, Test, Settings, Errors tables) including actual
customer/lab names, addresses and phone numbers. This content was inspected only to
confirm it is not a PLC register map, and was not reproduced, summarized, or
committed anywhere. `Ag_db1.mdb` and `Autograph_DB.mdb` were not inspected beyond
listing, for the same reason.

## Disposition

No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changes state as a result
of this review; all remain `BLOCKED-HARDWARE`. This document's findings are inputs
for the active G01-G03 evidence-gathering track in
`DRIVER/COMMISSIONING_KICKOFF_PLAN.md` — specifically: verify current communication
medium/IP against the physical machine, and obtain the PLC's own program export
(distinct from this communication-driver tag list) directly from the controller.
