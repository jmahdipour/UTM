---
project: Universal Testing Machine (UTS)
document: IMPLEMENTATION_BASELINE_RTM
version: 0.1
status: FROZEN
last_revision: 2026-08-09
---

# Implementation Baseline Requirements Traceability

Status vocabulary: `DESIGN-PASS`, `PHASE2-CODE`, `PENDING-WINDOWS`, `PENDING-LATER-PHASE`, `BLOCKED-HARDWARE`. No row may have an empty status.

| ID | Requirement | Governing source | Implementation/evidence | Acceptance | Status |
|---|---|---|---|---|---|
| `BASE-001` | Production code is VB.NET/net48/x86 | AI Handover §3; EDR-0013 | common project properties | `BAT-001` | PHASE2-CODE |
| `BASE-002` | Modular Monolith dependency direction is enforced | EDR-0008; Solution Architecture | project graph validator | `BAT-002` | PHASE2-CODE |
| `BASE-003` | Presentation has no SQLite/vendor dependency | EDR-0006/0008/0009 | project/source scan | `BAT-003` | PHASE2-CODE |
| `BASE-004` | Only Bootstrapper selects concrete adapters | EDR-0009; EDR-0013 | composition project graph | `BAT-004` | PHASE2-CODE |
| `BASE-005` | No default external listener exists | EDR-0008; EDR-0010 | source/dependency scan | `BAT-005` | PHASE2-CODE |
| `BASE-006` | Windows identity maps to an enabled Actor | EDR-0010 | security Application service/migration | `BAT-006` | PENDING-LATER-PHASE |
| `BASE-007` | Payload identity/role cannot grant authority | EDR-0010 | command/session contracts | `BAT-007` | PHASE2-CODE |
| `BASE-008` | Role rename cannot change authorization | EDR-0006; EDR-0010 | permission-ID model | `BAT-008` | PENDING-LATER-PHASE |
| `BASE-009` | Stop/JOG End survive session expiry | EDR-0010 | command policy tests | `BAT-009` | PENDING-LATER-PHASE |
| `BASE-010` | Security mutations and session events are immutable/audited | EDR-0010 | forward migration/repositories | `BAT-010` | PENDING-LATER-PHASE |
| `BASE-011` | Durable operations use SQLite authority | EDR-0011 | operation migration/scheduler | `BAT-011` | PENDING-LATER-PHASE |
| `BASE-012` | Operation retry is explicit and idempotent | EDR-0011 | operation-policy tests | `BAT-012` | PENDING-LATER-PHASE |
| `BASE-013` | Machine commands cannot enter job scheduler | EDR-0011 | interface/dependency test | `BAT-013` | PHASE2-CODE |
| `BASE-014` | Startup recovery never assumes Ready/resumes motion | EDR-0003/0009/0011 | recovery coordinator | `BAT-014` | PENDING-LATER-PHASE |
| `BASE-015` | Shutdown drains or explicitly faults accepted buffers | EDR-0001/0011 | acquisition/system test | `BAT-015` | PENDING-LATER-PHASE |
| `BASE-016` | Report consumes immutable calculated evidence only | EDR-0012 | report ports/dependency test | `BAT-016` | PHASE2-CODE |
| `BASE-017` | Released report bytes/hash are immutable | EDR-0012 | migration/release tests | `BAT-017` | PENDING-LATER-PHASE |
| `BASE-018` | Simulator reports are visibly non-production | EDR-0012 | report validation test | `BAT-018` | PENDING-LATER-PHASE |
| `BASE-019` | PDF is blocked until compatibility/regression validation | EDR-0012 | Technical Baseline | `BAT-019` | DESIGN-PASS |
| `BASE-020` | Hash is not represented as digital signature | EDR-0007/0010/0012 | documentation/contracts | `BAT-020` | DESIGN-PASS |
| `BASE-021` | Package versions are centrally pinned | EDR-0013 | `Directory.Packages.props` | `BAT-021` | PHASE2-CODE |
| `BASE-022` | SQLite native x86 requires Windows smoke evidence | EDR-0013 | CI/runtime test | `BAT-022` | PENDING-WINDOWS |
| `BASE-023` | Option Strict/Explicit are enabled | EDR-0013 | common build properties | `BAT-023` | PHASE2-CODE |
| `BASE-024` | Build has no production C# project | AI Handover §3 | source/project scan | `BAT-024` | PHASE2-CODE |
| `BASE-025` | No TODO/NotImplemented/empty catch in release paths | EDR-0013 | source validator | `BAT-025` | PHASE2-CODE |
| `BASE-026` | Core physical values reject unitless/non-finite input | EDR-0007/0008/0013 | Core primitives/NUnit | `BAT-026` | PHASE2-CODE |
| `BASE-027` | kgf conversion is exactly 9.80665 N/kgf | EDR-0007 | Core unit tests | `BAT-027` | PHASE2-CODE |
| `BASE-028` | CI builds/tests Debug and Release x86 on Windows | EDR-0013 | workflow | `BAT-028` | PHASE2-CODE / PENDING-WINDOWS |
| `BASE-029` | Baseline 8-hour Simulator soak has no silent loss | EDR-0013 | performance suite | `BAT-029` | PENDING-LATER-PHASE |
| `BASE-030` | x86 private bytes remain below baseline budget | EDR-0013 | performance suite | `BAT-030` | PENDING-LATER-PHASE |
| `BASE-031` | Physical adapter remains write-disabled | EDR-0009 | no physical production adapter project | `BAT-031` | DESIGN-PASS / BLOCKED-HARDWARE |
| `BASE-032` | Documentation/EDR/master index stay synchronized | Governance | baseline validator | `BAT-032` | PHASE2-CODE |
