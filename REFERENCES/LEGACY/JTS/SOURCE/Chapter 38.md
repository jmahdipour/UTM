# ARCHITECTURE
# Chapter 38
# Graph & Curve Architecture

Document ID

ARCH-038

Version

0.1

Status

FROZEN

Related EDR

EDR-043

Depends On

ARCH-013 Measurement Processing

ARCH-034 Data Acquisition

ARCH-036 Measurement Channels

ARCH-037 Dashboard

---

# Purpose

This chapter defines the complete Graph Engine architecture of the Universal Testing Machine.

The Graph Engine is responsible for

Live Curves

Engineering Curves

Interactive Analysis

Markers

Zoom

Export

Printing

The Graph Engine is completely independent from Data Acquisition.

---

# Philosophy

The graph is a visualization tool.

It never performs calculations.

Engineering calculations always occur before graph rendering.

---

# Architecture

```
DAQ

↓

Engineering Frames

↓

Measurement Processing

↓

Graph Engine

↓

User Interface
```

---

# Responsibilities

Graph Engine SHALL

Display Live Curves

Display Historical Curves

Support Zoom

Support Pan

Display Markers

Display Cursors

Export Images

Print Graphs

---

# SHALL NOT

Acquire Data

Perform Acceptance

Calculate Mechanical Properties

Communicate with PLC

Write Database

---

# Supported Curves

Default

Load vs Stroke

Stress vs Strain

Load vs Time

Stroke vs Time

Extensometer vs Time

---

Future

Stress vs Time

Energy vs Stroke

Energy vs Time

Custom Curves

Unlimited

---

# Default Live Curve

System Default

```
Load

vs

Stroke (Crosshead)
```

The operator may change this.

---

# Engineering Curves

Calculated

Stress

↓

Strain

True Stress

↓

True Strain

Engineering calculations occur first.

The graph displays results.

---

# Graph Types

Supported

Line

Scatter

Reference Curve

Overlay

Comparison

Future

3D

Heat Map

Video Synchronization

---

# Multiple Graphs

Supported

Single Graph

Dual Graph

Quad Graph

Tabbed Graphs

Operator selectable.

---

# Graph Refresh

```
Engineering Frame

↓

Event Bus

↓

Graph Engine

↓

Render
```

Graph never polls hardware.

---

# Rendering Strategy

Double Buffered

Hardware Accelerated (future)

No UI Flicker

Independent Refresh Thread

---

# Cursor

Supported

Single Cursor

Dual Cursor

Crosshair

Snap To Data

Free Cursor

---

# Cursor Information

Displays

X

Y

Engineering Units

Frame Number

Timestamp

---

# Zoom

Supported

Mouse Wheel

Drag Rectangle

Touch (future)

Keyboard

Auto Zoom

Fit To Screen

---

# Pan

Supported

Mouse Drag

Keyboard

Touch

---

# Markers

Automatic

Yield Point

Maximum Load

Fracture

Break

Rp0.2

Rp0.1

Rt0.5

Manual Markers

Supported

---

# Marker Style

Every marker contains

Icon

Label

Engineering Value

Coordinate

Tooltip

---

# Reference Lines

Supported

Horizontal

Vertical

Offset

Elastic Region

Yield Offset

Operator selectable.

---

# Grid

Configurable

Major Grid

Minor Grid

Grid Color

Grid Visibility

---

# Axis

Each axis contains

Title

Engineering Unit

Scale

Minimum

Maximum

Auto Scale

Manual Scale

---

# Supported Units

Automatically follow

Engineering Unit System

Changing units automatically updates axes.

---

# Overlay

Supported

Current Test

↓

Reference Test

↓

Material Curve

↓

Acceptance Curve

Unlimited overlays.

---

# Comparison Mode

Multiple completed tests

↓

Displayed together

Colors assigned automatically.

---

# Live Buffer

Graph keeps

Visible Buffer

History Buffer

Archive Buffer

Large tests remain responsive.

---

# Data Reduction

For extremely large datasets

Graph may reduce rendering points

WITHOUT modifying recorded measurements.

Measurements remain untouched.

---

# Graph Export

Supported

PNG

JPG

BMP

SVG

PDF

Clipboard

---

# Graph Printing

Supports

High Resolution

Black & White

Color

Report Integration

---

# Report Integration

Reports reference

Stored Graph Template

↓

Generate identical graph

Dashboard graph is never used directly.

---

# Events

Graph subscribes to

MeasurementFrameCreated

YieldDetected

MaximumLoadDetected

FractureDetected

AnalysisCompleted

---

# Performance

Supports

Very Large Tests

High Refresh Rates

Thousands of Frames

Smooth Interaction

No Acquisition Blocking

---

# Plugin Support

Future plugins may add

Graph Types

Markers

Annotations

Curve Filters

without modifying Graph Engine.

---

# Design Constraints

Graph Engine SHALL NOT

Perform Engineering Calculations

Modify Measurements

Access PLC

Access SQLite Directly

Evaluate Acceptance

Control Motion

---

# Architectural Decision (FROZEN)

The Graph Engine is a visualization subsystem only.

All engineering calculations shall be completed before rendering.

The graph always displays Engineering Values, never Raw Sensor Values.

Graphs shall remain responsive regardless of acquisition speed.

---

# Next Chapter

ARCH-039

Mechanical Property Calculation Architecture

This chapter will define

- Yield Detection
- Tensile Strength
- Breaking Force
- Young's Modulus
- Proof Stress (Rp0.2, Rp0.1, Rt0.5)
- Elongation
- Reduction of Area
- True Stress
- True Strain
- Energy Calculations
- Standard-specific calculation algorithms (ISO, ASTM, API)

---

# End of Chapter