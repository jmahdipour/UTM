# ARCHITECTURE
# Chapter 58
# User, Role, Security & Authorization Architecture

Document ID

ARCH-058

Version

0.1

Status

FROZEN

Related EDR

EDR-063

Depends On

ARCH-047 Configuration Management

ARCH-053 Test Execution Architecture

ARCH-057 Standards Library Architecture

ARCH-059 Audit & Electronic Signature Architecture

---

# Purpose

This chapter defines the architecture for users, roles, permissions, authentication and authorization within the Universal Testing Machine software.

The security architecture protects

- Test Data
- Methods
- Materials
- Standards
- Calibration
- Results
- Acceptance
- Reports
- Configuration
- Audit Records

---

# Philosophy

Authentication answers

```text
Who is the user?

Authorization answers

What is the user allowed to do?

Audit answers

What did the user do?

These three concepts shall remain separate.

Architecture
User

↓

Authentication

↓

Session

↓

Role

↓

Permission

↓

Authorization

↓

Application Operation

↓

Audit
Responsibilities

The Security subsystem SHALL

Authenticate users
Maintain user identities
Assign roles
Resolve permissions
Authorize operations
Protect privileged functions
Manage sessions
Support account status
Integrate with Audit
SHALL NOT

The Security subsystem shall not

Modify measurement data
Calculate engineering properties
Control machine motion
Modify calibration values directly
Evaluate test acceptance
Generate reports
User Object

Each user contains

User ID

Username

Display Name

Status

Role

Created Date

Modified Date

Last Login

Additional identity information may be stored according to laboratory policy.

User Status

Supported

Active

Disabled

Locked

Expired

Archived

Only Active users may normally authenticate.

Roles

The initial system defines

Operator

Supervisor

Administrator

Additional roles may be introduced later.

Operator

The Operator may normally

Create Test Session
Select Active Method
Select Material
Enter Specimen Information
Perform Test
Use JOG
View Results
Export permitted Data
Generate Reports
View permitted Historical Tests

The Operator shall not normally

Modify Calibration
Approve Methods
Modify Standards
Change Protected Configuration
Delete Historical Data
Supervisor

The Supervisor may

Perform Operator operations
Create Methods
Edit Draft Methods
Review Methods
Approve Methods
Review Results
Authorize permitted manual result operations
Review Audit Records
Administrator

The Administrator may

Manage Users
Manage Roles
Manage Permissions
Manage Configuration
Manage Method Library
Manage Standards Metadata
Manage Material Library
Manage System Settings
Manage Security Policies

Administrative permission does not automatically permit modification of immutable historical measurement data.

Permission Model

Permissions shall be granular.

Example

Test.Create

Test.Start

Test.Stop

Test.Jog

Test.View

Test.Export

Method.Create

Method.Edit

Method.Approve

Material.Create

Material.Edit

Calibration.View

Calibration.Execute

Result.Recalculate

Result.Override

Report.Generate

Audit.View

Configuration.Edit

User.Manage
Permission Naming

Permissions should use

Resource.Action

Example

Method.Create

Method.Edit

Method.Approve

This provides predictable authorization logic.

Role-to-Permission Mapping

A Role contains a set of Permissions.

Conceptually

Operator

├── Test.Create
├── Test.Start
├── Test.Stop
├── Test.Jog
├── Test.View
└── Report.Generate
Least Privilege

Users shall receive only permissions required for their assigned responsibilities.

Permissions shall not be granted merely because an operation is convenient.

Authorization

Before a protected operation

Application Request

↓

Authorization Service

↓

Permission Check

↓

Allowed

or

↓

Denied
Authorization Failure

When access is denied

Operation shall not execute.
The user shall receive an appropriate message.
The event may be written to Audit depending on security policy.

The system shall not expose sensitive implementation details.

Authentication

The architecture supports

Local Authentication

Windows Authentication

Enterprise Authentication

Future LDAP / Active Directory

The initial implementation may use the authentication mechanism selected by the project deployment requirements.

Password Policy

If local authentication is used, policy may define

Minimum Length
Complexity
Expiration
Failed Login Limit
Lockout Duration
Password History

The exact policy is configuration-controlled.

Password Storage

Passwords shall never be stored as plaintext.

Password verification shall use a modern password hashing mechanism with an appropriate per-user salt.

Session

After successful authentication the application creates a User Session.

Session contains

Session ID

User ID

Login Time

Last Activity

Authentication Context

Session Status
Session Timeout

Inactive sessions may expire according to configuration.

Example

Inactive

↓

Warning

↓

Session Lock

↓

Re-authentication
Session Lock

Session locking protects unattended laboratory workstations.

When locked

Machine State

remains controlled by Runtime

Security locking shall not abruptly terminate an active test.

Active Test and Lock

If the workstation becomes locked during an active test

Test Execution continues according to its runtime state.
Safety systems remain active.
UI interaction requires authentication.
Unauthorized users cannot operate protected controls.
Emergency Stop

Emergency Stop shall remain available according to the machine safety architecture.

Software authentication shall never prevent a required physical safety action.

Privileged Operations

Sensitive operations may require elevated authorization.

Examples

Calibration

Method Approval

Result Override

Configuration Change

User Management
Re-Authentication

For high-risk operations the system may require the current user to authenticate again.

Example

Result Override

↓

Re-authentication

↓

Reason

↓

Authorization

↓

Operation
Result Override

Manual result override shall be tightly controlled.

The system shall preserve

Original Result

New Result

User

Timestamp

Reason

Authorization Context

The original result shall never be silently deleted.

Method Approval

Method approval requires appropriate permission.

Workflow

Draft

↓

Review

↓

Approval

↓

Active

The approving user shall be recorded.

Standard Management

Only authorized users may

Add Standard Metadata
Add Standard Revision
Activate Revision
Modify Compliance Mapping

Normative Standard content shall not be invented by users or software.

Material Management

Authorized users may create or modify Material Library records.

Completed Test Sessions retain their Material Version and are not changed by later material edits.

Calibration Permissions

Calibration operations are protected.

Possible permissions

Calibration.View

Calibration.Create

Calibration.Edit

Calibration.Approve

Calibration.Execute

The exact permission mapping is deployment-specific.

Test Permissions

Possible permissions

Test.Create

Test.Start

Test.Pause

Test.Resume

Test.Stop

Test.Jog

Test.View

Test.Export
Result Permissions

Possible permissions

Result.View

Result.Recalculate

Result.Review

Result.Override
Report Permissions

Possible permissions

Report.View

Report.Generate

Report.Export

Report.Sign
Audit Permissions

Possible permissions

Audit.View

Audit.Export

Audit.Administer

Audit records themselves shall remain protected from ordinary modification.

Configuration Permissions

Possible permissions

Configuration.View

Configuration.Edit

Configuration.Approve

Critical configuration changes may require approval.

User Management

Authorized administrators may

Create User

Disable User

Lock User

Reset Credentials

Assign Role

Remove Role

Archive User

User Deletion

Users associated with historical Audit or Test records shall not be physically deleted when deletion would destroy traceability.

Instead the account shall normally be

Archived

or

Disabled
Role Changes

Changing a user's role affects future authorization.

Historical Audit records retain the identity of the user and the context in which the action occurred.

Permission Changes

Permission changes shall be audited.

Example

Permission Added

Permission Removed

Role Modified
Security Context

Every protected operation should have access to

User ID

Session ID

Role

Permission

Timestamp

Correlation ID
Correlation ID

Operations spanning multiple services should share a Correlation ID.

Example

Test Start

↓

Execution Service

↓

Acquisition

↓

Motion

↓

Calculation

The same logical operation can therefore be traced.

Offline Operation

If the machine operates without external authentication infrastructure, the application may use local authentication according to configured policy.

External identity services shall not be mandatory for the core test runtime unless explicitly required by deployment.

Security During Communication

Where network communication is used, the security layer shall support authenticated communication according to the selected deployment architecture.

Credentials shall not be transmitted or logged in plaintext.

Secret Management

The application shall not store

Passwords in source code
API secrets in source code
Tokens in plain configuration files
Credentials in Audit logs
Logging

Security events may include

Login Success

Login Failure

Logout

Session Expired

Account Locked

Permission Denied

Role Changed

Password Changed

Privileged Operation

Sensitive credentials shall never be logged.

Audit Integration

Security operations shall integrate with the Audit subsystem.

Example

User

↓

Authentication

↓

Operation

↓

Audit Event
Security and Test Traceability

A completed Test Session shall identify the user responsible for

Test creation
Test execution
Manual intervention
Result review
Result override where applicable
Report approval where applicable
Electronic Signature

Electronic signatures are handled by the dedicated Audit / Signature subsystem.

Security provides identity verification.

Signature provides formal approval evidence.

Backup

Security configuration shall be included in system backup according to deployment policy.

Passwords and secrets shall be backed up only through secure mechanisms.

Recovery

After restoration

User identities must remain traceable.
Historical audit records must remain associated with the original user identity.
Permission configuration must be restored consistently.
Security credentials must not be exposed.
Security Testing

The system shall include tests for

Authentication

Authorization

Permission Boundaries

Session Expiration

Account Lockout

Privilege Escalation

Unauthorized Access

Audit Integration
Threat Considerations

The architecture shall consider

Unauthorized Access
Privilege Escalation
Credential Theft
Session Hijacking
Unauthorized Result Modification
Configuration Tampering
Audit Tampering
Malicious Data Export
Defense in Depth

Security shall exist at multiple levels.

Authentication

↓

Authorization

↓

Application Validation

↓

Repository Protection

↓

Database Permissions / Integrity

↓

Audit

No single UI restriction is considered sufficient security.

UI Security

The UI may hide controls that the user cannot access.

However, hiding a button is not authorization.

The underlying service must independently verify permission.

API Security

Every protected application service shall perform authorization independently where applicable.

A caller cannot gain permission merely by invoking an internal service directly.

Database Security

Repositories shall prevent ordinary application operations from bypassing Business Layer authorization.

Historical records shall be protected against unauthorized modification.

Design Constraints

Security SHALL NOT

Control Test State
Modify Raw Measurement Data
Change Engineering Results Silently
Bypass Physical Safety
Invent User Identity
Store Plaintext Passwords
Delete Traceability
Replace Audit
Architectural Decision (FROZEN)

Security is based on explicit identity, role and permission management.

Authorization shall be enforced by application services and shall not rely solely on UI visibility.

Historical identities and security events shall remain traceable.

Privileged operations such as Method Approval, Calibration operations, Result Override and Configuration Changes shall require appropriate authorization.

Security mechanisms shall never interfere with physical emergency-stop functionality.

This decision is permanent.

Next Chapter

ARCH-059

Audit Trail & Electronic Signature Architecture

This chapter will define

Audit Events
Immutable Audit Records
User Traceability
Test Traceability
Result Changes
Method Approval
Calibration Approval
Electronic Signature
Signature Meaning
Signature Authentication
Audit Search
Audit Export
ISO 17025 Traceability
Historical Integrity
End of Chapter