# ARCHITECTURE
# Chapter 14
# Mechanical Property Engine Architecture

Document ID

ARCH-014

Version

0.1

Status

FROZEN

Related EDR

EDR-019

Depends On

ARCH-005 Analysis Architecture

ARCH-006 Event Detection

ARCH-013 Measurement Processing

---

# Purpose

The Mechanical Property Engine converts engineering channels and engineering events into final mechanical properties.

This engine is responsible only for property calculation.

It never acquires measurements.

It never detects events.

It never evaluates acceptance.

---

# Design Philosophy

The Mechanical Property Engine is a pure calculation engine.

Inputs

Engineering Channels

+

Engineering Events

↓

Outputs

Mechanical Properties

No hardware dependency exists.

No UI dependency exists.

---

# Position in Architecture

```
Measurement Processing

↓

Engineering Channels

↓

Event Detection

↓

Mechanical Property Engine

↓

Acceptance

↓

Reporting
```

---

# Responsibilities

The engine SHALL

Calculate mechanical properties

Validate calculation prerequisites

Store calculation results

Report calculation quality

Publish calculated properties

The engine SHALL NOT

Acquire measurements

Detect events

Communicate with PLC

Communicate with hardware

Generate reports

Perform acceptance

---

# Inputs

Engineering Channels

Examples

Load

Stroke

Extension

Stress

Strain

True Stress

True Strain

Machine Extension

---

Engineering Events

Examples

Elastic Region Start

Elastic Region End

Upper Yield

Lower Yield

Offset Yield

Maximum Load

Necking

Fracture

Test Finished

---

# Outputs

Mechanical Properties

Examples

Young Modulus

Upper Yield Strength

Lower Yield Strength

Rp0.2

Rp0.1

Rt0.5

Ultimate Strength (Rm)

Maximum Load

Yield Ratio

Elongation

Permanent Elongation

Reduction of Area

Energy

Proof Stress

Spring Constant (K)

Spring Rate

Future Properties

Unlimited

---

# Calculation Philosophy

Each mechanical property is calculated by an independent module.

Example

Young Modulus Module

Yield Module

Ultimate Strength Module

Energy Module

Elongation Module

No module depends directly on another module.

---

# Dependency Rules

Young Modulus

depends on

Elastic Region Event

Yield Strength

depends on

Yield Event

Ultimate Strength

depends on

Maximum Load Event

Fracture Elongation

depends on

Fracture Event

No module searches measurements independently.

---

# Calculation Quality

Each calculated property shall contain

Property ID

Value

Unit

Calculation Method

Calculation Quality

Source Events

Timestamp

Revision

---

# Supported Methods

Example

Yield Strength

Methods

Upper Yield

Lower Yield

Rp0.2

Rp0.1

Rt0.5

Manual

Future Plugins

Unlimited

The selected Test Method determines which calculation methods are enabled.

---

# Young Modulus

Young Modulus calculation uses

Engineering Stress

Engineering Strain

Elastic Region

Material Library assistance (optional)

Material Library NEVER replaces measured data.

It only assists the search process.

---

# Energy Calculations

Supported

Elastic Energy

Plastic Energy

Total Energy

Future Energy Models

---

# Spring Properties

Supported

Spring Constant

Spring Rate

Load Deflection

Spring Index

DIN-based calculations

Future Spring Standards

---

# Property Validation

Each calculated property shall be validated.

Possible Status

Valid

Estimated

Incomplete

Not Available

Manual

Rejected

---

# Property Visibility

Each property may be

Visible

Hidden

Internal

Calculated

Experimental

---

# Recalculation

Mechanical Properties shall be recalculated only when

Measurements change

Analysis configuration changes

Event detection changes

Material assistance changes

Not when UI changes.

---

# Data Storage

Each property stores

Value

Unit

Method

Version

Source Events

Calculation Time

Software Version

---

# Relationship with Material Library

Material Library provides

Reference Information

Search Assistance

Engineering Hints

The Mechanical Property Engine performs the calculation.

---

# Relationship with Acceptance

Acceptance Engine consumes

Mechanical Properties

Acceptance Engine never recalculates them.

---

# Relationship with Reporting

Reporting displays

Mechanical Properties

Reporting never recalculates them.

---

# Future Compatibility

The architecture shall support

Unlimited Mechanical Properties

Unlimited Calculation Methods

Plugin Calculation Modules

AI-assisted calculations

Future Standards

without redesign.

---

# Design Constraints

Mechanical Property Engine SHALL NOT

Acquire Measurements

Interpret Hardware

Detect Events

Perform Acceptance

Generate Reports

Modify Material Library

Modify Test Method

---

# Next Chapter

ARCH-015

Graph & Visualization Architecture

---

# End of Chapter