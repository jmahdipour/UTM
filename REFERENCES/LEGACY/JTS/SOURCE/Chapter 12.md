# ARCHITECTURE
# Chapter 12
# Data Acquisition Architecture

Document ID

ARCH-012

Version

0.1

Status

FROZEN

Related EDR

EDR-017

Depends On

ARCH-004 Measurement Architecture

ARCH-011 Hardware Architecture

---

# Purpose

This chapter defines how physical signals are acquired from hardware and transformed into synchronized measurement samples.

The Data Acquisition Layer (DAQ Layer) is responsible only for data collection.

It never performs engineering analysis.

---

# Design Philosophy

The Data Acquisition Layer separates

Hardware

from

Measurement

Its only responsibility is to acquire reliable synchronized samples.

---

# Architecture

```
Hardware

↓

Communication

↓

Acquisition

↓

Measurement

↓

Analysis
```

---

# Responsibilities

The Acquisition Layer shall

Acquire raw values

Timestamp samples

Synchronize channels

Monitor communication quality

Buffer samples

Detect acquisition faults

Publish synchronized frames

It shall NOT

Calculate Stress

Calculate Strain

Detect Yield

Perform Acceptance

Generate Reports

---

# Acquisition Frame

The software does NOT process individual sensor values.

The software processes Acquisition Frames.

Example

Acquisition Frame

```
Timestamp

Load

Stroke

Extension

Temperature

Pressure

...

Quality Flags
```

Each frame represents one synchronized instant.

---

# Sampling Modes

Supported

Continuous Sampling

Fixed Frequency

Triggered Sampling

Adaptive Sampling

Burst Sampling

Replay Sampling

Simulation Sampling

---

# Sampling Frequency

Sampling frequency belongs to Acquisition Layer.

It is independent from

Analysis

Reporting

Acceptance

Future hardware may support different frequencies without changing architecture.

---

# Synchronization

All channels inside one frame shall represent the same instant.

Example

Wrong

```
Load → t1

Stroke → t2

Extension → t3
```

Correct

```
Frame

Time=t

Load=t

Stroke=t

Extension=t
```

---

# Timestamp

Every Acquisition Frame contains

Timestamp

Frame Number

Sequence Number

Acquisition Source

Quality Status

---

# Buffering

Acquisition Layer owns

Input Buffer

Synchronization Buffer

Output Buffer

Analysis Engine never communicates directly with hardware.

It only reads synchronized frames.

---

# Buffer Overflow

Supported policies

Stop Acquisition

Overwrite Oldest

Pause Machine

Warning Only

Configurable

---

# Lost Samples

Every missing sample shall be detected.

Possible actions

Ignore

Interpolate

Warning

Abort Test

According to Test Method configuration.

---

# Quality Flags

Each channel inside a frame shall contain quality information.

Examples

Valid

Missing

Interpolated

Noise

Overflow

Underflow

Timeout

Disconnected

Simulated

---

# Acquisition Sources

Supported

PLC

DAQ Board

Motion Controller

EtherCAT

CAN

USB

TCP/IP

Simulation Engine

Replay Engine

Future Devices

Unlimited

---

# Channel Mapping

Acquisition Channels are NOT Measurements.

Example

```
ADC Channel 1

↓

Load
```

```
Encoder Counter 3

↓

Stroke
```

Channel mapping belongs to Acquisition Layer.

---

# Acquisition Diagnostics

The Acquisition Layer shall report

Current Sampling Rate

Dropped Frames

Communication Delay

Synchronization Quality

Buffer Usage

Channel Status

---

# Recording

Every synchronized Acquisition Frame may be recorded.

Recording Modes

Disabled

Temporary

Full Test

Continuous

Ring Buffer

Replay Recording

---

# Replay

Previously recorded Acquisition Frames may be replayed.

Replay behaves exactly like live acquisition.

Analysis Engine shall not distinguish between

Live

Replay

Simulation

---

# Simulation

Simulation produces Acquisition Frames.

The rest of the software remains unchanged.

Simulation is therefore a first-class acquisition source.

---

# Error Handling

The Acquisition Layer shall detect

Communication Timeout

Synchronization Failure

Frame Corruption

Buffer Overflow

Invalid Timestamp

Channel Failure

Every error shall generate an Event.

---

# Performance Requirements

Continuous acquisition

No frame loss

Deterministic timing

Minimal latency

Hardware independent

---

# Design Constraints

The Acquisition Layer SHALL NOT

Know Order

Know Customer

Know Material

Know Acceptance

Know Test Method logic

Perform Engineering Calculations

Generate Reports

---

# Future Compatibility

The architecture shall support

Distributed DAQ

High-speed acquisition

Vision systems

AI sensors

Wireless sensors

Cloud acquisition

Real-time streaming

without redesign.

---

# Next Chapter

ARCH-013

Measurement Processing Architecture

---

# End of Chapter