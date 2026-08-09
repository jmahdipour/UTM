# ARCHITECTURE
# Chapter 11
# Hardware & Communication Architecture

Document ID

ARCH-011

Version

0.1

Status

FROZEN

Related EDR

EDR-016

Depends On

ARCH-004 Measurement Architecture

ARCH-005 Analysis Architecture

ARCH-007 State Machine

---

# Purpose

This chapter defines the hardware architecture of the Universal Testing Machine.

The architecture separates hardware completely from software logic.

The software shall remain operational even if the hardware platform changes.

---

# Design Philosophy

Hardware is replaceable.

Software Architecture is permanent.

Changing

PLC

DAQ

Servo

Inverter

Controller

Load Cell

Encoder

must NOT require redesign of the software.

---

# Layer Architecture

```
Application Layer

↓

Business Layer

↓

Analysis Layer

↓

Measurement Layer

↓

Acquisition Layer

↓

Communication Layer

↓

Hardware Layer
```

Only adjacent layers may communicate.

---

# Hardware Layer

Contains physical devices.

Examples

Load Cell

Extensometer

Encoder

Servo Drive

PLC

DAQ

Limit Switch

Emergency Switch

Motor

Temperature Sensor

Pressure Sensor

Future Hardware

Unlimited

---

# Communication Layer

Responsible only for communication.

Examples

Ethernet

RS232

RS485

USB

CAN

EtherCAT

Modbus

OPC

TCP/IP

Future Protocols

Unlimited

This layer never performs engineering calculations.

---

# Acquisition Layer

Purpose

Acquire raw hardware values.

Responsibilities

Read Sensors

Synchronize Signals

Timestamp Samples

Quality Monitoring

Buffering

Error Detection

Outputs

Raw Measurements

---

# Measurement Layer

Transforms raw acquisition into engineering measurements.

Examples

Raw ADC

↓

Load

Encoder Pulses

↓

Stroke

Extensometer Counts

↓

Extension

---

# Analysis Layer

Consumes Measurements.

Never communicates with hardware.

---

# Hardware Independence

The Analysis Layer never knows

PLC Brand

DAQ Brand

Communication Protocol

Servo Model

Load Cell Brand

Encoder Type

Only Measurements are visible.

---

# Device Categories

## Measurement Devices

Load Cell

Encoder

Extensometer

Temperature

Pressure

Torque

Future Sensors

---

## Motion Devices

Servo

Motor

Hydraulic Valve

Pneumatic Valve

Future Motion Systems

---

## Safety Devices

Emergency Stop

Upper Limit

Lower Limit

Door Switch

Safety Relay

Future Devices

---

## Communication Devices

PLC

DAQ

Motion Controller

Industrial PC

Gateway

Remote I/O

---

# Hardware Identification

Every hardware device shall contain

Device ID

Device Name

Device Type

Manufacturer

Model

Serial Number

Firmware Version

Connection Status

Health Status

---

# Connection States

Disconnected

Connecting

Connected

Fault

Simulation

Maintenance

Disabled

---

# Communication Status

Each communication channel shall report

Online

Offline

Timeout

Packet Loss

Retry Count

Communication Quality

Latency

---

# Device Diagnostics

Every device shall support

Connection Test

Status

Health

Error Code

Firmware Version

Self-Test

Future Diagnostics

---

# Sampling

Hardware sampling is independent from analysis.

Acquisition

↓

Measurement

↓

Analysis

Sampling frequency never changes engineering architecture.

---

# Time Synchronization

All acquired channels shall use the same master clock.

Example

Time

↓

Load

↓

Stroke

↓

Extension

This guarantees synchronized analysis.

---

# Hardware Replacement

Example

Old PLC

↓

New PLC

Only Communication Layer changes.

Business

Analysis

Measurement

Reporting

remain unchanged.

---

# Simulation Mode

The architecture shall support

Virtual Hardware

Offline Replay

Recorded Tests

Training Mode

Without connecting to real hardware.

---

# Future Compatibility

The architecture shall support

Electric Machines

Hydraulic Machines

Servo Systems

Multi-axis Systems

Vision Systems

Environmental Chambers

Robotic Loading

Cloud Devices

without redesign.

---

# Design Constraints

Hardware Layer SHALL NOT

Calculate Stress

Calculate Strain

Detect Yield

Perform Acceptance

Generate Reports

Contain Business Objects

---

# Next Chapter

ARCH-012

Data Acquisition Architecture

---

# End of Chapter