# ARCHITECTURE
# Chapter 47
# Configuration Management Architecture

Document ID

ARCH-047

Version

0.1

Status

FROZEN

Related EDR

EDR-052

Depends On

ARCH-023 Database Architecture

ARCH-031 Audit Architecture

ARCH-032 Security Architecture

ARCH-046 Hardware Abstraction Layer

---

# Purpose

This chapter defines the Configuration Management Architecture.

The configuration subsystem manages all configurable parameters of the software while keeping engineering data independent.

Configuration controls

- Machine behavior
- Software behavior
- User preferences
- Hardware configuration
- Laboratory defaults

Configuration never stores engineering results.

---

# Philosophy

Configuration is **metadata**, not engineering data.

Changing configuration must never alter historical test results.

Every configuration change shall be traceable.

---

# Architecture

```
Configuration Repository

↓

Configuration Service

↓

Business Services

↓

User Interface
```

The Configuration Service is the single source of truth.

---

# Responsibilities

Configuration Service SHALL

Load Configuration

Save Configuration

Validate Configuration

Version Configuration

Export Configuration

Import Configuration

Publish Configuration Changes

---

# SHALL NOT

Store Test Results

Store Measurement Frames

Perform Calculations

Generate Reports

Control Motion

---

# Configuration Categories

The system separates configuration into independent domains.

```
Global

Machine

Hardware

Method Defaults

User

UI

Communication

Report

Plugin

Security
```

---

# Global Configuration

Contains

System Language

Default Unit System

Date Format

Time Format

Backup Policy

Logging Policy

Application Theme

---

# Machine Configuration

Contains

Machine Name

Machine ID

Machine Type

Maximum Capacity

Maximum Speed

Installed Load Cells

Installed Extensometers

Installed Hardware

---

# Hardware Configuration

Contains

Communication Drivers

Device Mapping

Sampling Parameters

Default Load Cell

Default Extensometer

Motion Limits

Safety Parameters

---

# User Configuration

Each user owns

Workspace

Window Layout

Recent Files

Preferred Language

Favorite Reports

Dashboard Layout

Graph Preferences

---

# UI Configuration

Contains

Ribbon Layout

Window Positions

Theme

Font Scaling

Visible Panels

Default Workspace

---

# Communication Configuration

Contains

PLC Address

Driver Type

Communication Timeout

Retry Count

Heartbeat Interval

Polling Rate

---

# Report Configuration

Contains

Default Template

Company Logo

Default Printer

Signature Policy

Export Format

Paper Size

---

# Plugin Configuration

Each plugin stores its own configuration independently.

Plugin settings shall never modify Core settings.

---

# Configuration Object

Every configuration item contains

Configuration ID

Category

Name

Value

Data Type

Version

Created Date

Modified Date

Modified By

---

# Supported Data Types

Boolean

Integer

Decimal

String

Date

Time

Enumeration

JSON

Binary

---

# Configuration Versioning

Every configuration set has a version.

Example

```
Machine Configuration

v1

↓

v2

↓

v3
```

Historical versions may be restored.

---

# Default Values

Every configuration parameter has

Factory Default

Laboratory Default

Current Value

Restore Factory Default is supported.

---

# Import

Supports

JSON

XML

Future YAML

Future Cloud Profiles

---

# Export

Supports

JSON

XML

ZIP Package

Complete Laboratory Configuration

---

# Configuration Profiles

Supported

Factory

Laboratory

Research

Production

Customer Specific

Operator Profile

Unlimited profiles.

---

# Validation

Before saving

Configuration Validator checks

Range

Dependencies

Required Fields

Compatibility

Data Types

Invalid configuration is rejected.

---

# Change Notification

Configuration changes publish

ConfigurationChanged

Event

Subscribers

UI

Communication Layer

Plugin Manager

Report Engine

---

# Runtime Changes

Some settings may change while running.

Examples

Theme

Language

Dashboard Layout

Others require restart.

Examples

Communication Driver

Machine Type

Hardware Mapping

---

# Audit

Every important configuration change generates

Audit Entry

Contains

Old Value

New Value

User

Timestamp

Reason (optional)

---

# Permissions

Operator

May change personal settings only.

Supervisor

May modify laboratory settings.

Administrator

May modify machine and hardware settings.

---

# Backup Integration

Configuration is included in

System Backup

Restore

Migration

Archive

---

# Relationship with Database

Configuration Repository stores settings.

Engineering tables remain independent.

---

# Relationship with Hardware

HAL reads hardware configuration from Configuration Service.

HAL never stores configuration itself.

---

# Relationship with UI

The UI never accesses configuration files directly.

All access goes through Configuration Service.

---

# Performance

Configuration is cached in memory.

Reads are optimized.

Writes are transactional.

---

# Future Compatibility

Supports

Cloud Configuration

Multi-Machine Profiles

Central Configuration Server

Remote Configuration

Enterprise Deployment

without redesign.

---

# Design Constraints

Configuration Service SHALL NOT

Store Engineering Results

Perform Calculations

Modify Historical Tests

Control Servo

Generate Reports

Communicate Directly with PLC

---

# Architectural Decision (FROZEN)

All configurable parameters within the Universal Testing Machine software shall be managed exclusively by the centralized Configuration Service.

No subsystem shall maintain independent configuration storage.

Historical engineering data shall remain completely independent from configuration changes.

This decision is permanent.

---

# Next Chapter

ARCH-048

Diagnostics, Logging & Monitoring Architecture

This chapter will define

- Diagnostic Engine
- Event Logging
- System Logging
- Performance Monitoring
- Health Monitoring
- Error Classification
- Maintenance Logs
- Remote Diagnostics

---

# End of Chapter