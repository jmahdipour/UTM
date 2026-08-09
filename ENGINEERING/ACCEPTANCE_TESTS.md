---
project: Universal Testing Machine (UTS)
document: IMPLEMENTATION_BASELINE_ACCEPTANCE_TESTS
version: 0.1
status: FROZEN
last_revision: 2026-08-09
---

# Implementation Baseline Acceptance Tests

| Test | Acceptance criterion | Current result |
|---|---|---|
| `BAT-001` | every production project is VB, net48 and x86 | PASS-STATIC; WINDOWS-BUILD-PENDING |
| `BAT-002` | project graph exactly respects Solution Architecture | PASS-STATIC |
| `BAT-003` | WPF has no SQLite/vendor/register/driver-concrete reference | PASS-STATIC |
| `BAT-004` | concrete selection exists only in Bootstrapper | PASS-STATIC |
| `BAT-005` | no HTTP/gRPC/socket/listener package or startup code | PASS-STATIC |
| `BAT-006` | unknown/disabled SID cannot create trusted Actor session | PENDING-CODE |
| `BAT-007` | payload username/role fields cannot affect trusted Actor | PASS-STATIC; NUNIT-PENDING-WINDOWS |
| `BAT-008` | rename role with identical permissions; result is unchanged | PENDING-CODE |
| `BAT-009` | expire session during active motion; Stop/JOG End remains requestable | PENDING-CODE |
| `BAT-010` | security history cannot be updated/deleted | PENDING-CODE |
| `BAT-011` | crash durable job; accepted operation remains recoverable | PENDING-CODE |
| `BAT-012` | duplicate job request returns one operation; unsafe job never retries | PENDING-CODE |
| `BAT-013` | architecture test proves scheduler has no machine command contract | PASS-STATIC; SCHEDULER-CODE-PENDING |
| `BAT-014` | unclean restart enters reconciliation and never auto-resumes | PENDING-CODE |
| `BAT-015` | shutdown interruption records drain or explicit gap/fault | PENDING-CODE |
| `BAT-016` | Report assembly cannot reference raw replay or driver | PASS-STATIC |
| `BAT-017` | regeneration/correction creates new artifact/report identity | PENDING-CODE |
| `BAT-018` | Simulator report without non-production mark fails validation | PENDING-CODE |
| `BAT-019` | package baseline contains no production PDF renderer | PASS-STATIC |
| `BAT-020` | contracts/docs contain no signature claim for SHA-256 alone | PASS-STATIC |
| `BAT-021` | every external PackageReference resolves through central exact version | PASS-STATIC; RESTORE-PENDING-WINDOWS |
| `BAT-022` | clean Windows x86 process loads SQLite, creates DB and performs WAL transaction | PENDING-WINDOWS |
| `BAT-023` | all VB production projects enable Strict/Explicit/Infer | PASS-STATIC; WINDOWS-BUILD-PENDING |
| `BAT-024` | no `.csproj` or production `.cs` exists | PASS-STATIC |
| `BAT-025` | release-source scan finds no TODO, NotImplementedException or empty catch | PASS-STATIC |
| `BAT-026` | Core rejects NaN/infinity/incompatible quantity/unit | PENDING-EXECUTION |
| `BAT-027` | 100 kgf converts to exactly 980.665 N within declared tolerance | PENDING-EXECUTION |
| `BAT-028` | Windows CI restores, builds and tests Debug/Release x86 | PENDING-WINDOWS |
| `BAT-029` | 1,000×4-channel 8-hour Simulator soak reports zero silent loss | PENDING-CODE |
| `BAT-030` | same soak remains below 1.2 GiB private bytes | PENDING-CODE |
| `BAT-031` | physical production/commissioning write adapter is absent or write-disabled | PASS-STATIC |
| `BAT-032` | every Frozen EDR is indexed and master docs list the latest status | PASS-STATIC |
