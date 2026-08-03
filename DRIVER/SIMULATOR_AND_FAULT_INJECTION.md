---
project: Universal Testing Machine (UTS)
document: SIMULATOR_AND_FAULT_INJECTION
version: 0.1
status: FROZEN
governing_edr: EDR-0009
last_revision: 2026-08-03
---

# Simulator and Fault-Injection Contract

## Determinism

The Simulator uses a virtual monotonic clock, explicit step advancement and seeded scenario data. A scenario plus seed, profile version and command sequence must reproduce identical status, sample, acknowledgement and event outputs. Tests do not depend on wall-clock sleeps or WPF timers.

## Virtual machine model

The minimum model includes connection health, driver session/profile identity, machine position/velocity, direction permission, Load/Stroke/Extension/Time channels, drive ready/fault, stationary proof, E-stop, hard/soft limits, overload, watchdog, active program/segment and JOG lease.

It is a behavioral conformance model, not a finite-element or safety-certified machine model.

## Scenario structure

Each versioned scenario declares:

- initial driver/machine/run conditions;
- active capabilities and channel metadata;
- virtual clock and scan/sample schedule;
- command inputs with RequestId and expected predicates;
- scheduled physical/status changes;
- injected faults and recovery proof;
- expected receipts, snapshots, quality flags, reason codes and final state;
- canonical input/output hash.

## Mandatory fault catalog

| Fault ID | Injected behavior | Required observation |
|---|---|---|
| `SIM.CONNECTION_DROP` | session lost during idle/motion | stale/unknown, assessed stop path, reconciliation, no resend |
| `SIM.ACK_TIMEOUT` | command effect/ack absent until deadline | TimedOut and lane reconciliation |
| `SIM.LATE_ACK` | acknowledgement after timeout | recorded discrepancy; no second command |
| `SIM.PARTIAL_STATUS` | coherent group incomplete | snapshot invalid/unknown; motion blocked |
| `SIM.CONTRADICTORY_STATUS` | moving and stationary both asserted | unsafe unknown/fault evidence |
| `SIM.STALE_STATUS` | scans cease while connection appears open | communication stale and motion blocked |
| `SIM.ESTOP` | E-stop activates | highest-priority reaction; no software reset |
| `SIM.HARD_LIMIT` | limit activates in commanded direction | direction blocked/protective reaction |
| `SIM.OVERLOAD` | overload activates | protective/fault reaction and persisted evidence |
| `SIM.SENSOR_MISMATCH` | observed sensor differs from binding | Arm/Start rejected |
| `SIM.CALIBRATION_INVALID` | calibration becomes inapplicable | quality/event and applicable command block |
| `SIM.SAMPLE_GAP` | sequence interval omitted | gap quality/evidence, raw data not fabricated |
| `SIM.SAMPLE_DUPLICATE` | duplicate batch delivered | idempotent handling/no duplicated evidence |
| `SIM.OUT_OF_ORDER` | old sequence arrives late | explicit rejection/quarantine policy |
| `SIM.SINK_BACKPRESSURE` | raw sink stops accepting | bounded response and run-quality/fault evidence |
| `SIM.JOG_LEASE_EXPIRE` | renew not received | stop request and no auto-resume |
| `SIM.POWER_CYCLE` | unclean restart | Handshaking/ReconciliationRequired, never Ready automatically |

## Separation from production

- Simulator has no vendor library or physical transport reference.
- Physical adapter cannot silently fall back to Simulator.
- Mode and adapter identity are permanently visible and recorded in run/command evidence.
- A Simulator run cannot be labeled as a production specimen test.

## Test layers

1. pure contract tests for DTO validation and determinism;
2. driver conformance tests applied unchanged to Simulator and adapter harness;
3. Application integration tests for guards, journaling and reconciliation;
4. physical commissioning tests with separately approved procedures.

Only layers 1–3 can be automated before hardware evidence exists.
