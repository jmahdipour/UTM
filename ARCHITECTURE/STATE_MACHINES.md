---
project: Universal Testing Machine (UTS)
document: STATE_MACHINES
version: 0.2
status: FROZEN
classification: ARCHITECTURE
governing_edr:
  - EDR-0003
---

# Machine and Test State Architecture

## Service ownership

| Service | Authority |
|---|---|
| `IMachineStateCoordinator` | Machine state and guarded machine commands |
| `ITestRunCoordinator` | Test Run lifecycle and EndReason |
| `ISafetySupervisor` | Safety readiness, protective faults and interlock snapshot |
| `ITestRunner` | Compiled segment execution inside accepted states |
| `IDeviceDriver` | Protocol commands/status; never domain transition policy |
| ViewModels | Command requests and read-only state projection |

## Required stable rejection codes

The first implementation must include at least:

- `WrongState`;
- `ActiveRunExists`;
- `MethodNotReleased`;
- `SnapshotNotPersisted`;
- `SafetyNotReady`;
- `InterlockOpen`;
- `CapabilityMissing`;
- `SensorInvalid`;
- `CalibrationInvalid`;
- `PermissionDenied`;
- `DeviceNotAcknowledged`;
- `CommunicationUnhealthy`;
- `EmergencyStopActive`.

Human-readable/localized messages are presentation resources and must not replace stable codes.

## Recovery rule

After process or communication loss, the software enters reconciliation. It compares the persisted run journal with physical device status, finalizes or faults incomplete data, and requires stationary proof before `Ready`. Recovery never replays a motion command automatically.
