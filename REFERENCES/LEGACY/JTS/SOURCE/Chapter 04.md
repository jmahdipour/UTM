# ARCHITECTURE
# Chapter 04
# Measurement Architecture

Document ID

ARCH-004

Version

0.1

Status

FROZEN

Related EDR

EDR-007

EDR-008

EDR-009

EDR-010

---

# Purpose

This chapter defines the Measurement Architecture of the Universal Testing Machine (UTS).

Measurement Architecture is the foundation of the entire software.

Everything inside Analysis Engine starts from Measurements.

---

# Design Philosophy

Measurements represent physical quantities.

Measurements are NOT Sensors.

Measurements are NOT Calculated Results.

Measurements are independent engineering objects.

---

# Layer Separation

```
Hardware Layer

↓

Sensors

↓

Measurement Layer

↓

Calculated Measurement Layer

↓

Mechanical Properties

↓

Acceptance

↓

Reporting
```

Each layer is completely independent.

---

# Sensor Layer

Examples

Load Cell

Crosshead Encoder

Extensometer

Temperature Sensor

Pressure Sensor

LVDT

DAQ Input

Future Sensors

Sensors only acquire signals.

Sensors never perform calculations.

---

# Measurement Layer

Measurements represent engineering quantities.

Core Measurements

- Load
- Stroke (Crosshead)
- Extension
- Time

These four measurements always exist.

---

# Optional Measurements

The architecture supports unlimited future measurements.

Examples

Temperature

Pressure

Torque

Humidity

Vision

Digital Input

Analog Input

Acceleration

Displacement

Custom Channel

Virtual Channel

---

# Sensor Mapping

One measurement may originate from one or more sensors.

Example

```
Load Cell

↓

Load
```

```
Encoder

↓

Stroke
```

```
Extensometer

↓

Extension
```

Sensors remain replaceable.

Measurement names never change.

---

# Measurement Identity

Every Measurement shall contain

Unique Identifier

Display Name

Engineering Unit

Current Value

Status

Timestamp

Source

Quality Flag

Zero Offset

Scaling

Visibility

---

# Measurement Units

Examples

Load

N

kN

kgf

lbf

Stroke

mm

inch

Extension

mm

%

Time

ms

s

min

Units belong to Measurements.

Units never belong to Sensors.

---

# Measurement Status

Each Measurement shall contain a status.

Possible states

Normal

Zeroed

Overrange

Underrange

Disconnected

Fault

Simulated

Invalid

Filtered

---

# Measurement Quality

Every measurement shall contain quality information.

Examples

Valid

Invalid

Estimated

Interpolated

Filtered

Outlier

Missing

Quality information shall travel with the measurement.

---

# Zero Reference

Measurements support zero reference.

Zeroing applies to

Measurement

NOT

Sensor

The physical sensor is never modified.

Only the engineering reference changes.

---

# Measurement Widget

Each Measurement is represented by an interactive widget.

Widget displays

Name

Current Value

Engineering Unit

Status

Indicator

Quality

---

# Measurement Widget Actions

Clicking a widget opens

Zero

Diagnostics

Information

Calibration (if permitted)

History

Trend

Future Extensions

Separate Zero buttons are prohibited.

---

# Measurement History

Every Measurement supports historical values.

History is used by

Graphs

Analysis

Reports

Replay

Diagnostics

---

# Measurement Synchronization

All active measurements shall share a common acquisition timeline.

Example

```
Time

↓

Load

↓

Stroke

↓

Extension
```

Measurements must remain synchronized.

---

# Relationship with Analysis

Analysis Engine consumes Measurements.

Analysis Engine never consumes Sensors directly.

```
Measurements

↓

Analysis Engine
```

---

# Relationship with Hardware

Hardware

↓

Sensors

↓

Measurements

Hardware replacement shall never change the Measurement Architecture.

---

# Relationship with Reports

Reports display Measurements.

Reports never access Sensors.

---

# Design Constraints

Measurement Layer shall remain independent from

Hardware

PLC

DAQ

Customer

Order

Material

Acceptance

Business Logic

---

# Future Compatibility

The architecture shall support

Unlimited Measurements

Unlimited Sensors

Unlimited Units

Unlimited Widgets

Unlimited Data Sources

without redesign.

---

# End of Chapter