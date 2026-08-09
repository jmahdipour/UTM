# ARCHITECTURE
# Chapter 07
# State Machine Architecture

Document ID

ARCH-007

Version

0.1

Status

FROZEN

Related EDR

EDR-013

Depends On

ARCH-006 Event Detection Architecture

---

# Purpose

This chapter defines the operational state model of the Universal Testing Machine.

The State Machine controls

- what the software is allowed to do
- what the operator is allowed to do
- which Events are valid
- which commands are accepted

The State Machine does NOT perform calculations.

---

# Design Philosophy

Event ≠ State

Event

Something happened.

State

Current operating condition.

Example

Event

Test Started

↓

State changes

Ready

↓

Running

---

# State Hierarchy

```
Power Off

↓

Initialization

↓

Ready

↓

Pre-Test

↓

Running

↓

Finished

↓

Ready
```

Exception States

Pause

Abort

Emergency Stop

Fault

Maintenance

---

# Primary States

## Initialization

Purpose

Software startup.

Responsibilities

- Load configuration
- Load methods
- Load materials
- Load hardware drivers
- Verify communication

Allowed Commands

None

Exit Condition

Initialization completed.

---

## Ready

Purpose

Machine ready for operation.

Machine is idle.

No active test.

Allowed Commands

Load Order

Open Method

Zero Measurements

Move Crosshead

Select Specimen

Start Test

Diagnostics

Calibration

---

## Pre-Test

Purpose

Operator prepares specimen.

Typical actions

Install specimen

Clamp specimen

Adjust extensometer

Zero measurements

Verify setup

Allowed Commands

Move Crosshead

Zero

Diagnostics

Start Test

Cancel

---

## Running

Purpose

Active testing.

Responsibilities

Acquire data

Generate Events

Perform analysis

Store measurements

Allowed Commands

Pause

Abort

Emergency Stop

Operator Notes

Forbidden Commands

Method Editing

Material Editing

Changing hardware configuration

---

## Pause

Purpose

Temporary interruption.

Allowed Commands

Resume

Abort

Emergency Stop

Exit

Running

or

Abort

---

## Finished

Purpose

Test successfully completed.

Responsibilities

Finalize calculations

Finalize events

Generate report

Store results

Allowed Commands

Report

Export

Archive

Return to Ready

---

## Abort

Purpose

Operator terminated test.

Results remain available.

Acceptance may be skipped.

---

## Emergency Stop

Purpose

Immediate hardware stop.

Highest priority.

No calculations.

No movements.

Operator intervention required.

---

## Fault

Purpose

Unexpected software or hardware error.

Examples

Communication Failure

Sensor Failure

DAQ Failure

Memory Error

Synchronization Error

Recovery required.

---

## Maintenance

Purpose

Engineering mode.

Available only to authorized users.

Examples

Calibration

Diagnostics

Hardware Testing

Sensor Verification

---

# State Transition Diagram

```
Initialization
        ↓
Ready
        ↓
Pre-Test
        ↓
Running
   ↓      ↓
Pause   Finished
   ↓
Running

Running
   ↓
Abort

Running
   ↓
Emergency Stop

Any State
   ↓
Fault
```

---

# State Responsibilities

Initialization

↓

Prepare System

Ready

↓

Prepare Test

Pre-Test

↓

Prepare Specimen

Running

↓

Acquire & Analyze

Finished

↓

Finalize

Fault

↓

Protect System

---

# State Permissions

| State | Move Crosshead | Zero | Start | Stop | Report |
|--------|----------------|------|-------|------|--------|
| Initialization | No | No | No | No | No |
| Ready | Yes | Yes | Yes | No | Yes |
| Pre-Test | Yes | Yes | Yes | Yes | No |
| Running | Limited | No | No | Yes | No |
| Pause | Limited | No | Resume | Abort | No |
| Finished | Yes | Yes | New Test | No | Yes |
| Abort | Yes | Yes | New Test | No | Yes |
| Emergency Stop | No | No | No | No | No |
| Fault | No | No | No | No | Diagnostics |

---

# Relationship with Events

State Machine

controls

allowed transitions.

Event Engine

detects

what occurred.

Example

Current State

Running

↓

Event

Maximum Load

↓

State

Running

(no change)

Current State

Running

↓

Event

Test Finished

↓

State

Finished

---

# Relationship with UI

User Interface SHALL use the current State to

Enable Buttons

Disable Buttons

Display Status

Prevent Invalid Operations

Example

Running

↓

Disable

Method Editing

Material Editing

Calibration

---

# Relationship with Hardware

State Machine never communicates directly with hardware.

Hardware Layer reports status.

State Machine decides whether commands are permitted.

---

# Future Compatibility

The architecture shall support additional states.

Examples

Automatic Calibration

Automatic Alignment

Remote Operation

Simulation Mode

AI Assisted Testing

Production Mode

without redesign.

---

# Design Constraints

State Machine SHALL NOT

Calculate engineering values

Generate reports

Communicate with PLC

Interpret measurements

Detect Yield

Detect Fracture

These belong to other modules.

---

# Next Chapter

ARCH-008

Acceptance Engine Architecture

---

# End of Chapter