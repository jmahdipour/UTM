# ARCHITECTURE
# Chapter 49
# Calibration Architecture

Document ID

ARCH-049

Version

0.1

Status

FROZEN

Related EDR

EDR-054

Depends On

ARCH-011 Hardware Architecture

ARCH-023 Database Architecture

ARCH-031 Audit Architecture

ARCH-036 Measurement Channel Architecture

ARCH-046 Hardware Abstraction Layer

---

# Purpose

This chapter defines the complete Calibration Architecture of the Universal Testing Machine.

Calibration ensures that every engineering measurement produced by the machine is traceable, accurate and compliant with laboratory standards.

This subsystem supports

- Load Cell Calibration
- Extensometer Calibration
- Stroke Calibration
- Machine Verification
- Calibration History
- ISO 17025 Traceability

---

# Philosophy

Calibration is **completely independent** from testing.

Testing shall never modify calibration.

Calibration shall never modify historical test results.

A calibration creates a new calibration record only.

---

# Architecture

```
Reference Instrument

↓

Calibration Engine

↓

Calibration Database

↓

Hardware Abstraction Layer

↓

Measurement System
```

---

# Responsibilities

Calibration Engine SHALL

Perform Calibration

Store Calibration

Validate Calibration

Generate Calibration Certificate

Maintain History

Verify Calibration

Activate Calibration

---

# SHALL NOT

Modify Test Results

Modify Reports

Modify Acceptance Results

Modify Mechanical Properties

Control Test Workflow

---

# Supported Calibration Types

Load Cell

Stroke (Crosshead)

Extensometer

Temperature (Future)

Pressure (Future)

Torque (Future)

Custom Sensors

---

# Load Cell Calibration

Supported Load Cells

25 ton

10 ton

2 ton

500 kg

100 kg

Future Load Cells

Unlimited

---

# Calibration Principle

```
Reference Force

↓

Machine Measurement

↓

Difference

↓

Correction Curve

↓

Calibration Table
```

---

# Multi-Point Calibration

Supported

2 Points

5 Points

10 Points

20 Points

Custom Number

Unlimited future expansion.

---

# Calibration Point

Each point stores

Reference Value

Measured Value

Correction

Deviation

Timestamp

Operator

---

# Calibration Curve

Supported

Linear

Piecewise Linear

Polynomial (Future)

Custom Curve (Future)

---

# Zero Calibration

Each sensor supports

Zero Verification

Zero Adjustment

Zero Validation

Zero History

Zero is stored separately from calibration.

---

# Extensometer Calibration

Supports

25 mm

50 mm

100 mm

Future extensometers

Optical

Laser

Video

---

# Stroke Calibration

Supports

Encoder Verification

Travel Verification

Reference Gauge

Digital Scale

Laser Measurement (Future)

---

# Calibration Status

Supported

Valid

Expired

Pending Verification

Rejected

Draft

Archived

---

# Calibration Validity

Each calibration contains

Calibration Date

Expiration Date

Verification Interval

Certificate Number

Laboratory

Technician

---

# Active Calibration

Only one calibration

per device

may be active.

Historical calibrations remain archived.

---

# Calibration History

History is immutable.

Nothing is overwritten.

Every new calibration creates

a new version.

---

# Calibration Version

Example

```
Load Cell 25 ton

v1

↓

v2

↓

v3
```

Old versions remain available.

---

# Calibration Certificate

Contains

Certificate Number

Machine

Device

Reference Instrument

Calibration Points

Error Table

Correction Curve

Technician

Approval

Date

Signature

---

# Reference Instrument

Stores

Reference Device

Serial Number

Certificate Number

Calibration Expiration

Traceability Laboratory

---

# Verification

Supported

Quick Verification

Full Verification

Intermediate Verification

Annual Verification

---

# Verification Result

PASS

FAIL

Warning

Adjustment Required

---

# Calibration Approval

Workflow

```
Draft

↓

Measured

↓

Verified

↓

Approved

↓

Activated
```

Only approved calibration becomes active.

---

# Audit

Every calibration action creates

Audit Entry

Examples

Calibration Started

Calibration Approved

Calibration Activated

Calibration Rejected

Calibration Deleted (Logical Only)

---

# Relationship with HAL

Calibration values are supplied to HAL.

HAL applies corrections during engineering conversion.

Business Layer never applies calibration directly.

---

# Relationship with Measurements

```
Raw Measurement

↓

HAL

↓

Calibration Correction

↓

Engineering Value

↓

Measurement Channel
```

Only Engineering Values leave HAL.

---

# Relationship with Reports

Reports store

Calibration Certificate Reference

not

Calibration Tables.

---

# Backup

Calibration records are included in

Backup

Restore

Migration

Archive

---

# Permissions

Operator

View Only

---

Calibration Technician

Create

Modify Draft

Verify

---

Supervisor

Approve

Activate

Archive

---

Administrator

Manage Configuration

Never modify historical calibration.

---

# Performance

Calibration is an offline operation.

It never executes during a running test.

---

# Future Compatibility

Supports

Automatic Calibration

AI Assisted Calibration

Remote Calibration

Electronic Reference Devices

Cloud Certificate Storage

without redesign.

---

# Design Constraints

Calibration Engine SHALL NOT

Modify Historical Measurements

Modify Test Results

Perform Acceptance

Generate Mechanical Properties

Control Motion During Tests

Bypass Audit

---

# Architectural Decision (FROZEN)

Calibration shall be implemented as an independent subsystem with complete historical traceability.

Only approved calibration records may become active.

Historical calibration records shall never be modified or deleted.

All engineering measurements shall pass through the Hardware Abstraction Layer where the active calibration is applied before becoming Engineering Values.

This decision is permanent.

---

# Next Chapter

ARCH-050

Machine Verification & Preventive Maintenance Architecture

This chapter will define

- Machine Health Verification
- Preventive Maintenance
- Service Scheduling
- Component Lifetime
- Inspection Checklists
- Maintenance History
- Service Alerts
- ISO 17025 Maintenance Compliance

---

# End of Chapter