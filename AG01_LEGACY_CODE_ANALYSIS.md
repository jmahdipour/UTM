---
project: Universal Testing Machine (UTS)
document: AG01_LEGACY_CODE_ANALYSIS
version: 0.1
status: CONTROLLED
classification: ENGINEERING_EVIDENCE
source: REFERENCES/LEGACY/AG01.zip
source_sha256: aa0e36169785ab64087c766e7dae54b48dd5e089a09a84df914569433f83a06c
analysis_date: 2026-08-02
---

# AG01 Legacy Code Analysis

## Purpose and authority

This document extracts engineering evidence from the historical `AG01.zip` codebase. It does not freeze legacy implementation details. Authority remains: newest Frozen EDR, `AI_HANDOVER_SPECIFICATION.md`, current architecture documents, migration registers, then legacy evidence.

## Source inventory

- 32 files; 12,502 lines of VB.NET; ZIP integrity verified.
- WinForms MDI application using National Instruments UI controls.
- Main behavior is concentrated in `MainModule.vb`; UI, control, acquisition, calculation, persistence and PLC access are tightly coupled through global state.
- Referenced domain/data classes and some report forms are absent, so the archive is incomplete and is not a buildable master source.

## Compatible evidence retained

| ID | Extracted evidence | UTS disposition |
|---|---|---|
| AG-MIG-001 | Four acquired channels exist: Force/Load, crosshead displacement, extensometer deformation and time. | MIGRATED as evidence supporting GR-007; names normalize to Load, Stroke, Extension and Time. |
| AG-MIG-002 | The code anticipates multiple physical sensors: six load-cell selections and three extensometer selections. | MIGRATED as capability evidence supporting GR-009; actual inventory remains unverified. |
| AG-MIG-003 | Test samples retain time, force, displacement and deformation, while stress and strain are calculated separately. | MIGRATED as evidence supporting GR-010. |
| AG-MIG-004 | Test results include specimen identity, date/time, standard, speed, geometry, calculated points and the sample series. | MIGRATED as reporting/traceability requirements, not as a fixed report layout. |
| AG-MIG-005 | Live graphing supports channel pairs including stress-strain and retains annotations for yield, tensile maximum and break. | MIGRATED as capability evidence; detection algorithms require Event Dictionary and validated methods. |
| AG-MIG-006 | Re-Test acquisition and offline result loading/analysis are distinct paths. | MIGRATED consistently with MIG-003 and MIG-009. |
| AG-MIG-007 | Test type evidence includes tensile, compression, bending, spring, nut, screw and programmable tests. | MIGRATED only as historical scope evidence; each executable method requires a controlled standard/fixture definition. |
| AG-MIG-008 | Manual movement is disabled while a test is running and re-enabled after test completion. | MIGRATED as a safety/state-machine requirement; exact interlocks remain unresolved. |

## Candidate EDR decisions

| ID | Candidate derived from code | Required resolution |
|---|---|---|
| AG-CEDR-001 | Sensor inventory supports legacy load-cell classes 5 kgf, 100 kgf, 500 kgf, 2 Tf, 10 Tf and 25 Tf, plus three extensometer ranges. | Confirm installed hardware, serial identity, capacity, units, usable range and calibration records. |
| AG-CEDR-002 | Test lifecycle includes Initialize, Ready/Hold, Running, Hold, Stopping/Completed, Manual and Fault/Emergency concepts. | Replace string/flag state with the approved Machine/Test State Machine. |
| AG-CEDR-003 | Manual control provides Up, Down, Stop, speed and clutch ratios Off/1:1/1:10. | Safety review must define hold-to-run versus latched JOG, permissions, travel/load interlocks and stop categories. |
| AG-CEDR-004 | Legacy speed presets are 0.5, 1, 2, 3, 5, 10, 20, 30, 50, 100, 200, 300 and 500 mm/min. | Treat as configurable UI evidence only; validate machine ranges, gearing and method constraints. |
| AG-CEDR-005 | Per-sensor calibration factors and per-load-cell high limits are persisted. | Replace scalar INI values with versioned SQLite calibration and limit records linked to sensor identity and run snapshot. |
| AG-CEDR-006 | Acquisition uses a configurable sampling period and records raw sample series before derived calculations. | Define clock source, timestamps, buffer policy, dropped-sample behavior, units and immutable raw-data schema. |
| AG-CEDR-007 | Online graphing and offline re-analysis use the same stored sample channels. | Define processed-series/version provenance and ensure re-analysis never overwrites raw acquisition. |
| AG-CEDR-008 | Specimen geometries include rod, plate and pipe with separate gauge lengths for crosshead and extensometer use. | Define versioned geometry contracts and validate formulas under each controlled test-method standard. |
| AG-CEDR-009 | Report generation consumes specimen metadata, graph, test parameters and derived results. | Define report templates, approval/signature, ISO/IEC 17025 traceability, revision and export contracts. |
| AG-CEDR-010 | PLC operations include connect, status read, measurement read, movement, timer, zero/reset, mode, speed, clutch and watchdog commands. | Define a hardware-independent driver contract and simulator before validating the physical adapter. |

## Superseded implementation patterns

| ID | Legacy pattern | Governing direction |
|---|---|---|
| AG-SUP-001 | WinForms MDI and National Instruments WinForms controls. | WPF + MVVM under AI Handover §3. |
| AG-SUP-002 | Global mutable variables in a monolithic `MainModule`. | Modular services, domain objects, commands, state machine and observable view-models. |
| AG-SUP-003 | UI calls PLC, file and analysis functions directly. | GR-014 and layered hardware/acquisition/measurement/analysis/reporting architecture. |
| AG-SUP-004 | Direct calculation from just-read raw values and direct plotting from global arrays. | GR-012/GR-013; pipeline and event/data-stream EDR must govern processing. |
| AG-SUP-005 | INI scalar calibration factors and limits without sensor identity or revision. | Traceable versioned sensor calibration and run snapshot requirements. |
| AG-SUP-006 | String flags such as `ON`, `HOLD`, `OFF` plus loosely related Booleans as machine state. | Formal state machine, guarded transitions, fault model and audit events. |
| AG-SUP-007 | ReDim Preserve on every sample and a shared text file named `Test_RAW.txt`. | Bounded acquisition buffers, batched persistence and unique immutable run storage. |
| AG-SUP-008 | Hard-coded `Test_method = "Tensile"` during start. | Executable Test Method selected and validated before arming a run. |

## Reference-only hardware map

The archive contains Facon/Fatek evidence including `FaconSvr.FaconServer`, project `Autograph_svr.fcs`, status bits, measurement registers and command coils. All addresses—including X14, M0/M4/M6/M10/M11/M20/M30/M31/M40-M42/M50-M52/M60-M64/M1941, R20/R21/R25/R32/R37/R500 and T55—are **REFERENCE-ONLY**. They shall not be used on a machine until the current PLC program, electrical drawings, sign conventions, scaling, timing, safe-state behavior and watchdog semantics are independently verified.

## Formula evidence requiring validation

- Rod area: `pi * d^2 / 4`.
- Plate area: `a * b`.
- Pipe area: `pi * abs(D^2 - d^2) / 4`.
- Legacy engineering stress: `abs(Force) / Area`.
- Legacy engineering strain: `abs(Displacement) / L0 * 100`.

The stress/strain implementation uses crosshead displacement even though extensometer deformation is acquired. This is not accepted for ISO 6892-1, ASTM E8/E8M or ASTM E111 calculations without method-specific validation. Sign removal by `Abs` also loses tension/compression direction and is not migrated.

## Open verification items

1. Obtain the missing project, database/domain classes, PLC server project, report forms and configuration files if forensic compatibility is required.
2. Confirm installed load cells and extensometers; do not infer them from numeric indexes.
3. Verify all PLC addresses and safe states against the current machine.
4. Define overload, E-stop, watchdog, travel-limit and communication-loss behavior before any driver implementation.
5. Confirm whether extension or stroke is the strain source for each test phase and standard.
6. Define sampling rate, synchronization, filtering, resampling and data-quality events.
7. Validate geometry and mechanical-property formulas from controlled standard revisions.
8. Define ISO/IEC 17025-aligned report traceability and calibration provenance; SQLite alone does not provide compliance.

# End of document
