# ARCHITECTURE
# Chapter 29
# State Transition Matrix & Business Rules Architecture

Document ID

ARCH-029

Version

0.1

Status

FROZEN

Related EDR

EDR-034

Depends On

ARCH-007 State Machine

ARCH-027 Service Layer

ARCH-028 Workflow Architecture

---

# Purpose

This chapter defines the official State Transition Matrix of the Universal Testing Machine software.

It specifies

Allowed States

Allowed Transitions

Business Rules

Validation Rules

Forbidden Operations

Every module in the software shall follow this state model.

---

# Philosophy

Every business object owns a lifecycle.

Only predefined transitions are allowed.

Undefined transitions are prohibited.

---

# Global State Model

```
Draft

↓

Ready

↓

Running

↓

Completed

↓

Approved

↓

Archived
```

Alternative paths

```
Draft

↓

Cancelled
```

```
Running

↓

Aborted
```

---

# State Definitions

## Draft

Object has been created.

Editing allowed.

Deletion allowed.

Testing prohibited.

---

## Ready

Validation completed.

Editing restricted.

Machine preparation allowed.

Testing allowed.

---

## Running

Test is executing.

Measurements active.

Editing prohibited.

Deletion prohibited.

---

## Completed

Acquisition finished.

Analysis complete.

Results available.

Editing prohibited.

Approval allowed.

---

## Approved

Official laboratory result.

Report finalized.

Results locked.

No engineering modification allowed.

---

## Archived

Read-only historical record.

Permanent storage.

---

## Cancelled

Object terminated before testing.

Kept for traceability.

---

## Aborted

Testing interrupted.

Partial measurements preserved.

Marked as incomplete.

---

# Transition Matrix

| Current State | Allowed Next State |
|---------------|-------------------|
| Draft | Ready |
| Draft | Cancelled |
| Ready | Running |
| Ready | Draft |
| Running | Completed |
| Running | Aborted |
| Completed | Approved |
| Completed | Archived |
| Approved | Archived |

Every other transition is prohibited.

---

# Forbidden Examples

Not allowed

Completed

↓

Running

---

Approved

↓

Draft

---

Archived

↓

Running

---

Cancelled

↓

Completed

---

# Business Rule Categories

Rules are divided into

Validation Rules

Transition Rules

Permission Rules

Integrity Rules

Safety Rules

---

# Validation Rules

Examples

Specimen must exist.

Method must exist.

Material must exist.

Geometry must be complete.

Machine must be connected.

Operator must be logged in.

Before entering Ready.

---

# Transition Rules

Example

Ready

↓

Running

Requirements

Machine Connected

Safety OK

Emergency Reset

Specimen Installed

Operator Authorized

---

# Permission Rules

Example

Operator

May

Run Test

Cannot

Approve Report

---

Supervisor

May

Approve Report

Override Decision

---

Administrator

May

Configure System

Manage Users

---

# Integrity Rules

Examples

A Test Session always belongs to one Specimen.

A Report always belongs to one Test Session.

A Mechanical Property always belongs to one Test Session.

A Measurement Frame always belongs to one Test Session.

Violation prohibited.

---

# Safety Rules

Running State

↓

Disable

Method Editing

Material Editing

Acceptance Editing

Calibration

Machine Configuration

Only monitoring remains active.

---

# UI Behaviour

State controls UI.

Example

Draft

↓

Enable

Edit Buttons

---

Running

↓

Disable

Edit Buttons

↓

Enable

Emergency Stop

Pause

Abort

---

Approved

↓

Enable

Print

Export

Archive

↓

Disable

Edit

Delete

---

# Service Behaviour

Services validate every transition.

Example

```
Running

↓

Completed

```

Requirements

Acquisition Finished

No Critical Error

Measurements Stored

Analysis Completed

If not

↓

Transition rejected.

---

# State Events

Each successful transition generates

StateChanged Event

Containing

Old State

New State

Timestamp

User

Reason

---

# Rollback Rules

Rollback allowed

Before Running

Rollback prohibited

After Measurements exist

Instead

Create new revision

or

Create new Test Session

---

# Multi-Object Synchronization

Example

When

Test Session

↓

Approved

Automatically

Report

↓

Approved

Audit Entry

↓

Created

Order Status

↓

Updated (optional)

---

# State Persistence

Current state stored in database.

State is never inferred from UI.

State survives

Restart

Power Failure

Software Update

---

# Exception Handling

Unexpected failure

↓

Current State preserved

↓

Recovery attempted

↓

Audit Entry created

↓

Operator notified

---

# Future Compatibility

Supports

Workflow Extensions

Laboratory Approval Chains

Cloud Approval

Electronic Signature

Digital Certificate

AI Workflow

without redesign.

---

# Design Constraints

State transitions SHALL NOT

Depend on UI

Depend on Database Engine

Depend on PLC Brand

Depend on Report Layout

Be bypassed by plugins

Be bypassed by administrators without audit logging

---

# Architectural Decision (FROZEN)

The State Transition Matrix is the single authoritative source for object lifecycles.

No module may implement its own independent state logic.

Every transition must pass through the centralized State Machine.

This decision is permanent.

---

# Next Chapter

ARCH-030

System Event Bus & Messaging Architecture

---

# End of Chapter