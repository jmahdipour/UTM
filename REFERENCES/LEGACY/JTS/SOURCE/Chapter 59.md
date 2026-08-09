# ARCHITECTURE
# Chapter 59
# Audit Trail & Electronic Signature Architecture

Document ID

ARCH-059

Version

0.1

Status

FROZEN

Related EDR

EDR-064

Depends On

ARCH-023 Database Architecture

ARCH-053 Test Execution Architecture

ARCH-054 Test Data & Measurement Storage

ARCH-056 Engineering Detection & Mechanical Property Algorithms

ARCH-058 User, Role, Security & Authorization

---

# Purpose

This chapter defines the architecture for audit trails, traceability, controlled actions and electronic signatures within the Universal Testing Machine software.

The subsystem protects the integrity and traceability of

- Test Sessions
- Measurement Data
- Methods
- Standards
- Calibration
- Results
- Acceptance Decisions
- Reports
- Configuration
- User Actions

---

# Philosophy

The system shall distinguish between

```text
Audit Trail

↓

What happened?
Electronic Signature

↓

Who formally approved it?
Authentication

↓

Who is the person?

These functions are related but are not interchangeable.

Architecture
User

↓

Authentication

↓

Authorized Operation

↓

Business Service

↓

Audit Event

↓

Immutable Audit Record

For formal approval:

Approval Request

↓

Re-authentication

↓

Electronic Signature

↓

Signed Object

↓

Audit Record
Responsibilities

The Audit subsystem SHALL

Record important user actions
Record system actions
Record security events
Preserve historical traceability
Record changes to controlled objects
Record approvals
Record electronic signatures
Support audit search
Support audit export
Detect unauthorized audit modification
SHALL NOT

The Audit subsystem shall not

Control the machine
Calculate engineering properties
Modify measurement data
Modify calibration
Determine acceptance
Replace authentication
Replace authorization
Audit Event

An Audit Event represents an action or significant system event.

Each event contains

Audit Event ID

Timestamp

User ID

Session ID

Event Type

Object Type

Object ID

Action

Result

Reason

Correlation ID

Additional metadata may be stored where required.

Event Types

Examples

Login

Logout

TestCreated

TestStarted

TestStopped

TestCompleted

TestInterrupted

MethodCreated

MethodModified

MethodApproved

CalibrationCreated

CalibrationApproved

ResultCalculated

ResultRecalculated

ResultOverridden

ReportGenerated

ReportApproved

ConfigurationChanged

PermissionChanged
System Events

Not every event originates from a human.

System events may include

ApplicationStarted

ApplicationStopped

HardwareConnected

HardwareDisconnected

DAQStarted

DAQStopped

CommunicationFault

RecoveryStarted

RecoveryCompleted

System-generated events shall identify the originating subsystem.

User Events

User events contain

User ID

Role

Session ID

The identity must refer to the authenticated user session.

Object Traceability

Audit records should identify the affected object.

Examples

Test Session ID

Method ID

Method Version

Calibration ID

Result ID

Report ID

Configuration ID
Immutable Audit Record

Completed Audit Records shall be immutable.

Normal application operations shall not allow

Editing
Deleting
Rewriting
Timestamp modification
User replacement
Audit Integrity

The system should support integrity verification through

Hash

Checksum

Sequential Integrity Chain

Digital Signature

according to the selected implementation.

Audit Sequence

Audit records may contain a monotonically increasing sequence.

Example

1001

1002

1003

1004

The sequence helps identify missing records.

Audit Hash Chain

Where implemented

Event 1001
   ↓
Hash 1001
   ↓
Event 1002
   ↓
Hash 1002
   ↓
Event 1003

A later event references the previous integrity value.

Timestamp

Audit timestamps shall use a consistent system time source.

The stored timestamp should preserve sufficient precision for event ordering.

Time Zone

Audit storage should use a canonical time representation such as UTC.

The UI may display the timestamp in the laboratory's configured local time zone.

Clock Integrity

The system should detect significant system-clock changes where practical.

Clock changes may generate an Audit Event.

Example

System Clock Changed
Correlation ID

Related operations share a Correlation ID.

Example

Test Start

↓

Motion Start

↓

DAQ Start

↓

Runtime Event

↓

Test Completion

This allows complete operation tracing.

Test Traceability

A Test Session should be traceable through

User

↓

Method

↓

Standard

↓

Specimen

↓

Calibration

↓

Measurement Dataset

↓

Calculation

↓

Acceptance

↓

Report
Change Tracking

Controlled objects should support versioned change history.

Examples

Method v1

↓

Method v2

↓

Method v3

Audit records identify who created or approved each version.

Before / After Values

For controlled configuration changes, the Audit record may contain

Previous Value

New Value

Sensitive information shall not be stored unnecessarily.

Reason for Change

Important modifications may require a mandatory reason.

Examples

Result Override

Method Change

Calibration Change

Configuration Change

The operation shall not complete if a required reason is missing.

Result Recalculation

When a result is recalculated

Original Result

↓

Recalculation

↓

New Result

The Audit record shall identify

Original Result ID

New Result ID

Algorithm Version

User

Timestamp

Reason
Result Override

Manual override is a controlled operation.

The system stores

Automatic Result

Override Result

Reason

User

Timestamp

Authorization

Signature if required

The original automatic result remains preserved.

Method Approval

Method approval follows

Draft

↓

Review

↓

Approval

↓

Active

The approval event contains

Method ID

Method Version

Approver

Timestamp

Approval Status
Calibration Approval

Where calibration approval is required

Calibration

↓

Review

↓

Approval

↓

Active

The approval event is permanently traceable.

Report Approval

A report may require formal approval.

Report

↓

Review

↓

Signature

↓

Approved

The signed report references the exact Report Version.

Electronic Signature

Electronic Signature represents formal user approval of a controlled object.

Examples

Method Approval

Calibration Approval

Result Approval

Report Approval
Signature Object

Each signature contains

Signature ID

User ID

Signed Object Type

Signed Object ID

Signed Object Version

Timestamp

Signature Meaning

Authentication Method

Signature Status
Signature Meaning

The signature must explicitly identify its meaning.

Examples

Approved

Reviewed

Verified

Released

Accepted

The software shall not treat all signatures as equivalent.

Signature Binding

The signature shall be bound to the exact object version.

Example

Report Version 4

↓

Signature

↓

Report Version 4

If Report Version 5 is created, the old signature does not automatically apply to Version 5.

Signature Authentication

High-risk signatures may require re-authentication.

Example

Approval Request

↓

Password / Identity Verification

↓

Signature Created

The authentication mechanism shall follow the configured Security architecture.

Signature Integrity

A signature should include an integrity reference to the signed object.

Conceptually

Object Hash

+

User Identity

+

Signature Meaning

+

Timestamp

This allows later verification that the signed object has not changed.

Signature Status

Supported

Valid

Revoked

Superseded

Invalid

A signature shall not be silently removed.

Signature Revocation

If a signature becomes invalid under laboratory policy

Original Signature

↓

Revoked

↓

Reason Recorded

The original signature remains historically visible.

Multiple Signatures

An object may require multiple signatures.

Example

Operator

↓

Supervisor

↓

Quality / Authorized Reviewer

The required sequence is Method / laboratory-policy dependent.

Audit Search

Authorized users may search audit records by

Date

User

Event Type

Object Type

Object ID

Test Session

Correlation ID
Audit Filtering

Supported filters include

Security

Tests

Methods

Calibration

Results

Reports

Configuration

System
Audit Export

Audit records may be exported.

Supported formats may include

CSV

XML

JSON

PDF

Export operations themselves shall be audited.

Audit Read Access

Viewing an audit record does not modify it.

Access to audit information shall be permission-controlled.

Audit Administration

Even administrators shall not normally be able to modify historical audit records through ordinary application functions.

Administrative maintenance must preserve traceability.

Audit Backup

Audit data shall be included in backup.

A backup shall preserve

Event IDs

Sequence

Timestamps

User References

Object References

Integrity Information
Audit Restore

After restoration the system shall verify audit integrity where supported.

Any integrity problem shall generate a diagnostic/security event.

Audit Retention

Retention periods shall be configurable according to laboratory policy and applicable requirements.

The system shall support long-term retention of traceability information.

Historical User

If a user account is later disabled or archived, historical Audit records continue to reference the original User ID.

Historical identity shall not be replaced with

Unknown User

merely because the account is inactive.

Historical Method

A completed Test Session retains the Method Version used during execution.

Later Method modifications do not alter historical Audit references.

Historical Calibration

Calibration references used by a Test Session remain traceable even after the calibration is superseded.

ISO 17025 Traceability

The architecture shall support traceability requirements associated with controlled laboratory activities.

The exact compliance interpretation shall be verified against the laboratory's applicable ISO 17025 procedures and controlled documentation.

Electronic Records

Electronic records associated with testing shall preserve

Identity

Timestamp

Object

Version

Action

Approval

Traceability
Audit and Measurement Separation

Measurement data and Audit records are separate logical domains.

Measurement Dataset

≠

Audit Dataset

Audit records reference measurement datasets but do not contain the complete measurement dataset.

Audit and Report Separation

A Report is a controlled output.

Audit records describe its lifecycle.

Report

↓

Audit

↓

Generated

↓

Reviewed

↓

Approved
Security Integration

Audit depends on the Security subsystem for

User Identity

Role

Session

Authentication Context
Failure Handling

If Audit persistence fails during a critical operation, the application shall not silently continue as though the event was recorded.

The system shall follow a configured policy.

Possible behavior

Operation Blocked

or

Operation Completed with Audit Failure

↓

Critical Warning

↓

Recovery Required

Critical traceability operations should prefer blocking until the Audit record can be safely persisted.

Performance

Audit processing shall not block high-frequency DAQ operations.

DAQ samples shall not create one full Audit record per sample.

Audit records are for significant events, not raw measurement frames.

Design Constraints

Audit SHALL NOT

Modify Historical Measurement Data
Modify Historical Results
Delete Evidence
Replace User Identity
Generate Engineering Properties
Control Hardware
Override Physical Safety
Architectural Decision (FROZEN)

All significant user and system actions affecting controlled laboratory data shall be traceable through an immutable Audit Trail.

Electronic Signatures shall be explicitly bound to the signed object, its exact version, the authenticated user and the meaning of the signature.

Result overrides, method approvals, calibration approvals and report approvals shall preserve the original state and create an auditable new state.

Historical audit and signature records shall remain traceable even when users, methods, calibrations or reports are subsequently archived or superseded.

This decision is permanent.

Next Chapter

ARCH-060

WPF / MVVM UI Architecture

This chapter will define

WPF Application Structure
MVVM
Views
ViewModels
Models
Commands
Services
Dependency Injection
Navigation
Data Binding
UI Thread
Dispatcher
Canvas
Ribbon
Status Bar
JOG Panel
Live Graph Integration
TrapeziumX-Compatible Layout
End of Chapter