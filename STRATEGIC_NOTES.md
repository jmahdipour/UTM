---
project: Universal Testing Machine (UTS)
document: STRATEGIC_NOTES
version: 0.1
status: PROPOSED
classification: STRATEGY
last_revision: 2026-08-17
---

# Strategic Notes

Non-binding observations that fall outside the engineering decision lifecycle in
`DOCUMENTATION_GOVERNANCE.md` (they are not EDRs, do not bind implementation, and
require no synchronization with `FROZEN_DECISIONS.md`). Recorded here so they are
not lost, and left for the owner to act on or dismiss independently of code work.

## SN-001: The documentation package may itself be a sellable asset

**Observation (external review, 2026-08-17):** The discipline in this repository —
full traceability from requirement to source citation to test, explicit legacy
evidence handling, a controlled decision lifecycle, atomic ISO/ASTM traceability —
matches the rigor expected of quality-system documentation in regulated domains
(e.g., IEC 62304 for medical device software, ISO/IEC 17025 for testing-laboratory
competence, ISO 13485 for medical device QMS). That rigor is valuable independently
of whether the VB.NET Solution ships on the current timeline.

**Possible uses if the primary software path is ever delayed or de-prioritized:**

- License or reference the `SCIENTIFIC/` atomic ISO 6892-1:2019/ASTM E8 traceability
  package to testing laboratories or other tensile-software developers as a
  standards-compliance reference, independent of this specific application.
- Offer the EDR/governance methodology itself (decision lifecycle, legacy-evidence
  handling, implementation-evidence gate) as a case study or template for other
  regulated-domain software projects.
- Use the documentation package's completeness as due-diligence evidence when
  seeking investment, a development partner, or a laboratory customer, even before
  Milestone 14 (system acceptance) closes.

**Why this is not an EDR:** it does not describe a bounded software contract, does
not change GR-001 through GR-014, and does not require an implementation-evidence
slice. It is a business-development observation, not an engineering decision.

**Required owner action:** none required; this is a standing note. Revisit if/when
the project's timeline, funding, or market path changes materially.

## SN-002: Two parallel tracks reached different milestones first

**Observation (2026-08-29):** by this date, `UTS` (the fully-architected,
EDR-governed Solution in this repository) had reached 11/12 buildable projects
but no confirmed run against real hardware. Separately, and outside this
repository's EDR track, the owner developed `Autograph.WPF` — a narrowly-scoped,
classic-project-format VB.NET/WPF diagnostic and calibration tool — which
reached real hardware validation (verified R37 rollover behavior on the
physical extensometer) through several iterated versions (V1.1-V1.2.8). See
`AUTOGRAPH_WPF_PROTOTYPE_REVIEW.md`.

**Why this is not a criticism of either track:** the two answer different
questions. `Autograph.WPF` answers "does this specific signal path work on the
real machine, right now?" with a small, disposable, single-purpose tool.
`UTS` answers "what does a complete, safety-governed, standards-traceable
testing-machine software system look like?" with an architecture designed to
outlast any one sensor or one machine. Reaching hardware first does not mean
the narrow tool should replace the broad architecture, and having the broader
architecture does not mean the narrow tool's hardware learnings should be
discarded.

**Why this is not an EDR:** it is a project-management/process observation,
not a bounded software contract.

**Required owner action:** none required. When ready, decide case-by-case
whether a specific piece of `Autograph.WPF` (the R37 rollover-handling
approach, the FaSvr late-bound COM connection pattern) should inform a future
`UTS` EDR — each such adoption should go through the normal evidence ->
EDR -> implementation-evidence-gate path like any other decision, not be
copied wholesale.
