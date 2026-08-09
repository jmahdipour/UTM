# Universal Testing Machine (UTS)

> Professional Universal Testing Machine Software
>
> Master Documentation Repository

---

# Project Status

Current Version:

```
Documentation v0.4
```

Status:

```
Implementation Baseline and Scientific Specification Phase
```

Project State:

```
Frozen Decisions Enabled
```

---

# Objective

Develop a professional Universal Testing Machine software inspired by:

- Shimadzu TrapeziumX
- Zwick testXpert III
- Instron Bluehill Universal
- MTS TestSuite

without cloning any existing software.

The system shall be:

- Modular
- Event Driven
- Rule Based
- Hardware Independent
- Extendable
- Standard Independent

---

# Technology

Platform

- VB.NET

Framework

- .NET Framework 4.8

Architecture

- WPF
- MVVM

Database

- SQLite

CPU

- x86

---

# Documentation Structure

```
README.md

DOCUMENTATION_GOVERNANCE.md

FROZEN_DECISIONS.md

AI_HANDOVER_SPECIFICATION.md

CHANGELOG.md

ROADMAP.md

ARCHITECTURE/

ENGINEERING/

EDR/

DOMAIN/

STANDARDS/

REFERENCES/

SCIENTIFIC/

UI/
```

---

# Documentation Rules

This repository is the ONLY official project reference.

Chat conversations are NOT official documentation.

Only Frozen Decisions inside this repository are authoritative.

---

# Current Progress

Completed — architecture decisions

- Business Architecture
- Database Philosophy
- Test Method Architecture
- Material Library
- Acceptance Architecture
- Measurement Architecture
- Analysis Pipeline architecture and complete scientific scope (EDR-0014)
- Event Driven Architecture
- Executable Test Method, state, safety, metrology and UI contracts
- SQLite physical model and Application/API contracts
- Hardware-independent Driver/Simulator contract
- Identity/session/authorization architecture
- Durable operations/recovery architecture
- Reporting/validation/release architecture
- Technical delivery/dependency/performance baseline
- ISO 6892-1:2019 requirement-family RTM and detailed scientific test-case specification

In Progress

- VB.NET/.NET Framework 4.8 x86 Solution foundation
- executable architecture and Core contract tests

Pending

- remaining production implementation milestones in `ROADMAP.md`
- independent review of extracted ISO atomic packages for Clauses 1-23, Figures 1-10 and informative Annex A; atomization of Figures 11-15 and Annexes B-L; detailed ASTM E8/E8M-15a package
- serialized scientific fixtures and independent test oracles
- Scientific Engine implementation and independent closure of all `SCI-*`/`SAT-*` pairs
- Windows x86 CI/native SQLite validation
- verified physical hardware map and commissioning evidence
- production PDF renderer compatibility/visual-regression gate

---

# Coding Rules

Language

VB.NET

UI

WPF

Pattern

MVVM

Database

SQLite

Target

.NET Framework 4.8

Architecture

x86

---

# Industrial References

Primary

- Shimadzu TrapeziumX
- Zwick testXpert III
- Instron Bluehill Universal
- MTS TestSuite

Secondary

- ADMET MTESTQuattro
- Tinius Olsen Horizon

---

# License

Internal Engineering Documentation

Universal Testing Machine Project
