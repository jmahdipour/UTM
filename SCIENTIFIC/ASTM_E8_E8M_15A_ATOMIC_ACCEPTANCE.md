---
project: Universal Testing Machine (UTS)
document: ASTM_E8_E8M_15A_ATOMIC_ACCEPTANCE
version: 1.0
status: CONTROLLED-DRAFT
governing_edr: EDR-0014
source: REF-STD-ASTM-E8-E8M-15A
last_revision: 2026-08-17
---

# ASTM E8/E8M-15a Atomic Acceptance Variants

## Execution status

Every variant is `SPECIFIED / FIXTURE-PENDING / NOT-RUN`; expected evidence is not a PASS claim.

| Variant | Parent SAT | Preconditions and inputs | Independent oracle / assertions | Expected evidence | Current result |
|---|---|---|---|---|---|
| `AAT-ASTM15-SCOPE` | `SAT-002` | edition/unit/temperature | edition-profile oracle | 15a and one unit system only | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-DEPENDENCIES` | `SAT-002`, `SAT-010` | referenced standards | dependency manifest | current applicable evidence | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-DEFINITIONS` | `SAT-006` | confusing term pairs | terminology oracle | distinct ASTM identities | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-SIGNIFICANCE` | `SAT-002` | unsupported product/in-service claims | authority review | no overclaim | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-APPARATUS` | `SAT-010` | machine/grips/devices/extensometers | equipment manifest | qualified ranges/classes | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-SPECIMENS` | `SAT-007` | all forms/sizes/Figures 1-20 | specimen decision table | exact geometry route | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-PREPARATION` | `SAT-010` | startup/idle states | readiness oracle | warmup evidence | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-DIMENSION-AREA` | `SAT-005` | resolution bands/formulas | geometry oracle | correct S0 | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-MARKING` | `SAT-009` | mark provenance/damage | lifecycle oracle | qualified marks | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-ZERO-GRIP` | `SAT-012` | zero/preload/alignment/slip | machine-state oracle | valid zero and grip | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-SPEED-MODE` | `SAT-013` | five modes/units | mode state machine | one explicit mode | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-YIELD-SPEED` | `SAT-013`, `SAT-014`, `SAT-015` | Methods A/B/C | rate/transition oracle | limits and behavior route | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-TENSILE-SPEED` | `SAT-013` | A above/on/below 5% | post-yield speed oracle | range or exception | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-YIELD-ROUTING` | `SAT-018` | offset/EUL/upper/lower/halt | behavior matrix | one justified method | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-OFFSET` | `SAT-020` | ideal/nonideal curves | curve construction | correct offset result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-EUL` | `SAT-021` | extension/device class | EUL construction | correct EUL result | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-DISCONTINUOUS` | `SAT-018` | upper/lower/halt events | event oracle | stable identities | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-YPE` | `SAT-023` | plateau/inflection | landmark oracle | correct YPE | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-UNIFORM` | `SAT-025` | Fmax behavior | force-extension oracle | correct uniform A | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-RM` | `SAT-024` | Fmax/S0 | formula oracle | correct tensile strength | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-ELONGATION-ROUTE` | `SAT-027` | at/after selection | method matrix | no mixing | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-A-AFTER` | `SAT-027` | reassembly/gauge/fracture | post-fracture oracle | valid after-fracture A | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-A-AT` | `SAT-027` | force-drop endpoint | raw-event oracle | valid at-fracture A | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-Z` | `SAT-028`, `SAT-030` | areas/fracture position | metrology/formula oracle | valid Z | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-ROUNDING` | `SAT-037` | ties/product overrides | decimal E29 oracle | final-step rounding | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-REPLACEMENT` | `SAT-030` | enumerated reasons | attempt lifecycle | new attempt; original retained | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-REPORT` | `SAT-037` | all 8.2/8.3 fields | report contract | correct applicability | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-PRECISION` | `SAT-045` | precision as limits | negative authority oracle | information-only | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-APPENDIX` | `SAT-002` | X1-X5 promoted | authority classifier | nonmandatory only | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-FIGURES` | `SAT-038` | Figures 1-26/X5.1 | figure manifest | labels route without inventions | SPECIFIED / FIXTURE-PENDING / NOT-RUN |
| `AAT-ASTM15-TABLES` | `SAT-045` | Table 1/X1.1-X1.6 | table manifest | scope/units retained | SPECIFIED / FIXTURE-PENDING / NOT-RUN |

## Variant count and closure rule

- Atomic acceptance variants: **31**.
- Every applicable boundary must execute; an unexecuted applicable case is `BLOCKED` or `FAIL`, never `PASS`.
