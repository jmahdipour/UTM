# ARCHITECTURE
# Chapter 70
# WPF HMI Architecture, Main Window, Ribbon, Live Values, JOG Panel & TrapeziumX-Compatible UI

Document ID

ARCH-070

Version

0.1

Status

FROZEN

Related EDR

EDR-075

Depends On

ARCH-053 Test Execution Architecture

ARCH-068 Method Engine

ARCH-069 Machine Controller

ARCH-066 Measurement Acquisition

ARCH-067 Engineering Data Model

---

# Purpose

This chapter defines the Human-Machine Interface architecture for the Shimadzu-compatible Universal Testing Machine application.

The HMI shall be implemented using

```text
WPF

MVVM

VB.NET

Visual Studio 2019

.NET Framework 4.8

x86

The interface shall follow the previously established requirement of a professional laboratory-machine appearance with a visual structure inspired by the existing TrapeziumX workflow.

Core Principle

The HMI is a presentation and interaction layer.

It shall not directly communicate with

PLC

Drive

Fatek Server

SQLite

Measurement Hardware

The dependency direction is

View
  |
  v
ViewModel
  |
  v
Application Services
  |
  v
Domain / Runtime
  |
  v
Infrastructure
Technology Constraint

The implementation is permanently constrained to

VB.NET

WPF

MVVM

.NET Framework 4.8

x86

The application shall not introduce

C#

.NET 6

.NET 7

.NET 8

.NET 9

.NET 10

into the production project.

Visual Studio

The target development environment is

Visual Studio 2019
CPU Architecture

The application target shall be

x86

This is important because the machine communication environment and existing native dependencies may require 32-bit execution.

Main Window

The MainWindow is the primary operational HMI.

Conceptually

+---------------------------------------------------------------+
| Ribbon                                                        |
+---------------------------------------------------------------+
| Test Information                                              |
+---------------------------------------------------------------+
| Live Values                     | JOG / Machine Control       |
|                                 |                             |
+---------------------------------------------------------------+
|                                                             |
|                    Live Graph Area                          |
|                                                             |
|                                                             |
+---------------------------------------------------------------+
| Test Status / Events / Results                                |
+---------------------------------------------------------------+
| Status Bar                                                    |
+---------------------------------------------------------------+
Main Window Responsibilities

The MainWindow provides access to

New Test

Open Test

Method

Specimen

Start

Pause / Hold

Stop

Report

Export

Calibration

Machine Status

JOG

Diagnostics
Ribbon

The application shall use a Ribbon-style menu.

The required visual direction is

Classic Office 2010 style

rather than a modern Backstage-centric interface.

Ribbon Requirement

The Ribbon shall remain compact and operational.

The Test operator should not need to navigate through multiple nested pages to perform common actions.

Ribbon Groups

Recommended groups

File

Test

Method

Machine

Results

Report

Tools
File Group

Commands

New

Open

Save

Close

Exit
Test Group

Commands

New Test

Start

Hold

Stop

Abort
Method Group

Commands

Select Method

New Method

Edit Method

Clone Method

Access shall depend on user role.

Machine Group

Commands

Machine Status

JOG

Reset Fault

Diagnostics

Engineering functions should be protected by permissions.

Results Group

Commands

View Results

Graph

Analysis

Compare
Report Group

Commands

Preview

Generate Report

Export PDF

Export CSV

Export XML
Tools Group

Commands

Settings

Calibration

Material Library

User Management

System Diagnostics
Ribbon Command State

Commands must be dynamically enabled or disabled according to application state.

Example

Test Running

Start = Disabled

Edit Method = Disabled

JOG = Disabled

Stop = Enabled
Command State Source

Command availability shall come from ViewModel state and application services.

The View shall not implement business rules.

Status Bar

The bottom status bar provides persistent machine information.

Recommended sections

Connection

Machine State

Load Cell

Extensometer

Position

Speed

Test State
Status Bar Example
PLC: Connected
Machine: READY
Load Cell: 25 ton
Extensometer: 50 mm
Position: 125.42 mm
Speed: 10.00 mm/min
Test: READY
Sensor Name Requirement

The status bar should display the actual sensor / hardware name rather than exposing PLC register terminology to the operator.

Live Value Panel

The Live Value panel displays measurements in real time.

Typical values

Force

Stress

Position

Extension

Strain

Speed
Primary Live Value

The most important live value should be visually prominent.

For a tensile Test this is normally

Force
Force Display

Example

125.43 kN
Stress Display

When specimen geometry is valid

425.8 MPa
Position Display
125.42 mm
Extension Display

When an extensometer is active

2.315 mm
Strain Display

Example

1.157 %
Live Sensor Selection

The operator may select which engineering value is emphasized in the live-value area.

The architecture should support the previously discussed configurable live-value selection.

Sensor Channel Architecture

The UI should not depend on a fixed PLC channel number.

It consumes normalized Measurement objects.

Live Value Model

Conceptually

LiveValue

Name

Value

Unit

Timestamp

Quality

Status
Measurement Quality

Possible states

Valid

Invalid

Stale

Disconnected

OutOfRange
Stale Measurement

If a measurement has not been updated within the configured timeout

Quality = Stale

The UI should not present it as a fresh measurement.

Live Update Frequency

The HMI update frequency is independent from the raw acquisition frequency.

Example

Acquisition

High frequency

↓

Runtime

↓

HMI

Controlled update rate
UI Performance

The WPF UI must not attempt to render every raw acquisition sample individually when doing so would cause performance degradation.

Graph Area

The graph is the central visual area of the Test screen.

It shall support

Stress-Strain

Force-Displacement

Force-Time

Custom XY

depending on the active Test.

Graph Engine

The graph rendering system remains independent from the HMI ViewModel.

Graph Data Flow
Acquisition

↓

Engineering Dataset

↓

Graph ViewModel

↓

Graph Control
Live Graph

During Test execution the graph shall update continuously.

Graph Update Strategy

The graph should use buffered / decimated data where necessary to maintain smooth rendering.

Raw Data Preservation

Graph optimization must never modify the stored raw dataset.

Graph Axes

Typical tensile Test

X = Strain (%)

Y = Stress (MPa)
Alternative Graph
X = Displacement (mm)

Y = Force (kN)
Axis Unit

Axis units shall always be explicit.

Guide Lines

The graph shall support optional guide lines.

Examples

Rp0.2 Guide

Elastic Modulus Line

Yield Line

Acceptance Limit
Guide Line Toggle

The operator may enable / disable guide lines where permitted.

Event Markers

The graph may show

Yield

Maximum Force

Break

Extensometer Removal

Operator Marker
Marker Source

Markers are produced by the Detection / Calculation layers.

The UI only displays them.

Graph Interaction

Recommended interactions

Zoom

Pan

Reset Zoom

Point Selection

Cursor

Marker Selection
Point Selection

The user may select a point on the curve.

The selected point should display

X Value

Y Value

Timestamp
Curve Selection

If multiple curves exist, the user may select which curve is active.

Graph Theme

The graph should visually match the overall laboratory-machine UI.

It should avoid excessive modern visual effects.

JOG Panel

The JOG panel shall remain easily accessible.

This is a permanent operational requirement.

JOG Layout

Recommended

          UP

     [   JOG   ]

        DOWN

with speed controls nearby.

JOG Controls

The panel should provide

UP

DOWN

STOP
JOG Speed

The operator may select a predefined JOG speed.

Example

0.1 mm/min

1 mm/min

10 mm/min

50 mm/min

Actual available values are machine configuration.

JOG Safety

JOG commands shall be disabled when

Emergency Stop

Controller Fault

Unsafe Interlock

Automatic Test Running

is active.

JOG Direction

Up and Down must be mutually exclusive.

JOG Button Behavior

For a momentary JOG button

Mouse Down

↓

Start Jog

Mouse Up

↓

Stop Jog
Keyboard JOG

Keyboard shortcuts may be supported.

Example

Arrow Up

Arrow Down

Space = Stop

Keyboard operation must not bypass safety rules.

JOG Focus

The JOG panel should clearly indicate when it has keyboard focus.

Test Information Panel

The Test Information panel displays the current Test metadata.

Fields

Acceptance Number

Customer

Project

Date

Operator

Method

Standard

Specimen
Acceptance Number

The Acceptance Number shall be clearly visible.

Customer

Customer name shall be associated with the Test.

Project

Project name shall be associated with the Test.

Date

Test date/time shall be displayed using the application's configured locale policy.

Operator

The logged-in operator should be recorded.

Method Display

Example

ISO 6892-1 Tensile 25T
Standard Display

Example

ISO 6892-1
Specimen Panel

The specimen area contains geometry and identification.

Recommended table

Specimen | Type | Diameter | Width | Thickness | L0 | A0
Specimen Selection

The application shall support multiple specimens within a Test session where required.

Active Specimen

The active specimen should be clearly identified.

Specimen State

Possible states

Draft

Ready

Running

Completed

Aborted
Material Selection

The Test may reference a Material Library entry.

Example

Steel
Rebar
Pipe
Aluminum
Custom
Material Snapshot

The actual material definition used by the Test shall be captured in the Test snapshot.

Method Selection

The Method selector should display only Methods that are compatible with the current machine.

Incompatible Methods

An incompatible Method may optionally be displayed with a warning indicator, but it must not be executable.

Method Selector Example
Method

[ ISO 6892-1 Tensile 25T ▼ ]
Test State Indicator

The HMI shall always show the current Test state.

Possible states

Idle

Draft

Ready

Running

Holding

Stopping

Completed

Aborted

Fault

EmergencyStopped
State Color

The application may use a restrained semantic visual system.

Example

Ready      -> neutral / positive

Running    -> active

Warning    -> warning

Fault      -> error

Stopped    -> neutral

Exact colors shall be defined in the Theme chapter.

Start Button

Start shall be visually prominent.

Start Availability

Start is enabled only when

TestReady = True
Hold Button

Hold temporarily stops automatic motion while preserving the Test state.

Stop Button

Stop performs a controlled stop.

Abort Button

Abort terminates the Test without declaring it a normal successful completion.

Emergency Stop

The HMI may provide a software emergency-stop action where supported.

The physical emergency-stop remains authoritative.

Alarm Area

Important machine conditions shall be displayed in a dedicated alarm / message area.

Examples

Drive Fault

PLC Communication Lost

Load Cell Disconnected

Extensometer Missing

Upper Limit Reached
Alarm Severity
Information

Warning

Critical
Alarm Persistence

Critical alarms should remain visible until acknowledged / cleared according to the alarm policy.

Message Area

Non-critical messages may appear in a status / event area.

Example

Method validated.
Event Log Panel

The Test screen may expose a compact event history.

Example

10:12:03 Test Started

10:12:10 Preload Reached

10:13:42 Yield Detected

10:14:05 Maximum Force Detected

10:14:21 Break Detected
ViewModel Architecture

Each major screen should have a dedicated ViewModel.

Recommended

MainWindowViewModel

TestViewModel

MethodViewModel

MachineViewModel

GraphViewModel

JogViewModel

ReportViewModel

DiagnosticsViewModel
MainWindowViewModel

Responsible for

Navigation

Global Commands

Current Test

Machine Status

User Session

Global Alarms
TestViewModel

Responsible for

Test Metadata

Specimen

Method

Test State

Start / Hold / Stop

Results
MachineViewModel

Responsible for

Machine State

Connection

Load Cell

Extensometer

Position

Speed

Fault
JogViewModel

Responsible for

Jog Up

Jog Down

Stop

Jog Speed

Jog Availability
GraphViewModel

Responsible for

Series

Axes

Markers

Guide Lines

Zoom State

Selected Point
MVVM Rule

Views shall not directly call controller methods.

Incorrect

Button_Click

↓

PLC.Write(...)

Correct

Button

↓

Command

↓

ViewModel

↓

Application Service

↓

Controller
Commands

Recommended command architecture

StartTestCommand

HoldTestCommand

StopTestCommand

AbortTestCommand

JogUpCommand

JogDownCommand

StopJogCommand

ResetFaultCommand
Async Commands

Operations involving hardware or database access should use asynchronous patterns where appropriate.

UI Thread Rule

No long-running hardware or database operation may block the UI thread.

Data Binding

The UI shall use WPF binding.

Example

ForceValue

↓

TextBlock
Property Notification

ViewModels shall implement property notification.

The architecture should use

INotifyPropertyChanged

or an equivalent MVVM implementation.

Collection Notification

Dynamic lists should use

ObservableCollection(Of T)

where appropriate.

Dependency Injection

Services should be injected into ViewModels rather than instantiated directly inside them.

Service Examples
ITestService

IMethodService

IMachineController

IMeasurementService

IGraphService

IReportService

IExportService
View Navigation

Navigation should be state-driven.

Possible views

DashboardView

TestView

MethodView

ResultsView

ReportView

CalibrationView

DiagnosticsView
Main Operational View

The Test View should remain the primary screen during machine operation.

Navigation Restriction During Test

Certain navigation actions should be disabled while the machine is moving.

Example

During Running

Edit Method = Disabled

Calibration = Disabled

Machine Configuration = Disabled
Completed Test Navigation

Completed Tests may be opened in read-only mode.

Read-Only Rule

Historical Test data must not be accidentally modified through the normal Test screen.

Historical View

A historical Test should display

Method Version

Machine Snapshot

Specimen

Measurements

Results

Report
Report Preview

Report preview should be accessible without changing the Test.

Theme Architecture

The UI theme shall be centrally managed.

The project previously referenced

theme.css

and a Material-style visual system.

However, WPF does not directly use CSS as its primary styling mechanism.

Theme Implementation

The production WPF implementation shall use

ResourceDictionary

Styles

ControlTemplates

Brush Resources

Converters
theme.css

If retained for design reference, theme.css shall be treated as a design-token reference rather than as the WPF runtime styling engine.

Theme Tokens

Centralized resources should define

PrimaryBackground

SecondaryBackground

PanelBackground

BorderBrush

TextBrush

MutedTextBrush

AccentBrush

WarningBrush

ErrorBrush

SuccessBrush
Font

The application should use a consistent engineering UI font.

The font must remain readable at the machine operator's viewing distance.

Typography

Recommended hierarchy

Application Title

Section Title

Live Value

Unit

Label

Status
Live Value Typography

The main Force value should be substantially larger than ordinary labels.

Example

125.43

kN
Unit Separation

The numeric value and unit should remain visually distinguishable.

Panel Design

Panels should have

Clear Header

Content Area

Consistent Padding

Consistent Border
Avoid Excessive Decoration

The HMI is an industrial application.

Avoid

Excessive shadows

Large animations

Unnecessary gradients

Decorative transitions
TrapeziumX Compatibility

The goal is functional and visual familiarity rather than pixel-for-pixel copying of proprietary implementation.

The following concepts should remain familiar

Ribbon

Test Information

Live Values

Graph

Status

JOG

Results

Reports
Layout Consistency

The same operational elements should remain in predictable positions.

Resize Behavior

The MainWindow should support resizing without destroying the primary operational layout.

Minimum Window Size

A minimum usable window size shall be defined.

It must accommodate

Live Values

Graph

JOG

Status

without excessive overlap.

Fullscreen / Machine Display

The application may support maximized operation as the default machine configuration.

Multi-Monitor

The architecture should not require multiple monitors.

Optional multi-monitor support may be added later.

Keyboard Navigation

All major commands should be reachable by keyboard.

Shortcut Examples
Ctrl+N = New Test

Ctrl+O = Open

Ctrl+S = Save

F5 = Start / context dependent

Esc = Stop / Cancel according to state

Exact shortcuts must be validated against safety requirements.

Safety-Critical Keyboard Commands

Keyboard shortcuts must never bypass normal interlocks.

Mouse Interaction

Buttons should provide immediate visual feedback.

Touch Support

Touch support may be considered but is not required for the baseline implementation.

Accessibility

The application should provide

Readable Text

Adequate Contrast

Keyboard Navigation

Clear Status

Non-color-only Error Indicators
Error Presentation

Errors should contain

What Happened

Why It Happened

What The Operator Can Do

where possible.

Example

Bad

Error 0x80004005

Preferred

PLC communication lost.

Automatic motion has been stopped.

Check the communication server and network connection.
Confirmation Dialogs

Confirmation dialogs should be used for potentially destructive actions.

Examples

Abort Test?

Delete Method?

Exit While Test Is Running?
No Confirmation Spam

Routine safe actions should not require unnecessary confirmation.

Busy State

During an asynchronous operation the UI should indicate activity.

Example

Connecting...
Loading Method...
Generating Report...
Modal Operations

Long operations should not create an unresponsive modal window.

UI State Model

The MainWindow state should derive from

Application State

Machine State

Test State

User Role
Example
Machine Fault

↓

Start Disabled

JOG Disabled

Reset Fault Enabled
User Roles

The HMI should support role-aware access.

Possible roles

Operator

Engineer

Administrator
Operator

Normal Test execution.

Engineer

Method configuration, diagnostics and advanced machine configuration.

Administrator

System configuration, user management and deployment configuration.

Permission Enforcement

UI hiding is not sufficient.

The service layer must also enforce permissions.

Design-Time Data

WPF Views should support design-time data where useful.

This improves visual development without connecting to the physical machine.

Simulation Mode

A simulation controller may be used for UI development.

ISimulationMachineController

implements

IMachineController
Simulation Benefits

Allows development of

Live Graph

Live Values

JOG UI

Test State

Alarms

Reports

without physical machine movement.

Hardware Mode

Production uses

Fatek / PLC / Hardware Controller
Simulation / Production Boundary

The ViewModel must not know whether the machine is simulated.

Example
TestViewModel

↓

IMachineController

↓

SimulationController

or

TestViewModel

↓

IMachineController

↓

FatekMachineController
UI Testability

The MVVM architecture shall permit automated tests of

Command Availability

State Transitions

Validation Messages

Formatting

Navigation

without requiring WPF rendering.

Performance Target

The HMI shall remain responsive during continuous measurement acquisition and graph updates.

Memory Management

The UI must avoid retaining unbounded raw sample collections.

Graph Buffer

The GraphViewModel should use a bounded rendering buffer when necessary.

Raw Data

Raw data remains in the Test Dataset / acquisition storage and is not limited by the display buffer.

Live Value Formatting

Formatting must respect the configured unit system.

Examples

Force = 125.43 kN

Stress = 425.8 MPa

Position = 125.42 mm

Speed = 10.00 mm/min
Unit Conversion

Unit conversion should occur through an engineering unit service.

The ViewModel should not contain conversion formulas.

Culture

The UI language is English according to the current project requirement.

Numeric formatting should nevertheless be controlled explicitly.

Date / Time

Date and time formatting should use a centralized formatter.

Logging

The HMI may display application events but detailed logs remain in the logging subsystem.

UI Logging Rule

The UI must not become the primary storage for diagnostic logs.

Main Test Screen

The final operational screen should conceptually contain

Ribbon
---------------------------------------------------------------
Test Information
---------------------------------------------------------------
| Live Values                  | Machine / JOG               |
|                              |                              |
---------------------------------------------------------------
|                                                           |
|                        GRAPH                              |
|                                                           |
|                                                           |
---------------------------------------------------------------
| Events / Alarms / Results                                  |
---------------------------------------------------------------
Status Bar
Operational Workflow

The intended operator workflow is

New Test

↓

Enter Acceptance Number

↓

Enter Customer / Project

↓

Select Standard

↓

Select Method

↓

Select Material

↓

Enter Specimen Dimensions

↓

Validate

↓

Install Specimen

↓

Confirm Sensors

↓

Confirm Clutch

↓

Machine Ready

↓

Start Test

↓

Monitor Live Values / Graph

↓

Automatic Completion

↓

Review Results

↓

Generate Report

↓

Export
HMI Boundary

The HMI owns

Presentation

Navigation

User Input

Command Invocation

Status Display

Visualization
HMI Does Not Own

The HMI does not own

Engineering Calculations

Motion Algorithms

PLC Protocol

Measurement Acquisition

Database SQL

Calibration Algorithms
Acceptance Criteria

ARCH-070 is accepted when

WPF is used.

MVVM is used.

VB.NET is used.

.NET Framework 4.8 is used.

x86 is the deployment target.

MainWindow contains the primary Test workflow.

Classic Office 2010-style Ribbon is supported.

Backstage is not required.

Live values are available.

JOG remains accessible.

Automatic Test controls are state-aware.

Graph area supports live visualization.

Stress-Strain and Force-Displacement can be represented.

Guide lines and event markers are supported.

Status bar exposes machine state.

Sensor names are shown instead of raw PLC terminology.

UI does not directly access PLC or SQLite.

Hardware access occurs through services/interfaces.

Simulation mode is possible.

Historical Tests are read-only.

User roles are respected.

UI remains responsive during hardware communication.

UI remains responsive during graph updates.

Theme resources are centralized.

Architectural Decision (FROZEN)

The HMI shall be implemented as a WPF MVVM application using VB.NET on .NET Framework 4.8 x86.

The MainWindow shall provide the primary operational Test environment.

The visual language shall remain compatible with the established TrapeziumX-inspired workflow, including Ribbon, Live Values, Graph, JOG, Test Information and Status Bar.

The JOG interface shall remain readily accessible but shall never bypass controller safety rules.

The HMI shall never directly access PLC registers, Fatek communication, SQLite SQL or physical measurement hardware.

All hardware interaction shall occur through application services and interfaces.

The UI shall represent normalized engineering values rather than raw hardware addresses.

Live visualization shall be optimized independently from raw data storage.

Historical Tests shall be displayed read-only.

The WPF styling system shall use ResourceDictionary / Styles rather than treating CSS as the runtime styling mechanism.

This decision is permanent.

Next Chapter

ARCH-071

SQLite Database Architecture, Schema v1.1, Repository Layer & Data Persistence

This chapter will define

SQLite
Database File
Schema Version
Migration System
Three-Layer Architecture
Repository Pattern
Connection Management
Transactions
Methods
Method Versions
Tests
Specimens
Materials
Measurements
Results
Reports
Calibration Data
Users
Audit Trail
Machine Configuration
Controller Mapping
Foreign Keys
Indexes
Unique Constraints
Soft Delete
Historical Immutability
Backup
Restore
Database Integrity
x86 SQLite Provider
.NET Framework 4.8 Compatibility
Concurrency
Error Handling
Database Recovery
Schema Version 1.1
End of Chapter