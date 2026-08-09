# ARCHITECTURE
# Chapter 55
# Graph, Curve & Visualization Analysis Architecture

Document ID

ARCH-055

Version

0.1

Status

FROZEN

Related EDR

EDR-060

Depends On

ARCH-034 Data Acquisition

ARCH-039 Mechanical Property Calculation

ARCH-052 Test Method Architecture

ARCH-053 Test Execution Architecture

ARCH-054 Test Data & Measurement Storage

---

# Purpose

This chapter defines the architecture for real-time and post-test visualization of mechanical test data.

The subsystem manages

- Live Graph
- Test Curves
- Stress-Strain Curves
- Load-Stroke Curves
- Multiple Curves
- Zoom
- Pan
- Point Selection
- Guide Lines
- Curve Markers
- Downsampling
- Real-Time Rendering
- Graph Export

---

# Philosophy

The Graph Engine is a visualization subsystem.

It displays measurement and analysis data.

It does not own the original measurement data.

It does not modify engineering results.

It does not perform machine control.

---

# Architecture

```text
Measurement Data

↓

Graph Data Provider

↓

Graph Engine

↓

Visualization ViewModel

↓

WPF Graph Control

↓

UI
Responsibilities

Graph Engine SHALL

Render Live Data

Render Historical Data

Display Multiple Curves

Support Zoom

Support Pan

Support Point Selection

Display Guide Lines

Display Markers

Display Calculated Points

Support Curve Comparison

Support Export

SHALL NOT

Modify Original Measurement Data

Control Motion

Modify Calibration

Evaluate Acceptance

Modify Test Results

Directly access PLC

Directly access DAQ Hardware

Supported Curves

The system shall support

Load vs Time

Stroke (Crosshead) vs Time

Extensometer vs Time

Load vs Stroke (Crosshead)

Stress vs Strain

Stress vs Stroke (Crosshead)

Strain vs Time
Primary Engineering Curve

For tensile testing the primary curve is

Stress vs Strain

when the required data and Method are available.

Load Curve
X = Stroke (Crosshead)

Y = Load

Used for

Machine behavior
Force response
Break detection
Operator monitoring
Stress-Strain Curve
X = Strain

Y = Stress

Used for

Yield Analysis
Young's Modulus
Ultimate Tensile Strength
Elongation
Material Behavior
Live Graph

During an active test the graph receives measurement updates continuously.

DAQ

↓

Measurement Buffer

↓

Graph Data Provider

↓

Graph Engine

↓

Screen
Live Rendering

The graph shall update asynchronously.

UI rendering must never block

DAQ
Motion
Test Execution
Safety Processing
Rendering Frequency

DAQ sampling frequency and screen refresh frequency are independent.

Example

DAQ = 1000 Hz

Display = 30–60 FPS

The Graph Engine may reduce displayed points while preserving the complete stored dataset.

Downsampling

Downsampling is permitted only for visualization.

Original data remains unchanged.

Supported strategies may include

Min/Max

Largest Triangle

Uniform Sampling

Adaptive Sampling

The selected algorithm shall be deterministic.

High-Density Data

When a curve contains more points than available screen pixels, the Graph Engine shall reduce visual points while preserving important extrema.

The visualization must not hide significant peaks or drops merely because of downsampling.

Zoom

Supported

Zoom In

Zoom Out

Zoom X

Zoom Y

Zoom Rectangle

Fit All
Pan

Supported

Pan X

Pan Y

Pan Both

Pan shall not modify the underlying dataset.

Cursor

The graph supports an interactive cursor.

Cursor displays values such as

Time

Load

Stroke (Crosshead)

Extensometer

Stress

Strain

depending on the selected curve.

Point Selection

The operator may select points from a curve.

Selected point displays

X Value

Y Value

Channel Values

Timestamp
Point Markers

Supported markers

Start

Preload

Yield

Rp0.2

Rp0.1

Rt0.5

Maximum Load

Ultimate Tensile Strength

Break

End
Guide Lines

The graph shall support optional guide lines.

Examples

Horizontal

Vertical

Slope

Offset

Elastic Modulus

Rp0.2 Offset

Guide lines are visualization objects.

They do not modify the measurement dataset.

User Controls

Supported

Show Grid

Hide Grid

Show Legend

Hide Legend

Show Markers

Hide Markers

Show Guide Lines

Hide Guide Lines

Auto Scale

Manual Scale

Fit Curve
Multiple Curves

The graph may display multiple curves simultaneously.

Examples

Specimen 01

Specimen 02

Specimen 03

Specimen 04

Specimen 05
Curve Comparison

Each curve shall have an independent identity.

The graph may compare

Stress
Strain
Load
Stroke (Crosshead)
Calculated Properties
Curve Visibility

Each curve may be

Visible

Hidden

Selected

Highlighted

Hiding a curve never deletes it.

Curve Metadata

Each curve contains

Curve ID

Test Session ID

Dataset ID

X Channel

Y Channel

Units

Material

Specimen

Method

Display Name
Curve Color

Curve colors are presentation properties.

The visualization layer may assign colors automatically.

The user may customize curve appearance where permitted.

Color selection must never affect engineering calculations.

Axis

Each axis contains

Title

Unit

Minimum

Maximum

Scale

Tick Interval
Axis Scaling

Supported

Automatic

Manual

Fixed Range

Fit Data
Unit Conversion

Graph values may be displayed in the user's selected unit system.

Example

N → kN
mm → in
MPa → ksi

The stored engineering dataset remains unchanged.

Graph Templates

A Method may define a default graph template.

Example

ISO 6892-1 Tension

↓

Stress-Strain

↓

Grid ON

Legend ON

Yield Marker ON

Rp0.2 Guide Line ON
Graph Workspace

The UI may provide

Graph Area

Legend

Cursor

Properties Panel

Axis Controls

Zoom Controls

Curve List
TrapeziumX-Compatible Layout

The visualization architecture shall support a layout compatible with the established TrapeziumX-style workflow.

The implementation shall allow

Graph

↓

Curve Controls

↓

Analysis Markers

↓

Result Panel

without coupling the Graph Engine to a specific UI framework implementation.

Analysis Overlay

The graph may display results generated by the Calculation Engine.

Examples

Young's Modulus

Yield Point

Rp0.2

Maximum Stress

Break Point

The Graph Engine only displays these values.

Calculation Separation
Calculation Engine

↓

Result

↓

Graph Overlay

The Graph Engine never calculates the result itself.

Real-Time Analysis

The Graph Engine may display provisional analysis results during a running test.

These are marked as

Live

Provisional

Not Final

Final calculations are generated after dataset finalization.

Selection Synchronization

Selecting a result in the Result Panel may highlight the corresponding point on the graph.

Selecting a point on the graph may highlight the corresponding result where applicable.

Graph Events

Supported events

PointSelected

CurveSelected

CurveHidden

CurveShown

ZoomChanged

PanChanged

MarkerSelected

GuideLineSelected

GraphExportRequested
Export

Supported formats

PNG

JPEG

SVG (Future)

PDF

Clipboard

Data Export

Graph image export is separate from measurement data export.

Measurement data remains available through the Data Export subsystem.

Print

The Graph Engine may provide a printable representation.

Printing shall not alter the original graph configuration or test data.

Accessibility

The graph should support

Keyboard Navigation

Readable Labels

Tooltips

High DPI

Font Scaling

Color-independent markers

Performance

The Graph Engine shall

Render asynchronously

Avoid UI blocking

Use data virtualization where required

Use downsampling for high-density display

Maintain smooth interaction

Memory Management

Large datasets shall not require the entire dataset to be duplicated in UI memory.

The Graph Engine should request only required data ranges.

Historical Data

Historical graphs shall be reproducible from

Test Dataset

+

Method Snapshot

+

Calculation Versions
Graph Configuration Persistence

User-specific graph preferences may be stored.

Examples

Axis Range

Visible Curves

Grid

Legend

Zoom

Panel Layout

These preferences shall not modify Test Data.

Audit

Graph viewing itself normally does not require an audit entry.

Important analytical operations may be audited.

Examples

Manual Point Selected

Guide Line Added

Graph Exported

Analysis Annotation Added
Design Constraints

Graph Engine SHALL NOT

Modify Measurement Data

Modify Calibration

Control Hardware

Execute SQL Directly

Perform Acceptance

Change Mechanical Properties

Architectural Decision (FROZEN)

The Graph Engine is a presentation and visualization subsystem only.

Original measurement data shall remain immutable.

All curve analysis results originate from the Calculation Engine.

The Graph Engine may display, annotate and export results but shall never become the authoritative source of engineering calculations.

Real-time visualization shall remain decoupled from acquisition frequency and shall never interfere with machine control or data acquisition.

This decision is permanent.

Next Chapter

ARCH-056

Engineering Detection & Mechanical Property Algorithm Architecture

This chapter will define

Yield Detection
Rp0.2
Rp0.1
Rt0.5
Young's Modulus
Ultimate Tensile Strength
Break Detection
Elongation
Reduction of Area
Elastic Region Detection
Slope Detection
Algorithm Versioning
Standard-Specific Algorithms
End of Chapter