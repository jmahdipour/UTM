---
project: Universal Testing Machine (UTS)
document: START_HERE_FOR_NEW_ENGINEER
version: 0.1
status: CONTROLLED
classification: ONBOARDING
last_revision: 2026-08-17
---

# Start Here

This is a 10-minute map for a new engineer (human or AI) joining UTS. It tells you the order to read things in and, more importantly, *why* each document matters before you touch code. It is not authoritative on its own — `DOCUMENTATION_GOVERNANCE.md` and `FROZEN_DECISIONS.md` are. Read this first so those two make sense.

## Reading order

1. **`README.md`** — what the product is, current phase, directory map. Five minutes, gives you the shape of the whole repository.
2. **`FROZEN_DECISIONS.md`** — the master index. Skim the Golden Rules table and the EDR table. Do not try to absorb every EDR yet; just learn that this file is the single entry point and the open decision sequence at its bottom is the actual current priority.
3. **`AI_HANDOVER_SPECIFICATION.md`** — the fourteen Golden Rules (GR-001 through GR-014). This is the domain model's constitution. Almost every confusing decision later in the project traces back to one of these. In particular:
   - GR-001/GR-002 (Order is the root, not Customer) is the single most commonly violated rule in legacy material — expect to see it broken in every pre-EDR reference file.
   - GR-011 (no standalone Zero button) and GR-013 (as amended by EDR-0001) are the two rules that most change how you'd naively design the UI or the measurement pipeline.
4. **`EDR/EDR-0001` through `EDR/EDR-0009`, in order.** Each one resolves exactly one open question left by the Golden Rules. Reading them out of order makes later ones look arbitrary — EDR-0003/0004 (state machines/safety) only make sense after EDR-0001 (why raw data and domain events are separate streams).
5. **`EDR/EDR-0010` through `EDR/EDR-0014`.** These extend the same reasoning into identity, durability, reporting and the scientific engine. EDR-0014 is the largest single decision in the project — do not attempt to implement any calculation before reading `SCIENTIFIC/SCIENTIFIC_COMPLETION_SPECIFICATION.md` alongside it.
6. **`ROADMAP.md`** — where the project actually is right now, milestone by milestone. This is the only file that tells you what is real (has passing code) versus what is only decided.
7. **`LEGACY_DECISION_MIGRATION_REGISTER.md`** — read this *before* opening anything under `REFERENCES/LEGACY/`. It tells you which parts of the legacy material are safe corroborating evidence and which parts are explicitly `SUPERSEDED` and must never be copied. Skipping this step is the most common way to accidentally reintroduce an already-rejected pattern (a software JOG clutch, a Customer-rooted hierarchy, a standalone Zero button — all three exist in the legacy UI mockup and are individually rejected).

## The one rule that matters more than any single document

**No numeric value, hardware address, safety behavior, or business hierarchy from `REFERENCES/LEGACY/` may be implemented as-is.** Everything there is evidence, not authority. If a legacy file and a Frozen EDR disagree, the EDR wins, always, without exception.

## If you only have time to internalize one thing

Read the **Open decision sequence** at the bottom of `FROZEN_DECISIONS.md` before writing any code. It is the current priority order, and it changes over time — this file (`START_HERE_FOR_NEW_ENGINEER.md`) will not always be updated the same day it does, so treat `FROZEN_DECISIONS.md` as the live source and this file as the map to get there.
