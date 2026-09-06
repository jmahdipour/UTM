# Autograph.WPF prototype archive

Source: `Autograph_V1_2_8_Calibration_WPF_Integrated_READONLY_FIXED.zip`, uploaded by
the project owner on 2026-08-29. SHA-256:
`bf5fa6c4dab8f1ff3d9593720018ca8873c10571b53f22921c6addd8ff783d8b`.

Owner statement: this package builds and runs without issue on their machine,
unlike the `UTS` Solution skeleton under `src/`/`tests/` at the time of upload.

## What this is

A separate, independently-developed VB.NET/WPF/.NET Framework 4.8/x86
application — **not** part of the `UTS` Solution (`UTS.sln`), and not built
against any Frozen EDR in this repository. It is a narrowly-scoped,
hardware-validated diagnostic and calibration tool for the extensometer
channel, evolved through versions V1.1 through V1.2.8 (manifests and release
notes for every version are preserved inside the archive). See
`AUTOGRAPH_WPF_PROTOTYPE_REVIEW.md` for the full controlled review.

## Status

Preserved as **prototype/reference evidence**, not authoritative implementation
code for UTS. It is not legacy (it is current, actively-developed, and
hardware-validated against the real machine's FaSvr/R37 path) and not part of
the UTS Solution (different project format, different namespace and domain
model entirely: `Autograph.Domain` / `Autograph.Infrastructure` /
`Autograph.Application` / `Autograph.WPF`, classic-style `.vbproj` files, not
SDK-style). No numeric value, calibration constant, or behavior from this
archive may be adopted into `UTS` without independent verification and an
approved EDR, per `DOCUMENTATION_GOVERNANCE.md`.

The raw ZIP archive itself stays outside version control; only this pointer,
its hash, and the derived findings in `AUTOGRAPH_WPF_PROTOTYPE_REVIEW.md` are
committed.
