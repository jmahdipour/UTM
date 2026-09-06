---
project: Universal Testing Machine (UTS)
document: AUTOGRAPH_WPF_PROTOTYPE_REVIEW
version: 0.1
status: CONTROLLED
classification: ENGINEERING_EVIDENCE
source: REFERENCES/PROTOTYPES/AUTOGRAPH_WPF/Autograph_V1_2_8_Calibration_WPF_Integrated_READONLY_FIXED.zip
source_sha256: bf5fa6c4dab8f1ff3d9593720018ca8873c10571b53f22921c6addd8ff783d8b
analysis_date: 2026-08-29
related: DRIVER/HARDWARE_MAP.md, AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md, STRATEGIC_NOTES.md
---

# Autograph.WPF Prototype Review

## Purpose and authority

This document extracts engineering evidence and process observations from
`Autograph.WPF`, a separate application the owner developed outside this
repository's EDR track. It does not freeze any implementation detail, does not
change any Frozen EDR, and does not close any gate in
`DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md`. Authority remains: newest
Frozen EDR, `AI_HANDOVER_SPECIFICATION.md`, current architecture documents,
migration registers, then this kind of prototype/reference evidence.

## What it is, precisely

Four classic-style (non-SDK) VB.NET projects targeting .NET Framework 4.8 /
x86, referenced from `Autograph.WPF.sln`:

| Project | Role |
|---|---|
| `Autograph.Domain` | Minimal shared model types |
| `Autograph.Infrastructure` | `FaSvrAdapter` (real COM connection to FaSvr) and a fake/test data source |
| `Autograph.Application` | `R37CounterTracker` (rollover-aware counting) and `ExtensometerCalibration`/`ExtensometerMeasurementEngine` |
| `Autograph.WPF` | The operator shell (`MainWindow`), styled after the TrapeziumX-inspired reference already on file in `REFERENCES/LEGACY/tensile_shell.html` |

Version history (V1.1 through V1.2.8) is fully preserved inside the archive as
per-version `*_MANIFEST.txt`/`*_RELEASE_NOTES.txt` files, not reproduced in
full here; summary below.

## Version history summary

| Version | What it added |
|---|---|
| V1.1 | `R37CounterTracker`: rollover-aware continuous counting from the raw 0-32767 register, hardware-verified against two real forward rollovers |
| V1.2 | Software zero, multi-point piecewise-linear calibration, live 100 ms extension read — all read-only |
| V1.2.1 | Hardened the zero/calibration workflow (calibration invalid outside its zero reference frame) after hardware testing |
| V1.2.2-3 | Clarified/fixed calibration point capture semantics (absolute extension from zero; fresh FaSvr read at capture time) |
| V1.2.4 | Live calibration verification against a fresh read, with signed error and pass/fail at a fixed ±0.01 mm diagnostic tolerance |
| V1.2.5 | Observational calibration diagnostic output (selected segment, local slope) alongside verification |
| V1.2.6 | Dynamic multi-point calibration table, live-drawn calibration curve, CSV export of both calibration and diagnostic log |
| V1.2.7 | Per-standard calibration profiles (SG-25/50/100), selectable fit modes (piecewise linear / linear with offset / single factor), fit quality metrics (R2, max point error), certificate metadata panel |
| V1.2.8 | Operator shell rebuilt around the reference HTML visual system (dark TrapeziumX-style shell, cards, sensor-grouped calibration: Load cells / Extensometers / Crosshead) |

Every version's manifest states, without exception: PLC write disabled by
design, R37 read-only, no PLC write operation implemented or called.

## Real hardware evidence — significant

`R37CounterTracker`'s rollover logic (hysteresis thresholds at 2048 and 30720
of the 0-32767 range) is stated in the V1.1 release notes to have been
**verified against two real forward rollovers on the physical extensometer
path**, and re-verified through later versions including a reverse rollover
and a six-point calibration with interpolation. This is materially stronger
than anything else in this repository's driver evidence chain: it is a working
communication path to the real FaSvr/PLC, not source-code analysis or a
static schematic.

**This retroactively explains the extensometer zero-reading issue already
recorded in `DRIVER/HARDWARE_MAP.md`'s `R37` row and
`SHIMADZU_EXTENSOMETER_MANUAL_REVIEW.md`.** R37 is a 16-bit counter that wraps
at 32768. The legacy `AG01`/`Autograph` VB6-era code path reviewed earlier
(`MainModule.vb`'s `Read_Deformation`) has no rollover-handling logic at all —
it reads the raw register directly. Every time the counter wraps, the raw
value genuinely passes near zero, which a rollover-unaware reader displays as
a real zero extension. `Autograph.WPF`'s `R37CounterTracker` is precisely the
missing piece: converting the wrapping raw register into a continuous count.
This is a plausible, well-supported explanation, not a confirmed root-cause
determination — the owner has not yet confirmed the reported bug disappears
when using this tracker.

**`FaSvrAdapter`'s connection approach is worth preserving as a pattern**: it
uses late-bound COM invocation via `Type.GetTypeFromProgID` and
`InvokeMember`, rather than a compile-time COM interop reference. This avoids
requiring a registered type library on every development machine, at the cost
of losing compile-time type checking on the FaSvr calls — a reasonable
trade-off for a diagnostic tool, worth a deliberate decision (not a default)
if carried into `UTS`'s own driver adapter.

## Relationship to the UTS Solution — deliberately not integrated

This is not, and does not claim to be, part of `UTS`. Concretely:

- Different project system entirely: classic-style `.vbproj` (`<TargetFrameworkVersion>`, `<PlatformTarget>`) versus `UTS`'s SDK-style `.vbproj` (`<TargetFramework>net48</TargetFramework>` inherited from `Directory.Build.props`).
- Different namespace/domain model: `Autograph.*` versus `UTS.*`; no shared assemblies, no `ProjectReference` between the two solutions.
- Does not implement or reference any UTS contract (`EDR-0001` measurement/event separation, `EDR-0002` Test Method model, `EDR-0005` sensor/calibration lifecycle, `EDR-0009` driver contract). Its own calibration model (`ExtensometerCalibration`, session-only, not persisted to SQLite) is a simpler, self-contained design built for its own diagnostic purpose.
- Confirms, independently, one process-level observation already on file: `STRATEGIC_NOTES.md`'s eventual entry on this topic (added alongside this review) — a narrowly-scoped, pragmatic, hardware-validated tool reached real hardware faster than the fully-architected `UTS` Solution has so far. This is not a criticism of either track; the two answer different questions (`Autograph.WPF`: "does this signal path work on the real machine?"; `UTS`: "what does a complete, safety-governed, standards-traceable testing-machine software look like?").

## A build-tooling lesson worth carrying back to UTS

`Autograph.WPF` uses **classic-style** WPF project files (the traditional
`Microsoft.VisualBasic.targets`/`Microsoft.WinFx.targets`-based system, not
`Microsoft.NET.Sdk.WindowsDesktop`), and the owner reports it builds without
issue. `UTS.Presentation.Wpf` and `UTS.Bootstrapper`, built as SDK-style
projects, went through multiple rounds of `InitializeComponent`
markup-compiler failures before being rewritten without XAML entirely (see
`CHANGELOG.md`, Code v0.5). This is circumstantial, not proof, but it is
consistent with SDK-style VB.NET WPF XAML compilation being the less mature
path on the reported toolchain. Worth remembering if XAML is ever
reintroduced into `UTS.Presentation.Wpf`: classic-style project format is a
lower-risk fallback already proven on this exact machine.

## Disposition

No gate in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` changes state. No
UTS contract, EDR, or Frozen decision changes. This document records: (1) a
plausible explanation for the previously-open extensometer zero-reading
issue, (2) a real-hardware-validated reference implementation pattern for
R37 rollover handling and FaSvr COM connection, and (3) a process/tooling
observation. Whether and how to bring any of this into `UTS` proper is an
open decision for the owner, not resolved here.
