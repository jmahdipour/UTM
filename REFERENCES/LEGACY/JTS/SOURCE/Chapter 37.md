# ARCHITECTURE
# Chapter 37
# Real-Time Display & Dashboard Architecture

Document ID

ARCH-037

Version

0.1

Status

FROZEN

Related EDR

EDR-042

Depends On

ARCH-034 Data Acquisition

ARCH-036 Measurement Channel Architecture

ARCH-030 Event Bus

---

# Purpose

This chapter defines the Real-Time Dashboard Architecture.

The Dashboard is the primary operational screen used during testing.

It shall provide immediate visibility of machine status and engineering values while maintaining a clean and stable interface.

---

# Design Philosophy

The dashboard is an **operational instrument panel**, not a configuration page.

The operator must understand the machine state within one second by looking at the dashboard.

---

# Dashboard Layout

The dashboard consists of six permanent areas.

```
----------------------------------------------------
 Ribbon
----------------------------------------------------
 Live Measurement Panel
----------------------------------------------------
 Graph Area
----------------------------------------------------
 Test Status
----------------------------------------------------
 Event / Alarm Area
----------------------------------------------------
 Status Bar
----------------------------------------------------
```

The layout remains stable during testing.

---

# Live Measurement Panel

The Live Measurement Panel displays engineering channels.

Default channels

```
Load

Stroke (Crosshead)

Extensometer

Time
```

Future channels appear below the default channels.

---

# Measurement Card

Each channel is displayed as one card.

Example

```
-------------------------
Load

25.367

kN
-------------------------
```

---

# Default Card Order

The first four cards are fixed.

```
1  Load

2  Stroke (Crosshead)

3  Extensometer

4  Time
```

This order is permanent.

---

# Additional Cards

Future channels

Temperature

Pressure

Humidity

Torque

Laser

etc.

appear after Time.

Operator may reorder optional channels.

Default channels remain fixed.

---

# Live Refresh

Dashboard refreshes from

Engineering Frames

published by the Acquisition Engine.

Dashboard never communicates directly with PLC.

---

# Refresh Strategy

Acquisition

↓

Event Bus

↓

Dashboard

↓

UI Refresh

The Dashboard never polls hardware.

---

# Zero Interaction

As approved previously,

the engineering value itself functions as the Zero button.

Example

```
Load

12.64

kN

(click)

↓

Zero Load
```

Confirmation dialog

```
Zero Load ?

YES

NO
```

appears before applying zero.

---

# Zero Rules

Zero allowed

Idle

Ready

Not Running

Zero prohibited

Running

Paused

Completed

Archived

---

# Card Color Policy

Normal

Default theme color

Warning

Amber

Alarm

Red

Disconnected

Gray

Calibration Expired

Orange

---

# Alarm Indicator

Each card may display

Calibration Warning

Communication Error

Out of Range

Sensor Failure

Overflow

Quality Warning

Icons only.

Numeric value remains visible.

---

# Status Banner

Above dashboard

Machine State

Examples

Idle

Ready

Running

Paused

Completed

Emergency Stop

Disconnected

The banner color reflects state.

---

# Test Status Panel

Displays

Method

Specimen

Material

Operator

Elapsed Time

Machine State

Current Speed

Current Direction

Load Cell

Extensometer

without opening additional windows.

---

# Event Panel

Displays

Yield Detected

Maximum Load

Fracture

Pause

Resume

Emergency Stop

Communication Lost

Calibration Warning

Newest event always appears first.

---

# Graph Integration

Dashboard owns one primary graph.

Graph receives engineering channels.

Graph never accesses hardware.

Graph updates independently from numeric cards.

---

# Status Bar

Always visible.

Contains

PLC Connection

DAQ Status

Sampling Frequency

Frame Counter

Machine Ready

Software Version

Date

Time

---

# Multi-Monitor Support

Supported

Primary Monitor

↓

Dashboard

Secondary Monitor

↓

Graph

or

Report

or

Diagnostics

Operator configurable.

---

# Responsive Behaviour

Dashboard scales with

Resolution

Window Size

DPI

Font Scaling

without changing layout logic.

---

# User Customization

Operator may

Hide optional channels

Resize graph

Change graph position

Dock windows

Restore defaults

Operator may NOT

Remove default channels.

---

# Performance Requirements

Dashboard shall

Never block acquisition

Never block motion

Never block analysis

Support high-frequency updates

Maintain stable UI performance.

---

# Failure Behaviour

If acquisition stops

Dashboard freezes last engineering values.

Status changes to

Disconnected

No values are cleared automatically.

---

# Relationship with Reports

Dashboard is live only.

Historical reports never read dashboard values.

Reports use recorded Measurement Frames.

---

# Relationship with Event Bus

Dashboard subscribes to

ChannelValueUpdated

MachineStateChanged

AlarmRaised

AlarmCleared

CommunicationChanged

TestStarted

TestStopped

---

# Design Constraints

Dashboard SHALL NOT

Perform Engineering Calculations

Evaluate Acceptance

Modify Database

Control Servo

Read PLC Directly

Generate Reports

---

# Architectural Decision (FROZEN)

The Dashboard is a passive visualization subsystem.

It displays engineering information received through the Event Bus.

The four default engineering channels

- Load
- Stroke (Crosshead)
- Extensometer
- Time

shall always remain visible by default.

The engineering value display itself shall serve as the Zero control for zero-capable channels.

---

# Next Chapter

ARCH-038

Graph & Curve Architecture

This chapter will define

- Live Graph Engine
- Stress-Strain Curves
- Load-Stroke Curves
- Multi-Graph Support
- Zoom
- Pan
- Cursor
- Peak Markers
- Yield Markers
- ASTM / ISO Graph Behaviour

---

# End of Chapter