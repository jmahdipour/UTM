# ARCHITECTURE
# Chapter 61
# Navigation, Workspace, Ribbon & Operator Workflow Architecture

Document ID

ARCH-061

Version

0.1

Status

FROZEN

Related EDR

EDR-066

Depends On

ARCH-028 Workflow Architecture

ARCH-058 User, Role, Security & Authorization

ARCH-060 WPF / MVVM UI Architecture

ARCH-053 Test Execution Architecture

---

# Purpose

This chapter defines the navigation structure, workspace organization, Ribbon behavior and operator workflow of the Universal Testing Machine application.

The objective is to provide a clear laboratory-oriented workflow while maintaining the established TrapeziumX-inspired operational concept.

---

# Philosophy

The application shall distinguish between

```text
Application Navigation

↓

Workspace Navigation

↓

Test Workflow

↓

Machine Operation

Navigation changes the displayed workspace.

It must not directly manipulate machine hardware.

Main Application Shell

The application shell consists of

Ribbon

Navigation

Workspace

Status Bar

Conceptually

+--------------------------------------------------------------+
| Application Header                                           |
+--------------------------------------------------------------+
| Ribbon                                                       |
+--------------------------------------------------------------+
| Navigation / Workspace                                       |
|                                                              |
|                                                              |
|                    Active Workspace                          |
|                                                              |
|                                                              |
+--------------------------------------------------------------+
| Status Bar                                                   |
+--------------------------------------------------------------+
Primary Navigation

The initial navigation structure is

Home

Test

Methods

Materials

Results

Reports

Calibration

Tools

Settings

Additional items may be added according to installed modules and permissions.

Home Workspace

The Home workspace provides an operational overview.

Typical information

Machine Status

Connection Status

Current User

Active Method

Last Test

Recent Tests

System Warnings
Test Workspace

The Test workspace is the primary operator workspace.

It provides

Test Information

Specimen Information

Method Information

Live Values

Live Graph

Machine State

JOG Controls

Test Controls

Status
Methods Workspace

The Methods workspace provides access to

Method List

Method Search

Method Editor

Method Version

Method Status

Method Approval
Materials Workspace

The Materials workspace provides

Material List

Material Search

Material Editor

Material Version

Material Requirements
Results Workspace

The Results workspace provides

Test History

Result Search

Result Details

Curve Review

Recalculation

Manual Review
Reports Workspace

The Reports workspace provides

Report Templates

Report Preview

Generate

Print

Export

Approval
Calibration Workspace

The Calibration workspace provides controlled calibration functions.

It is separate from normal Test Execution.

Tools Workspace

Tools may contain

Diagnostics

Communication Monitor

Data Import

Data Export

Database Tools

Simulation Mode

Availability is permission-dependent.

Settings Workspace

Settings contains application configuration.

Examples

Application

Machine

Units

Graph

Reports

Security

Storage

Users
Ribbon

The Ribbon shall use a classic Office-style organization.

The Ribbon is not a Backstage-driven architecture.

Ribbon Tabs

Recommended initial structure

Home

Test

Method

Data

Reports

Tools

Settings

The exact tab visibility depends on the active user role.

Home Ribbon

Typical commands

New Test

Open Test

Save

Print

Refresh

Help
Test Ribbon

Typical commands

Start

Pause

Resume

Stop

Reset

JOG

Commands are enabled according to the Runtime State.

Method Ribbon

Typical commands

New Method

Edit

Duplicate

Validate

Approve

Activate

Archive
Data Ribbon

Typical commands

Import

Export

CSV

XML

Search

Filter
Reports Ribbon

Typical commands

Generate

Preview

Print

Export

Approve
Tools Ribbon

Typical commands

Diagnostics

Communication

Simulation

Database

System Information
Settings Ribbon

Typical commands

Configuration

Users

Security

Units

Application Settings
Permission-Aware Ribbon

Ribbon commands shall be filtered according to permissions.

Example

Operator

↓

Test commands visible

Calibration administration hidden

However, service authorization remains mandatory.

Command State

A command has at least three relevant conditions

Visible

Enabled

Authorized

These concepts shall not be confused.

Example

A Stop button may be

Visible = True

Authorized = True

Enabled = False

when the machine is already stopped.

Navigation Service

Navigation shall be centralized.

Conceptually

Navigate(target)

↓

Navigation Service

↓

Workspace Instance

↓

ViewModel

↓

View
Workspace

A Workspace is a logical application context.

Examples

Test Workspace

Method Workspace

Results Workspace

Each Workspace may have its own

View

ViewModel

Commands

Toolbar

State
Workspace Lifecycle

A Workspace may be

Created

Activated

Deactivated

Closed
Workspace State

The application should preserve relevant workspace state when practical.

Example

Results Workspace

↓

Search Filter

↓

Selected Test

↓

Result Tab
Unsaved Changes

Before navigating away from a workspace containing unsaved changes

Unsaved Changes

↓

Save

Discard

Cancel
Active Test Protection

Navigation during an active test requires special handling.

The operator shall not accidentally leave the operational context in a way that hides critical machine state.

Active Test Rule

During

Running

Paused


the Test Workspace shall remain readily accessible.

Other workspaces may be restricted according to operational policy.

Test Completion

After completion

Running

↓

Completed

↓

Results Available

The operator may navigate to Results.

Fault State

If the machine enters Fault

Fault

↓

Fault Information

↓

Operator Action

The application should automatically bring the operator's attention to the fault.

Emergency Stop State

When Emergency Stop is detected

Emergency Stop

↓

Critical State Display

↓

Motion Inhibited

The application must not hide the safety state behind navigation.

Test Creation Workflow

The standard workflow is

New Test

↓

Test Information

↓

Select Method

↓

Select Material

↓

Enter Specimen

↓

Validate

↓

Ready
Test Information

Test Information may include

Acceptance Number

Customer Name

Date

Project Name

Test Standard

Specimen Name
Specimen Entry

The specimen table may contain

Specimen

Geometry

Diameter

Width

Thickness

Gauge Length

Area
Method Selection

The operator selects an approved Method.

The application validates that the Method is usable.

Method Validation

Before Ready state

Method Exists

↓

Method Approved

↓

Method Active

↓

Required Hardware Available

↓

Required Sensors Available

↓

Required Geometry Available
Ready State

The Ready state indicates that the application has completed pre-test validation.

Example

Machine Connected

Method Valid

Specimen Valid

Load Cell Valid

Required Channels Available

No Critical Fault
Start Test

The workflow is

Ready

↓

Start Request

↓

Authorization

↓

Safety Validation

↓

Test Initialization

↓

Running
Start Confirmation

A confirmation dialog may be used where required by laboratory policy.

However, repeated confirmation should not make normal test execution unnecessarily slow.

Running Workspace

During Running the Test workspace displays

Live Load

Live Stroke

Live Extensometer

Live Graph

Elapsed Time

Machine State

Test Controls
Pause

Pause workflow

Running

↓

Pause Request

↓

Runtime Validation

↓

Paused

The actual machine response is controlled by Test Execution and Motion Services.

Resume
Paused

↓

Resume Request

↓

Validation

↓

Running
Stop

Normal stop workflow

Running

↓

Stop Request

↓

Controlled Stop

↓

Finalization

↓

Completed
Abort

Where supported, an abnormal termination may be represented separately from normal Stop.

Running

↓

Abort

↓

Test Aborted

The distinction between Stop and Abort shall be preserved in Test History.

Test Finalization

After acquisition stops

Finalize Dataset

↓

Validate Dataset

↓

Calculate Results

↓

Acceptance Evaluation

↓

Generate Result State

↓

Completed
Results Navigation

After completion

Test Completed

↓

Results Workspace

↓

Test Result
Result Review

The operator may review

Curve

Maximum Force

Yield

Rp0.2

Young's Modulus

UTS

Elongation

Break

depending on the selected Method.

Manual Review

If the Method allows manual review

Automatic Result

↓

Review

↓

Accept

or

↓

Override

Overrides require the authorization defined in ARCH-058.

Report Workflow
Completed Test

↓

Result Review

↓

Report Generate

↓

Preview

↓

Approve if required

↓

Export / Print
Calibration Navigation

Calibration should not be started from the ordinary Test Start workflow.

Calibration Workspace

↓

Select Calibration Procedure

↓

Authorization

↓

Calibration
Method Workflow

Method lifecycle

New

↓

Draft

↓

Validate

↓

Review

↓

Approved

↓

Active

↓

Superseded / Archived
Method Editing Protection

An Active Method shall not be silently modified.

Changes create a new Method Version.

Navigation Guards

Navigation Guards prevent unsafe or invalid transitions.

Examples

Active Test

↓

Prevent destructive navigation
Unsaved Method

↓

Ask Save / Discard / Cancel
Navigation Guard Rules

A Guard may inspect

Current Workspace

Application State

Runtime State

Unsaved Changes

Permissions
Navigation Does Not Control Hardware

The Navigation Service must never directly call

PLC

Servo

DAQ

Motion Controller
Keyboard Shortcuts

The application may support shortcuts.

Examples

Ctrl+N

New Test
Ctrl+S

Save
Ctrl+P

Print

Keyboard shortcuts shall respect authorization and runtime state.

JOG Shortcuts

JOG keyboard shortcuts, if enabled, require explicit configuration.

Because JOG directly affects machine motion, shortcut activation shall include the same safety and authorization checks as the visual JOG control.

Operator Focus

During Test Execution the UI shall prioritize

Machine State

Live Values

Live Graph

Test Controls

Safety State

Non-critical configuration functions should not distract the operator.

Visual Hierarchy

The primary Test Workspace should visually emphasize

1. Machine State

2. Live Load

3. Live Graph

4. Test Controls

5. Specimen / Method Information

6. Secondary Information
Status Bar

The Status Bar remains visible across the main application shell.

Recommended fields

User

Machine

Connection

Method

Load Cell

Test State
Notifications

Non-critical notifications may appear as

Information

Warning

Success

Error

Critical machine events should use the dedicated machine-status mechanism.

Toast Notifications

Toast notifications may be used for

Save Completed

Export Completed

Report Generated

Configuration Saved

They should not be the sole notification mechanism for safety-critical conditions.

Search

Major workspaces should support search.

Examples

Search Test

Search Method

Search Material

Search Report

Search shall be performed through application services rather than direct SQL from the View.

Filtering

Large datasets should support

Date Range

Customer

Project

Material

Method

Standard

Test Number
Workspace Reuse

Where appropriate, workspaces may be reused instead of creating multiple duplicate windows.

This reduces UI complexity and resource usage.

Multiple Windows

Multiple windows may be supported for secondary operations.

Machine-control operations should remain associated with the primary Test Workspace.

Modal Operations

Modal dialogs should be limited to operations that genuinely require focused user input.

Examples

Confirmation

Authentication

Approval

Critical Configuration
Error Recovery Workflow

For recoverable errors

Error

↓

Display

↓

Suggested Action

↓

Retry / Cancel

For non-recoverable errors

Critical Error

↓

Protect Current State

↓

Diagnostic Information

↓

Safe Recovery
Application Startup Workflow
Application Start

↓

Load Configuration

↓

Initialize Logging

↓

Initialize Database

↓

Initialize Security

↓

Initialize Services

↓

Initialize Hardware

↓

Evaluate Machine State

↓

Open Main Window
Startup Failure

If database initialization fails

Application

↓

Safe Failure

The application shall not start normal test execution.

Hardware Connection Failure

If hardware initialization fails

Application

↓

Offline / Diagnostic State

Historical data may remain accessible where possible.

Shutdown Workflow

Normal shutdown

User Exit

↓

Check Active Test

↓

Check Unsaved Changes

↓

Stop Background Services

↓

Flush Audit

↓

Close Repositories

↓

Shutdown
Shutdown During Test

The application shall not silently terminate an active Test Session.

The shutdown workflow must require an appropriate safe-state decision.

Recovery After Unexpected Shutdown

On next startup

Detect Incomplete Session

↓

Recover Metadata

↓

Mark Session Interrupted

↓

Preserve Existing Data

↓

Offer Recovery / Review

The system shall not falsely mark an interrupted test as Completed.

Role-Based Workflow

Operator

Create

↓

Execute

↓

Review

↓

Report

Supervisor

Create

↓

Configure

↓

Review

↓

Approve

Administrator

Configure

↓

Manage

↓

Audit
Workflow and Audit

Important workflow transitions shall generate Audit Events.

Examples

Test Created

Test Started

Test Paused

Test Resumed

Test Stopped

Test Aborted

Method Approved

Result Overridden

Report Approved
Workflow and Security

Every protected workflow transition shall pass authorization.

Example

Result Override

↓

Permission Check

↓

Authentication if required

↓

Audit

↓

Operation
Workflow and Calculation

The UI does not calculate mechanical properties.

After Test completion

Test Service

↓

Calculation Service

↓

Results Workspace
Workflow and Acceptance

The UI displays Acceptance results generated by the Acceptance Engine.

It does not independently determine PASS or FAIL.

Workflow and Reporting

The UI requests reports from the Report Service.

It does not rebuild engineering results from raw data.

Design Constraints

Navigation SHALL NOT

Control Machine Motion
Access PLC
Access Servo Directly
Calculate Results
Modify Raw Measurement Data
Modify Calibration
Bypass Authorization
Hide Emergency Stop State
Mark Interrupted Tests as Completed
Architectural Decision (FROZEN)

The application shall use a centralized Navigation Service and clearly separated Workspaces.

The Test Workspace is the primary operational environment and shall always provide direct visibility of machine state, live values, live graph and essential test controls.

Navigation shall be state-aware and permission-aware.

Active tests, unsaved controlled objects and critical machine conditions shall be protected by Navigation Guards.

The Ribbon shall provide a classic Office-style command structure without requiring a Backstage architecture.

This decision is permanent.

Next Chapter

ARCH-062

Application Service Layer & Domain Service Architecture

This chapter will define

Application Services
Domain Services
Service Interfaces
Dependency Injection
Transaction Boundaries
Test Service
Method Service
Material Service
Measurement Service
Calculation Service
Acceptance Service
Report Service
Calibration Service
Audit Service
Security Service
Service-to-Repository Rules
Service-to-Hardware Rules
End of Chapter