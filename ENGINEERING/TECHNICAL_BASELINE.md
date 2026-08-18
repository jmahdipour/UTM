---
project: Universal Testing Machine (UTS)
document: TECHNICAL_BASELINE
version: 0.1
status: FROZEN
governing_edr: EDR-0013
last_verified: 2026-08-09
---

# Technical Baseline

## Platform

| Item | Frozen value |
|---|---|
| Language | VB.NET only for production code |
| Target framework | .NET Framework 4.8 (`net48`) |
| UI | WPF with MVVM |
| Process architecture | x86 |
| Persistence | SQLite through ADO.NET; no ORM |
| System shape | local Modular Monolith; in-process Application API |
| Physical adapter | `BLOCKED-HARDWARE`; Simulator is the only executable motion model |

## Centrally pinned packages

| Package | Version | Scope | Baseline status |
|---|---:|---|---|
| `Microsoft.NETFramework.ReferenceAssemblies.net48` | 1.0.3 | build-only reference assemblies | PINNED |
| `System.Data.SQLite.Core` | 1.0.119 | SQLite ADO.NET/native x86 provider | PINNED; WINDOWS-X86-SMOKE-PENDING |
| `OxyPlot.Wpf` | 2.2.0 | WPF chart rendering | PINNED; UI-INTEGRATION-PENDING |
| `NLog` | 6.1.4 | diagnostic logging only | PINNED; DIAGNOSTIC-INTEGRATION-PENDING |
| `NUnit` | 4.6.1 | executable tests | PINNED |
| `NUnit3TestAdapter` | 6.2.0 | Visual Studio/VSTest adapter | PINNED |
| `Microsoft.NET.Test.Sdk` | 18.8.1 | test host integration | PINNED |

Official package evidence:

- [System.Data.SQLite.Core 1.0.119](https://www.nuget.org/packages/System.Data.SQLite.Core/1.0.119) and [official x86 binary matrix](https://system.data.sqlite.org/home/doc/branch-v1/www/downloads.wiki)
- [OxyPlot.Wpf 2.2.0](https://www.nuget.org/packages/OxyPlot.Wpf/2.2.0)
- [NLog 6.1.4](https://www.nuget.org/packages/NLog/6.1.4)
- [NUnit 4.6.1](https://www.nuget.org/packages/NUnit/4.6.1), [NUnit3TestAdapter 6.2.0](https://www.nuget.org/packages/NUnit3TestAdapter/6.2.0) and [official adapter compatibility](https://docs.nunit.org/articles/vs-test-adapter/Supported-Frameworks.html)
- [Microsoft.NET.Test.Sdk 18.8.1](https://www.nuget.org/packages/Microsoft.NET.Test.Sdk/18.8.1)
- [Microsoft .NET Framework 4.8 reference assemblies 1.0.3](https://www.nuget.org/packages/Microsoft.NETFramework.ReferenceAssemblies.net48/1.0.3)

The SQLite package is held at the established 1.0.119 line because it explicitly supplies the ADO.NET provider and x86/.NET Framework binaries. Promotion requires a Windows x86 native-load, WAL, backup and deployment smoke test. A newer version number alone is not sufficient evidence.

## Deliberately unselected

| Capability | Decision |
|---|---|
| PDF renderer | keep behind `IReportRenderer`; select only after net48/x86, license, Unicode/font, pagination and regression spike |
| DI container | none; explicit Composition Root |
| MVVM framework | none; small owned primitives |
| ORM | none; parameterized ADO.NET repositories |
| message broker | none; durable SQLite operation model |
| dynamic plugin loader | none in v1 |

## Build and validation

- Windows MSBuild/Visual Studio build tools with .NET Framework 4.8 targeting pack;
- `Debug|x86` and `Release|x86` only;
- central package versions in `Directory.Packages.props`;
- repository validators run before compilation;
- NUnit tests and architecture tests run in CI;
- native/provider, installer and long-soak tests remain Windows execution gates.

The current Linux work environment has no .NET Framework MSBuild runtime. Static project/contract/database validators can run here; a successful Windows CI build is required before this baseline is called executable.
