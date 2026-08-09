# ARCHITECTURE
# Chapter 57
# Standards Library & Standards Compliance Engine Architecture

Document ID

ARCH-057

Version

0.1

Status

FROZEN

Related EDR

EDR-062

Depends On

ARCH-022 Material Library

ARCH-052 Test Method Architecture

ARCH-056 Engineering Detection & Mechanical Property Algorithms

ARCH-040 Acceptance Engine

---

# Purpose

This chapter defines the architecture for managing testing standards and their relationship with Test Methods, calculations and acceptance requirements.

The subsystem provides a controlled source for

- Standard Definitions
- Standard Revisions
- Clauses
- Requirements
- Test Requirements
- Calculation Rules
- Method Mapping
- Compliance References
- National Standards
- Customer Standards

---

# Philosophy

A Standard is a normative reference.

A Standard is not a Test Method.

The architecture separates

```text
Standard

↓

Standard Revision

↓

Requirement

↓

Method

↓

Execution

↓

Calculation

↓

Acceptance
Responsibilities

The Standards subsystem SHALL

Store Standards

Store Revisions

Store Standard Metadata

Store Requirements

Map Requirements to Methods

Map Requirements to Algorithms

Maintain Standard Status

Maintain Revision History

Provide Traceability

Support Compliance Verification

SHALL NOT

Control Hardware

Execute Tests

Modify Measurement Data

Perform Motion Control

Modify Calibration

Generate Mechanical Results

Replace the Acceptance Engine

Supported Standards

The architecture shall support, at minimum, standards relevant to the project.

Examples

ISO 6892-1

ASTM E8 / E8M

ASTM E111

ASTM A370

API 5L

ISO 7438

ISO 5173

ISO 17025

INSO 3132

Additional standards shall be extensible without architectural changes.

Standard Object

Each Standard contains

Standard ID

Standard Code

Title

Organization

Country / Region

Category

Status

Description
Standard Example
Standard ID

ISO-6892-1
Code

ISO 6892-1
Title

Metallic materials — Tensile testing

The exact official title shall be stored according to the licensed/reference source used by the laboratory.

Standard Organization

Examples

ISO

ASTM

API

INSO

Other National Organization
Standard Category

Examples

Tensile

Compression

Bending

Extensometer

Calibration

Laboratory Quality

Material Specification
Standard Revision

A Standard may have multiple revisions.

Example

ISO 6892-1

Revision A

↓

Revision B

↓

Revision C

Each revision is a separate immutable reference.

Revision Object

Contains

Revision ID

Standard ID

Revision Code

Publication Date

Effective Date

Status

Source Reference

Notes
Revision Status

Supported

Draft

Active

Superseded

Withdrawn

Archived
Historical Rule

A completed Test Session stores the exact

Standard ID

Standard Revision

used during execution.

Changing the active Standard Revision shall never change historical tests.

Requirement Object

A Requirement represents a testable or traceable requirement derived from a Standard.

Examples

Test Rate Requirement

Gauge Length Requirement

Yield Calculation Requirement

Elongation Requirement

Acceptance Requirement
Requirement Identity

Each requirement contains

Requirement ID

Standard Revision

Clause Reference

Requirement Type

Description

Parameter

Unit

Mandatory Flag
Clause Reference

Where applicable, the system stores the originating clause/reference.

Example

Clause

X.X.X

The system shall not invent clause numbers.

Clause references must originate from the controlled standard source.

Requirement Types

Supported categories

Test Setup

Specimen

Geometry

Machine

Rate

Acquisition

Calculation

Acceptance

Reporting

Safety
Requirement Parameter

A requirement may define

Name

Value

Unit

Tolerance

Range

Enumeration
Example

Conceptually

Requirement

Test Speed

Value

10

Unit

mm/min

The actual allowed value must be determined from the applicable Standard/Method context.

Standard-to-Method Mapping

A Standard may map to multiple Methods.

ISO 6892-1

├── Method A

├── Method B

└── Fixed-Speed Laboratory Method

The Method defines the executable configuration.

Method-to-Standard Rule

Every Active Method shall reference

Standard ID

Standard Revision

where compliance with a Standard is claimed.

Algorithm Mapping

A Standard Requirement may reference an Algorithm Profile.

Example

Standard Requirement

↓

Rp0.2

↓

Algorithm Profile

↓

Calculation Engine
Calculation Mapping

The Standards subsystem defines which calculation concept is required.

The Calculation Engine implements the algorithm.

This separation prevents normative rules from being embedded directly into application code.

Acceptance Mapping

Where a Standard defines acceptance criteria, the requirement is mapped to the Acceptance Profile.

Standard

↓

Acceptance Requirement

↓

Acceptance Profile

↓

Acceptance Engine
Standard Parameters

Parameters may include

Rate

Gauge Length

Offset

Strain Range

Stress Range

Tolerance

Geometry Rule

Calculation Rule

Parameters are version-specific.

Parameter Immutability

Once a Standard Revision is active, its normative configuration shall be immutable.

Changes require a new revision or controlled configuration version.

Compliance Matrix

The system may maintain a compliance matrix.

Example

Standard Requirement
        ↓
Method Parameter
        ↓
Algorithm
        ↓
Acceptance Rule
        ↓
Report Field
Traceability

A final result should be traceable through

Report

↓

Result

↓

Algorithm Version

↓

Method Version

↓

Standard Revision

↓

Requirement
Standard Applicability

A Standard may specify applicability by

Material

Product

Geometry

Test Type

Temperature

Equipment

Specimen Type

The Method Validator shall use applicable requirements.

National Standards

The architecture supports national standards.

Example

INSO 3132

National standards follow the same structure.

Standard

↓

Revision

↓

Requirement

↓

Method
Customer Standards

Authorized users may configure customer-specific requirements.

Customer requirements shall be clearly identified as

Customer


rather than incorrectly represented as official ISO/ASTM requirements.

Internal Laboratory Procedures

The system may also support internal procedures.

They shall be identified separately from external normative standards.

Example

LAB-PROC-001
Standard Source

Each Standard Revision should contain controlled source metadata.

Examples

Publisher

Document Reference

Publication Date

Acquisition Date

Source Identifier
Licensed Standards

The application shall not distribute copyrighted normative text unless the laboratory has the required rights.

The system may store

Clause Reference

Requirement Metadata

Compliance Mapping

without reproducing restricted full-text content.

Standard Validation

Before a Method is activated, the system verifies

Standard Exists

Revision Exists

Revision Active

Required Parameters Defined

Required Algorithms Available

Required Acceptance Profile Available
Compliance Validation

Conceptually

Method

↓

Standard Validator

↓

Requirement Check

↓

Pass

or

↓

Compliance Warning

or

↓

Method Rejected
Compliance Levels

Supported

Compliant

Conditionally Compliant

Not Evaluated

Non-Compliant

The exact interpretation shall be controlled by laboratory policy.

Non-Compliant Method

A Method shall not be presented as Standard-compliant if mandatory requirements cannot be satisfied.

The UI shall clearly distinguish

Standard-Compliant Method

from

Laboratory Custom Method
Standard Revision Selection

The system shall support

Current Active Revision

Historical Revision

Historical revisions remain available for historical Test Sessions.

Standard Deprecation

When a Standard Revision is superseded

Active

↓

Superseded

New Methods should normally use the newer revision according to laboratory policy.

Existing Tests retain the historical revision.

Standard Comparison

The system may compare revisions.

Supported information

Revision A

Revision B

Changed Parameters

Changed Requirements

Changed Algorithms

Changed Acceptance Rules

Comparison must be based on controlled source data.

Import

Standards metadata may be imported from

JSON

XML

CSV

Controlled Standards Package

The system shall validate imported references.

Export

Standards metadata may be exported as

JSON

XML

Compliance Package

Restricted normative text shall not be exported unless authorized.

Database Separation

Standards data is stored independently from

Methods

Materials

Tests

Results

Acceptance

Reports

Repositories provide access.

Business logic shall not use direct SQL against Standards tables.

Audit

Important operations generate Audit Records.

Examples

Standard Created

Revision Added

Revision Activated

Revision Superseded

Requirement Added

Compliance Mapping Changed

Standard Imported
Security

Only authorized users may

Create Standard Metadata

Add Revisions

Modify Compliance Mapping

Activate Revisions

Retire Revisions

Standard Integrity

Active Standard Revision metadata shall be protected against unauthorized modification.

Where possible, a content/configuration hash should be stored.

Standard Snapshot

When a Method Version is frozen, it shall retain enough metadata to identify the exact Standard Revision used.

The Test Session then retains

Standard ID

Revision ID

Method Version
Historical Reproducibility

A historical result must remain traceable even when

Standard Revision

Method

Algorithm

Material

have subsequently changed.

Relationship with Method Library
Standards Library

↓

Requirements

↓

Method Library

↓

Method Version

The Method Library consumes controlled Standard metadata.

Relationship with Calculation Engine
Standard Requirement

↓

Calculation Profile

↓

Calculation Engine

↓

Mechanical Property
Relationship with Acceptance Engine
Standard Requirement

↓

Acceptance Profile

↓

Acceptance Engine

↓

Acceptance Result
Relationship with Report Engine

Reports may display

Standard

Revision

Method

Result

Acceptance

The Report Engine does not determine compliance independently.

Future Standards

New standards shall be added by configuration and controlled implementation.

The architecture shall not require redesign of the Test Execution Engine for each new Standard.

AI Assistance

Future AI features may assist with

Standard Requirement Extraction

Method Configuration Suggestions

Compliance Mapping Review

Revision Difference Detection

Missing Requirement Detection

AI-generated mappings shall never automatically become normative requirements without authorized human review.

Design Constraints

Standards Engine SHALL NOT

Control Hardware

Modify Measurement Data

Calculate Results

Modify Calibration

Directly control Acceptance

Generate Reports

Invent Standard Requirements

Invent Clause References

Replace authorized Standard Sources

Architectural Decision (FROZEN)

The Standards Library is the authoritative source for controlled Standard and Revision metadata.

Normative requirements are version-specific.

Methods implement executable procedures derived from Standards.

Algorithms implement calculations referenced by Methods and Requirements.

Historical Test Sessions retain the exact Standard Revision used during testing.

The system shall never claim compliance based on an unverified or invented Standard requirement.

This decision is permanent.

Next Chapter

ARCH-058

User, Role, Security & Authorization Architecture

This chapter will define

Users
Roles
Permissions
Operator
Supervisor
Administrator
Authentication
Authorization
Method Approval
Calibration Permissions
Result Editing Permissions
Audit Security
Password / Identity Integration
Session Security
Electronic Signature Integration
End of Chapter