# ARCHITECTURE
# Chapter 45
# Communication Architecture

Document ID

ARCH-045

Version

0.1

Status

FROZEN

Related EDR

EDR-050

Depends On

ARCH-011 Hardware Architecture

ARCH-030 Event Bus

ARCH-034 Data Acquisition

ARCH-035 Motion Control

---

# Purpose

This chapter defines the Communication Architecture between the software and external hardware.

The communication subsystem provides a unified interface for

- PLC
- Servo Drive
- DAQ
- Sensors
- Legacy Shimadzu Systems
- Future Hardware

The remainder of the software shall never depend on a specific communication protocol.

---

# Philosophy

The software communicates with **devices**, not with protocols.

Changing a PLC or servo drive shall require only a new communication driver.

The Business Layer shall remain unchanged.

---

# Architecture

```
Business Layer

↓

Communication Service

↓

Communication Manager

↓

Communication Driver

↓

Protocol

↓

Hardware
```

---

# Responsibilities

Communication Layer SHALL

Connect

Disconnect

Read Data

Write Data

Monitor Connection

Recover Connection

Publish Events

---

# SHALL NOT

Perform Engineering Calculations

Perform Acceptance

Generate Reports

Modify Database

Interpret Measurements

---

# Communication Targets

Supported

PLC

Servo Drive

DAQ

Digital IO

External Sensors

Barcode Reader

Future Devices

---

# Driver Abstraction

Every hardware type uses a driver.

Examples

Fatek Driver

Shimadzu Legacy Driver

Modbus Driver

OPC UA Driver

EtherCAT Driver

Custom Driver

---

# Driver Interface

Every driver implements

```
Connect()

Disconnect()

Read()

Write()

Reset()

Status()

Reconnect()
```

The remainder of the software uses only this interface.

---

# Communication Manager

The Communication Manager

Loads Drivers

Monitors Drivers

Restarts Drivers

Publishes Status

Handles Timeouts

---

# Communication State Machine

```
Disconnected

↓

Connecting

↓

Connected

↓

Running

↓

Error

↓

Recovering

↓

Connected
```

Alternative

```
Disconnected
```

---

# Connection States

Supported

Disconnected

Connecting

Connected

Busy

Timeout

Recovering

Fault

Disabled

---

# PLC Communication

Default architecture supports

Fatek PLC

through

Communication Driver

Future PLCs require only new drivers.

---

# Current Machine Architecture

Based on previous architectural decisions

Current machine

Shimadzu AG-25TB

Modified

↓

LS Servo

↓

LS Drive

↓

Fatek PLC

↓

Autograph Server

Communication Layer remains independent of this configuration.

---

# Servo Communication

Supported

Enable

Disable

Speed Command

Direction

Alarm

Position

Status

Actual protocol hidden inside driver.

---

# DAQ Communication

DAQ Driver supplies

Engineering Samples

Sampling Status

Synchronization

Buffer Status

DAQ implementation hidden from Business Layer.

---

# Communication Cycle

```
Read Device

↓

Validate

↓

Timestamp

↓

Publish Event
```

Write cycle

```
Command

↓

Validate

↓

Send

↓

Verify

↓

Publish Result
```

---

# Timeout Handling

Each driver supports

Read Timeout

Write Timeout

Connection Timeout

Reconnect Delay

Maximum Retry

---

# Recovery Strategy

On communication failure

```
Detect Failure

↓

Publish Alarm

↓

Retry

↓

Reconnect

↓

Resume
```

If recovery fails

↓

Disconnected State

---

# Heartbeat

Supported

Periodic Heartbeat

Device Alive Check

Connection Health

Heartbeat interval configurable.

---

# Error Categories

Communication Error

Protocol Error

Timeout

CRC Error

Device Offline

Invalid Packet

Configuration Error

Driver Failure

---

# Event Publication

Communication Layer publishes

MachineConnected

MachineDisconnected

CommunicationLost

CommunicationRecovered

DriverLoaded

DriverFailed

HeartbeatTimeout

---

# Logging

Every communication error may be logged.

Includes

Timestamp

Device

Driver

Protocol

Error Code

Retry Count

Recovery Result

---

# Driver Configuration

Each driver owns

Port

IP Address

Baud Rate

Parity

Timeout

Retry Count

Polling Interval

Configuration independent from Business Layer.

---

# Multi-Device Support

Supported

Multiple PLCs

Multiple DAQs

Multiple Servo Drives

Multiple Machines

Future Distributed Systems

---

# Thread Model

Dedicated Communication Thread

↓

Driver Thread

↓

Event Queue

Communication never blocks

UI

DAQ

Analysis

Report Generation

---

# Security

Only Communication Layer may access hardware.

Business Layer never accesses

Registers

Ports

Sockets

Drivers

directly.

---

# Legacy Support

Supports

Shimadzu Legacy Communication

through dedicated driver.

Legacy compatibility does not affect new architecture.

---

# Future Compatibility

Supports

Fatek

Mitsubishi

Siemens

Omron

Beckhoff

Modbus

OPC UA

EtherCAT

CANopen

Ethernet/IP

Serial Devices

Future protocols

without redesign.

---

# Design Constraints

Communication Layer SHALL NOT

Calculate Engineering Values

Perform Acceptance

Modify Reports

Execute SQL

Render UI

Perform Motion Decisions

---

# Architectural Decision (FROZEN)

The Universal Testing Machine software shall communicate with hardware exclusively through the Communication Layer.

All hardware-specific protocols shall be isolated inside communication drivers.

Replacing a PLC, DAQ or servo drive shall not require changes to the Business Layer or Presentation Layer.

This decision is permanent.

---

# Next Chapter

ARCH-046

Hardware Abstraction Layer (HAL) Architecture

This chapter will define

- Hardware Abstraction Layer (HAL)
- Device Independence
- Sensor Abstraction
- Motion Device Abstraction
- DAQ Abstraction
- Load Cell Abstraction
- Extensometer Abstraction
- Future Hardware Compatibility

---

# End of Chapter