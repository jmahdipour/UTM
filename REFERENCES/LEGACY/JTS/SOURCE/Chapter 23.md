# ARCHITECTURE
# Chapter 23
# Database Architecture

Document ID

ARCH-023

Version

0.1

Status

FROZEN

Related EDR

EDR-028

Depends On

All Previous Architecture Documents

---

# Purpose

This chapter defines the logical database architecture of the Universal Testing Machine (UTS).

The database is the permanent memory of the software.

Its architecture shall remain independent from

UI

Hardware

PLC

Communication

Analysis Algorithms

---

# Design Philosophy

The database stores

Objects

Relationships

History

Traceability

The database SHALL NOT contain engineering logic.

All engineering logic belongs to the Business Layer.

---

# Database Type

Current Implementation

SQLite

Future Supported

Microsoft SQL Server

PostgreSQL

Oracle

MySQL

Cloud Database

The software architecture must remain independent of the database engine.

---

# Layer Position

```
Presentation Layer

↓

Business Layer

↓

Repository Layer

↓

Database

↓

Storage
```

Only the Repository Layer accesses the database.

---

# Object-Oriented Database Philosophy

Every database table represents one business object.

Example

```
Customer

Order

Specimen

Method

Material

Acceptance Profile

Test

Measurement

Report
```

Tables never represent UI controls.

---

# Database Categories

```
Master Data

↓

Configuration Data

↓

Operational Data

↓

Historical Data

↓

Audit Data
```

---

# Master Data

Rarely changes.

Contains

Customers

Materials

Acceptance Profiles

Methods

Machine Information

Users

Roles

Standards

Templates

---

# Configuration Data

Contains

Software Settings

Machine Settings

Units

Languages

Themes

Permissions

Communication

DAQ Configuration

Graph Configuration

---

# Operational Data

Contains

Orders

Specimens

Test Sessions

Measurements

Events

Mechanical Properties

Acceptance Results

Reports

---

# Historical Data

Contains

Archived Tests

Old Reports

Previous Methods

Material Revisions

Acceptance Revisions

Previous Configurations

---

# Audit Data

Contains

Login History

Configuration Changes

Method Changes

Material Changes

Acceptance Changes

Report Approvals

Digital Signatures

System Logs

---

# Database Relationships

```
Customer

↓

Orders

↓

Specimens

↓

Tests

↓

Measurements

↓

Mechanical Properties

↓

Acceptance

↓

Reports
```

Every object owns its own identity.

---

# Identity

Every table contains

UUID

Primary Key

Creation Date

Revision

Status

Version

---

# Soft Delete

Records are never physically removed.

Supported Status

Active

Archived

Deprecated

Deleted

Hidden

This guarantees traceability.

---

# Revision System

Every important object supports revisions.

Examples

Method

Material

Acceptance Profile

Report Template

Machine Configuration

Old revisions remain available.

---

# Transactions

Critical operations shall use transactions.

Examples

Start Test

Finish Test

Report Approval

Acceptance Approval

Configuration Changes

---

# Data Integrity

Supported

Primary Keys

Foreign Keys

Unique Constraints

Check Constraints

Version Validation

Reference Validation

---

# Repository Pattern

Business Layer

↓

Repository

↓

SQLite

Business objects never communicate directly with SQL.

---

# Object Groups

## Business

Customer

Order

Specimen

Operator

Project

---

## Engineering

Method

Material

Acceptance

Mechanical Property

Measurement

Event

---

## Machine

Machine

DAQ

Channel

Calibration

Sensor

Communication

---

## Reporting

Report

Template

Graph

Export

Signature

---

## Security

Users

Roles

Permissions

Audit

Login

---

# Time Handling

All timestamps stored as

UTC

Displayed

Local Time

Database remains timezone independent.

---

# Units

Database stores

Engineering Base Units

Display units belong to UI.

Example

Database

N

UI

kN

Changing display units never changes stored data.

---

# Performance

Supports

Large Test History

Fast Search

Indexed Queries

Background Loading

Lazy Loading

Future Millions of Records

---

# Backup

Supports

Automatic Backup

Manual Backup

Incremental Backup

Compressed Backup

Encrypted Backup

Cloud Backup

---

# Recovery

Supports

Point-in-Time Recovery

Database Validation

Repair

Rollback

Integrity Check

---

# Future Compatibility

Supports

Multiple Machines

Central Database

Network Laboratory

Cloud Synchronization

ERP Integration

LIMS Integration

AI Database

without redesign.

---

# Design Constraints

Database SHALL NOT

Contain Engineering Algorithms

Contain UI Logic

Communicate with Hardware

Perform Acceptance

Calculate Mechanical Properties

Interpret Measurements

---

# Architectural Decision (FROZEN)

The database is a persistent object store.

All engineering logic shall remain outside the database.

The database stores facts.

The software interprets those facts.

This separation is permanent.

---

# Next Chapter

ARCH-024

Database Schema (Logical Entity Model)

> **Important:** This chapter is one of the most critical documents in the entire project. It will define every Entity, every Table, every Relationship, every Primary Key, every Foreign Key, and every dependency in the SQLite database that the VB.NET application will use.

---

# End of Chapter