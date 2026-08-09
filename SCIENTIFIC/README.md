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
- `ISO_6892_1_2019_CLAUSES_17_23_ATOMIC_RTM.md` atomizes 103 source items from Clauses 17-23 and the previously unatomized Figures 1 and 8-10.
- `ISO_6892_1_2019_CLAUSES_17_23_PARAMETERS.md` records 15 new parameter/formula candidates and controlled cross-package parameter reuse pending independent review.
- `ISO_6892_1_2019_CLAUSES_17_23_ATOMIC_ACCEPTANCE.md` defines 26 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `ISO_6892_1_2019_ANNEX_A_ATOMIC_RTM.md` atomizes 94 source items from informative Annex A, Figures A.1-A.2 and Table A.1.
- `ISO_6892_1_2019_ANNEX_A_PARAMETERS.md` records 19 sampling, fracture, slope and software-validation parameter/formula candidates pending independent review.
- `ISO_6892_1_2019_ANNEX_A_ATOMIC_ACCEPTANCE.md` defines 21 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `ISO_6892_1_2019_ANNEX_B_ATOMIC_RTM.md` atomizes 48 source items from normative Annex B, Tables B.1-B.2 and shared Figure 11.
- `ISO_6892_1_2019_ANNEX_B_PARAMETERS.md` records 19 new geometry, table, tolerance and area-accuracy parameter/formula candidates pending independent review.
- `ISO_6892_1_2019_ANNEX_B_ATOMIC_ACCEPTANCE.md` defines 14 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `validate_atomic_traceability.py` checks all five packages, counts, locators, global parameter authority, cross-package identity uniqueness and SCI/SAT/parameter/variant links.

The package is a design baseline. Clauses 1-23, Figures 1-11 and Annexes A-B are atomized and routed, but their independent review remains pending. Figures 12-15, Annexes C-L and the detailed ASTM profile are not yet atomized. No serialized fixtures, scientific-engine implementation or conformity evidence exists.
