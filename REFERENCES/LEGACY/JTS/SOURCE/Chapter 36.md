# ARCHITECTURE
# Chapter 36
# Measurement Channel Architecture

Document ID

ARCH-036

Version

0.1

Status

FROZEN

Related EDR

EDR-041

Depends On

ARCH-013 Measurement Processing

ARCH-034 Data Acquisition

ARCH-035 Motion Control

---

# Purpose

This chapter defines the Measurement Channel Architecture.

The channel system is responsible for representing every measurable engineering quantity inside the software.

The architecture is completely hardware-independent.

---

# Design Philosophy

A **Channel** is a logical engineering signal.

A channel is **not** a PLC register.

A channel is **not** a DAQ input.

A channel is an engineering object.

```
Physical Sensor

↓

DAQ

↓

Engineering Channel

↓

Business Objects

↓

UI

↓

Report
```

---

# Engineering Channel Definition

Every channel contains

- Identity
- Engineering Unit
- Engineering Value
- Quality
- Timestamp
- Visibility
- Configuration

---

# Default Channels

Every machine shall contain exactly four predefined engineering channels.

| Channel | Display Name |
|----------|--------------|
| Load | Load |
| Stroke | Stroke (Crosshead) |
| Extensometer | Extensometer |
| Time | Time |

These four channels are permanent.

They cannot be deleted.

They may only be hidden if permitted by future configuration.

---

# Naming Convention

Official names

```
Load

Stroke (Crosshead)

Extensometer

Time
```

These names shall be used consistently in

UI

Methods

Reports

Graphs

CSV Export

API

Documentation

---

# Future Channels

Additional channels may be created.

Examples

Temperature

Humidity

Pressure

Torque

LVDT

Digital Input

Digital Output

Laser

Camera Position

Custom Sensor

Unlimited future expansion.

---

# Channel Categories

```
Physical

↓

Virtual

↓

Calculated

↓

System
```

---

# Physical Channels

Directly originate from hardware.

Examples

Load

Stroke

Extensometer

Temperature

Pressure

---

# Virtual Channels

Derived without changing engineering meaning.

Examples

Absolute Load

Filtered Load

Moving Average

Peak Hold

Scaled Value

---

# Calculated Channels

Produced by engineering algorithms.

Examples

Stress

Strain

Young's Modulus

True Stress

True Strain

Energy

These are NOT acquisition channels.

---

# System Channels

Generated internally.

Examples

Time

Frame Number

Sampling Rate

Machine State

Sequence Number

---

# Channel Properties

Each channel contains

Channel ID

Name

Display Name

Description

Category

Engineering Unit

Precision

Visible

Enabled

Color (UI only)

Order

Default Graph

---

# Engineering Units

Examples

Load

kN

N

kgf

lbf

---

Stroke

mm

cm

inch

---

Extensometer

mm

%

---

Time

s

ms

---

Changing display units never changes stored values.

---

# Live Value

Each channel has one current value.

```
Current Engineering Value

↓

UI

↓

Graph

↓

Analysis

↓

Recording
```

---

# Historical Values

Every channel maintains history through Measurement Frames.

History belongs to

Test Session

NOT

Channel

---

# Channel Quality

Each channel includes a quality state.

Supported

Good

Estimated

Invalid

Disconnected

Calibration Error

Overflow

Out of Range

Unknown

Quality propagates through the system.

---

# Channel Visibility

Properties

Visible

Hidden

Engineering Only

Report Only

Service Only

Administrator Only

---

# Channel Ordering

Default order

1

Load

2

Stroke (Crosshead)

3

Extensometer

4

Time

Additional channels appear after these.

The default order is frozen.

---

# Live Display

The Live Display Panel uses channels.

Each visible channel appears as

```
Display Name

↓

Engineering Value

↓

Engineering Unit
```

---

# Zero Function

As defined in previous architectural decisions,

the **engineering value display itself acts as the Zero button.**

Example

```
+12.6 kN

(click)

↓

Zero Load
```

The same behavior applies to

Load

Stroke

Extensometer

Future zero-capable channels.

Time cannot be zeroed manually.

---

# Channel Zero Policy

Zero affects

Engineering Offset

It never changes

Calibration

Raw Measurement

Historical Data

Channel Identity

---

# Sampling Independence

Channels do not own sampling rates.

Sampling belongs to

Acquisition Engine.

Channels only receive synchronized frames.

---

# Relationship with Graph

Graphs subscribe to channels.

Graphs never access hardware.

Graphs display engineering values only.

---

# Relationship with Reports

Reports reference channel names.

Reports never reference PLC addresses.

---

# Relationship with Methods

Methods select required channels.

Methods never create channels.

---

# Relationship with Hardware

Hardware mapping belongs to the Communication Layer.

The Channel Layer is unaware of

PLC Registers

DAQ Addresses

Communication Protocols

---

# Dynamic Channel Registration

Future plugins may register channels.

Example

AI Camera

↓

Creates

Surface Crack Width

as a new engineering channel.

No software redesign required.

---

# Event Publication

Whenever a channel changes,

the system publishes

```
ChannelValueUpdated
```

Payload contains

Channel ID

Timestamp

Engineering Value

Quality

---

# Performance

Supports

High-speed updates

Thousands of frames

Low latency

Thread-safe reads

Independent UI refresh

---

# Design Constraints

Measurement Channels SHALL NOT

Know PLC Registers

Know DAQ Addresses

Perform Engineering Calculations

Perform Acceptance

Generate Reports

Store Historical Frames

---

# Architectural Decision (FROZEN)

The Universal Testing Machine software shall expose all engineering measurements through a unified Measurement Channel architecture.

The four default channels

- Load
- Stroke (Crosshead)
- Extensometer
- Time

are mandatory and permanent.

Additional channels may be added without modifying the core architecture.

The engineering value display itself shall function as the Zero control for zero-capable channels, as approved in previous architectural decisions.

---

# Next Chapter

ARCH-037

Real-Time Display & Dashboard Architecture

This chapter will define

- Live Indicator Cards
- Dashboard Layout
- Numeric Displays
- Sensor Widgets
- Zero Interaction
- Status Bar
- Alarm Indicators
- Refresh Strategy
- Multi-monitor Support

---

# End of Chapter