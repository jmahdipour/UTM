---
project: Universal Testing Machine (UTS)
document: COMMISSIONING_KICKOFF_PLAN
version: 0.1
status: PROPOSED
classification: SCOPE
governing_edr: EDR-0009
related: DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md
proposed_date: 2026-08-17
proposed_by: External review (longest-feedback-loop risk)
---

# Commissioning Kickoff Plan (Gates G01-G03)

## Why this document exists

`ROADMAP.md` places physical commissioning at Milestone 15, after Milestones 1-14
(Solution, domain, driver, scientific engine, UI, reporting, packaging) are closed.
That ordering is correct for when physical *motion* is authorized. It is not correct
for when evidence-gathering should *start*, because Gates G01-G03 need none of the
software work above them:

- **G01 Machine identity** — serial/asset identity, controller, drive, installed
  options. This is a site visit and a form, not code.
- **G02 Controlled documents** — current electrical schematic, I/O list,
  communication manual, drive manual. This is document collection, not code.
- **G03 PLC/drive software** — source/export, version and cryptographic hash matching
  the installed controller. This is a controller export and a hash, not code.

None of these three gates require `src/` to exist. Deferring them to Milestone 15
means the single longest and least controllable feedback loop in the project (access
to the physical machine, its documentation, and whoever controls its PLC program)
only starts after every other milestone is already done — turning a schedule risk
that could have been retired early into the last, and least flexible, blocker.

## Proposed action

Start G01-G03 evidence-gathering now, in parallel with Milestones 1-14, using the
existing gate definitions in `DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md` without
changing them. This document does not add gates, lower evidence requirements, or
authorize any motion, read, or write — it only proposes doing the paperwork-and-access
part of G01-G03 earlier than the current milestone ordering implies.

## Minimum evidence checklist for this track

| Gate | Concrete artifact to obtain | Owner action needed |
|---|---|---|
| G01 | Machine nameplate/serial photo, controller model, drive model, installed options list | Physical access to the machine, 1 site visit |
| G02 | Electrical schematic (current revision), I/O list, communication manual, drive manual — as files, not verbal description | Request from machine builder/integrator or facilities archive |
| G03 | PLC program export (Facon/Fatek per `DRIVER/HARDWARE_MAP.md` legacy evidence) with SHA-256, and drive parameter export with version | Access to the programming port/software; may require the original integrator |

Each artifact, once obtained, is filed as `LEGACY-EVIDENCE` or `DOCUMENT-VERIFIED`
per the point lifecycle already defined in EDR-0009 — this plan does not change that
lifecycle, only the timing of when collection starts.

## Explicit non-goals

- This plan does **not** authorize `PhysicalMonitorOnly` mode by itself; that still
  requires the approved read-only subset of G05 and no writes configured, per the
  existing activation-progression table.
- This plan does **not** shorten or skip any gate; G04 onward still require the
  safety/risk work that depends on G01-G03 evidence existing first.
- This plan does **not** commit engineering time away from Milestones 1-14; it is
  sized to be ownable by whoever has physical/administrative access to the machine,
  which for a single-maintainer project may not be the same person writing code.

## Required owner action

Accept, adjust the artifact list, or reject. If accepted, track progress directly in
`DRIVER/COMMISSIONING_AND_ACTIVATION_GATES.md`'s existing gate register — this
document does not introduce a separate tracking mechanism.
