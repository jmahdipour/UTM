# ARCHITECTURE
# Chapter 15
# Graph & Visualization Architecture

Document ID

ARCH-015

Version

0.1

Status

FROZEN

Related EDR

EDR-020

Depends On

ARCH-004 Measurement Architecture

ARCH-005 Analysis Architecture

ARCH-013 Measurement Processing

ARCH-014 Mechanical Property Engine

---

# Purpose

This chapter defines the architecture of all graphical visualization components.

Graphs are visualization tools.

Graphs never perform engineering calculations.

Graphs never modify measurements.

Graphs only visualize engineering information.

---

# Design Philosophy

Graph = Visualization Layer

Everything shown on a graph already exists elsewhere.

Graph never creates data.

Graph only consumes

Measurements

Engineering Channels

Events

Mechanical Properties

Reference Curves

---

# Position in Architecture

```
Measurements

↓

Engineering Channels

↓

Mechanical Properties

↓

Graph Engine

↓

Operator
```

---

# Supported Graph Types

Engineering Graphs

Stress – Strain

Load – Stroke

Load – Time

Extension – Time

Stress – Time

Strain – Time

True Stress – True Strain

Custom Graph

Overlay Graph

Future Graphs

Unlimited

---

# Graph Data Source

Graphs consume only Engineering Channels.

They never read

Raw ADC

PLC Registers

Communication Buffers

Hardware Values

---

# Live Graph

Supports

Real-time Update

Zoom

Pan

Auto Scale

Manual Scale

Freeze Display

Resume

---

# Historical Graph

Supports

Replay

Zoom

Measurement Cursor

Multiple Cursors

Print

Export

Comparison

---

# Graph Layers

```
Background

↓

Grid

↓

Reference Curves

↓

Measured Curve

↓

Calculated Curves

↓

Events

↓

Markers

↓

Cursor

↓

Annotations
```

Each layer is independent.

---

# Reference Curves

Reference curves are optional.

Examples

Material Library Curve

Previous Test

Golden Sample

Customer Reference

Imported CSV

Imported XML

Reference curves never participate in calculations.

---

# Event Markers

Every Event may appear on graph.

Examples

Yield

Maximum Load

Fracture

Necking

Elastic End

Operator Note

Machine Event

Safety Event

---

# Interactive Cursor

Cursor displays

X Value

Y Value

Engineering Unit

Nearest Event

Measurement Index

Timestamp

Multiple cursors supported.

---

# Guide Lines

Graph supports engineering guide lines.

Examples

Yield Offset Line

Elastic Fit Line

Rp0.2 Offset

User Defined Line

Horizontal Line

Vertical Line

Guide lines are visual only.

---

# Graph Scaling

Supported

Automatic

Manual

Fixed

Logarithmic

Independent X/Y

Future Scale Types

---

# Overlay Mode

Multiple curves may be displayed together.

Examples

Current Test

Previous Test

Reference Material

Golden Sample

Batch Average

Overlay never modifies original data.

---

# Channel Visibility

Every channel may be

Visible

Hidden

Temporary

Diagnostic

Future

---

# Annotation System

Graph supports

Text

Arrow

Circle

Rectangle

Operator Comment

Automatic Event Label

Future Objects

Unlimited

Annotations are stored separately from measurements.

---

# Export

Supported

PNG

JPEG

SVG

PDF

Clipboard

Vector Export

Future Formats

Unlimited

---

# Printing

Graph printing supports

Current View

Full Graph

Multiple Graphs

Report Integration

High Resolution

---

# Performance Requirements

Smooth Live Display

Independent UI Refresh

No Data Loss

No Blocking

Hardware Independent

---

# Relationship with Material Library

Material Library may provide

Reference Curves

Typical Behaviour

Engineering Notes

Graph Engine displays them.

Graph Engine never interprets them.

---

# Relationship with Mechanical Properties

Mechanical Properties may appear as

Markers

Tables

Guide Lines

Reference Labels

Graph never recalculates properties.

---

# Design Constraints

Graph Engine SHALL NOT

Perform Engineering Calculations

Modify Measurements

Modify Events

Perform Acceptance

Communicate with Hardware

---

# Future Compatibility

Architecture shall support

3D Graphs

Multi-Axis Graphs

Digital Image Correlation

Video Synchronization

AI Curve Analysis

Custom Rendering Engines

without redesign.

---

# Next Chapter

ARCH-016

Method Template Architecture

---

# End of Chapter