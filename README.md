# UTS
## Universal Testing System

Industrial Universal Testing Machine Software

---

## Overview

UTS is an industrial-grade Universal Testing Machine software platform developed for controlling and managing tensile, compression, bending, cyclic and custom mechanical tests.

The project is designed as a modern replacement for legacy UTM software while maintaining compatibility with industrial testing environments.

Main objectives:

- High reliability
- Long-term maintainability
- Modular architecture
- Hardware independence
- ISO/ASTM compliance
- Industrial quality

---

## Target Platform

- Microsoft Windows 10
- Microsoft Windows 11

---

## Development Environment

Visual Studio 2019

Language

VB.NET

Framework

.NET Framework 4.8

Architecture

WPF

MVVM

Clean Architecture

DDD

SQLite

---

## Solution Structure

UTS.sln

Projects

- UTS.Common
- UTS.Domain
- UTS.Application
- UTS.Device
- UTS.Hardware
- UTS.Motion
- UTS.Infrastructure
- UTS.Database
- UTS.Reporting
- UTS.UI
- UTS.Tests
- UTS.Tools

---

## Main Features

Universal Testing Machine control

Tensile Test

Compression Test

Bending Test

Cyclic Test

Stress Control

Strain Control

Force Control

Crosshead Position Control

Live Graph

Calibration

Material Library

Method Library

Reporting

CSV

Excel

PDF

Database

User Management

Hardware Configuration

Maintenance

Diagnostics

---

## Supported Standards

ISO 6892-1

ISO 7438

ISO 5173

ASTM E8

ASTM E111

ASTM A370

API 5L

INSO 3132

Additional standards can be added without modifying the software core.

---

## Design Principles

SOLID

Clean Architecture

Dependency Injection

Repository Pattern

Factory Pattern

Strategy Pattern

Adapter Pattern

MVVM

---

## Hardware Layer

The hardware implementation is completely isolated from the application layer.

Supported devices will include:

PLC

Servo

Inverter

Encoder

DAQ

Load Cell

Extensometer

Future hardware can be added by implementing the corresponding interfaces.

---

## Build Requirements

Visual Studio 2019

.NET Framework 4.8

Windows SDK

SQLite

---

## License

Private

Copyright © UTS Development Team

All Rights Reserved.

---

Version

0.1.0

Status

Under Development
