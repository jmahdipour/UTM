---
project: Universal Testing Machine (UTS)
document: DRIVER_ACCEPTANCE_TESTS
version: 0.1
status: FROZEN
governing_edr: EDR-0009
last_revision: 2026-08-03
---

# Driver Acceptance Tests

Result vocabulary: `PASS-DOC`, `PENDING-CODE`, `BLOCKED-HARDWARE`. Document results validate the Frozen contract package only; they are not executable or commissioning evidence.

| Test | Acceptance criterion | Evidence/result |
|---|---|---|
| DAT-001 | driver cannot publish authoritative Machine state | contract assigns only typed observations; PASS-DOC |
| DAT-002 | connection/fault observations map without Boolean defaults | executable contract test; PENDING-CODE |
| DAT-003 | restart/reconnect never resumes prior motion | Simulator scenario; PENDING-CODE |
| DAT-004 | receipts distinguish Ack/Reject/Timeout/Fail; timeout reconciles | conformance test; PENDING-CODE |
| DAT-005 | invalid guarded capability is rejected before native write | adapter spy test; PENDING-CODE |
| DAT-006 | only verified 0.1/1/10 JOG presets advertised; no clutch API | catalog/static inspection; PASS-DOC |
| DAT-007 | receipt retains correlation/session/profile/ack predicate | serialization test; PENDING-CODE |
| DAT-008 | E-stop/final-limit/drive-disable work independently of PC | physical validation; BLOCKED-HARDWARE |
| DAT-009 | status/heartbeat continue while WPF rendering is blocked | integration test; PENDING-CODE |
| DAT-010 | higher-priority fault pre-empts ordinary motion intent | Simulator fault test; PENDING-CODE |
| DAT-011 | API uses semantic Stop intent and makes no category claim | document/static inspection; PASS-DOC |
| DAT-012 | partial/stale/contradictory snapshot is unsafe unknown | Simulator scenario; PENDING-CODE |
| DAT-013 | Connect alone never reaches CommandReady/Machine Ready | conformance test; PENDING-CODE |
| DAT-014 | JOG stops on lease/heartbeat/interlock loss | Simulator scenario; PENDING-CODE |
| DAT-015 | force-jump parameters/reaction verified per machine/profile | commissioning test; BLOCKED-HARDWARE |
| DAT-016 | reconnect returns to handshake; command not resent | Simulator late-ack/reconnect scenario; PENDING-CODE |
| DAT-017 | no driver command emulates physical E-stop reset | command-catalog static inspection; PASS-DOC |
| DAT-018 | all physical safety/commissioning gates have signed results | gate register; BLOCKED-HARDWARE |
| DAT-019 | actual E-stop/limits/watchdog/map/ack are verified | commissioning evidence; BLOCKED-HARDWARE |
| DAT-020 | sensor, installation, calibration and binding IDs remain distinct | DTO/serialization test; PENDING-CODE |
| DAT-021 | six legacy load cells/three extensometers are not auto-created | map/static inspection; PASS-DOC |
| DAT-022 | released point records type/order/polarity/unit/scale/freshness/evidence | profile validation; BLOCKED-HARDWARE |
| DAT-023 | frame preserves raw provenance/quality and never maps unknown to zero | contract test; PENDING-CODE |
| DAT-024 | zero/tare produces a new correction identity and no raw rewrite | integration test; PENDING-CODE |
| DAT-025 | verified sensor range/overload blocks incompatible motion | commissioning test; BLOCKED-HARDWARE |
| DAT-026 | Arm rejects missing capability/calibration/range/sampling | Application+Simulator test; PENDING-CODE |
| DAT-027 | WPF project cannot reference physical adapter/vendor library | dependency test; PENDING-CODE |
| DAT-028 | release/focus/navigation/lost input cannot sustain JOG | WPF+Simulator integration; PENDING-CODE |
| DAT-029 | sample sink is bounded and display frames cannot become raw input | integration test; PENDING-CODE |
| DAT-030 | raw kgf remains preserved and exact conversion is 9.80665 N/kgf | unit/provenance test; PENDING-CODE |
| DAT-031 | sink backpressure raises explicit quality/fault evidence | Simulator scenario; PENDING-CODE |
| DAT-032 | no REST/socket/remote-motion or generic register API exists | static package inspection; PASS-DOC |
| DAT-033 | duplicate RequestId never issues second physical command; Stop priority | conformance spy test; PENDING-CODE |
| DAT-034 | only coordinator reaches driver; lease/mapping boundary explicit | architecture inspection; PASS-DOC |
| DAT-035 | Re-Analyze/Report assemblies cannot reference driver | dependency test; PENDING-CODE |
| DAT-036 | required hardware/safety ports exist with prohibited dependencies absent | architecture inspection; PASS-DOC |
| DAT-037 | SQLite transaction is not held during driver wait | transaction integration test; PENDING-CODE |
| DAT-038 | driver failures map to stable codes with redacted details | conformance test; PENDING-CODE |
| DAT-039 | every AG01 address is marked legacy/write-disabled | hardware-map validator; PASS-DOC |
| DAT-040 | installed sensors/map/safety behavior match controlled evidence | commissioning; BLOCKED-HARDWARE |
| DAT-041 | Facon COM ProgID/project is isolated to x86 adapter | dependency/build test; PENDING-CODE |
| DAT-042 | each legacy read is verified for type/polarity/scale/timing | commissioning; BLOCKED-HARDWARE |
| DAT-043 | each legacy write has verified sequence/ack/safe state | commissioning; BLOCKED-HARDWARE |
| DAT-044 | sampling/status/watchdog run outside UI rendering timer | integration test; PENDING-CODE |
| DAT-045 | unreleased physical profile cannot enable writes | map/gate static inspection; PASS-DOC |

## Result summary

- total tests: 45
- `PASS-DOC`: 10
- `PENDING-CODE`: 26
- `BLOCKED-HARDWARE`: 9
- tests without result: 0

The document package may proceed for owner review. Physical adapter activation cannot pass until all `BLOCKED-HARDWARE` tests are replaced by signed results, and implementation is incomplete until all `PENDING-CODE` tests execute successfully.
