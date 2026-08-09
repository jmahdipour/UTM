# ARCHITECTURE
# Chapter 35
# Machine Motion & Control Architecture

Document ID

ARCH-035

Version

0.1

Status

FROZEN

Related EDR

EDR-040

Depends On

ARCH-007 State Machine

ARCH-011 Hardware Architecture

ARCH-030 Event Bus

ARCH-034 Data Acquisition

---

# Purpose

This chapter defines the complete motion control architecture of the Universal Testing Machine.

The Motion System controls

Crosshead Motion

Speed

Direction

Jogging

Positioning

Emergency Stop

Limit Protection

PLC Communication

Servo Drive Communication

This subsystem is completely independent from Engineering Analysis.

---

# Philosophy

Machine Motion is deterministic.

Engineering calculations shall never influence servo motion directly.

Motion decisions belong only to the Motion Controller.

---

# Motion Architecture

```
Operator

↓

UI

↓

Motion Service

↓

Motion Controller

↓

PLC

↓

Servo Drive

↓

Motor

↓

Crosshead
```

---

# Responsibilities

Motion Controller SHALL

Move Crosshead

Control Speed

Control Direction

Read Position

Read Motion Status

Detect Limits

Perform Homing

Execute Stop

Execute Emergency Stop

---

# SHALL NOT

Calculate Engineering Properties

Evaluate Acceptance

Generate Reports

Access SQLite

Render UI

---

# Motion Modes

Supported

Manual Jog

Automatic Test

Return Home

Position Move

Calibration Move

Maintenance Move

Recovery Move

---

# Manual Jog

Operator presses

UP

or

DOWN

Motion continues while button is held.

Release

↓

Stop

Jog speed is configurable.

---

# Automatic Test Motion

Controlled only by

Test Method

Motion Profile

PLC

Operator cannot manually jog while testing.

---

# Position Move

Move to

Absolute Position

Relative Position

Speed configurable.

---

# Homing

Supported

Reference Sensor

Encoder Zero

Manual Home

Future Absolute Encoder

---

# Speed Control

Supported

Constant Speed

Variable Speed

Step Speed

Standard Controlled Speed

Future Motion Profiles

---

# Speed Source

Speed command originates from

Test Method

or

Jog Controller

Never from Engineering Analysis.

---

# Direction

Supported

Compression

↓

Down

Tension

↓

Up

Actual direction configurable during machine commissioning.

---

# Motion State Machine

```
Idle

↓

Ready

↓

Jogging

↓

Positioning

↓

Testing

↓

Stopping

↓

Completed
```

Alternative

```
Emergency Stop
```

---

# Motion Commands

Supported

Start

Stop

Pause

Resume

Jog Up

Jog Down

Move Absolute

Move Relative

Home

Emergency Stop

Reset

---

# Motion Feedback

Controller receives

Current Position

Current Speed

Drive Status

Alarm Status

Limit Status

Servo Ready

Motion Complete

---

# Limit Detection

Supported

Software Upper Limit

Software Lower Limit

Hardware Upper Limit

Hardware Lower Limit

Emergency Limit

---

# Software Limits

Configured in software.

May be modified only by authorized users.

Prevent accidental overtravel.

---

# Hardware Limits

Detected by PLC.

Highest priority.

Cannot be overridden by software.

---

# Emergency Stop

Highest priority command.

Immediately

Stop Motion

Disable Motion Commands

Generate Alarm

Create Audit Entry

Notify UI

Testing ends in

Aborted

---

# Pause

Supported

Motion stops.

DAQ continues.

Measurements continue if configured.

Resume allowed.

---

# Resume

Returns to

Previous Speed

Previous Direction

Previous Motion State

Only if safety conditions remain valid.

---

# Communication

Motion Controller communicates only with

PLC

Never directly with

UI

SQLite

Report Engine

Analysis Engine

---

# PLC Interface

Typical commands

Enable

Disable

Run

Stop

Reset Alarm

Set Speed

Set Direction

Read Position

Read Status

Actual implementation depends on PLC protocol.

---

# Servo Drive

The architecture supports

LS

Yaskawa

Mitsubishi

Panasonic

Delta

Siemens

Future Drives

Driver-specific implementation belongs to Hardware Layer.

---

# Position Source

Default

Encoder

Future

Linear Scale

Absolute Encoder

Laser Position

External Position Sensor

---

# Motion Safety

Before movement

Verify

Servo Ready

PLC Connected

Emergency Stop Released

Limit OK

Machine Ready

Operator Authorized

If any check fails

↓

Movement rejected.

---

# Synchronization with DAQ

Motion and acquisition operate independently.

DAQ reads

Position

from engineering channels.

Motion Controller never waits for DAQ.

---

# Relationship with Test Method

Method specifies

Speed Strategy

Control Mode

Termination Condition

Motion Controller executes them.

---

# Relationship with UI

UI sends commands.

UI never generates motion logic.

---

# Relationship with Event Bus

Publishes

MotionStarted

MotionStopped

PositionReached

LimitReached

EmergencyStop

ServoAlarm

HomeCompleted

Subscribers receive notifications.

---

# Failure Handling

Examples

Servo Alarm

PLC Timeout

Communication Failure

Encoder Failure

Limit Triggered

Emergency Stop

Every failure generates

Alarm

Diagnostic Entry

Audit Record

Operator Notification

---

# Future Compatibility

Supports

Multi-Axis Machines

Hydraulic Machines

Linear Motors

Robot Loading Systems

Closed Loop Motion

Advanced Servo Controllers

without redesign.

---

# Design Constraints

Motion Controller SHALL NOT

Perform Engineering Calculations

Access Database

Generate Reports

Interpret Measurements

Evaluate Acceptance

Render User Interface

---

# Architectural Decision (FROZEN)

Machine Motion shall remain an independent deterministic subsystem.

Engineering calculations, report generation, acceptance evaluation, and UI rendering shall never directly control servo motion.

All motion commands shall pass through the centralized Motion Controller.

This decision is permanent.

---

# Next Chapter

ARCH-036

Measurement Channel Architecture

This chapter will define:

- Channel Definitions
- Engineering Units
- Default Channels
- Dynamic Channels
- Virtual Channels
- Channel Configuration
- Channel Naming
- Live Display Architecture

---

# End of Chapter