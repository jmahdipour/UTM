# ARCHITECTURE
# Chapter 53
# Test Execution & Runtime State Machine Architecture

Document ID

ARCH-053

Version

0.1

Status

FROZEN

Related EDR

EDR-058

Depends On

ARCH-028 Workflow Architecture

ARCH-034 Data Acquisition

ARCH-035 Motion Control

ARCH-045 Communication Architecture

ARCH-046 Hardware Abstraction Layer

ARCH-052 Test Method Architecture

---

# Purpose

This chapter defines the runtime architecture responsible for executing an actual mechanical test.

It defines

- Test Preparation
- Pre-Test Validation
- Ready State
- JOG
- Start
- Running
- Pause
- Resume
- Stop
- Emergency Stop
- Break Detection
- Completion
- Fault Handling
- Test Session Lifecycle

---

# Philosophy

The Test Execution Engine is the runtime coordinator.

It does not own

- Hardware drivers
- Calibration algorithms
- Mechanical property algorithms
- Acceptance rules
- Report generation

It coordinates these subsystems.

---

# Architecture

```text
Test Session

↓

Execution Controller

↓

Runtime State Machine

↓

Method Sequence

↓

Motion + Acquisition

↓

Measurement Data

↓

Calculation

↓

Acceptance

↓

Report
```

---

# Responsibilities

The Test Execution Engine SHALL

Validate Test Readiness

Create Test Session

Load Method Snapshot

Start Test

Execute Method Steps

Coordinate Acquisition

Coordinate Motion

Handle Operator Commands

Handle Stop Conditions

Handle Faults

Finalize Test

---

# SHALL NOT

Directly communicate with PLC

Directly communicate with Servo

Modify Calibration

Calculate Mechanical Properties

Evaluate PASS / FAIL

Generate Reports

---

# Test Session

Every execution creates a unique

```text
Test Session ID
```

The Test Session becomes the permanent container for

- Method Snapshot
- Specimen
- Measurements
- Runtime Events
- Calculated Results
- Acceptance Result
- Report References

---

# Runtime State Machine

Primary states

```text
Created

↓

Preparing

↓

Validating

↓

Ready

↓

Running

↓

Completed
```

Alternative paths

```text
Ready
 ↓
Paused
 ↓
Running
```

Fault path

```text
Any Active State

↓

Fault

↓

Recovery

↓

Ready
```

Emergency path

```text
Any Motion State

↓

Emergency Stop

↓

Safe
```

---

# State: Created

Test Session has been created.

Required references are established.

No machine motion is permitted.

---

# State: Preparing

The engine loads

Method Snapshot

Specimen

Material Snapshot

Acceptance Profile

Hardware Requirements

Calculation Profiles

Report Configuration

---

# State: Validating

The system validates

Machine

Hardware

Calibration

Method

Specimen

Safety

Communication

DAQ

Required Channels

---

# Validation Rules

Test cannot proceed if

Required Device Missing

Calibration Invalid

Method Incompatible

Safety Fault Active

DAQ Unavailable

Required Channel Missing

Specimen Invalid

Acceptance Profile Missing when mandatory

---

# State: Ready

All preconditions are satisfied.

Machine may accept

Start

JOG

Stop

Operator Commands

---

# JOG

JOG is an operator positioning function.

JOG is available independently of the main test sequence where machine safety permits.

Supported

Forward

Reverse

Speed Selection

Stop

---

# JOG Safety

JOG SHALL respect

Emergency Stop

Travel Limits

Machine Limits

Configured Maximum Speed

Hardware Interlocks

JOG shall never bypass safety systems.

---

# Test Start

When Start is requested

```text
Ready

↓

Start Validation

↓

Running
```

The engine records

Start Timestamp

Operator

Test Session ID

Method Version

Active Hardware

Calibration References

---

# State: Running

The Method Sequence is executed.

Example

```text
Approach

↓

Preload

↓

Measurement Start

↓

Main Test

↓

Break Detection

↓

Return

↓

Completed
```

---

# Step Execution

For each step

```text
Load Step

↓

Validate Step

↓

Execute

↓

Monitor

↓

Evaluate Stop Condition

↓

Next Step
```

---

# Runtime Monitoring

During Running the engine continuously monitors

Load

Stroke (Crosshead)

Extensometer

Time

Motion State

Safety State

Communication State

DAQ State

Stop Conditions

---

# Measurement Acquisition

Acquisition is started according to the Method.

The Execution Engine coordinates acquisition.

The DAQ subsystem remains responsible for actual data acquisition.

---

# Motion Coordination

The Execution Engine requests motion through the Motion Service.

It does not access the servo driver directly.

```text
Execution Engine

↓

Motion Service

↓

HAL

↓

Driver

↓

Servo
```

---

# Stop Conditions

The runtime evaluates configured conditions.

Examples

Maximum Load

Maximum Stroke (Crosshead)

Maximum Extension

Break

Load Drop

Time

Strain

Operator Stop

Safety Fault

---

# Pause

Pause is permitted only when the current Method Step supports pause.

When paused

```text
Motion

↓

Safe Hold / Defined State
```

DAQ behavior is determined by the Method.

---

# Resume

Resume is allowed only after

Pause State Valid

Safety Valid

Hardware Ready

Communication Valid

---

# Normal Stop

Operator may request Stop.

The system performs the configured safe stop sequence.

Example

```text
Stop Request

↓

Controlled Stop

↓

Stop Acquisition

↓

Finalize Data

↓

Completed
```

---

# Emergency Stop

Emergency Stop has priority over all normal commands.

```text
Emergency

↓

Motion Immediately Safe

↓

Acquisition State Captured

↓

Runtime Fault

↓

Safe State
```

The software shall never attempt to override a physical emergency-stop circuit.

---

# Fault State

Fault may result from

Communication Failure

DAQ Failure

Hardware Fault

Safety Interlock

Invalid Runtime State

Unexpected Device State

Database Failure

Software Exception

---

# Fault Handling

```text
Fault Detected

↓

Stop / Safe Motion

↓

Capture Diagnostic State

↓

Record Event

↓

Attempt Recovery when safe

↓

Recovery Successful

or

↓

Require Operator Intervention
```

---

# Recovery

Automatic recovery is allowed only for recoverable faults.

Examples

Communication Reconnect

DAQ Restart

Driver Restart

Non-critical Plugin Failure

Motion recovery requires explicit safety validation.

---

# Break Detection

Break detection is configured by the Method.

Detection may be based on

Force Drop

Load Threshold

Standard Rule

Strain

Manual Operator Selection

The Detection Engine determines the actual breakpoint.

---

# Test Completion

A test is completed when

All required Method Steps finish

or

A valid terminal stop condition occurs.

The system then

```text
Stop Acquisition

↓

Finalize Measurements

↓

Finalize Runtime Events

↓

Calculate Properties

↓

Evaluate Acceptance

↓

Completed
```

---

# Completion Types

Supported

Normal Completion

Break Completion

Operator Stop

Safety Stop

Fault Completion

Aborted

---

# Data Finalization

Before completion

The system guarantees

Measurement Buffer Flushed

Final Timestamp Recorded

Channel Synchronization Finalized

Method Snapshot Stored

Runtime Events Stored

---

# Calculation Trigger

After measurement finalization

```text
Test Completed

↓

Calculation Engine

↓

Mechanical Properties
```

Calculation never runs against incomplete final data unless explicitly configured for live preview.

---

# Acceptance Trigger

After calculation

```text
Mechanical Properties

↓

Acceptance Engine

↓

Acceptance Result
```

---

# Report Trigger

After acceptance

```text
Acceptance Result

↓

Report Engine

↓

Report
```

---

# Runtime Events

Important runtime events include

```text
TestCreated

TestPreparing

TestValidationStarted

TestValidationCompleted

TestReady

TestStarted

TestPaused

TestResumed

TestStopped

TestBreakDetected

TestCompleted

TestFaulted

EmergencyStopActivated
```

---

# Operator Commands

Supported

Start

Pause

Resume

Stop

Emergency Stop

JOG Forward

JOG Reverse

Reset Fault

Acknowledge Alarm

---

# Command Validation

Every command is validated against the current state.

Example

```text
Start

Allowed: Ready

Rejected: Running
```

Invalid commands are rejected without changing state.

---

# State Transition Rules

State transitions are explicit.

No subsystem may directly change the Runtime State.

Only the Execution Controller may perform legal state transitions.

---

# State Transition Logging

Every transition stores

Previous State

New State

Timestamp

Operator

Reason

Test Session ID

Correlation ID

---

# Determinism

Runtime execution must be deterministic.

The same

Method Version

Hardware Configuration

Input Conditions

shall produce the same execution sequence.

---

# Real-Time Separation

Critical execution paths shall not depend on

UI

Report Generation

Database Queries

Plugin UI

Long-running Background Tasks

---

# UI Relationship

The UI observes Runtime State.

The UI does not own the state machine.

```text
Runtime State

↓

Event Bus

↓

ViewModel

↓

UI
```

---

# Database Relationship

Runtime events and test metadata are persisted through repositories.

The active motion/acquisition loop shall not depend on synchronous database writes.

Buffered persistence may be used.

---

# Recovery After Application Restart

If the application terminates unexpectedly during a test, the system shall detect an incomplete Test Session during startup.

The recovery workflow shall

```text
Detect Incomplete Session

↓

Mark Session Interrupted

↓

Recover Stored Measurement Data

↓

Store Diagnostic Event

↓

Require Operator Review
```

The system shall never silently mark an interrupted test as PASS or Completed.

---

# Safety Priority

Priority order

```text
Physical Safety

↓

Emergency Stop

↓

Machine Safety

↓

Runtime Fault

↓

Operator Stop

↓

Method Stop Conditions

↓

Normal Completion
```

---

# Design Constraints

The Test Execution Engine SHALL NOT

Access PLC Registers Directly

Access Servo APIs Directly

Modify Raw Measurement Data

Modify Calibration

Calculate Results

Evaluate Acceptance

Generate Reports

Bypass Safety Interlocks

---

# Architectural Decision (FROZEN)

The Test Execution Engine is the single coordinator of the Test Session runtime state.

All runtime transitions shall be explicit, validated and auditable.

Physical safety and emergency-stop conditions always have priority over software commands.

The UI shall never own the test state machine.

A test interrupted by an unexpected shutdown shall remain traceable and shall never be silently converted into a successful result.

This decision is permanent.

---

# Next Chapter

ARCH-054

Test Data & Measurement Storage Architecture

This chapter will define

- Raw Measurement Frames
- Engineering Values
- Channel Storage
- Time Synchronization
- Test Data Lifecycle
- SQLite Storage Strategy
- Large Dataset Handling
- Data Integrity
- Immutable Test Data
- CSV / XML Interchange
- Historical Reproducibility

---

# End of Chapter