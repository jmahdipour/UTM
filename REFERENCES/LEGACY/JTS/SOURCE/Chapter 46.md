# ARCHITECTURE
# Chapter 46
# Hardware Abstraction Layer (HAL) Architecture

Document ID

ARCH-046

Version

0.1

Status

FROZEN

Related EDR

EDR-051

Depends On

ARCH-011 Hardware Architecture

ARCH-034 Data Acquisition

ARCH-045 Communication Architecture

---

# Purpose

This chapter defines the Hardware Abstraction Layer (HAL).

The HAL isolates the software from physical hardware.

The remainder of the software shall never know

- PLC Brand
- Servo Brand
- DAQ Brand
- Sensor Manufacturer
- Communication Protocol

Changing hardware shall require only HAL modifications.

---

# Philosophy

The Business Layer works with

**Devices**

not

**Hardware Brands**

Example

```
Business Layer

↓

Load Cell

↓

HAL

↓

LS Drive

or

Shimadzu

or

Beckhoff

or

Future Hardware
```

The Business Layer never notices the difference.

---

# Architecture

```
Business Layer

↓

Device Interface

↓

Hardware Abstraction Layer

↓

Hardware Driver

↓

Physical Device
```

---

# Responsibilities

HAL SHALL

Provide Device Interfaces

Hide Hardware Details

Translate Commands

Normalize Measurements

Manage Device Capabilities

Publish Device Status

---

# SHALL NOT

Perform Engineering Calculations

Generate Reports

Perform Acceptance

Store Data

Access SQLite

---

# Abstract Devices

HAL defines logical devices

Load Cell

Stroke Encoder

Extensometer

DAQ

Servo

PLC

Digital IO

Analog IO

Emergency System

---

# Device Interfaces

Each logical device owns one interface.

Example

```
ILoadCell

IServo

IDAQ

IExtensometer

IMotionController

IEncoder
```

Business Layer communicates only through interfaces.

---

# Load Cell Abstraction

Provides

Current Load

Engineering Unit

Status

Calibration Reference

Zero Offset

Capacity

Resolution

The Business Layer never accesses ADC values.

---

# Stroke Device

Provides

Position

Velocity

Direction

Limits

Zero

Status

Independent of encoder type.

---

# Extensometer Device

Provides

Extension

Gauge Length

Status

Resolution

Calibration

Supports

Mechanical

Optical

Laser

Video

Future Types

---

# Servo Device

Provides

Enable

Disable

Speed

Direction

Position

Alarm

Ready

Reset

Brand independent.

---

# PLC Device

Provides

Machine State

Inputs

Outputs

Commands

Status

Never exposes PLC registers.

---

# DAQ Device

Provides

Engineering Samples

Sampling Status

Synchronization

Health

No hardware-specific API exposed.

---

# Digital IO

Provides

Input

Output

Status

Debounce

Future Expansion

---

# Emergency System

Provides

Emergency Stop

Safety Door

Interlock

Reset

Safety Status

Independent of PLC implementation.

---

# Device Discovery

HAL automatically detects

Configured Devices

↓

Creates

Logical Devices

↓

Registers

System Interfaces

---

# Device Registration

Example

```
Load Cell

↓

Register

↓

Device Manager

↓

Ready
```

Supports dynamic registration.

---

# Capability Model

Each device reports

Capabilities

Example

Servo

Supports

Absolute Position

Velocity

Acceleration

JOG

Home

If unsupported

Capability returns false.

---

# Device Status

Supported

Offline

Connecting

Ready

Busy

Running

Fault

Maintenance

Disabled

---

# Device Health

Reports

Temperature

Voltage

Communication

Diagnostics

Calibration Status

Future Health Indicators

---

# Device Manager

Responsibilities

Create Devices

Destroy Devices

Monitor Devices

Restart Devices

Notify Event Bus

---

# Device Events

Published

DeviceConnected

DeviceDisconnected

DeviceFault

DeviceRecovered

DeviceReady

CapabilityChanged

---

# Thread Safety

Each device owns

Independent Synchronization

HAL prevents concurrent access conflicts.

---

# Multi-Machine Support

Architecture supports

One Machine

Multiple Machines

Distributed Machines

Remote Devices

without redesign.

---

# Hardware Replacement

Example

Current

```
LS Servo
```

Replacement

```
Mitsubishi Servo
```

Only

Servo Driver

changes.

Business Layer remains identical.

---

# Legacy Compatibility

Legacy Shimadzu hardware

Supported

through

Legacy HAL Driver

No architecture changes required.

---

# Plugin Integration

Future plugins may register

New Devices

New Drivers

New Sensor Types

without modifying HAL Core.

---

# Logging

HAL generates

Hardware Logs

Driver Logs

Diagnostics

Device Statistics

---

# Performance

Supports

Low Latency

Real-Time Updates

High-Speed Sampling

Asynchronous Drivers

Non-blocking Communication

---

# Future Compatibility

Supports

Hydraulic Systems

Electromechanical Systems

Pneumatic Systems

Robot Systems

Vision Systems

Future Hardware

without redesign.

---

# Design Constraints

HAL SHALL NOT

Contain Business Logic

Calculate Engineering Properties

Generate Reports

Modify Acceptance

Execute SQL

Render UI

---

# Architectural Decision (FROZEN)

The Universal Testing Machine software shall interact only with logical devices defined by the Hardware Abstraction Layer.

The Core software shall never depend on any specific hardware manufacturer or communication protocol.

Replacing any hardware component shall require only a new HAL driver implementation.

This decision is permanent.

---

# Next Chapter

ARCH-047

Configuration Management Architecture

This chapter will define

- Global Settings
- Machine Settings
- User Settings
- Method Settings
- Configuration Versioning
- Import / Export Settings
- Default Values
- Configuration Profiles

---

# End of Chapter