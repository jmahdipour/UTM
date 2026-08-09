# ARCHITECTURE
# Chapter 44
# Plugin & Extension Architecture

Document ID

ARCH-044

Version

0.1

Status

FROZEN

Related EDR

EDR-049

Depends On

ARCH-027 Service Layer

ARCH-030 Event Bus

ARCH-031 Audit Architecture

ARCH-039 Mechanical Property Engine

---

# Purpose

This chapter defines the Plugin & Extension Framework of the Universal Testing Machine (UTS).

The objective is to allow future expansion without modifying the Core software.

Examples

- AI Modules
- Custom Reports
- Customer Algorithms
- New Standards
- ERP Integration
- LIMS Integration
- Machine Drivers
- Data Exporters

---

# Philosophy

The Core System shall remain stable.

New functionality shall be added through plugins.

The Core shall never be modified to support individual customers.

---

# Architecture

```
Core System

↓

Plugin Manager

↓

Plugin API

↓

Installed Plugins
```

---

# Responsibilities

Plugin Manager SHALL

Discover Plugins

Load Plugins

Unload Plugins

Validate Compatibility

Manage Versions

Manage Permissions

Publish Plugin Events

---

# SHALL NOT

Perform Engineering Calculations

Modify Core Architecture

Modify Database Schema

Control Servo Directly

Modify Core Business Logic

---

# Plugin Categories

Supported

Engineering Plugin

Machine Plugin

Report Plugin

Import Plugin

Export Plugin

AI Plugin

Visualization Plugin

Communication Plugin

Utility Plugin

---

# Engineering Plugins

May provide

New Standards

New Mechanical Properties

Special Calculations

Research Algorithms

Statistical Analysis

---

# Machine Plugins

May provide

New PLC Driver

New Servo Driver

DAQ Driver

Digital IO

Custom Hardware

Machine Diagnostics

---

# Report Plugins

May provide

Customer Templates

Certificate Formats

Government Reports

Research Reports

Company Branding

---

# Import Plugins

Examples

SAP

ERP

CSV

Excel

XML

JSON

REST

Future APIs

---

# Export Plugins

Examples

LIMS

MES

ERP

Cloud

REST API

XML

JSON

CSV

---

# AI Plugins

Examples

Automatic Yield Detection

Failure Classification

Fracture Image Analysis

Predictive Maintenance

Automatic Report Review

Anomaly Detection

Future AI Models

---

# Visualization Plugins

Examples

3D Graph

Heat Map

Camera Overlay

Video Synchronization

Advanced Dashboard

---

# Communication Plugins

Examples

OPC UA

MQTT

Modbus TCP

EtherCAT

CANopen

Serial Devices

Future Protocols

---

# Plugin Package

Every plugin contains

Plugin Manifest

Assembly

Resources

Configuration

Documentation

Digital Signature (future)

---

# Plugin Manifest

Contains

Plugin Name

Plugin ID

Version

Author

Description

Required API Version

Required Software Version

Permissions

Dependencies

---

# Plugin Lifecycle

```
Discover

↓

Validate

↓

Load

↓

Initialize

↓

Run

↓

Shutdown

↓

Unload
```

---

# Plugin API

Core exposes only approved interfaces.

Examples

ILogger

IEventBus

IReportProvider

ICalculationProvider

IImportProvider

IExportProvider

ISettingsProvider

Plugins never access internal classes directly.

---

# Event Integration

Plugins communicate through the Event Bus.

Example

```
MechanicalPropertiesCalculated

↓

AI Plugin

↓

Prediction Generated

↓

Publish Event
```

Direct module access is prohibited.

---

# Permissions

Plugins receive explicit permissions.

Examples

Read Measurements

Read Reports

Export Data

Generate Reports

Receive Events

No unrestricted access.

---

# Security

Plugins

Cannot

Access Database Directly

Modify Audit

Modify Calibration

Control Motion

Bypass Authentication

---

# Sandboxing

Plugins execute inside controlled boundaries.

Exceptions are isolated.

Plugin failure shall never crash the Core System.

---

# Version Compatibility

Plugin Manager checks

Plugin Version

↓

API Version

↓

Software Version

↓

Dependency Versions

Incompatible plugins are rejected.

---

# Dependency Management

Plugins may depend on

Core API

Other Plugins (optional)

External Libraries

Circular dependencies are prohibited.

---

# Configuration

Each plugin owns independent settings.

Configuration stored separately from Core configuration.

---

# Logging

Plugins receive Logger Interface.

All plugin activity may be logged.

Plugin logs remain separate from Core logs.

---

# Audit

Important plugin actions generate Audit Entries.

Examples

Plugin Installed

Plugin Removed

Plugin Enabled

Plugin Disabled

Plugin Failure

---

# Performance

Plugins execute asynchronously whenever possible.

Core acquisition and motion always have higher priority.

Plugins shall never block

DAQ

Motion

Measurement Processing

---

# Installation

Workflow

```
Select Plugin

↓

Verify Signature (future)

↓

Compatibility Check

↓

Install

↓

Restart Plugin Manager

↓

Ready
```

---

# Removal

Removing a plugin

Never deletes engineering data.

Only plugin-specific configuration may be removed.

---

# Future Compatibility

Supports

Marketplace

Online Updates

Cloud Plugins

AI Marketplace

Laboratory Extensions

Customer SDK

without redesign.

---

# Design Constraints

Plugins SHALL NOT

Modify Core Database Schema

Modify State Machine

Modify Repository Layer

Control Motion Directly

Bypass Security

Bypass Audit

---

# Architectural Decision (FROZEN)

The Universal Testing Machine software shall provide a stable Plugin Framework.

All future customer-specific functionality, AI modules, communication drivers, custom reports and integrations shall be implemented as plugins.

The Core Architecture shall remain unchanged.

This decision is permanent.

---

# Next Chapter

ARCH-045

Communication Architecture

This chapter will define

- PLC Communication
- DAQ Communication
- Driver Abstraction
- Protocol Layer
- Fatek Communication
- Shimadzu Legacy Communication
- Communication State Machine
- Timeout Strategy
- Recovery Mechanisms

---

# End of Chapter