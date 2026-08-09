# ARCHITECTURE
# Chapter 33
# Calibration Architecture

Document ID

ARCH-033

Version

0.1

Status

FROZEN

Related EDR

EDR-038

Depends On

ARCH-011 Hardware Architecture

ARCH-013 Measurement Processing

ARCH-023 Database Architecture

ARCH-031 Audit Architecture

---

# Purpose

This chapter defines the complete Calibration Architecture of the Universal Testing Machine (UTS).

Calibration guarantees that all engineering measurements are traceable to national or international standards.

Calibration is an independent subsystem.

It shall never be part of a Test Method.

---

# Philosophy

Calibration answers only one question:

> **"How accurately does this measurement channel represent the physical quantity?"**

It never answers

How to perform a test

How to evaluate acceptance

How to generate reports

---

# Fundamental Principle

Calibration belongs to the **measurement system**, not to the specimen or the test.

```
Machine

↓

Sensor

↓

Calibration

↓

Measurement

↓

Engineering Analysis
```

---

# Supported Calibration Types

The architecture shall support unlimited calibration types.

Default types

- Load Cell
- Stroke (Crosshead)
- Extensometer
- Analog Sensor
- Digital Sensor
- Future Sensors

---

# Default Sensor Architecture

Every machine contains four predefined engineering channels

1. Load
2. Stroke (Crosshead)
3. Extensometer
4. Time

Additional channels may be added later.

Calibration architecture shall automatically support them.

---

# Calibration Objects

```
Calibration

│

├── Calibration Type

├── Sensor

├── Calibration Certificate

├── Calibration Points

├── Calibration Curve

├── Verification

├── Approval

└── History
```

---

# Sensor

Each sensor contains

Sensor ID

Sensor Name

Serial Number

Manufacturer

Model

Resolution

Engineering Unit

Installation Date

Status

---

# Calibration Certificate

Each calibration has

Certificate Number

Laboratory

Technician

Standard Used

Reference Instrument

Calibration Date

Expiration Date

Remarks

Digital Attachment

---

# Calibration Standards

Examples

ISO 7500-1

ISO 9513

ASTM E4

ASTM E83

Future Standards

Unlimited

---

# Calibration Modes

Supported

Single Point

Multi Point

Linear

Polynomial

Piecewise Linear

Future Models

---

# Calibration Points

Each calibration consists of

Reference Value

Measured Value

Error

Correction

Timestamp

Operator

Point Number

Unlimited calibration points supported.

---

# Calibration Curve

Generated automatically from calibration points.

Supported

Linear

Polynomial

Spline (future)

Lookup Table

User Defined

The Measurement Processing Engine uses this curve.

---

# Verification

Calibration may be verified without recalibration.

Verification stores

Verification Date

Operator

Reference Instrument

Maximum Error

Pass / Fail

Remarks

Verification never replaces calibration.

---

# Approval Workflow

```
Calibration

↓

Verification

↓

Supervisor Approval

↓

Active
```

Only approved calibrations may become active.

---

# Active Calibration

Only one active calibration is allowed per

Sensor

Calibration Type

Machine

Older calibrations remain archived.

---

# Calibration History

Nothing is deleted.

Each calibration is preserved.

Supported

Current

Previous

Archived

Expired

Superseded

---

# Traceability

Every calibration shall reference

Reference Instrument

↓

Reference Certificate

↓

National Standard

↓

International Standard

This satisfies ISO traceability requirements.

---

# Machine Independence

Calibration belongs to

Machine + Sensor

NOT

Test Method

Material

Specimen

Acceptance Profile

---

# Automatic Usage

When a measurement begins

Measurement Processing Engine loads

Current Active Calibration

↓

Applies correction automatically

Operator intervention is not required.

---

# Calibration During Testing

Calibration changes are prohibited while

Test State = Running

Any attempt shall be rejected.

---

# Expired Calibration

If calibration has expired

System behaviour is configurable

Examples

Warning Only

Prevent Testing

Supervisor Override

Laboratory Policy

---

# Calibration Audit

Every action generates

Audit Entry

Examples

Calibration Created

Calibration Approved

Calibration Activated

Calibration Expired

Calibration Archived

Calibration Restored

---

# Security

Only authorized users may

Create Calibration

Modify Calibration

Approve Calibration

Activate Calibration

Archive Calibration

Permissions are controlled by the Security subsystem.

---

# Import / Export

Supported

CSV

XML

JSON

Calibration Certificate PDF

Future National Formats

---

# Relationship with Measurement Processing

```
Sensor

↓

Calibration

↓

Measurement Processing

↓

Engineering Value
```

Calibration is always applied before engineering analysis.

---

# Relationship with Test Method

There is **no relationship**.

Test Methods never select calibrations.

The machine always uses the active approved calibration.

---

# Relationship with Reporting

Reports may display

Calibration Certificate Number

Calibration Date

Expiration Date

Reference Standard

Verification Status

according to report template settings.

---

# Future Compatibility

Supports

Automatic Calibration

Electronic Calibration Devices

Remote Calibration

Cloud Certificate Storage

AI Calibration Diagnostics

Multiple Machines

without redesign.

---

# Design Constraints

Calibration SHALL NOT

Modify Test Methods

Modify Materials

Modify Acceptance Profiles

Modify Historical Measurements

Perform Engineering Analysis

Communicate directly with Reports

---

# Architectural Decision (FROZEN)

Calibration is a machine-level engineering subsystem.

It is completely independent of

Test Methods

Materials

Specimens

Acceptance Profiles

Every engineering measurement shall always use the currently active approved calibration.

This decision is permanent.

---

# Next Chapter

ARCH-034

Data Acquisition & Real-Time Processing Architecture

> This chapter will define:
>
> - Real-time sampling
> - Multi-thread acquisition
> - Buffer architecture
> - Synchronization
> - Frame generation
> - Live data pipeline
> - Timing accuracy
> - High-speed acquisition strategy

---

# End of Chapter