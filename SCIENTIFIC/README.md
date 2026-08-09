# Scientific Package

This package defines the controlled scientific scope and evidence required by EDR-0014.

- `SCIENTIFIC_COMPLETION_SPECIFICATION.md` defines what scientific completion means.
- `REQUIREMENTS_TRACEABILITY.md` routes ISO 6892-1:2019 and derived-analysis requirement families to implementation and tests.
- `ACCEPTANCE_TESTS.md` is the controlled acceptance-case index.
- `TEST_CASE_SPECIFICATIONS.md` defines variants, execution rules, independent oracles and expected evidence for all 45 cases.
- `TEST_FIXTURE_CATALOG.md` defines analytical, geometry, quality, procedural, Golden and independent fixture contracts.
- `SOURCE_COVERAGE_AUDIT.md` records the atomic ISO/ASTM traceability gaps and scientific-gate assessment.
- `ISO_6892_1_2019_CLAUSES_01_10_ATOMIC_RTM.md` atomizes 191 source items from Clauses 1-10 and Table 1.
- `ISO_6892_1_2019_CLAUSES_01_10_PARAMETERS.md` records 53 extracted parameter/formula candidates pending independent review.
- `ISO_6892_1_2019_CLAUSES_01_10_ATOMIC_ACCEPTANCE.md` defines 30 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `ISO_6892_1_2019_CLAUSES_11_16_ATOMIC_RTM.md` atomizes 71 source items and every routed construction point from Figures 2-7.
- `ISO_6892_1_2019_CLAUSES_11_16_PARAMETERS.md` records 13 extracted parameter/formula candidates pending independent review.
- `ISO_6892_1_2019_CLAUSES_11_16_ATOMIC_ACCEPTANCE.md` defines 21 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `validate_atomic_traceability.py` checks both packages, counts, locators, cross-package identity uniqueness and SCI/SAT/parameter/variant links.

The package is a design baseline. Clauses 1-16 are atomized and routed, but their independent review remains pending. Clauses 17-23, Annexes A-L and the detailed ASTM profile are not yet atomized. No serialized fixtures, scientific-engine implementation or conformity evidence exists.
