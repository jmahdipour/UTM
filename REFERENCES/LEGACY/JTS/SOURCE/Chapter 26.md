# ARCHITECTURE
# Chapter 26
# Repository Layer Architecture

Document ID

ARCH-026

Version

0.1

Status

FROZEN

Related EDR

EDR-031

Depends On

ARCH-023 Database Architecture

ARCH-024 Logical Database Schema

ARCH-025 SQLite Physical Schema

---

# Purpose

This chapter defines the Repository Layer.

The Repository Layer is the only software component permitted to communicate directly with the database.

It completely isolates the Business Layer from SQLite.

---

# Design Philosophy

The Business Layer shall never know

SQLite

SQL

Tables

Indexes

Transactions

The Business Layer communicates only with Repositories.

---

# Architecture

```
Presentation Layer

↓

Business Layer

↓

Repository Layer

↓

SQLite Provider

↓

SQLite Database
```

---

# Responsibilities

Repository Layer SHALL

Read Data

Write Data

Update Data

Archive Data

Execute Transactions

Validate Persistence

Map Objects

---

# Repository Layer SHALL NOT

Contain Business Logic

Perform Engineering Calculations

Perform Acceptance

Interpret Measurements

Generate Reports

Communicate with Hardware

---

# Repository Pattern

Every Business Object owns one Repository.

Examples

CustomerRepository

OrderRepository

SpecimenRepository

MethodRepository

MaterialRepository

AcceptanceRepository

MeasurementRepository

EventRepository

ReportRepository

UserRepository

---

# Repository Interface

Every Repository shall implement

Create()

Read()

Update()

Delete()

Archive()

Exists()

Find()

Search()

Count()

Transaction()

---

# Example

```
CustomerRepository

Create(Customer)

↓

SQLite
```

```
MaterialRepository

Find(MaterialGradeID)

↓

SQLite

↓

Material Object
```

---

# Object Mapping

Repositories convert

Business Objects

↓

Database Records

and

Database Records

↓

Business Objects

The Business Layer never sees SQL rows.

---

# Query Philosophy

Business Layer

↓

Repository

↓

SQLite

Example

Wrong

```
SELECT *

FROM MaterialGrade
```

Correct

```
MaterialRepository.GetByID(...)
```

---

# Transactions

Repository Layer owns database transactions.

Examples

Create Test

↓

Create TestSession

↓

Create Measurements

↓

Commit

If failure

↓

Rollback

---

# Batch Operations

Supported

InsertMany()

UpdateMany()

ArchiveMany()

DeleteMany()

Import()

Export()

---

# Search

Repositories support

ID

Name

Code

Keyword

Status

Revision

Date

Custom Filter

Future Search

Unlimited

---

# Lazy Loading

Large objects

Measurements

Graphs

Events

Attachments

shall support Lazy Loading.

Business objects load only when required.

---

# Caching

Optional

Repositories may cache

Material Library

Methods

Acceptance Profiles

Users

Settings

Frequently used data only.

---

# Read / Write Separation

Optional future architecture

Read Repository

↓

Optimized Queries

Write Repository

↓

Transactions

Supported without redesign.

---

# Repository Groups

## Business

CustomerRepository

ProjectRepository

OrderRepository

SpecimenRepository

---

## Engineering

MethodRepository

MaterialRepository

AcceptanceRepository

MeasurementRepository

MechanicalPropertyRepository

EventRepository

---

## Machine

MachineRepository

CalibrationRepository

ChannelRepository

DAQRepository

CommunicationRepository

---

## Reporting

ReportRepository

TemplateRepository

AttachmentRepository

---

## Security

UserRepository

RoleRepository

PermissionRepository

AuditRepository

---

## Configuration

SettingsRepository

ThemeRepository

LanguageRepository

MachineSettingsRepository

---

# Error Handling

Repositories return

Success

Failure

Validation Error

Duplicate

Not Found

Database Error

Transaction Error

No UI messages are generated here.

---

# Logging

Every Repository operation may be logged.

Examples

Insert

Update

Archive

Restore

Migration

Errors

Logs are optional and configurable.

---

# Thread Safety

Repositories shall support

Background Loading

Concurrent Reading

Safe Transactions

Future Multi-threading

---

# Testing

Repositories shall support

Mock Database

In-Memory Database

SQLite

Future SQL Server

without changing Business Logic.

---

# Dependency Injection

Business Layer receives

Repository Interfaces

NOT

Concrete SQLite implementations.

This enables future database replacement.

---

# Future Compatibility

Supports

SQLite

SQL Server

PostgreSQL

Oracle

Cloud Databases

REST Storage

Distributed Databases

without redesign.

---

# Design Constraints

Repository Layer SHALL NOT

Contain Engineering Rules

Contain Acceptance Logic

Contain Machine Logic

Contain UI Code

Contain Graph Rendering

Interpret Measurements

---

# Architectural Decision (FROZEN)

The Repository Layer is the permanent boundary between the Business Layer and the physical database.

No Business Object shall access SQLite directly.

No SQL statement shall exist outside the Repository Layer.

This decision is permanent.

---

# Next Chapter

ARCH-027

Service Layer Architecture

(The orchestration layer that coordinates all business modules and workflows.)

---

# End of Chapter