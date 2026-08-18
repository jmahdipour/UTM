---
project: Universal Testing Machine (UTS)
document: SOLUTION_ARCHITECTURE
version: 0.1
status: FROZEN
governing_edr:
  - EDR-0008
  - EDR-0009
  - EDR-0010
  - EDR-0011
  - EDR-0012
  - EDR-0013
  - EDR-0014
last_revision: 2026-08-09
---

# Solution Architecture

## Production assemblies

| Assembly | Responsibility | Direct project references |
|---|---|---|
| `UTS.Core` | domain primitives, units, states and pure rules | none |
| `UTS.Application.Contracts` | commands, queries, projections and outbound ports | Core |
| `UTS.Application` | use cases, authorization, coordination and transactions | Contracts, Core |
| `UTS.Infrastructure.SQLite` | migrations, repositories, raw store and audit | Contracts, Core |
| `UTS.Infrastructure.Driver.Abstractions` | shared adapter contracts/conformance utilities | Contracts, Core |
| `UTS.Infrastructure.Driver.Simulator` | deterministic virtual adapter | Driver Abstractions, Contracts, Core |
| `UTS.Infrastructure.Reporting` | renderer/export/artifact adapters | Contracts, Core |
| `UTS.Presentation.Wpf` | Views, ViewModels, resources and read-model interaction | Contracts |
| `UTS.Bootstrapper` | executable Composition Root and startup/recovery | all selected concrete assemblies |

`UTS.Presentation.Wpf` does not reference Application implementation or Infrastructure. It receives inbound handlers/read-model services from Bootstrapper through Application Contracts.

## Source layout

```text
UTS.sln
src/<production project>/
tests/<test project>/
build/
tools/
ENGINEERING/
```

All projects target `net48`/x86 and use VB.NET. Project-reference and source-scan architecture tests enforce the dependency table and prohibit provider/vendor types outside their adapters.

## Composition rule

The Bootstrapper is the only place allowed to select Simulator versus physical adapter, SQLite provider, renderer and Windows identity implementation. Physical mode defaults to `PhysicalMonitorOnly`; the current composition contains no production physical adapter.
