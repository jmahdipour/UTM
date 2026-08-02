---
project: Universal Testing Machine (UTS)
document: SAFETY_AND_INTERLOCKS
version: 0.2
status: FROZEN
classification: ARCHITECTURE
governing_edr:
  - EDR-0004
---

# Safety and Interlock Architecture

## Command path

```mermaid
flowchart TD
    UI["UI / Future API"] --> CMD["Machine State Coordinator"]
    CMD --> SAFE["Safety Supervisor"]
    SAFE --> DRV["Typed Driver"]
    DRV --> PLC["PLC / Drive"]
    HW["Physical Safety Chain"] --> PLC
    PLC --> STAT["Verified Status"]
    STAT --> SAFE
    SAFE --> EVT["Fault / Interlock Events"]
    EVT --> CMD
```

## Fail-closed rule

Motion authorization is a short-lived result of current, fresh, mutually consistent evidence. It is not a sticky Boolean. Any required unknown/stale status denies a new motion command.

## Software boundaries

- Core defines immutable safety/interlock value objects and pure guard evaluation.
- Application owns `SafetySupervisor`, state coordination, audit and permission checks.
- Infrastructure reads typed hardware status and writes typed commands.
- Presentation renders the interlock snapshot and rejection reason.
- No Presentation or Analysis code writes device registers.

## Commissioning status

This architecture is Frozen. Physical safety behavior is **not commissioned**. No numeric safety limit, PLC address, stop time, Performance Level or certification claim is Frozen until the open hardware verification items in EDR-0004 are completed.
