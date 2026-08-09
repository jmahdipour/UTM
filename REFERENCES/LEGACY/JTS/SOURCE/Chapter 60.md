# ARCHITECTURE
# Chapter 60
# WPF / MVVM User Interface Architecture

Document ID

ARCH-060

Version

0.1

Status

FROZEN

Related EDR

EDR-065

Depends On

ARCH-028 Workflow Architecture

ARCH-045 Communication Architecture

ARCH-053 Test Execution Architecture

ARCH-055 Graph & Curve Visualization

ARCH-058 User, Role, Security & Authorization

ARCH-059 Audit Trail & Electronic Signature

---

# Purpose

This chapter defines the WPF user-interface architecture for the Universal Testing Machine software.

The implementation target is

```text
Visual Studio 2019

VB.NET

WPF

.NET Framework 4.8

x86

MVVM

C# shall not be used for the application implementation.

.NET 6 or later shall not be used for the application implementation.

Philosophy

The UI is a presentation layer.

The UI shall not contain

Hardware control logic
PLC communication logic
Calculation algorithms
Calibration algorithms
Acceptance logic
Direct SQL
Test execution state-machine logic

The UI communicates with application services through ViewModels and commands.

Architecture
WPF View

↓

ViewModel

↓

Application Service

↓

Domain / Business Logic

↓

Repository / Hardware Service

↓

Infrastructure
MVVM

The application shall use

Model

View

ViewModel
Model

Models represent application data and domain objects.

Examples

Test

Specimen

Method

Material

Measurement

Result

Calibration

Report

User

Models shall not contain WPF-specific UI behavior.

View

Views are WPF XAML components.

Examples

MainWindow

TestView

MethodView

MaterialView

CalibrationView

ReportView

SettingsView

LoginView
ViewModel

ViewModels expose data and commands required by Views.

Examples

MainViewModel

TestViewModel

MethodViewModel

CalibrationViewModel

ReportViewModel

SettingsViewModel
ViewModel Responsibilities

ViewModels SHALL

Expose display data
Expose Commands
Expose UI state
Receive application events
Request application operations
Notify the View of state changes
ViewModel SHALL NOT

ViewModels SHALL NOT

Access PLC directly
Access serial ports directly
Execute SQL directly
Implement yield algorithms
Implement calibration mathematics
Control servo hardware directly
Commands

User actions shall use Commands.

Examples

StartTestCommand

StopTestCommand

PauseTestCommand

ResumeTestCommand

JogForwardCommand

JogReverseCommand

ResetFaultCommand
ICommand

Commands should implement the standard WPF

ICommand

interface or an application-specific compatible command abstraction.

Command Validation

Commands shall determine whether an operation is currently allowed.

Example

StartTestCommand

CanExecute = True

when RuntimeState = Ready
UI State

UI state shall be derived from application state.

Example

RuntimeState = Running

↓

Start Button Disabled

Pause Button Enabled

Stop Button Enabled

The View shall not independently decide the machine state.

Property Notification

ViewModels shall support

INotifyPropertyChanged

for observable UI properties.

Observable Collections

Dynamic collections should use

ObservableCollection(Of T)

where appropriate.

Examples

Methods

Materials

Specimens

Curves

Results

Users
Main Window

The Main Window provides the primary application shell.

Conceptually

+------------------------------------------------------+
| Ribbon                                               |
+------------------------------------------------------+
| Navigation / Workspace                               |
+------------------------------------------------------+
|                                                      |
|                  Active View                         |
|                                                      |
+------------------------------------------------------+
| Status Bar                                           |
+------------------------------------------------------+
Ribbon

The application shall use a classic Office-style Ribbon concept.

The Ribbon shall provide access to

Home

Test

Methods

Materials

Results

Reports

Calibration

Tools

Settings

The exact tabs may be permission-dependent.

No Backstage

The main Ribbon architecture shall not depend on the Office Backstage interface.

Application commands should remain directly accessible through the Ribbon and standard application menus.

Navigation

Navigation shall be managed by a navigation service.

Conceptually

Navigation Request

↓

Navigation Service

↓

ViewModel

↓

View
Navigation Targets

Examples

Dashboard

Test

Methods

Materials

Calibration

Results

Reports

Settings

Users
Navigation Permission

Navigation options may be filtered according to the user's permissions.

However, service-level authorization remains mandatory.

Workspace

The Main Window contains a primary workspace.

The workspace displays the currently selected application View.

Test Workspace

The Test workspace is the primary operational screen.

Conceptually

+------------------------------------------------------+
| Test Information                                     |
+----------------------+-------------------------------+
| Specimen             | Live Values                   |
| Method               |                               |
| Load Cell            | Load                          |
|                      | Stroke (Crosshead)           |
|                      | Extensometer                 |
+----------------------+-------------------------------+
|                                                      |
|                 LIVE GRAPH                           |
|                                                      |
+------------------------------------------------------+
| JOG / Controls       | Test Status                  |
+------------------------------------------------------+
Live Values

The Test View shall support configurable live measurement values.

Typical values

Load

Stroke (Crosshead)

Extensometer

Time

The configured sensor/channel architecture determines which values are available.

JOG Panel

JOG controls should remain accessible from the primary test workspace.

Supported

Forward

Reverse

Stop

Speed

The UI sends commands to the Motion Service.

JOG Safety

The UI shall never bypass

Emergency Stop

Travel Limit

Hardware Interlock

Configured Maximum Speed
Status Bar

The Status Bar displays important runtime information.

Examples

Connection Status

Machine State

Test State

Active Method

Active Load Cell

Active User

The UI shall use meaningful sensor/device names rather than exposing raw PLC register identifiers to normal operators.

Connection Indicator

The UI may display

Connected

Disconnected

Connecting

Fault

for communication subsystems.

Test State Indicator

The current runtime state should be clearly visible.

Examples

Ready

Running

Paused

Completed

Fault

Emergency Stop
Live Graph Integration

The Test View consumes Graph Engine output.

TestViewModel

↓

Graph Data Provider

↓

Graph Control

The ViewModel shall not implement graph calculations.

Result Panel

After or during a test, the UI may display

Maximum Force

Ultimate Tensile Strength

Yield

Rp0.2

Young's Modulus

Elongation

Break

Values are supplied by the Calculation Engine.

Method View

The Method View manages Test Method configuration.

Typical sections

General

Standard

Specimen

Load Cell

Extensometer

Crosshead

Speed

Control

Cycle

Detection

Results

Report
Method Editing

Method editing shall respect

Draft

Approved

Active

Archived

states.

Material View

Material View manages Material Library information.

Examples

Material Name

Grade

Standard

Elastic Modulus Reference

Yield Requirement

Tensile Requirement
Specimen View

Specimen information includes

Specimen Name

Geometry

Dimensions

Initial Gauge Length

Area

Thickness

Width

Diameter
Calibration View

Calibration View provides controlled calibration workflow.

Calibration shall remain separate from normal Test Execution.

Results View

Results View displays finalized test results.

It shall distinguish

Automatic Result

Manual Override

Recalculated Result

Final Result
Reports View

Reports View allows

Preview

Generate

Print

Export

Approve

according to permissions.

Settings View

Settings are grouped into appropriate categories.

Examples

Application

Machine

Units

Graph

Users

Security

Storage

Reports
Data Binding

WPF data binding shall be used for View-to-ViewModel communication.

Bindings should use

OneWay

TwoWay

OneTime

according to the property semantics.

UI Thread

The WPF UI executes on the UI thread.

Hardware and acquisition operations shall not block this thread.

Dispatcher

Cross-thread UI updates shall be marshaled through the WPF Dispatcher where required.

Background Operations

Long-running operations shall run outside the UI thread.

Examples

Data Import

Large Dataset Loading

Report Generation

Calculation

Database Maintenance

Export
Real-Time Data

Live measurement data shall be delivered to the UI through a controlled event/observable mechanism.

The UI shall not poll the hardware directly.

Event Flow
DAQ

↓

Measurement Service

↓

Runtime Event / Data Stream

↓

TestViewModel

↓

UI
Error Display

Errors shall be presented at the appropriate level.

Examples

Information

Warning

Error

Critical Safety Alarm
Safety Alarm

Critical safety alarms shall be visually prominent.

The UI must not require a normal dialog interaction before the underlying safety system can stop motion.

Dialogs

Dialogs may be used for

Confirmation

Input

Error

Approval

Authentication

Critical machine safety must not depend on modal dialogs.

Localization

The application should support localization.

The initial UI language is

English

User-visible strings should not be hard-coded throughout ViewModels.

Theme

The UI shall support a centralized visual theme.

The project may use

Theme Resources

Resource Dictionaries

theme.css

or an equivalent WPF resource architecture where practical.

The visual design should maintain consistency with the established TrapeziumX-inspired layout.

Colors

UI colors should be centrally defined.

Examples

Primary

Secondary

Background

Panel

Border

Text

Warning

Error

Success
Fonts

Fonts shall be centralized through application resources.

The UI must support normal Windows DPI scaling.

DPI

The UI shall be designed for

100%

125%

150%

200%

where practical.

Responsive Layout

The main window shall use WPF layout containers such as

Grid

DockPanel

StackPanel

Canvas

according to the purpose of each region.

Canvas

Canvas may be used for

Graph overlays
Custom machine visualization
Interactive coordinate areas
Custom controls

Canvas shall not replace normal layout containers where automatic layout is required.

Resource Dictionaries

Shared styles should be placed into resource dictionaries.

Examples

Colors.xaml

Typography.xaml

Controls.xaml

Buttons.xaml

Ribbon.xaml

Graph.xaml
Custom Controls

Reusable controls should be created for frequently used components.

Examples

LiveValueCard

MachineStatusIndicator

JogControl

TestStateIndicator

MeasurementDisplay

CurveLegend
Dependency Injection

The application should use dependency injection at the Composition Root.

Dependencies include

IConfigurationService

ITestService

IMethodService

IMaterialService

IMeasurementService

IMotionService

ICalculationService

IAuditService

IReportService
Service Locator

A global Service Locator shall not be used as the primary dependency mechanism.

Dependencies should be explicitly injected.

Composition Root

Application startup creates the required services.

Conceptually

App.xaml

↓

Bootstrapper

↓

Service Registration

↓

MainWindow

↓

MainViewModel
Interface-Based Services

ViewModels should depend on interfaces rather than concrete hardware implementations.

Example

IMotionService

↓

MotionService

↓

HAL
Hardware Independence

The WPF UI shall remain functional with

Real Hardware

Simulation Hardware

Test Mock

Offline Dataset

where the corresponding services are available.

Simulation Mode

A simulation mode may provide

Simulated Load

Simulated Stroke (Crosshead)

Simulated Extensometer

Simulated Test Sequence

This supports UI development without physical machine access.

Offline Historical Mode

The UI should be able to display historical Test Sessions without connecting to the machine.

MVVM Testing

ViewModels shall be testable without creating actual WPF windows.

Tests should cover

Commands

CanExecute

State Changes

Validation

Navigation

Permission Handling
UI Logging

The UI may log

Navigation Errors

Binding Errors

Command Errors

Unhandled UI Exceptions

but raw measurement data shall not be logged through normal UI logging.

Exception Handling

Unhandled UI exceptions should be caught at the application boundary.

The application shall create a diagnostic record.

The system shall not silently continue after an unrecoverable state.

Application Shutdown

Normal shutdown should follow

Stop UI Operations

↓

Check Active Test

↓

Request Safe Shutdown

↓

Flush Services

↓

Close Database

↓

Close Application

An active test shall not be silently terminated.

Startup

Startup should perform

Load Configuration

↓

Initialize Services

↓

Initialize Database

↓

Initialize Security

↓

Initialize Hardware Services

↓

Load Main Window

Hardware initialization failures shall be clearly reported.

UI and Database

Views and ViewModels shall not execute SQL directly.

All database access shall pass through application services and repositories.

UI and Audit

Important user operations invoke application services that generate Audit Events.

The ViewModel shall not manually construct audit records unless explicitly designed as part of the service contract.

UI and Security

The UI may hide unauthorized commands.

The service layer must still enforce authorization.

Accessibility

The UI should support

Keyboard Navigation

Tooltips

Readable Labels

Logical Tab Order

High DPI

Accessible Automation Names
Performance Requirements

The UI shall remain responsive during

DAQ

Motion

Test Execution

Graph Rendering

Large Dataset Processing
Memory Requirements

The UI shall avoid unnecessary duplication of large measurement datasets.

Graph visualization should use the Graph Data Provider and downsampling mechanisms defined in ARCH-055.

Design Constraints

WPF UI SHALL NOT

Access PLC Directly
Access Servo Directly
Access DAQ Hardware Directly
Execute SQL Directly
Calculate Mechanical Properties
Modify Calibration
Modify Raw Measurement Data
Implement Acceptance Rules
Own Test Runtime State
Bypass Security
Architectural Decision (FROZEN)

The application UI shall use WPF + MVVM with VB.NET on .NET Framework 4.8 x86.

Views are presentation components.

ViewModels expose state and commands.

Application Services own application operations.

Hardware access remains behind service and HAL interfaces.

The UI shall never become the owner of machine control, measurement calculation, database access or test execution state.

The primary Test Workspace shall provide the operator with Live Values, Live Graph, JOG controls and Test State while maintaining strict separation from the underlying machine-control architecture.

This decision is permanent.

Next Chapter

ARCH-061

Navigation, Workspace, Ribbon & Operator Workflow Architecture

This chapter will define

Main Window Navigation
Classic Office Ribbon
Workspace Management
Test Workspace
Method Workspace
Results Workspace
Reports Workspace
Calibration Workspace
Navigation Guards
Unsaved Changes
Active Test Protection
Permission-Aware Navigation
Keyboard Shortcuts
Operator Workflow
End of Chapter