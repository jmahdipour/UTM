# ARCHITECTURE
# Chapter 54
# Test Data & Measurement Storage Architecture

Document ID

ARCH-054

Version

0.1

Status

FROZEN

Related EDR

EDR-059

Depends On

ARCH-023 Database Architecture

ARCH-034 Data Acquisition

ARCH-036 Measurement Channel Architecture

ARCH-039 Mechanical Property Calculation

ARCH-053 Test Execution Architecture

---

# Purpose

This chapter defines the architecture for storing, protecting and retrieving all measurement data generated during a mechanical test.

The subsystem manages

- Raw Measurement Frames
- Engineering Values
- Measurement Channels
- Time Synchronization
- Test Data Storage
- Data Integrity
- Historical Reproducibility
- Large Dataset Handling
- Data Export

---

# Philosophy

Measurement data is primary laboratory evidence.

Calculated properties are derived from measurements.

Therefore

```text
Raw Measurement Data

↓

Engineering Values

↓

Calculated Properties

↓

Acceptance

↓

Report
```

The system shall never treat a calculated property as a replacement for the original measurement data.

---

# Data Layers

Measurement storage is divided into logical layers.

```text
Layer 1

Raw Acquisition Data

↓

Layer 2

Engineering Measurement Data

↓

Layer 3

Calculated Properties

↓

Layer 4

Acceptance Results

↓

Layer 5

Report
```

---

# Raw Acquisition Data

Raw acquisition data represents the values received from the acquisition subsystem before engineering conversion.

Examples

ADC Counts

Encoder Counts

Digital Samples

Raw Extensometer Signal

Raw Load Signal

---

# Engineering Measurement Data

Engineering values are normalized values produced by the HAL and measurement subsystem.

Canonical channels are

```text
Load

Stroke (Crosshead)

Extensometer

Time
```

Examples

```text
Load → kN

Stroke (Crosshead) → mm

Extensometer → mm

Time → s
```

---

# Raw Data Immutability

After successful test finalization, raw measurement data shall be immutable.

No normal application operation may modify the original acquisition values.

Corrections shall create derived data rather than modifying the original evidence.

---

# Engineering Data Immutability

Engineering measurement data belonging to a completed Test Session shall also be immutable.

If recalculation is required, the system creates a new calculation result referencing the same measurement dataset.

---

# Measurement Frame

A measurement frame represents one synchronized sampling point.

Example

```text
Timestamp

Load

Stroke (Crosshead)

Extensometer
```

---

# Frame Example

Conceptually

```text
Frame 1000

Time = 10.000 s

Load = 125.40 kN

Stroke = 18.20 mm

Extensometer = 2.31 mm
```

---

# Time Synchronization

All channels belonging to the same acquisition sequence shall use a common time base.

The primary time channel is

```text
Time
```

---

# Sampling

The system supports configurable sampling rates according to DAQ capabilities.

Examples

```text
100 Hz

500 Hz

1000 Hz

Custom
```

The actual rate used during the test shall be stored in the Test Session.

---

# Sampling Metadata

Each acquisition dataset stores

```text
Sampling Rate

Start Time

End Time

Channel List

DAQ Device

DAQ Configuration

Synchronization Information
```

---

# Channel Metadata

Every stored channel contains

```text
Channel ID

Canonical Name

Device ID

Unit

Resolution

Sampling Rate

Calibration Reference

Status
```

---

# Canonical Channel Names

The following names are mandatory:

```text
Load

Stroke (Crosshead)

Extensometer

Time
```

No alternative internal name shall replace these canonical names in the core data model.

---

# Units

Every measurement value shall have an explicit unit.

Examples

```text
N

kN

mm

µm

s

MPa

%
```

Unit conversion is handled by the Measurement / Unit subsystem.

---

# Test Dataset

Each Test Session owns one logical Test Dataset.

```text
Test Session

↓

Test Dataset

├── Raw Data

├── Engineering Data

├── Metadata

└── Acquisition Information
```

---

# Dataset Identity

Each dataset contains

```text
Dataset ID

Test Session ID

Schema Version

Creation Timestamp

Finalization Timestamp

Status
```

---

# Dataset Status

Supported

```text
Acquiring

Finalizing

Complete

Interrupted

Corrupted

Archived
```

---

# Acquisition Workflow

```text
Test Start

↓

Create Dataset

↓

Start Acquisition

↓

Receive Frames

↓

Validate Frames

↓

Store / Buffer

↓

Finalize

↓

Integrity Verification

↓

Complete
```

---

# Buffering

High-frequency acquisition shall not require a database transaction for every individual sample.

The system shall support

```text
DAQ

↓

Memory Buffer

↓

Batch Write

↓

Database / Dataset Storage
```

This prevents database latency from interfering with acquisition.

---

# Batch Storage

Measurement frames should be persisted in batches.

Batch size shall be configurable according to performance requirements.

---

# Database Separation

Small metadata belongs in SQLite.

Large measurement datasets may use optimized storage structures while remaining referenced by SQLite.

The architecture shall allow large test datasets without forcing every sample into ordinary relational rows.

---

# SQLite Role

SQLite stores

```text
Test Metadata

Dataset Metadata

Channel Metadata

References

Indexes

Calculated Results

Acceptance Results

Audit References
```

Large acquisition blocks may be stored separately when required by performance constraints.

---

# Large Dataset Strategy

The system shall support

```text
Small Test

↓

SQLite

```

and

```text
Large Test

↓

Chunked Measurement Storage

↓

SQLite Metadata Reference
```

The storage implementation shall remain transparent to the Business Layer.

---

# Chunking

Large datasets may be divided into chunks.

Example

```text
Dataset

├── Chunk 001

├── Chunk 002

├── Chunk 003

└── Chunk 004
```

Each chunk contains ordered measurement frames.

---

# Chunk Metadata

Contains

```text
Chunk ID

Dataset ID

First Timestamp

Last Timestamp

Frame Count

Checksum

Storage Location
```

---

# Integrity

Each dataset and optional chunk shall support integrity verification.

Integrity may use

```text
Checksum

Hash

CRC

```

according to the storage implementation.

---

# Corruption Detection

If corruption is detected

```text
Dataset

↓

Integrity Check

↓

FAILED
```

The system shall

- Mark dataset as Corrupted
- Preserve available data
- Create Diagnostic Event
- Create Audit Entry
- Prevent silent use of corrupted data

---

# Interrupted Test

If acquisition stops unexpectedly

```text
Acquiring

↓

Interrupted
```

The available measurement data shall be preserved.

The Test Session shall not automatically become a valid completed test.

---

# Recovery

On application restart

```text
Find Incomplete Dataset

↓

Verify Stored Frames

↓

Recover Available Data

↓

Mark Dataset Interrupted

↓

Require Operator Review
```

---

# Data Ordering

Measurement frames shall retain deterministic ordering.

Ordering is based primarily on

```text
Acquisition Sequence

and

Timestamp
```

---

# Missing Frames

Missing frames shall never be silently interpolated into the original dataset.

If interpolation is required for analysis, the resulting dataset must be explicitly identified as derived.

---

# Duplicate Frames

Duplicate frames shall be detectable where acquisition metadata permits.

Duplicates shall not silently overwrite original frames.

---

# Derived Data

Examples

```text
Stress

Strain

Corrected Extension

Smoothed Curve

Filtered Curve
```

Derived data shall reference its source dataset.

---

# Derived Dataset Metadata

Contains

```text
Source Dataset ID

Algorithm ID

Algorithm Version

Parameters

Creation Time

Created By
```

---

# Filtering

Filtering may be used for analysis.

Examples

Moving Average

Low Pass

Noise Reduction

Filtering shall never modify the original raw or engineering dataset.

---

# Resampling

Resampling may be performed for visualization or analysis.

The original sampling data remains unchanged.

---

# Data Compression

The storage subsystem may support compression for large datasets.

Compression shall be transparent to the Business Layer.

---

# Data Retrieval

Supported retrieval modes

```text
Full Dataset

Time Range

Channel Range

Downsampled Dataset

Analysis Window
```

---

# Graph Retrieval

The Graph Engine may request

```text
Load vs Stroke (Crosshead)

Stress vs Strain

Load vs Time

Stroke (Crosshead) vs Time

Extensometer vs Time
```

The storage subsystem returns the required data without exposing storage implementation details.

---

# Analysis Retrieval

Calculation Engine may request

```text
Elastic Region

Yield Region

Maximum Load Region

Break Region

Complete Dataset
```

---

# Database Transactions

Metadata operations shall be transactional.

Large measurement writes may use controlled batch transactions.

A partially written dataset must never appear as a completed dataset.

---

# Test Finalization

Before a Test Session is marked completed

```text
Acquisition Stopped

↓

Buffers Flushed

↓

Dataset Finalized

↓

Integrity Verified

↓

Dataset Marked Complete

↓

Calculation Allowed
```

---

# Calculation Dependency

The Calculation Engine shall never calculate final results from an unfinalized dataset unless the calculation is explicitly a live-preview calculation.

---

# Live Preview

During a running test, temporary calculations may use

```text
Live Measurement Buffer
```

These values are provisional.

They shall not replace final calculated results.

---

# Historical Reproducibility

A completed Test Session shall retain references to

```text
Measurement Dataset

Method Version

Method Snapshot

Material Version

Calibration References

Software Version

Calculation Algorithm Versions
```

This allows historical reproduction of results.

---

# Export

Measurement data supports

```text
CSV

XML

JSON

Future HDF5

Future Binary Dataset
```

---

# CSV Export

CSV export shall contain explicit headers.

Example

```text
Time,Load,Stroke (Crosshead),Extensometer
```

Units shall be included through metadata or explicit export configuration.

---

# XML Export

XML shall contain

```text
Test Metadata

Specimen

Method

Channels

Units

Measurement Data

Calculation References
```

---

# JSON Export

JSON may contain

```text
Metadata

Method Snapshot

Channel Definitions

Measurements

Results
```

---

# Security

Measurement data shall respect laboratory permissions.

Normal users shall not be allowed to overwrite completed datasets.

---

# Audit

Important operations generate Audit Entries.

Examples

```text
Dataset Created

Acquisition Started

Dataset Finalized

Dataset Recovered

Dataset Exported

Integrity Failure

Dataset Archived
```

---

# Backup

Completed measurement datasets are included in the Backup strategy.

Large datasets shall be included through their storage references and physical data blocks.

A backup is invalid if it contains metadata without the associated measurement dataset.

---

# Archive

Archived datasets remain

Read Only

Searchable

Exportable

Traceable

---

# Performance Requirements

The storage architecture shall not block

DAQ

Motion Control

Runtime State Machine

Safety Processing

---

# Design Constraints

Measurement Storage SHALL NOT

Modify Original Data

Calculate Mechanical Properties

Evaluate Acceptance

Control Hardware

Modify Calibration

Generate Reports

Bypass Audit

---

# Architectural Decision (FROZEN)

Measurement data is the primary evidence of every mechanical test.

Raw and finalized engineering measurement data shall be immutable.

All derived data shall reference its source data and algorithm version.

Large datasets shall be supported through buffered and optionally chunked storage without exposing storage implementation details to the Business Layer.

A Test Session may be finalized only after its measurement dataset has been flushed, finalized and integrity-verified.

This decision is permanent.

---

# Next Chapter

ARCH-055

Graph, Curve & Visualization Analysis Architecture

This chapter will define

- Live Graph
- Stress-Strain Curve
- Load-Stroke Curve
- Multiple Curves
- Zoom / Pan
- Point Selection
- Guide Lines
- Curve Analysis
- Downsampling
- Real-Time Rendering
- TrapeziumX-Compatible Visualization
- Exported Graphs

---

# End of Chapter