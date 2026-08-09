# ARCHITECTURE
# Chapter 32
# Security & User Management Architecture

Document ID

ARCH-032

Version

0.1

Status

FROZEN

Related EDR

EDR-037

Depends On

ARCH-031 Logging, Diagnostics & Audit

ARCH-027 Service Layer

ARCH-023 Database Architecture

---

# Purpose

This chapter defines the complete security architecture of the Universal Testing Machine (UTS) software.

It covers

Authentication

Authorization

Roles

Permissions

Electronic Signatures

Session Management

Account Security

Audit Compliance

The architecture is designed to satisfy

ISO 17025

ISO 9001

FDA 21 CFR Part 11 (future)

Industrial Laboratory Requirements

---

# Philosophy

The software protects

Machine

Data

Results

Reports

Methods

Acceptance Rules

Configuration

Every action must be attributable to an identified user.

---

# Security Layers

```
Authentication

↓

Authorization

↓

Permission

↓

Audit

↓

Traceability
```

Each layer is independent.

---

# Authentication

Authentication answers

"Who is the user?"

Supported methods

Username / Password

Windows Authentication (future)

LDAP (future)

Active Directory (future)

Smart Card (future)

Biometric (future)

Two-Factor Authentication (future)

---

# Authorization

Authorization answers

"What is the user allowed to do?"

Authorization is Role-Based.

---

# User Roles

Default roles

Operator

Supervisor

Laboratory Manager

Administrator

Service Engineer

Developer

Read-Only User

Future Custom Roles

Unlimited

---

# Operator

Allowed

Run Tests

Create Specimens

Select Methods

Generate Reports

Not Allowed

Modify Calibration

Modify Acceptance Profiles

Modify Machine Configuration

Approve Reports

Manage Users

---

# Supervisor

Allowed

Everything Operator can do

Approve Reports

Override Acceptance

Review Tests

Authorize Manual Decisions

---

# Laboratory Manager

Allowed

Manage Methods

Manage Materials

Manage Acceptance Profiles

Approve Configurations

Review Audit

Generate Statistics

---

# Administrator

Allowed

Manage Users

Manage Roles

Manage Permissions

Database Maintenance

Backup

Restore

Configuration

Plugin Management

---

# Service Engineer

Allowed

Calibration

Machine Diagnostics

Communication

DAQ

Maintenance

Cannot

Modify Acceptance

Modify Reports

Modify Results

---

# Developer

Optional role

Only available in Development Mode.

Never enabled in Production by default.

---

# Permission Model

Each permission is independent.

Examples

RunTest

StopTest

AbortTest

ModifyMethod

ModifyMaterial

ModifyAcceptance

ApproveReport

ExportData

BackupDatabase

RestoreDatabase

InstallPlugin

CalibrateMachine

---

# Permission Groups

Permissions may be grouped.

Example

Calibration

↓

Calibrate Load

Calibrate Stroke

Calibrate Extensometer

Approve Calibration

View Calibration

---

# User Account

Each account stores

User ID

Username

Password Hash

Role

Status

Language

Last Login

Password Expiration

Failed Login Count

Digital Signature ID

---

# Account Status

Supported

Active

Locked

Disabled

Expired

Pending Approval

Archived

---

# Password Policy

Configurable

Minimum Length

Complexity

Expiration

History

Maximum Attempts

Automatic Lockout

---

# Session Management

Each login creates

Session ID

Login Time

Machine

Workstation

Operator

Role

Sessions automatically expire after configurable inactivity.

---

# Electronic Signature

Supported

Operator Signature

Reviewer Signature

Supervisor Signature

Approval Signature

Every signature contains

User

Timestamp

Reason

Affected Object

Hash (future)

Certificate (future)

---

# Approval Workflow

Example

```
Report Generated

↓

Supervisor Login

↓

Electronic Signature

↓

Approved
```

Approval is stored permanently in the Audit Trail.

---

# Manual Override

Some operations require

Reason

Supervisor Approval

Electronic Signature

Audit Record

Examples

Acceptance Override

Calibration Approval

Configuration Change

Result Invalidation

---

# Account Lockout

After configurable failed logins

↓

Account Locked

Only Administrator or Laboratory Manager may unlock.

---

# Permission Evaluation

Permission checks occur

Before

every protected operation.

Permission is never checked in the UI only.

The Business Layer is the authority.

---

# Security Events

Examples

Login

Logout

Permission Denied

Password Changed

Account Locked

Account Unlocked

Role Changed

Digital Signature Added

Every event enters the Audit Trail.

---

# Relationship with Audit

Every protected action generates

Audit Entry

↓

User

↓

Role

↓

Timestamp

↓

Affected Object

---

# Offline Operation

Security shall continue functioning without Internet access.

No cloud dependency is required.

---

# Future Compatibility

Supports

LDAP

Active Directory

Azure AD

OAuth

SAML

PKI Certificates

Hardware Tokens

Multi-Factor Authentication

without redesign.

---

# Design Constraints

Security Layer SHALL NOT

Perform Engineering Calculations

Modify Measurements

Modify Mechanical Properties

Communicate with PLC

Control Machine Motion

Render UI

---

# Architectural Decision (FROZEN)

Every operation affecting engineering data, quality records, calibration, acceptance, or reporting shall be performed by an authenticated user with sufficient permissions.

All protected actions shall be traceable through immutable audit records.

This decision is permanent.

---

# Next Chapter

ARCH-033

Calibration Architecture

> This chapter will define one of the most critical engineering subsystems:
>
> - Load Cell Calibration
> - Stroke Calibration
> - Extensometer Calibration
> - Multi-point Calibration
> - Calibration Certificates
> - Calibration Traceability
> - Calibration History
> - ISO 7500-1 compliance
> - ISO 9513 compliance

---

# End of Chapter