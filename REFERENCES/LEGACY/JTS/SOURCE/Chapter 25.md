# ARCHITECTURE
# Chapter 25
# SQLite Physical Schema Architecture

Document ID

ARCH-025

Version

0.1

Status

FROZEN

Related EDR

EDR-030

Depends On

ARCH-024 Logical Entity Model

---

# Purpose

This chapter defines the physical SQLite schema.

Unlike the Logical Entity Model, this chapter defines the actual database implementation.

This document becomes the reference for

VB.NET Models

Repository Layer

SQLite Tables

Migration Scripts

Future SQL Server Migration

---

# Design Philosophy

The database shall satisfy

Performance

Traceability

Normalization

Future Expansion

Database Engine Independence

---

# Naming Convention

Tables

Singular

Example

```
Customer

Order

Specimen

TestSession

MaterialGrade
```

Columns

PascalCase

Example

```
CustomerID

OrderNumber

CreatedAt

Revision
```

Primary Keys

UUID

Stored as TEXT(36)

Never Integer Identity.

---

# Common Fields

Every major table contains

```
ID

CreatedAt

UpdatedAt

Revision

Status

IsDeleted
```

---

# Business Tables

## Customer

Primary Key

CustomerID

Fields

Name

Code

Address

Phone

Email

Description

---

## Project

Primary Key

ProjectID

FK

CustomerID

---

## Order

Primary Key

OrderID

FK

CustomerID

ProjectID

Fields

OrderNumber

ReceivedDate

Operator

Status

---

## Specimen

Primary Key

SpecimenID

FK

OrderID

MethodID

MaterialGradeID

AcceptanceProfileID

Fields

SpecimenName

Geometry

Description

---

# Geometry Tables

## SpecimenDimension

Primary Key

DimensionID

FK

SpecimenID

Fields

Parameter

Value

Unit

Example

Diameter

16

mm

---

# Method Tables

## MethodTemplate

Primary Key

MethodTemplateID

---

## TestMethod

Primary Key

MethodID

FK

MethodTemplateID

Fields

Version

Description

Revision

---

# Material Tables

## MaterialFamily

Primary Key

MaterialFamilyID

---

## MaterialGrade

Primary Key

MaterialGradeID

FK

MaterialFamilyID

Fields

GradeName

Standard

Description

---

## AcceptanceProfile

Primary Key

AcceptanceProfileID

FK

MaterialGradeID

Fields

ProfileName

Version

DecisionRule

RiskPolicy

---

## MaterialReferenceProperty

Primary Key

ReferencePropertyID

FK

MaterialGradeID

Fields

PropertyName

ReferenceValue

Minimum

Maximum

Unit

---

## MaterialReferenceCurve

Primary Key

CurveID

FK

MaterialGradeID

---

# Test Tables

## TestSession

Primary Key

TestSessionID

FK

SpecimenID

Fields

StartedAt

FinishedAt

MachineID

OperatorID

Status

---

## MeasurementFrame

Primary Key

FrameID

FK

TestSessionID

Fields

Timestamp

Sequence

---

## MeasurementValue

Primary Key

MeasurementValueID

FK

FrameID

ChannelID

Fields

Value

Quality

---

# Event Tables

## Event

Primary Key

EventID

FK

TestSessionID

Fields

EventType

Timestamp

Description

Priority

---

# Mechanical Property Tables

## MechanicalProperty

Primary Key

PropertyID

FK

TestSessionID

Fields

PropertyName

Value

Unit

Method

Quality

---

# Acceptance Tables

## AcceptanceResult

Primary Key

AcceptanceResultID

FK

TestSessionID

AcceptanceProfileID

Fields

FinalDecision

DecisionRule

RiskPolicy

UncertaintyEnabled

---

## AcceptancePropertyResult

Primary Key

PropertyResultID

FK

AcceptanceResultID

MechanicalPropertyID

Fields

Decision

Requirement

MeasuredValue

Remarks

---

# Report Tables

## Report

Primary Key

ReportID

FK

TestSessionID

TemplateID

Fields

Revision

Approved

GeneratedAt

---

## ReportTemplate

Primary Key

TemplateID

Fields

Name

Version

Language

---

# Machine Tables

## Machine

Primary Key

MachineID

Fields

MachineName

SerialNumber

SoftwareVersion

---

## Channel

Primary Key

ChannelID

Fields

ChannelName

EngineeringUnit

Visible

DefaultColor

---

## Calibration

Primary Key

CalibrationID

FK

MachineID

ChannelID

Fields

CalibrationDate

ApprovedBy

---

# User Tables

## User

Primary Key

UserID

Fields

UserName

PasswordHash

RoleID

---

## Role

Primary Key

RoleID

Fields

RoleName

---

## Permission

Primary Key

PermissionID

Fields

PermissionName

---

## AuditLog

Primary Key

AuditID

Fields

UserID

Action

Timestamp

Description

---

# Configuration Tables

Settings

MachineSettings

CommunicationSettings

DAQSettings

GraphSettings

ThemeSettings

LanguageSettings

Each stored independently.

---

# Indexes

Mandatory indexes

CustomerCode

OrderNumber

SpecimenID

MaterialGradeID

AcceptanceProfileID

TestSessionID

Timestamp

PropertyName

EventType

MachineID

---

# Foreign Key Policy

SQLite Foreign Keys

Always Enabled

ON DELETE

RESTRICT

ON UPDATE

CASCADE

No orphan records allowed.

---

# UUID Policy

Every object receives UUID during creation.

UUID never changes.

Referenced everywhere.

---

# Storage Policy

Measurements

Append Only

Events

Append Only

Mechanical Properties

Immutable after approval

Reports

Immutable after approval

Audit

Never modified

---

# Migration Policy

Schema Version stored inside database.

Future upgrades

Migration Scripts

Version Controlled

Never destructive.

---

# Future Compatibility

Physical schema supports

SQL Server

PostgreSQL

Oracle

Cloud SQL

Distributed Databases

without changing the Business Layer.

---

# Architectural Decision (FROZEN)

The SQLite schema is an implementation detail.

The Business Architecture owns the data model.

The physical database must always follow the logical architecture and never dictate it.

---

# Next Chapter

ARCH-026

Repository Layer Architecture

(The data access layer between VB.NET and SQLite)

---

# End of Chapter