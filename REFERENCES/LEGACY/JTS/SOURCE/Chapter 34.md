# ARCHITECTURE
# Chapter 34
# Real-Time Data Acquisition & Processing Architecture

Document ID

ARCH-034

Version

0.1

Status

FROZEN

Related EDR

EDR-039

Depends On

ARCH-011 Hardware Architecture

ARCH-012 Data Acquisition

ARCH-013 Measurement Processing

ARCH-033 Calibration Architecture

---

# Purpose

This chapter defines the real-time acquisition architecture of the Universal Testing Machine.

This subsystem is responsible for

Reading Sensors

Synchronizing Channels

Applying Calibration

Generating Frames

Publishing Live Data

Supplying Analysis Engine

It is the heart of the runtime system.

---

# Philosophy

Measurements shall always be synchronized.

The software never acquires channels independently.

Everything is acquired as a single synchronized frame.

---

# Architecture Position

```
Sensors

↓

DAQ

↓

Acquisition Engine

↓

Calibration

↓

Engineering Channels

↓

Measurement Processing

↓

Event Bus
```

---

# Responsibilities

The Acquisition Engine SHALL

Acquire synchronized channels

Timestamp measurements

Generate acquisition frames

Apply calibration

Validate measurements

Publish engineering frames

Maintain acquisition timing

---

# SHALL NOT

Perform Acceptance

Calculate Mechanical Properties

Generate Reports

Interpret Results

Control UI

---

# Acquisition Cycle

```
Read Sensors

↓

Timestamp

↓

Synchronize

↓

Apply Calibration

↓

Create Frame

↓

Validate

↓

Publish
```

---

# Acquisition Frame

A frame represents one instant in time.

Each frame contains

FrameID

Sequence Number

Timestamp

Channel Values

Quality Flags

Calibration Version

Machine Status

---

# Default Engineering Channels

Every frame contains

Load

Stroke (Crosshead)

Extensometer

Time

Additional channels may exist.

---

# Additional Channels

Future channels

Temperature

Pressure

Humidity

Digital Input

Digital Output

Laser

Video

LVDT

Torque

Strain Gauge

Custom Sensors

Unlimited

---

# Sampling

Supported Modes

Fixed Frequency

Fixed Interval

Adaptive

Triggered

External Trigger

Future Modes

---

# Sampling Frequency

Architecture supports

Low Speed

Medium Speed

High Speed

Ultra High Speed

Actual values depend on hardware.

Software architecture imposes no limitation.

---

# Synchronization

All channels inside one frame must share

One Timestamp

One Sequence Number

One Acquisition Cycle

Partial frames are prohibited.

---

# Timestamp Source

Priority

Hardware Clock

↓

DAQ Clock

↓

System Clock

Timestamp precision shall remain hardware-independent.

---

# Calibration Stage

Calibration is applied immediately after acquisition.

```
Raw Sensor

↓

Calibration

↓

Engineering Value
```

Raw values are never sent to Analysis.

---

# Engineering Frame

After calibration

Frame contains

Engineering Units

Examples

kN

mm

%

s

Engineering Frames are immutable.

---

# Quality Flags

Each channel contains

Good

Estimated

Invalid

Disconnected

Out of Range

Overflow

Calibration Error

These flags propagate through the system.

---

# Buffer Architecture

```
Acquisition

↓

Input Buffer

↓

Processing Buffer

↓

History Buffer

↓

Archive
```

Independent buffers prevent data loss.

---

# Double Buffering

Supported

Acquisition Buffer

↓

Processing Buffer

Acquisition never waits for analysis.

---

# Overflow Policy

If buffers overflow

Never stop acquisition immediately.

Policy configurable

Drop Oldest

Drop Newest

Pause

Abort Test

Laboratory Defined

---

# Event Publication

Every engineering frame generates

MeasurementFrameCreated

event

↓

Event Bus

Subscribers

Graph

Analysis

Recording

Plugins

---

# Thread Model

Dedicated Threads

DAQ Thread

Processing Thread

Graph Thread

Analysis Thread

UI Thread

These threads remain isolated.

---

# Thread Independence

DAQ shall never wait for

Graph

Report

Database

UI

Plugins

Acquisition has highest priority.

---

# Machine State Awareness

Acquisition reacts to

Idle

Ready

Running

Paused

Completed

Aborted

During Idle

Sampling may be reduced.

During Running

Full acquisition enabled.

---

# Failure Handling

Examples

Sensor Failure

Communication Timeout

DAQ Failure

Synchronization Failure

Calibration Failure

Each generates

Diagnostic Event

Audit Entry

Operator Notification

---

# Recording Strategy

Measurements are stored

Sequentially

Append Only

Never overwritten

Every frame remains identifiable.

---

# Performance Requirements

Deterministic Timing

Low Latency

No Frame Reordering

No UI Blocking

No Database Blocking

Continuous Acquisition

---

# Relationship with Analysis

```
Engineering Frames

↓

Analysis Engine

↓

Mechanical Properties
```

Analysis never accesses sensors directly.

---

# Relationship with Graph

Graph receives

Published Engineering Frames

Never reads hardware directly.

---

# Relationship with Database

Acquisition publishes frames.

Repository stores frames asynchronously.

DAQ never writes directly into SQLite.

---

# Future Compatibility

Supports

Distributed DAQ

Remote Sensors

EtherCAT

CANopen

Modbus

Ethernet/IP

OPC UA

Future DAQ Systems

without redesign.

---

# Design Constraints

Acquisition SHALL NOT

Perform Acceptance

Calculate Mechanical Properties

Generate Reports

Render Graphs

Execute SQL

Depend on UI Refresh Rate

---

# Architectural Decision (FROZEN)

The entire software shall operate on synchronized Engineering Frames.

All downstream modules shall consume these frames.

No module may access sensors directly except the Acquisition Engine.

This guarantees deterministic timing, synchronized measurements, and future hardware compatibility.

---

# Next Chapter

ARCH-035

Machine Motion & Control Architecture

This chapter will define

- Servo Motion
- Crosshead Control
- Jog Control
- Speed Profiles
- Limit Detection
- Emergency Stop
- Motion State Machine
- PLC Interaction
- Drive Communication

---

# End of Chapter