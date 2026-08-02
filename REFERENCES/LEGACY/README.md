# Legacy references

The files in this directory preserve historical project analysis, vendor-reference extraction and an HTML UI prototype.

They are retained as engineering evidence only. They are not Frozen UTS specifications and must not override:

1. the newest Frozen EDR;
2. `AI_HANDOVER_SPECIFICATION.md`;
3. current architecture documents.

Use `LEGACY_DECISION_MIGRATION_REGISTER.md` at the repository root to determine whether a legacy statement is migrated, awaiting an EDR, superseded or still open.

- `MERGED_TensileTestX_Complete.md`: consolidated legacy handover, architecture notes, workflow analysis, hardware notes and appendices.
- `tensile_shell.html`: historical interactive UI shell/prototype.
- `AG01/README.md`: integrity manifest and authority warning for the supplied AG01 source archive.
- `/AG01_LEGACY_CODE_ANALYSIS.md`: controlled extraction of AG01 decisions, conflicts and verification items.

Do not implement numeric acceptance criteria, hardware addresses, calibration constants or safety behavior directly from these files without current verification and the required EDR.
