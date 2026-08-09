# ARCHITECTURE
# Chapter 30
# System Event Bus & Messaging Architecture

Document ID

ARCH-030

Version

0.1

Status

FROZEN

Related EDR

EDR-035

Depends On

ARCH-027 Service Layer

ARCH-029 State Transition Matrix

---

# Purpose

This chapter defines the internal communication architecture of the Universal Testing Machine (UTS).

The objective is to eliminate direct dependencies between software modules by introducing a centralized Event Bus.

Every module communicates through events.

Modules shall not directly control each other.

---

# Design Philosophy

The architecture follows an **Event-Driven Architecture (EDA).**

```
Module A

↓

Publish Event

↓

Event Bus

↓

Interested Modules

↓

Process Event
```

The publisher never knows who receives the event.

The receiver never knows who generated the event.

---

# Benefits

Loose Coupling

High Scalability

Easy Maintenance

Plugin Compatibility

Independent Development

Asynchronous Processing

Future Distributed Architecture

---

# Position in Architecture

```
Presentation

↓

Services

↓

Business Modules

↓

Event Bus

↓

Subscribers
```

The Event Bus is a communication layer.

It never contains business logic.

---

# Responsibilities

The Event Bus SHALL

Publish Events

Subscribe Listeners

Deliver Messages

Manage Event Queue

Guarantee Delivery Order

Support Synchronous Events

Support Asynchronous Events

---

# Event Bus SHALL NOT

Perform Engineering Calculations

Modify Business Objects

Communicate with Hardware

Generate Reports

Access SQLite directly

Interpret Messages

---

# Event Categories

```
Business Events

Engineering Events

Machine Events

System Events

Security Events

UI Events
```

---

# Business Events

Examples

CustomerCreated

OrderCreated

SpecimenCreated

MethodAssigned

MaterialAssigned

AcceptanceAssigned

WorkflowStarted

WorkflowFinished

---

# Engineering Events

Examples

TestStarted

TestStopped

YieldDetected

MaximumLoadDetected

FractureDetected

AnalysisCompleted

AcceptanceCompleted

ReportGenerated

---

# Machine Events

Examples

MachineConnected

MachineDisconnected

EmergencyStop

LimitReached

CommunicationLost

DAQStarted

DAQStopped

CalibrationFinished

---

# Security Events

Examples

UserLogin

UserLogout

PermissionDenied

PasswordChanged

ConfigurationModified

DigitalSignatureAdded

---

# UI Events

Examples

WindowOpened

WindowClosed

GraphZoomChanged

ThemeChanged

LanguageChanged

OperatorMessage

---

# Event Structure

Every event contains

```
EventID

EventType

Timestamp

Source

Priority

Payload

CorrelationID

UserID

SessionID
```

---

# Event Payload

Payload is strongly typed.

Example

YieldDetected

Payload

```
YieldStrength

Timestamp

FrameID

Method

Source
```

Payload definitions belong to the Event Dictionary.

---

# Event Priority

Supported priorities

Critical

High

Normal

Low

Background

Priority affects processing order.

Priority never changes business rules.

---

# Delivery Modes

Supported

Synchronous

Asynchronous

Broadcast

Point-to-Point

Future Remote Delivery

---

# Event Queue

The Event Bus maintains an internal queue.

```
Publish

↓

Queue

↓

Dispatch

↓

Subscribers
```

Events are processed in timestamp order within the same priority level.

---

# Subscribers

Examples

Report Engine

↓

AnalysisCompleted

↓

Generate Report

---

Graph Engine

↓

MeasurementUpdated

↓

Refresh Graph

---

Acceptance Engine

↓

MechanicalPropertiesCalculated

↓

Evaluate Acceptance

---

Audit Engine

↓

Any Business Event

↓

Store Audit Record

---

# Publisher Examples

Measurement Engine

publishes

MeasurementUpdated

Event Detection

publishes

YieldDetected

Service Layer

publishes

OrderCreated

Machine Layer

publishes

EmergencyStop

---

# Subscription Rules

A module subscribes only to events it requires.

Example

Graph Engine

does NOT subscribe to

UserLogin

---

Acceptance Engine

does NOT subscribe to

ThemeChanged

---

# Event Ordering

Guaranteed ordering

Within one Event Category

and

Within one Event Source

Cross-category ordering is not guaranteed unless explicitly required.

---

# Error Handling

If a subscriber fails

↓

Event Bus logs the error

↓

Other subscribers continue

A failed subscriber shall not stop the system.

---

# Retry Policy

Supported

No Retry

Single Retry

Configurable Retry

Future Persistent Queue

---

# Logging

Every published event may be logged.

Stored information

Event Type

Timestamp

Publisher

Subscribers

Execution Time

Result

Errors

---

# Thread Safety

The Event Bus shall support

Multi-threading

Background Processing

Parallel Subscribers

UI Thread Isolation

Future Multi-core Execution

---

# Plugin Integration

Plugins communicate only through the Event Bus.

They SHALL NOT call Core modules directly.

Example

AI Plugin

↓

Subscribe

AnalysisCompleted

↓

Generate Prediction

No dependency on Analysis Engine implementation.

---

# Performance Requirements

Low Latency

High Throughput

Non-blocking Dispatch

Minimal Memory Allocation

Deterministic Behaviour

---

# Future Compatibility

Supports

Distributed Event Bus

Cloud Messaging

MQTT

RabbitMQ

Kafka

SignalR

REST Notifications

without changing the Business Layer.

---

# Design Constraints

The Event Bus SHALL NOT

Contain Business Logic

Modify Database Records

Control Machine Motion

Perform Engineering Calculations

Evaluate Acceptance

Render UI

---

# Architectural Decision (FROZEN)

All module-to-module communication inside the UTS software shall occur through the centralized Event Bus.

Direct communication between independent modules is prohibited unless explicitly defined by architecture.

This decision guarantees loose coupling, plugin compatibility, and long-term maintainability.

---

# Next Chapter

ARCH-031

Logging, Diagnostics & Audit Architecture

---

# End of Chapter