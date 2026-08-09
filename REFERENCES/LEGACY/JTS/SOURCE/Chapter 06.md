# ARCHITECTURE
# Chapter 06
# Event Detection Architecture

Document ID

ARCH-006

Version

0.1

Status

FROZEN

Related EDR

EDR-012

---

# Purpose

This chapter defines the Event Detection Engine.

The Event Detection Engine is the central decision-making component of the UTS software.

Every engineering interpretation shall originate from Events.

No downstream module is allowed to interpret raw measurements independently.

---

# Design Philosophy

The software is **Event Driven**.

Measurements describe

"What is happening."

Events describe

"What has happened."

Mechanical Properties describe

"What it means."

Acceptance describes

"Whether it is acceptable."

---

# Architecture Position

```
Measurement Channels

↓

Validation

↓

Signal Processing

↓

Engineering Channels

↓

EVENT DETECTION ENGINE

↓

Mechanical Properties

↓

Acceptance

↓

Reporting
```

---

# Event Definition

An Event is an engineering state transition recognized by the software.

Examples

Test Started

Elastic Region Started

Elastic Region Ended

Upper Yield

Lower Yield

Offset Yield

Maximum Load

Necking Started

Fracture

Operator Stop

Emergency Stop

Test Finished

---

# Event Responsibilities

The Event Engine SHALL

Detect

Validate

Timestamp

Store

Publish

Engineering Events

The Event Engine SHALL NOT

Calculate Young Modulus

Calculate Stress

Calculate Strain

Generate Reports

Evaluate Acceptance

Communicate with Hardware

---

# Event Sources

Events may originate from

Engineering Channels

Machine Status

Operator Actions

Safety System

Software Logic

Future AI Modules

---

# Event Consumers

Events are consumed by

Mechanical Property Engine

Acceptance Engine

Reporting Engine

User Interface

Data Logger

Future AI Engine

Future Statistics Engine

---

# Event Life Cycle

```
Condition

↓

Candidate Event

↓

Validation

↓

Confirmed Event

↓

Published Event

↓

Consumed

↓

Archived
```

---

# Event Object

Each Event shall contain

Event ID

Event Name

Timestamp

Measurement Index

Trigger Source

Priority

Status

Quality

Description

Parameters

---

# Event Categories

## Test Events

Examples

Test Initialized

Test Ready

Test Started

Test Finished

Abort

Pause

Resume

---

## Engineering Events

Examples

Elastic Start

Elastic End

Upper Yield

Lower Yield

Offset Yield

Maximum Load

Maximum Stress

Necking

Fracture

---

## Machine Events

Examples

Limit Switch

Travel Limit

Overload

Communication Lost

Emergency Stop

---

## Sensor Events

Examples

Load Cell Fault

Encoder Fault

Extensometer Fault

DAQ Failure

Noise Warning

Out of Range

---

## Operator Events

Examples

Zero Measurement

Start

Stop

Hold

Resume

Cancel

---

# Event Priority

Priority levels

Critical

High

Normal

Information

Diagnostic

Priority determines

Display

Logging

Alarm

Processing Order

---

# Event Rules

An Event SHALL

occur only once

or

explicitly define whether multiple occurrences are permitted.

Example

Test Started

One occurrence

Maximum Load

One occurrence

Warning

Multiple occurrences allowed

---

# Event Storage

Every confirmed Event shall be permanently stored with the Test Record.

Events are part of test history.

Events are never recalculated after report approval unless analysis is rerun.

---

# Event Independence

Events are independent from

Hardware

PLC

Customer

Order

Material Library

Acceptance

UI

---

# Standard Independence

ISO

ASTM

DIN

EN

Customer Specifications

shall define

Event Rules

NOT

Event Architecture.

---

# Future Compatibility

The Event Engine shall support

Unlimited Event Types

Unlimited Event Parameters

Unlimited Consumers

Custom Events

Plugin Events

AI Generated Events

without architectural redesign.

---

# Relationship with State Machine

The Event Engine detects transitions.

The State Machine controls allowed transitions.

These are independent modules.

---

# Next Chapter

ARCH-007

State Machine Architecture

---

# End of Chapter