---
project: Universal Testing Machine (UTS)
document: EDR-0012
title: Reporting, Validation and Release Architecture
version: 1.0
status: FROZEN
decision_date: 2026-08-09
classification: REPORTING-AND-QUALITY-ARCHITECTURE
supersedes: none
related:
  - GR-003
  - GR-004
  - GR-006
  - GR-012
  - EDR-0001
  - EDR-0002
  - EDR-0005
  - EDR-0007
  - EDR-0008
  - EDR-0010
  - EDR-0011
---

# EDR-0012 — Reporting, Validation and Release Architecture

## Status boundary

This architecture does not claim ISO/IEC 17025 conformity, accreditation, certified standard coverage, validated physical measurements, legally binding electronic signature or production hardware commissioning.

## Decision

Reports are reproducible rendered views of immutable, already-calculated evidence. A report renderer cannot read raw samples, run scientific algorithms, evaluate new acceptance rules or alter results.

Every generation request first persists a canonical `ReportInputBundle` containing exact identities and SHA-256 hashes for Order/customer snapshot, Specimen revision, Run snapshot, method, sensors/calibrations, analysis revision, calculated properties, acceptance evaluation, report-template revision, output-unit profile, locale, renderer/build and any approved override lineage.

## Report lifecycle

| State | Meaning |
|---|---|
| `Draft` | generated artifact for review; not released |
| `Validated` | deterministic validation rules passed for the exact artifact hash |
| `Released` | authorized Actor released the validated hash under the active policy |
| `Superseded` | a later released report replaces it; history retained |
| `Revoked` | report use withdrawn with reason; evidence retained |
| `Failed` | generation/validation failed; diagnostics and inputs retained |

Editing an input, template, output profile or override creates a new report record and artifact. Released bytes never change in place.

## Template lifecycle

Report templates use Draft → Validated → Released → Retired revisions. A template defines layout, labels, bound fields, tables, charts and conditional visibility. It cannot contain arbitrary executable scripts, SQL, formulas that create mechanical properties, acceptance thresholds or machine commands.

## Required content and provenance

A released report identifies at least:

- installation/build and report/template/renderer versions;
- Order/customer/specimen/run identities;
- method/controlled-standard references without overstating coverage;
- measurement sources, units and calibration identities applicable to reported values;
- analysis revision, algorithm/recipe revision and quality/invalidity flags;
- acceptance profile/evaluation and decision-rule/uncertainty evidence when enabled;
- overrides, re-analysis and supersession lineage;
- generation, validation and release Actors/times;
- artifact SHA-256 and release-manifest identity.

Simulator and imported runs are visibly identified. A Simulator report is marked `NON-PRODUCTION — SIMULATED DATA` and cannot be released as a physical specimen result.

## Artifact formats

- CSV export is a versioned data artifact with explicit schema, delimiter, culture, decimal, units and provenance header/manifest. It is not a formatted released report.
- PDF is the controlled released document format after a compatible renderer passes font embedding, pagination, Unicode/localization, chart fidelity and regression tests on the target Windows/x86 environment.
- Until that compatibility validation passes, `IReportRenderer` remains the stable port and no PDF package is treated as production-approved.
- Print output is generated from the released artifact, never from mutable screen state.

## Validation and release evidence

Validation is deterministic for the exact input and artifact hashes and checks required fields, units, quality flags, template compatibility, page/asset integrity, artifact hash and forbidden production claims.

Release is a separate authorized command and may require separation of duties under EDR-0010. A release manifest records all hashes and approvals. SHA-256 is content identity only; cryptographic signing requires a later PKI/key-lifecycle decision.

## Persistence impact

A forward migration must add report input bundles, generation attempts, validation records, release/supersession/revocation evidence and release manifests while preserving the existing `report_record` and `artifact` identities through expand/migrate rules.

## Verification requirements

Tests must prove deterministic generation, no raw/scientific dependency, immutable released bytes, complete revision/hash provenance, Simulator watermark enforcement, template script prohibition, locale/unit reproducibility, CSV schema stability, failed-attempt retention, separation-of-duties enforcement, PDF visual regression when selected and restore of every artifact referenced by a released manifest.

## Rejected alternatives

1. **Calculate missing values during rendering** — creates unversioned scientific results.
2. **Report directly from mutable UI state** — cannot be reproduced or audited.
3. **Overwrite a released PDF after correction** — destroys the released evidence identity.
4. **Treat a hash as an electronic signature** — content integrity and signer identity are different assurances.
5. **Claim complete standard/ISO 17025 compliance from template labels** — conformity requires controlled requirements, validation and organizational evidence.

# End of EDR
