# ARCHITECTURE
# Chapter 42
# Project, Order & Sample Management Architecture

Document ID

ARCH-042

Version

0.1

Status

FROZEN

Related EDR

EDR-047

Depends On

ARCH-028 Workflow Architecture

ARCH-023 Database Architecture

ARCH-031 Audit Architecture

ARCH-032 Security Architecture

---

# Purpose

This chapter defines the complete Laboratory Information Management (LIMS) workflow inside the Universal Testing Machine software.

It manages

- Customers
- Projects
- Orders
- Specimens
- Batch Testing
- Traceability

This subsystem organizes all engineering data before testing begins.

---

# Philosophy

The testing machine does not simply perform tests.

It manages laboratory work.

Every specimen belongs to an order.

Every order belongs to a customer.

Complete traceability is mandatory.

---

# Hierarchy

```
Customer

↓

Project (Optional)

↓

Order

↓

Specimen

↓

Test Session

↓

Report
```

Every level owns the next level.

---

# Customer

Customer represents

Company

University

Research Center

Factory

Individual

Government Organization

---

# Customer Object

Contains

Customer ID

Name

Address

Phone

Email

Tax Number

Contact Person

Notes

Status

---

# Project

Project groups multiple orders.

Examples

Bridge Project

Pipeline Project

Production Batch

Research Program

Projects are optional.

---

# Project Object

Contains

Project ID

Customer

Project Name

Reference Number

Start Date

End Date

Description

Status

---

# Order

Order represents one laboratory request.

One order may contain

One specimen

or

Thousands of specimens.

---

# Order Object

Contains

Order Number

Customer

Project

Creation Date

Requested By

Operator

Priority

Status

Notes

---

# Order Status

Supported

Draft

Waiting

Testing

Completed

Closed

Cancelled

Archived

---

# Specimen

Specimen is the most important laboratory object.

Every specimen represents one physical sample.

---

# Specimen Object

Contains

Specimen ID

Specimen Name

Material

Geometry

Dimensions

Batch Number

Heat Number

Acceptance Profile

Method

Status

---

# Specimen Status

Supported

Created

Prepared

Ready

Testing

Completed

Rejected

Archived

---

# Batch

Batch groups specimens.

Example

```
Order

↓

20 Specimens

↓

20 Test Sessions

↓

20 Reports

↓

1 Batch Summary
```

---

# Batch Summary

Displays

Average

Minimum

Maximum

Standard Deviation

PASS Count

FAIL Count

Not Evaluated

Future Cpk

---

# Barcode Support

Each specimen may own

Barcode

QR Code

RFID (future)

Unique Laboratory Number

---

# Barcode Usage

Barcode may identify

Customer

Order

Specimen

Report

Machine

Calibration Certificate

---

# Search

Supports

Customer

Project

Order

Specimen

Material

Heat Number

Batch

Barcode

QR

Operator

Date

Status

---

# Traceability

Every report shall allow tracing

Report

↓

Specimen

↓

Order

↓

Project

↓

Customer

and vice versa.

---

# Copy Workflow

Operator may duplicate

Order

Specimen

Method Assignment

Acceptance Assignment

Material Assignment

History is never duplicated.

---

# Import

Supports

CSV

Excel

ERP Export

LIMS Export

JSON

XML

Future SAP

---

# Export

Supports

CSV

Excel

PDF

JSON

XML

Customer Report Package

---

# Multi-Specimen Workflow

```
Create Order

↓

Import 100 Specimens

↓

Assign Methods

↓

Run Tests

↓

Generate Reports

↓

Close Order
```

---

# Relationship with Test Method

Specimen references

Method

Method never references Specimen.

---

# Relationship with Material

Specimen references

Material

Material Library remains independent.

---

# Relationship with Acceptance

Specimen references

Acceptance Profile

Acceptance Engine evaluates later.

---

# Relationship with Report

Each Test Session normally generates

One Report

One Specimen

Multiple reports supported through revisions.

---

# Relationship with Audit

All management operations create audit records.

Examples

Customer Created

Order Modified

Specimen Deleted

Batch Imported

Report Archived

---

# Permissions

Operator

Create Orders

Create Specimens

Run Tests

---

Supervisor

Approve Reports

Modify Orders

Review Batch

---

Administrator

Delete Archived Records

Manage Templates

Database Maintenance

---

# Deletion Policy

Customers

Soft Delete

Orders

Soft Delete

Specimens

Never physically deleted after testing.

Reports

Never deleted.

Archived only.

---

# Laboratory Dashboard

Future dashboard

Displays

Orders Waiting

Running Tests

Completed Today

Failed Specimens

Calibration Status

Machine Availability

---

# Future Compatibility

Supports

ERP

MES

LIMS

SAP

Oracle

Cloud Laboratory

Multi-site Laboratory

without redesign.

---

# Design Constraints

Project Management SHALL NOT

Perform Engineering Calculations

Evaluate Acceptance

Modify Mechanical Properties

Communicate with PLC

Generate Reports

Control Motion

---

# Architectural Decision (FROZEN)

The software shall maintain complete laboratory traceability through the hierarchy

Customer

↓

Project

↓

Order

↓

Specimen

↓

Test Session

↓

Report

Every engineering result shall always be traceable back to its originating specimen and customer.

No tested specimen shall ever lose its historical relationship.

This decision is permanent.

---

# Next Chapter

ARCH-043

Database Backup, Restore & Data Migration Architecture

This chapter will define

- Automatic Backup
- Manual Backup
- Restore Workflow
- Version Migration
- SQLite Upgrade Strategy
- Database Integrity
- Disaster Recovery
- Archive Strategy

---

# End of Chapter