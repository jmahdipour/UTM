# ARCHITECTURE
# Chapter 10
# User Interface Architecture

Document ID

ARCH-010

Version

0.1

Status

FROZEN

Related EDR

EDR-015

Depends On

ARCH-001 Business Architecture

ARCH-004 Measurement Architecture

ARCH-005 Analysis Architecture

ARCH-007 State Machine

ARCH-009 Reporting Architecture

---

# Purpose

This chapter defines the User Interface Architecture.

The User Interface is the operator's working environment.

Its purpose is to

Display

Operate

Monitor

Configure

without containing engineering logic.

---

# Design Philosophy

The UI is only a presentation layer.

The UI never

Calculates

Evaluates

Controls acceptance

Detects events

Interprets measurements

The UI consumes information from the Application Layer.

---

# UI Principles

The interface shall be

Professional

Minimal

Fast

Industrial

Operator-oriented

Touch-friendly

Keyboard-friendly

Expandable

---

# Design Inspiration

Primary References

Shimadzu TrapeziumX

Zwick testXpert III

Instron Bluehill Universal

MTS TestSuite

The interface shall be familiar to experienced testing operators.

---

# Window Layout

```
+-----------------------------------------------------------+

 Ribbon

+-----------------------------------------------------------+

 Navigation Panel

 Workspace

 Live Values

 Graph

 Results

+-----------------------------------------------------------+

 Status Bar

+-----------------------------------------------------------+
```

---

# Main Areas

Ribbon

Navigation Panel

Workspace

Measurement Widgets

Graph Area

Results Area

Status Bar

---

# Ribbon

The Ribbon is the primary command interface.

Tabs

Home

Order

Specimen

Method

Material

Machine

Analysis

Report

Calibration

Settings

Help

Future Tabs

Unlimited

---

# Navigation Panel

Displays

Orders

Specimens

Methods

Material Library

Reports

Templates

History

Logs

Favorites

---

# Workspace

Dynamic content area.

Changes according to

Current State

Selected Object

Selected Module

---

# Measurement Widgets

Core Widgets

Load

Stroke (Crosshead)

Extension

Time

Each widget displays

Current Value

Unit

Status

Quality

Trend

---

# Widget Behaviour

Click

↓

Context Menu

Available Operations

Zero

Information

Diagnostics

History

Calibration (if permitted)

Future Extensions

---

# Graph Area

Supports

Stress-Strain

Load-Stroke

Load-Time

Extension-Time

Custom Curves

Multiple Curves

Reference Curves

Cursor

Zoom

Pan

Guide Lines

Marker Lines

---

# Results Area

Displays

Mechanical Properties

Acceptance

Warnings

Events

Statistics

Live Updates

---

# Status Bar

Displays

Machine State

Connection Status

Current User

Current Order

Current Specimen

Current Method

Current Material

Software Version

Clock

---

# Dialog Philosophy

Dialogs are used only when necessary.

Preference

Inline Editing

Dock Panels

Expandable Sections

Minimal Popups

---

# Notifications

Notification Types

Information

Warning

Error

Critical

Confirmation

Notifications never interrupt acquisition unless critical.

---

# Theme

Default

Industrial Light

Future

Dark Theme

High Contrast

Custom Themes

---

# Language Support

English

Persian

Future Languages

All UI text shall use resource files.

No hardcoded text.

---

# Permissions

UI adapts to user role.

Examples

Operator

Supervisor

Administrator

Service Engineer

Developer

Each role has different available commands.

---

# State Awareness

UI behaviour depends on State Machine.

Example

Running

↓

Disable

Method Editing

Material Editing

Calibration

Order Editing

Example

Ready

↓

Enable

Method Selection

Specimen Editing

Zero

Movement

---

# Error Presentation

Errors shall contain

Title

Description

Suggested Action

Technical Details (optional)

Reference Code

---

# Performance Requirements

Live Measurements

Continuous

Smooth Graph

No blocking dialogs

No UI freeze

Fast screen switching

---

# Future Compatibility

The UI architecture shall support

Additional Panels

Multiple Monitors

Touch Screens

Remote Operation

Custom Layouts

Plugin Windows

without redesign.

---

# Design Constraints

The UI SHALL NOT

Perform engineering calculations

Interpret measurements

Communicate directly with PLC

Access database directly

Modify acceptance logic

Implement business rules

---

# Next Chapter

ARCH-011

Hardware & Communication Architecture

---

# End of Chapter