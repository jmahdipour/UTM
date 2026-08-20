# Autograph legacy source package

`Autograph.zip` is preserved as historical engineering evidence, uploaded by the
project owner on 2026-08-18 as the software that operates the existing physical
machine. SHA-256: `d6cf28306a546fca9ed8fb9ea929d0be2e502b513b80e877658871023a6666a4`.

It is a fuller Visual Studio source snapshot of the same `AG01` WinForms VB.NET
codebase already preserved under `REFERENCES/LEGACY/AG01/` (54 source files /
18,084 lines here, versus 32 files / 12,502 lines in the original `AG01.zip`
ingestion), plus a `Backup/AG01/` older revision, compiled binaries, and Microsoft
Access databases.

It is not authoritative implementation code and is not current-machine-verified. Do
not execute it against real hardware or reuse PLC addresses, scaling factors,
calibration values, limits, safety behavior or formulas without verification and an
approved EDR. See `/AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md` for controlled findings and
`/LEGACY_DECISION_MIGRATION_REGISTER.md` for prior AG01/JTS disposition context.

## Excluded from any ingestion: personal and business data

`DataBase/Plc_DB.mdb` (despite its name) is not a PLC register map — it is the
application's operational database, and contains real customer/lab names,
addresses, and phone numbers. None of that content was reproduced, summarized, or
committed anywhere in this repository. Only PLC/communication-driver-relevant
technical files (`.fcs` project exports, `.INI` configuration, VB.NET source) were
reviewed for engineering evidence.

The raw ZIP archive itself, and all extracted binaries/databases, remain outside
version control; only this pointer, its hash, and the derived technical findings in
`/AUTOGRAPH_LEGACY_ARCHIVE_REVIEW.md` are committed.
