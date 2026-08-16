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
- `ISO_6892_1_2019_ANNEX_C_ATOMIC_RTM.md` atomizes 25 source items from normative Annex C, Formula C.1 and Figure 12.
- `ISO_6892_1_2019_ANNEX_C_PARAMETERS.md` records 10 new gauge, grip-distance and `S0` parameter/formula candidates pending independent review.
- `ISO_6892_1_2019_ANNEX_C_ATOMIC_ACCEPTANCE.md` defines 10 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `ISO_6892_1_2019_ANNEX_D_ATOMIC_RTM.md` atomizes 64 source items from normative Annex D, Formula D.1, Tables D.1-D.3 and Figure 13.
- `ISO_6892_1_2019_ANNEX_D_PARAMETERS.md` records 31 new shape, length, table, tolerance and `S0` parameter/formula candidates pending independent review.
- `ISO_6892_1_2019_ANNEX_D_ATOMIC_ACCEPTANCE.md` defines 19 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `ISO_6892_1_2019_ANNEX_E_ATOMIC_RTM.md` atomizes 58 source items from normative Annex E, Formulas E.1-E.4 and Figures 14-15.
- `ISO_6892_1_2019_ANNEX_E_PARAMETERS.md` records 12 new tube-form, plug-geometry and `S0` parameter/formula candidates pending independent review.
- `ISO_6892_1_2019_ANNEX_E_ATOMIC_ACCEPTANCE.md` defines 15 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `ISO_6892_1_2019_ANNEX_F_ATOMIC_RTM.md` atomizes 35 source items from informative Annex F and Formulas F.1-F.3.
- `ISO_6892_1_2019_ANNEX_F_PARAMETERS.md` records 3 new stiffness-compensated rate and calibration formulas pending independent review.
- `ISO_6892_1_2019_ANNEX_F_ATOMIC_ACCEPTANCE.md` defines 8 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `ISO_6892_1_2019_ANNEX_G_ATOMIC_RTM.md` atomizes 153 source items from normative Annex G, Formulas G.1-G.8 and Tables G.1-G.3.
- `ISO_6892_1_2019_ANNEX_G_PARAMETERS.md` records 56 equipment, procedure, regression, uncertainty, reporting and evidence parameters/formulas pending independent review.
- `ISO_6892_1_2019_ANNEX_G_ATOMIC_ACCEPTANCE.md` defines 24 bidirectionally linked acceptance variants; all remain `NOT-RUN`.
- `validate_atomic_traceability.py` checks all ten packages, counts, locators, global parameter authority, cross-package identity uniqueness and SCI/SAT/parameter/variant links.

The package is a design baseline. Clauses 1-23, Figures 1-15 and Annexes A-G are atomized and routed, but their independent review remains pending. Annexes H-L and the detailed ASTM profile are not yet atomized. No serialized fixtures, scientific-engine implementation or conformity evidence exists.
