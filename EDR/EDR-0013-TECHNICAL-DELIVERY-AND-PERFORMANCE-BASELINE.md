---
project: Universal Testing Machine (UTS)
document: EDR-0013
title: Technical Delivery, Dependency, Deployment and Performance Baseline
version: 1.0
status: FROZEN
decision_date: 2026-08-09
classification: DELIVERY-ARCHITECTURE
supersedes: none
related:
  - EDR-0001
  - EDR-0006
  - EDR-0007
  - EDR-0008
  - EDR-0009
  - EDR-0011
  - EDR-0012
---

# EDR-0013 — Technical Delivery, Dependency, Deployment and Performance Baseline

## Decision

UTS is delivered as a single local **Modular Monolith**. Production code is VB.NET targeting .NET Framework 4.8 and x86. WPF/MVVM is the desktop presentation technology. SQLite is the local transactional authority. No C# production project, .NET Core/modern-.NET runtime target, microservice, external message broker, public listener or dynamic plugin loader is part of v1.

The Solution and project dependency graph are governed by `ARCHITECTURE/APPLICATION_API_CONTRACTS.md`. Only the Bootstrapper/Composition Root may reference concrete adapters and select Simulator or an approved physical mode.

## Build quality baseline

- `Option Strict On`, `Option Explicit On` and `Option Infer On` for every VB project.
- deterministic Release builds, x86 PlatformTarget and portable PDBs where supported;
- warnings are treated as errors for owned production code;
- nullable/non-finite/invalid physical values are rejected by explicit contracts;
- no `TODO`, `NotImplementedException` or empty catch in a released execution path;
- package versions are centrally pinned and changed only through reviewed baseline update;
- CI builds/tests on Windows with the .NET Framework 4.8 reference assemblies;
- build metadata records source commit, dependency baseline and schema range.

## Approved package baseline

The initial package set and status are maintained in `ENGINEERING/TECHNICAL_BASELINE.md`. A package is usable only after license, vulnerability, .NET Framework, x86/native, offline-restore and deployment smoke checks pass. Pinning a package does not by itself prove runtime compatibility.

No ORM, DI container, MVVM framework, general event bus or arbitrary scripting engine is approved for the first implementation. A small explicit Composition Root, command pipeline and MVVM primitives are owned by the Solution.

## Deployment and update

- supported runtime is an owner-approved Windows workstation with .NET Framework 4.8 enabled;
- the process remains x86 even on 64-bit Windows;
- installation is offline-capable and includes verified native prerequisites;
- application runtime does not require local Administrator rights;
- writable data, artifacts, logs and configuration are outside the installation directory with least-privilege ACLs;
- application, database schema, adapter/profile and artifact compatibility are checked at startup;
- updates are explicit, signed/verified when the release-signing mechanism is approved, backed up and never applied while a Run or maintenance operation is active;
- automatic silent application update is prohibited.

## Performance acceptance profile

The following are initial software budgets, not claims about unverified physical hardware:

| Area | Baseline acceptance target |
|---|---|
| Acquisition integrity | zero silent loss; every overflow/gap is explicit |
| Baseline synthetic load | 1,000 frames/s × 4 core channels for an 8-hour Simulator soak |
| UI isolation | forced 2-second WPF dispatcher stalls do not block acquisition/persistence |
| Live rendering | UI projections are capped/configured independently; default chart refresh no higher than 20 Hz |
| Local command latency | non-device, non-job command p95 ≤ 150 ms on the reference workstation/database |
| Query latency | common Order/Run/status query p95 ≤ 250 ms on the representative dataset |
| Startup | shell or explicit Diagnostics/Recovery result ≤ 15 s on the reference dataset |
| x86 memory | private bytes remain below 1.2 GiB during the 8-hour baseline soak |
| Shutdown | accepted buffers are drained or explicitly faulted; no silent discard |

The reference workstation, representative database/artifact set and exact measurement methodology are versioned acceptance inputs. Failure does not justify dropping raw evidence or weakening safety rules; it triggers profiling and design correction.

## Verification requirements

Architecture tests must inspect project references and source for forbidden dependencies. CI must restore pinned packages, build x86 Debug/Release, run NUnit and static validators, create a dependency manifest, and retain test results. Windows runtime tests must prove native SQLite x86 loading before persistence is promoted from baseline to implemented.

## Rejected alternatives

1. **AnyCPU** — can select an incompatible native/COM architecture and violates the Frozen x86 target.
2. **Microservices/broker for a single workstation** — increases deployment, recovery and consistency risk.
3. **Service Locator or global mutable modules** — hides dependencies and recreates AG01 coupling.
4. **Floating package versions** — makes builds and scientific evidence non-reproducible.
5. **UI timer as acquisition/watchdog owner** — violates EDR-0001, EDR-0004 and EDR-0009.
6. **Silent automatic update** — can change validated behavior during an uncontrolled state.

# End of EDR
