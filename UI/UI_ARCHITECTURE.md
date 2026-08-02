---
project: Universal Testing Machine (UTS)
document: UI_ARCHITECTURE
version: 0.2
status: FROZEN
classification: PRESENTATION
governing_edr:
  - EDR-0006
---

# WPF/MVVM UI Architecture

## Project boundaries

| Project/layer | UI responsibility |
|---|---|
| Presentation.Wpf | Views, styles, resources, navigation, ViewModels and user interaction |
| Application | Commands, queries, authorization, state guards and orchestration |
| Core | Domain/value objects and pure rules; no WPF reference |
| Infrastructure | SQLite, PLC/driver, files and exporters; no View reference |

## ViewModel families

- `ShellViewModel`;
- `ReceptionViewModel`;
- `TestWorkspaceViewModel`;
- `MethodLibraryViewModel` and seven step ViewModels;
- `CalibrationViewModel`;
- `SettingsViewModel`;
- `ReportViewModel`;
- shared `MachineStatusViewModel`, `MeasurementWidgetViewModel`, `ChartViewModel`, `CommandAvailabilityViewModel`.

## UI state rule

ViewModels consume immutable/read-only projections of machine state, run state, safety/interlocks, permissions and current data. They do not mirror the same state in independent mutable flags.

## Visual benchmark rule

Shimadzu TrapeziumX, Instron Bluehill, ZwickRoell testXpert and MTS TestSuite inform professional workflow and density. UTS does not copy vendor code, protected assets or an entire vendor interface. Frozen UTS domain, safety and command rules win over visual similarity.
