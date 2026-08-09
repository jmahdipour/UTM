# ARCHITECTURE
# Chapter 28
# Application Workflow Architecture

Document ID

ARCH-028

Version

0.1

Status

FROZEN

Related EDR

EDR-033

Depends On

All Previous Architecture Documents

---

# Purpose

This chapter defines the complete lifecycle of every object inside the Universal Testing Machine software.

Unlike previous chapters, which define architecture, this chapter defines the operational workflow of the application.

This workflow is the backbone of the software.

---

# Philosophy

The software is workflow-driven.

Every operation follows a predefined lifecycle.

No object may skip mandatory workflow steps.

---

# Global Workflow

```
Customer

↓

Project

↓

Order

↓

Specimen

↓

Test Method

↓

Material

↓

Acceptance Profile

↓

Ready

↓

Testing

↓

Analysis

↓

Acceptance

↓

Report

↓

Archive
```

---

# Workflow Principle

Every stage has

Input

↓

Validation

↓

Execution

↓

Output

↓

Next Stage

---

# Stage 1

Customer

Purpose

Defines who requested the test.

Creates

Orders

Projects

Reports

---

# Stage 2

Project (Optional)

Purpose

Groups related orders.

Examples

Bridge

Pipeline

Research

Production Batch

---

# Stage 3

Order

Purpose

Represents one testing request.

Owns

Specimens

Reports

History

---

# Stage 4

Specimen Definition

Purpose

Defines

Geometry

Dimensions

Material Grade

Identification

Acceptance Profile Reference

The specimen is now fully identified.

---

# Stage 5

Method Selection

Purpose

Defines

How the test will be performed.

Method may come from

Template

or

Manual Configuration

After selection

Method becomes immutable for this test.

---

# Stage 6

Material Selection

Purpose

Connect specimen to Material Library.

Outputs

Engineering References

Reference Curves

Acceptance Profiles

Yield Behaviour

Engineering Notes

---

# Stage 7

Acceptance Selection

Purpose

Defines evaluation criteria.

May be

Automatic

↓

Material Default

or

Manual

↓

Operator Selection

---

# Stage 8

Ready State

Validation Checklist

✓ Machine Connected

✓ Method Assigned

✓ Material Assigned

✓ Acceptance Assigned (optional)

✓ Specimen Complete

✓ Safety OK

↓

Ready

---

# Stage 9

Pre-Test

Operator actions

Install Specimen

Adjust Grips

Zero Sensors

Verify Live Channels

Start Acquisition

The specimen is NOT moving yet.

---

# Stage 10

Testing

Workflow

```
Idle

↓

Start

↓

Running

↓

Monitoring

↓

Event Detection

↓

Completion

↓

Stop
```

Measurements

Events

Graphs

Mechanical Properties

are generated continuously.

---

# Stage 11

Analysis

Executed automatically after acquisition.

Produces

Mechanical Properties

Engineering Results

Derived Properties

---

# Stage 12

Acceptance

Workflow

```
Mechanical Properties

↓

Acceptance Profile

↓

Decision Rule Engine

↓

Risk

↓

Uncertainty

↓

Decision
```

Outputs

PASS

FAIL

Review

Not Evaluated

---

# Stage 13

Reporting

Inputs

Customer

Order

Specimen

Method

Material

Mechanical Properties

Acceptance

Graphs

Events

↓

Generate Report

---

# Stage 14

Approval

Optional

Operator

↓

Reviewer

↓

Supervisor

↓

Approved Report

Digital signatures may be required.

---

# Stage 15

Archiving

Stores

Measurements

Events

Properties

Acceptance

Report

Audit

Configuration Snapshot

No engineering information is lost.

---

# Exceptional Workflow

Test Aborted

```
Testing

↓

Abort

↓

Store Partial Data

↓

Generate Event

↓

Optional Report
```

No data shall be discarded.

---

# Re-Test Workflow

```
Existing Specimen

↓

Duplicate Test Session

↓

New Measurements

↓

New Results

↓

Independent Report
```

Original test remains unchanged.

---

# Batch Workflow

```
Order

↓

10 Specimens

↓

10 Tests

↓

10 Results

↓

1 Batch Summary
```

Fully supported.

---

# Workflow Ownership

| Stage | Owner |
|--------|-------|
| Customer | CustomerService |
| Order | OrderService |
| Specimen | SpecimenService |
| Method | MethodService |
| Material | MaterialService |
| Acceptance | AcceptanceService |
| Testing | WorkflowService |
| Analysis | AnalysisService |
| Report | ReportService |
| Archive | ArchiveService |

---

# Rollback Rules

If failure occurs

Before Testing

↓

Rollback allowed

After Measurements begin

↓

Never delete data

↓

Create Audit Entry

↓

Mark Session

Aborted

---

# State Transitions

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

Alternative

```
Draft

↓

Cancelled
```

or

```
Running

↓

Aborted
```

---

# Audit Integration

Every workflow transition generates

Audit Record

Timestamp

Operator

Machine

Reason

Old State

New State

---

# Future Compatibility

Supports

Multi-Machine Workflow

Remote Testing

Cloud Approval

ERP Workflow

LIMS Workflow

AI Assistance

Automatic Scheduling

without redesign.

---

# Design Constraints

Workflow SHALL NOT

Depend on UI

Depend on SQLite

Depend on PLC

Depend on Report Layout

Depend on Hardware Brand

Skip mandatory validation stages

---

# Architectural Decision (FROZEN)

The complete software shall operate as a deterministic workflow engine.

Every object has a defined lifecycle.

Every transition is traceable.

Every decision is auditable.

No hidden workflow shall exist outside this architecture.

---

# Next Chapter

ARCH-029

State Transition Matrix & Business Rules Architecture

---

# End of Chapter