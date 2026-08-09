---
project: Universal Testing Machine (UTS)
document: EDR-0014
title: Scientific and Analysis Engine
version: 1.0
status: FROZEN
decision_date: 2026-08-09
classification: SCIENTIFIC-ARCHITECTURE
supersedes: none
amends:
  - AI_HANDOVER_SPECIFICATION.md GR-012
related:
  - EDR-0001
  - EDR-0002
  - EDR-0005
  - EDR-0007
  - EDR-0008
  - EDR-0011
  - EDR-0012
---

# EDR-0014 - Scientific and Analysis Engine

## Context

The existing Analysis Pipeline decision froze separation of measured and calculated data, immutable raw evidence and revisioned re-analysis. It did not define a complete scientific scope. The former Roadmap wording reduced Milestone 10 to stress-strain, Rm, Rp0.2, modulus and elongation. That wording was incomplete and could incorrectly permit a partial engine to be described as scientifically complete.

The project owner requires every applicable ISO 6892-1 point and calculation, plus explicit derived engineering analysis for logarithmic strain, true stress and curve energy. ASTM E8/E8M must remain a separate standard profile, and the ASM tensile-testing book is an engineering reference rather than a conformity authority.

## Decision

The v1 Scientific Engine is a deterministic, versioned pipeline with three isolated profile families:

1. `ISO6892_1_2019AnalysisProfile` - governed by the controlled third edition of ISO 6892-1:2019.
2. `ASTME8E8MAnalysisProfile` - governed only by the exact controlled ASTM revision selected by the Test Method; E8 and E8M unit systems are never mixed.
3. `DerivedEngineeringAnalysisProfile` - non-normative engineering properties including logarithmic strain, true stress and energy integrals, with explicit validity limits.

Shared numerical primitives may be reused, but standard-specific applicability, parameters, procedures, labels, validation and reports remain in the selected profile. A Test Method snapshot pins the profile, source revision, algorithm revision, parameters, units and quality policy before a Run is armed.

## Controlled sources

| Reference | Authority in this decision |
|---|---|
| `REF-STD-ISO-6892-1-2019` | Normative source for the ISO profile after clause-level traceability |
| `REF-STD-ASTM-E8-E8M-15A` | Historical controlled ASTM source; normative only for a Method explicitly pinned to 15a |
| `REF-SCI-ASM-TENSILE-2004` | Non-normative scientific interpretation and independent verification support |

Possession of a PDF does not prove implementation or conformity. A newer standard edition does not silently replace a released Method. Revision migration requires a controlled difference review, new profile revision and regression evidence.

## Scientific pipeline

The ordered pipeline is:

1. freeze the Run Configuration Snapshot;
2. consume immutable raw samples through controlled replay or live acquisition;
3. validate identity, order, time, unit, calibration, range and channel quality;
4. calculate canonical measured and derived series without using display-decimated data;
5. apply only declared processing and preserve unprocessed analytical inputs;
6. detect curve landmarks with source-sample provenance;
7. calculate properties under the selected profile;
8. evaluate property quality, applicability and uncertainty;
9. persist an immutable `AnalysisRevision` and result bundle;
10. expose read-only graph, report and acceptance inputs.

Live results are `Provisional`. Final results may be published only after raw evidence is finalized and the selected analysis revision completes.

## Implementation boundaries

- `UTS.Core` owns typed scientific quantities, result states and pure deterministic numerical/profile rules.
- `UTS.Application` orchestrates snapshots, live/final analysis, durable re-analysis and authorization without owning formulas in command handlers.
- `UTS.Infrastructure.SQLite` persists immutable inputs, analysis revisions, series, points, properties and provenance.
- `UTS.Presentation.Wpf` displays read models, graph markers and corrections; it never calculates reportable properties.
- `UTS.Infrastructure.Reporting` consumes immutable result bundles and performs no scientific recalculation.
- Driver and Simulator assemblies produce measurements/status only and have no scientific-profile dependency.

## Complete ISO 6892-1:2019 scope

The ISO profile covers every applicable requirement in Clauses 5 through 23 and the normative Annexes B, C, D, E and G. Informative Annexes A, F, H, I, J, K and L are retained as controlled guidance or verification evidence where applicable. Requirement-family routing is maintained in `SCIENTIFIC/REQUIREMENTS_TRACEABILITY.md`; atomic condition/table/formula coverage and its open evidence status are maintained in `SCIENTIFIC/SOURCE_COVERAGE_AUDIT.md`.

The calculated or detected catalog includes, where applicable:

- geometry and gauge quantities `a0/Ta`, `b0`, `d0`, `D0`, `L0`, `L'0`, `Lc`, `Le`, `Lt`, `Lu`, `L'u`, `S0` and `Su`;
- measured/derived series and rates `F`, `R`, `e`, extension, strain rate, estimated strain rate, crosshead separation rate and stress rate;
- curve landmarks and coordinates for force zero, preload/toe when configured, elastic evaluation bounds, yield start/end, `Fm`, fracture and every reported property;
- `Fm`, `Rm`, `ReH`, `ReL`, parameterized `Rp`, parameterized `Rt` and the verification result for parameterized `Rr`;
- `Ae`, `Ag`, `Agt`, `At`, `A`, `Z`, and `Awn` when its informative Annex J method is selected;
- `Delta Lm`, `Delta Lf`, the elastic slope `mE`, instantaneous/declared slope `m`, and Annex G modulus `E`;
- Annex G regression bounds `R1/R2` or `e1/e2`, point count, coefficient of determination `R2`, slope standard deviation `Sm` and relative standard deviation `Sm(rel)`;
- procedure, specimen, rate, uncertainty and report evidence required to decide whether each result is valid, warning, invalid or not applicable.

Parameterized properties are never hard-coded to Rp0.2. `ReH` and `ReL` are not manufactured for curves without an applicable discontinuous-yield phenomenon. `Rr` is a specified load-unload verification and is not silently substituted by an offset-line result. The slope `mE` used for proof-strength construction is not automatically reported as material modulus `E`; Annex G governs `E`.

## Derived engineering analysis

The engineering profile may calculate:

\[
\varepsilon_{true}=\ln(1+e)
\]

and, while uniform deformation and the required assumptions are valid,

\[
\sigma_{true}=\sigma_{eng}(1+e)
\]

It also calculates cumulative and interval energy density by a declared numerical integration rule:

\[
W=\int \sigma\,d\varepsilon
\]

Required energy outputs include engineering and true-curve energy to selected landmarks, total energy to fracture when valid, and explicitly defined elastic/plastic partitions. The result records curve type, limits, integration algorithm, sample range, unit and uncertainty/quality.

After necking begins, the simple area-constancy conversion is not a local true-stress measurement. Post-neck true stress requires a validated instantaneous local-area source such as an approved Vision/DIC profile. Otherwise the result is limited to the uniform region or marked `Estimated`/`InvalidBeyondNecking`; it is never presented as measured true fracture stress.

These derived properties are not labelled ISO 6892-1 requirements unless a traced clause explicitly requires them.

## Result contract

Every point, series and property records:

- value and unit, or an explicit absence status;
- applicability and `Provisional`, `Valid`, `Warning`, `Invalid`, `NotApplicable` or `Estimated` state as allowed by its contract;
- source sequence/range and graph coordinates;
- standard/profile, source edition, clause or engineering reference;
- detector/calculator version and all effective parameters;
- calibration, geometry, Method and Analysis Revision identities;
- processing provenance, quality flags, uncertainty and reason codes;
- automatic value plus any operator override, identity, reason and audit reference.

No failed calculation defaults to zero, NaN, an empty string or a fabricated point. No implicit Stroke-for-Extensometer fallback, smoothing, interpolation, gap filling, curve correction or material-library hint may alter a scientific result.

## Re-analysis and graph correction

Re-analysis is deterministic and driver-independent. It consumes immutable raw evidence and creates a new immutable `AnalysisRevision`. Manual point correction preserves both the automatic and corrected points. Display zoom, decimation and visual smoothing never change analytical inputs. Any analytical filter or interpolation is versioned, visible and separately tested.

## Scientific completion gate

The phrase **scientifically complete** is permitted only when:

- every applicable `SCI-*` requirement has executable implementation evidence;
- every paired `SAT-*` test is `PASS` against controlled Golden, synthetic, boundary and corrupted datasets;
- results have been compared with an independent calculation implementation;
- determinism, units, rounding, missing-data, noise, plateau, multi-peak, fracture and no-intersection cases pass;
- uncertainty and report fields pass for the selected standard profile;
- an independent scientific review is signed and the RTM contains no open v1 row.

Until then, the correct status is **Scientific Architecture and Scope Frozen; Implementation Pending**.

The initial 45 `SCI-*`/`SAT-*` pairs are routing families, not proof that every source condition has already been atomized or executed. `SG-02` remains open until the controlled source inventory and reviewed profile parameters are complete. This clarifies evidence status and does not reduce the Frozen full-coverage scope.

## Rejected alternatives

1. **Rm/Rp0.2-only engine** - omits required ISO properties, procedures and validity rules.
2. **One blended ISO/ASTM algorithm** - destroys revision and conformity traceability.
3. **Always return a number** - fabricates results for non-applicable or invalid curves.
4. **Use displayed graph points for analysis** - display decimation changes scientific output.
5. **Treat mE as E** - confuses a proof-strength construction slope with Annex G modulus.
6. **Extend simple true stress past necking without area data** - presents an estimate as a local measurement.
7. **Treat a hash as scientific validation** - integrity evidence does not prove numerical correctness.

# End of EDR
