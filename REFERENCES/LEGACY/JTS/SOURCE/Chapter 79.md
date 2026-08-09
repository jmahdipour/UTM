# ARCHITECTURE
# Chapter 79
# Data Acquisition Architecture, High-Speed Sampling, Channel Synchronization, Raw/Processed Data, Buffering, Real-Time Graph Pipeline, SQLite Persistence & Data Integrity

Document ID

ARCH-079

Version

0.1

Status

FROZEN

Related EDR

EDR-084

Depends On

ARCH-074 Measurement Acquisition Pipeline

ARCH-075 Sensor Architecture

ARCH-076 Calibration Architecture

ARCH-078 Test Execution State Machine

---

# Purpose

This chapter defines the complete Data Acquisition Architecture for the Universal Testing Machine.

The acquisition subsystem is responsible for receiving, timestamping, validating, buffering, transforming and persisting measurement data.

The architecture must support both

```text
High-Frequency Measurement Acquisition

and

Real-Time User Interface

without allowing the UI to interfere with measurement integrity.

Core Principle

Measurement acquisition is independent from UI rendering.

Hardware

↓

Acquisition

↓

Buffer

↓

Processing

↓

Persistence

↓

UI

The UI is a consumer of measurement data.

It is not the source of measurement timing.

Acquisition Architecture
+------------------------------+
| Machine / Controller          |
| Sensors / PLC / Drive         |
+---------------+--------------+
                |
                v
+------------------------------+
| Acquisition Adapter           |
+---------------+--------------+
                |
                v
+------------------------------+
| Acquisition Service           |
+---------------+--------------+
                |
                v
+------------------------------+
| Raw Sample Buffer             |
+----------+----------+---------+
           |          |
           |          |
           v          v
+----------------+ +----------------+
| Processing     | | Database       |
| Pipeline       | | Writer         |
+-------+--------+ +-------+--------+
        |                  |
        v                  v
+---------------+    +-------------+
| Derived Data  |    | SQLite      |
+-------+-------+    +-------------+
        |
        v
+----------------+
| Graph / UI     |
+----------------+
Acquisition Responsibilities

The Acquisition Service is responsible for

Receive Samples

Assign Sequence

Assign Timestamp

Validate Channels

Detect Missing Samples

Detect Invalid Samples

Normalize Units

Publish Raw Samples

Buffer Data

Provide Data to Processing

Provide Data to Persistence
Acquisition Service Must Not

The Acquisition Service must not

Control Test State

Perform Safety Decisions Alone

Modify Method Definitions

Modify Calibration Definitions

Generate Reports

Directly Manipulate WPF Controls
Channel Architecture

The system must represent measurement channels independently.

Standard Channels

Supported conceptual channels include

Force

CrossheadDisplacement

Extensometer

Encoder

Position

Speed

Additional channels may be added.

Force Channel

The Force Channel represents the load measurement.

Example

ChannelId = FORCE_01

Unit = N
Extension Channel

Represents extensometer extension.

Example

ChannelId = EXT_01

Unit = mm
Crosshead Displacement

Represents machine crosshead movement.

Example

ChannelId = CROSSHEAD_01

Unit = mm
Encoder Channel

Represents encoder-derived position or displacement.

Speed Channel

Represents measured or controller-reported speed.

Channel Identity

Each channel should have

ChannelId

Name

Type

Unit

Source

Status

Enabled
Channel Source

Examples

PLC

Load Cell

Extensometer

Encoder

Controller

Calculated
Physical vs Derived Channel

A channel may be

Physical

or

Derived
Example
FORCE_RAW

↓

Calibration

↓

FORCE

↓

Stress

Here

FORCE_RAW

is physical/raw data and

STRESS

is derived.

Sample

A Sample is the atomic acquisition record representing simultaneous or near-simultaneous channel values.

Sample Structure

Conceptually

SampleSequence

Timestamp

Force

Extension

Displacement

Speed

Quality
Sample Identity

Every Sample must have a monotonically increasing sequence number within a Test.

Example

1001

1002

1003

1004
Sequence Scope

The sequence number is unique within the Test acquisition stream.

Sample Timestamp

Every Sample must have a timestamp.

Timestamp Requirements

The timestamp must support

Ordering

Elapsed Time

Synchronization

Analysis

Recovery
Monotonic Time

Elapsed Test timing should use a monotonic clock.

Wall Clock

A wall-clock timestamp should also be stored where required for traceability.

Dual Time Concept

Recommended

MonotonicElapsedTime

UtcTimestamp
Example
Sample 1001

Elapsed = 0.000 s

UTC = 2026-08-02T08:30:15.120Z
Why Monotonic Time

System clock changes must not alter physical elapsed-time calculations.

Wall Clock Changes

If the operating system time changes during Test execution

Elapsed Time

must remain continuous.
Sample Synchronization

All channels belonging to a Sample should correspond to the same acquisition instant or the nearest synchronized instant defined by the hardware protocol.

Hardware Timestamp

If the controller / acquisition hardware provides timestamps, those timestamps should be preserved.

Software Timestamp

If hardware timestamps are unavailable, the Acquisition Service assigns a timestamp as close to acquisition as practical.

Timestamp Source

The system should store the timestamp source.

Example

Hardware

Software

Controller
Channel Synchronization

The architecture must identify whether channels are

Synchronous

Asynchronous

Interpolated
Synchronous Acquisition

Preferred when hardware supports it.

Example

Force

Extension

Position

Speed

↓

Same Sample Frame
Asynchronous Acquisition

Some hardware channels may update at different rates.

Asynchronous Handling

The Acquisition Service must not pretend that independently sampled values were measured at exactly the same instant.

Resampling

Where required by a Method, asynchronous channels may be resampled onto a common time base.

Resampling Rule

Raw samples remain unchanged.

Resampled data is derived data.

Interpolation

Interpolation may be used only where mathematically and procedurally valid.

No Silent Interpolation

The system must record when a value is interpolated.

Sample Quality

Every sample should have a quality state.

Quality States

Recommended

Good

Warning

Invalid

Missing

OutOfRange

Interpolated

Filtered
Quality Flags

Multiple quality flags may be combined.

Example

Good

+

Calibrated

or

Interpolated

+

Warning
Raw Data

Raw data represents the closest available representation of the acquired measurement before analytical transformations.

Raw Data Principle

Raw data must remain immutable.

Raw Force

Example

ADC / Controller Value

=

Raw Force Input
Calibrated Data

Calibrated data is produced by applying the active Test calibration snapshot.

Example
Raw Force

↓

Calibration Snapshot

↓

Force [kN]
Processed Data

Processed data may include

Filtered Force

Filtered Extension

Normalized Displacement
Derived Data

Derived data includes

Stress

Strain

Young's Modulus

Yield Candidate

Maximum Force
Data Layers

The architecture therefore distinguishes

Layer 1

Raw

↓

Layer 2

Calibrated

↓

Layer 3

Processed

↓

Layer 4

Derived
Raw Data Must Not Be Overwritten

Filtering or calibration must never replace the original raw sample.

Calibration Application

The Calibration Snapshot selected at Test start is applied to raw values.

Example
RawValue

100245

↓

Calibration v7

↓

Force

100.23 kN
Calibration Version

Every processed Test measurement must be traceable to the Calibration Snapshot.

Method Snapshot

Every derived calculation must also be traceable to the Method Snapshot.

Data Lineage

Conceptually

Raw Sample

↓

Calibration Version

↓

Processed Sample

↓

Method Version

↓

Derived Result
Acquisition Rate

The architecture must support configurable acquisition rates.

Example Rates

Depending on hardware capability

10 Hz

50 Hz

100 Hz

200 Hz

500 Hz

1000 Hz

Higher if supported

The actual maximum is determined by the acquisition hardware and communication path.

Acquisition Rate vs UI Rate

These are independent.

Example

Acquisition

1000 Hz

while

UI

30 Hz
Acquisition Rate vs Database Rate

These may also be different depending on the persistence strategy.

Database Persistence

The system should preserve sufficient data for accurate Test reconstruction.

Persistence Policy

The Method / system configuration determines whether

Every Sample

or

Validated Sample Stream

or

Raw High-Speed Stream

is persisted.

For metrology-oriented operation, preservation of raw acquisition data is preferred.

High-Speed Acquisition

High-speed acquisition must not synchronously execute SQLite writes on the acquisition thread.

Wrong Architecture
Acquire Sample

↓

SQLite INSERT

↓

Acquire Next Sample

This can create timing jitter.

Correct Architecture
Acquire

↓

Memory Buffer

↓

Database Queue

↓

SQLite Writer
Producer / Consumer

The acquisition layer is the Producer.

The database writer is the Consumer.

Producer
Acquisition Thread

↓

SampleQueue
Consumer
DatabaseWriter

↓

SQLite
Queue

The queue must be bounded.

Why Bounded

An unlimited queue can eventually consume all available memory if the database becomes slower than acquisition.

Queue Overflow

If the queue reaches its limit, the system must follow a defined safety policy.

Overflow Policy

For a metrology-oriented Test, silently dropping raw samples is prohibited.

Possible responses

Warning

Controlled Stop

Fault

The preferred behavior should be defined by Test criticality.

Sample Loss

If samples are lost

DataQuality = Invalid / Missing

must be recorded.

Sample Loss Must Be Visible

The operator and final report should be able to determine whether the acquisition stream contained missing data.

Ring Buffer

A ring buffer may be used for real-time graph display.

Graph Buffer

The graph does not necessarily need the entire Test dataset in active memory.

Example
Last 30 seconds

or

Last 10000 samples

may be maintained for real-time display.

Full Data

Full Test data remains in persistent storage.

Real-Time Graph Architecture
Acquisition

↓

Raw Buffer

↓

Processing

↓

Graph Stream

↓

UI Throttling

↓

WPF Graph
UI Throttling

The UI must not render every hardware sample when acquisition rate is high.

Example
1000 samples/s

↓

Graph update

30 frames/s
Decimation

The graph pipeline may decimate data for display.

Important Rule

Display decimation must not delete the stored measurement samples.

Graph Decimation

Possible strategies

Latest Sample

Average Window

Min/Max Envelope

Largest Excursion
Preferred Strategy for Curves

For high-speed force curves, min/max envelope decimation may preserve peaks better than simple averaging.

Example
100 acquisition samples

↓

1 display segment

↓

Minimum + Maximum
Graph Data vs Analysis Data

Graph data is a presentation representation.

Analysis must use the full-resolution appropriate data.

No Analysis From UI Graph

The analysis engine must not read data from the UI graph.

Data Processing Pipeline
Raw Sample

↓

Validation

↓

Calibration

↓

Unit Normalization

↓

Filtering / Processing

↓

Derived Channels

↓

Feature Detection
Processing Order

The order must be deterministic.

Unit Normalization

All calculations should operate on normalized engineering units.

Examples

Force = N

Length = mm

Stress = MPa

according to the Method.

Unit Conversion

Conversion must occur before calculations requiring a common unit system.

Example
kN

↓

N

↓

Stress
Force to Stress

Conceptually

Stress = Force / Area

with compatible units.

Extension to Strain
Strain = ΔL / L0
Filtering

Filtering may be configured by Method or processing policy.

Filtering Principle

Filtering must not destroy important physical features.

Filter Metadata

If filtering is applied, store

FilterType

Parameters

Version

AppliedAt
Filter Examples

Conceptually

MovingAverage

LowPass

Median

Only validated filters should be used for standards-based calculations.

Filtered vs Raw

The result must always be traceable to the processing path.

Filter Phase

Filtering may be performed

Online

Offline

Both
Online Filtering

Used for

Control Assistance

Live Graph

Noise Reduction
Offline Filtering

Used for

Final Analysis

Result Calculation

when permitted by the Method.

Control Filtering

Control feedback filtering and report-analysis filtering must be treated separately.

Reason

A filter suitable for display may not be suitable for machine control or standards-based calculations.

Sample Validation

Every acquired sample should pass basic validation.

Validation Checks
Sequence Valid

Timestamp Valid

Channel Present

Numeric Value Valid

Range Valid

Communication Valid
NaN

NaN values are invalid.

Infinity

Infinity values are invalid.

Range Validation

Each channel may define physical / configured limits.

Example
Force < -ExpectedLimit

or

Force > SensorCapacity

may produce an OutOfRange quality flag.

Out-of-Range Data

Out-of-range values must not be silently clamped.

Clamping

Clamping may hide real measurement problems.

Therefore

Raw Value

=

Preserved

and

Quality

=

OutOfRange
Missing Samples

A missing sample can occur because

Communication Interrupted

Controller Did Not Respond

Acquisition Thread Delayed

Hardware Error
Missing Sample Representation

The system may represent missing data using a quality event rather than inventing a numeric value.

Interpolation

Interpolation may be performed later if permitted.

Duplicate Samples

Duplicate sequence numbers indicate an acquisition integrity problem.

Duplicate Handling

The duplicate must not silently overwrite an existing sample.

Acquisition Diagnostics

The system should maintain counters such as

SamplesReceived

SamplesValid

SamplesInvalid

SamplesMissing

SamplesDuplicated

SamplesOutOfRange

SamplesInterpolated
Diagnostics Snapshot

At Test completion, acquisition statistics should be available.

Example
Received = 1,000,000

Valid = 999,982

Invalid = 10

Missing = 8

Duplicate = 0
Acquisition Health Score

A health score may be calculated for diagnostics.

However, the final Test validity must follow Method-specific rules rather than a generic score.

Acquisition Heartbeat

The Acquisition Service should monitor the communication heartbeat where supported.

Heartbeat

Conceptually

Controller

↓

Heartbeat

↓

Acquisition Service
Heartbeat Timeout

If the expected heartbeat is missing

AcquisitionCommunicationFault

may be raised.

Controller vs Acquisition Failure

These should be distinguishable.

ControllerFault

vs

AcquisitionFault
Database Writer

The Database Writer is responsible for persisting measurement data efficiently.

Database Writer Architecture
SampleQueue

↓

Batch Builder

↓

SQLite Transaction

↓

Commit
Batch Insert

Multiple samples should be inserted in batches rather than one transaction per sample.

Example
1000 samples

↓

one or several transactions

The actual batch size should be configurable / benchmarked.

Transaction

A batch should normally be atomic.

Batch Failure

If a batch fails

Retry

or

Fault

according to the database failure policy.

Retry

Retries must be bounded.

Infinite Retry

Infinite retry is prohibited.

SQLite Connection

The database writer should maintain a dedicated database connection or controlled connection strategy.

UI Database Access

The UI should not directly write measurement samples.

Database Threading

SQLite access should be serialized through the repository / writer layer.

WAL Mode

SQLite WAL mode may be considered for concurrent read/write scenarios.

The final configuration must be validated for the target deployment.

Foreign Keys

Foreign key enforcement should be enabled where applicable.

SQLite Journal

The SQLite journaling strategy must be selected to balance durability and acquisition performance.

Durability

Measurement data is high-value data.

The system should prioritize durability over marginal write speed.

Database Transactions

Critical metadata and state changes should use explicit transactions.

Sample Storage

Conceptual table

TestSamples
TestSamples

Recommended fields

SampleId

TestId

Sequence

TimestampUtc

ElapsedTime

ForceRaw

ExtensionRaw

DisplacementRaw

SpeedRaw

QualityFlags

Additional channels may be represented according to the channel model.

Dynamic Channel Storage

Two approaches are possible.

Fixed Columns

or

Normalized Channel Table
Fixed Column Approach

Example

TestSamples

Force

Extension

Displacement

Speed
Advantages
Fast

Simple

Easy Queries

Good for Known Channels
Disadvantages
Schema Changes

Less Flexible
Normalized Channel Approach

Conceptually

Samples

Channels

SampleChannelValues
Advantages
Flexible

Supports Custom Sensors
Disadvantages
More Rows

More Joins

Potentially Lower Query Performance
Recommended Architecture

Use a hybrid approach.

Core high-frequency channels may have fixed columns.

Additional configurable channels may use a secondary normalized structure.

Core Channels

Recommended

Force

CrossheadDisplacement

Extensometer

Speed
Additional Channels

May include

Temperature

Pressure

Custom Sensor 1

Custom Sensor 2
Four-Channel Live Display

The UI may expose four live sensor slots.

Three may be fixed and one configurable according to the existing system requirement.

Live Display Does Not Define Acquisition

A sensor selected for Live Display remains an acquisition channel regardless of whether it is currently displayed.

Data Storage Precision

Numeric data must be stored at sufficient precision for subsequent analysis.

Display Precision

Display rounding must not modify stored data.

Example

Stored

100.123456789

Displayed

100.12
Export Precision

CSV/XML export should provide configurable output precision without altering internal stored values.

Acquisition Session

Every Test should have one primary acquisition session.

Acquisition Session Metadata
AcquisitionSessionId

TestId

StartTime

EndTime

SampleRate

ChannelConfiguration

AcquisitionAdapter

Status
Acquisition Adapter

The adapter isolates the physical communication mechanism.

Adapter Examples
PLC Adapter

Serial Adapter

Ethernet Adapter

DAQ Adapter

Simulation Adapter
Simulation Adapter

A Simulation Adapter may be implemented for software testing.

Simulation Requirement

Simulation must not be mixed with production hardware mode without an explicit mode indicator.

Simulation Data

Simulation data should be clearly marked.

Production Mode

Production mode must use actual configured hardware.

Acquisition Configuration

The configuration should define

SampleRate

Channels

Units

Timeout

BufferSize

BatchSize

QualityRules
Sample Rate Validation

Requested sample rate must be supported by the adapter.

Unsupported Rate

If unsupported

Acquisition Configuration = Invalid
Dynamic Sample Rate

Changing sample rate during a Test should normally be prohibited unless explicitly supported by the Method.

Rate Snapshot

The Test should store the acquisition configuration used.

Acquisition Start

The acquisition stream should begin before or in coordination with machine motion according to the Method.

Acquisition Stop

Acquisition must continue long enough to capture the final relevant measurement.

Stop Ordering

Recommended

Stop Motion

↓

Capture Final Measurement

↓

Stop Acquisition

↓

Flush Buffer

↓

Finalize
Fault Ordering

For safety fault

Safety Stop

↓

Preserve Acquisition

↓

Capture Final Data

↓

Finalize / Abort

where physically possible.

Data Flush

Before Test finalization

Queue Empty

AND

Database Writer Confirmed

AND

Final Sample Persisted

should be established.

Data Integrity Check

At finalization the engine may verify

FirstSequence

LastSequence

SampleCount

MissingCount

DuplicateCount
Sequence Integrity

Expected

LastSequence - FirstSequence + 1

=
Number of expected samples

for a strictly continuous stream.

Gaps

If the equality fails, the gap information must be recorded.

Sample Count

The database should store the final sample count.

Acquisition Summary

Recommended final fields

TotalSamples

ValidSamples

InvalidSamples

MissingSamples

DuplicateSamples

OutOfRangeSamples

Duration

ActualSampleRate
Actual Sample Rate

The actual rate should be calculated from timestamps where meaningful.

Requested vs Actual

These are distinct.

Requested = 1000 Hz

Actual = 997.8 Hz
Acquisition Performance

The system should monitor

Average Rate

Minimum Interval

Maximum Interval

Jitter

Queue Depth

Database Write Rate
Jitter

Sample interval variation can be important for diagnostic purposes.

Example
Expected Δt = 1 ms

Actual:

0.99 ms

1.01 ms

1.00 ms
Acquisition Diagnostics

The diagnostics page may expose

Current Sample Rate

Queue Depth

Dropped Samples

Database Queue

Communication Status
Acquisition Logging

Important acquisition failures must be logged into the Test Event Log.

Performance Requirement

The acquisition subsystem must not depend on WPF rendering performance.

WPF Dispatcher

Measurement data should be marshalled to the WPF Dispatcher only for presentation.

UI Update Pipeline
Acquisition

↓

Processing

↓

Presentation Buffer

↓

Dispatcher

↓

ViewModel

↓

Graph
Backpressure

The UI must not create unlimited pending Dispatcher operations.

Wrong
1000 samples/s

↓

1000 Dispatcher calls/s
Correct
1000 samples/s

↓

Latest / Decimated Presentation Buffer

↓

30 UI updates/s
Latest Value Display

For numeric live values, the UI may display the latest valid measurement.

Graph Display

The graph may use a decimated stream.

Data Table Display

A live data table may use a lower update frequency than acquisition.

No UI Blocking

Database operations must not run on the UI thread.

No Hardware Blocking

Controller communication must not run synchronously on the UI thread.

Acquisition Thread Safety

Shared measurement state must use thread-safe mechanisms.

Immutable Sample Object

A Sample object should preferably be immutable after creation.

Example
Sample

Sequence = 10245

Timestamp = ...

Force = ...

Extension = ...

Once published, the sample should not be mutated.

Processing Object

ProcessedSample may contain references / identifiers to the originating raw sample.

Data Lineage

Example

Raw Sample 10245

↓

Processed Sample 10245

↓

Derived Stress Sample 10245
Reproducibility

A final result should be reproducible from

Raw Samples

+

Calibration Snapshot

+

Method Snapshot

+

Geometry Snapshot

+

Processing Configuration
Data Version

Processing algorithms should be versioned.

Algorithm Version

Example

YieldAlgorithm = RP02_V2

ModulusAlgorithm = E111_V1

BreakAlgorithm = PEAKDROP_V3
Why Algorithm Versioning

A software update must not silently change historical results.

Calculation Reproducibility

Historical recalculation should use the explicitly selected algorithm version.

Processing Configuration Snapshot

The Test should store the effective processing configuration.

Data Retention

Raw acquisition data should remain retained for the configured Test retention period.

Deletion

Deletion of raw Test data should be permission-controlled and audited.

Archive

Completed Tests may be archived.

Archive Principle

Archiving must preserve

Raw Data

Results

Method Snapshot

Calibration Snapshot

Processing Version

Event Log
Backup

The database backup strategy must include Test measurement data.

Backup Validation

Backups should be periodically tested for restore capability.

Export

CSV export may provide

Timestamp

Elapsed Time

Force

Extension

Displacement

Speed

Quality
XML Export

XML may additionally contain

Test Metadata

Method

Calibration

Channels

Samples

Results
CSV Structure

Recommended first section

# TestId
# Method
# Calibration
# SampleRate

followed by tabular data.

Export Rule

Export must represent stored values rather than values re-read from live hardware.

Import

Raw Test measurement import should be restricted because it can affect traceability.

Imported Data

If supported, imported measurements must be explicitly marked as imported.

Imported Test

Example

DataOrigin = Imported
Production Test

Example

DataOrigin = MachineAcquisition
Acquisition Error Classification

Recommended categories

Communication

Timing

DataQuality

Hardware

Database

Processing
Error Example
ACQ-COM-001

Controller sample timeout
Warning Example
ACQ-TIM-002

Sample interval exceeded expected tolerance
Critical Example
ACQ-DATA-003

Raw sample loss detected during active Test
Acquisition Configuration Table

Conceptually

AcquisitionConfigurations

fields

ConfigurationId

Name

SampleRate

BufferSize

BatchSize

Timeout

Status
Channel Configuration Table
AcquisitionChannels

fields

ChannelId

ConfigurationId

Name

Type

Unit

Source

Enabled

Sequence
Test Acquisition Snapshot

The Test should store the effective acquisition configuration.

Snapshot
TestAcquisitionSnapshot

may contain

SampleRate

Channels

Adapter

BufferPolicy

ProcessingPolicy
No Configuration Drift

Changing global acquisition settings must not modify an existing Test's historical snapshot.

Calibration Relationship

The Acquisition Service provides raw data.

Calibration is applied in the processing pipeline.

Method Relationship

The Method determines which channels and processing algorithms are required.

Execution Relationship

The Test Execution Engine coordinates the acquisition lifecycle.

Complete Relationship
Method

↓

What to measure

↓

Acquisition

↓

How to capture

↓

Calibration

↓

How to interpret raw sensor value

↓

Processing

↓

How to derive engineering values

↓

Analysis

↓

How to calculate results
Acceptance Criteria

ARCH-079 is accepted when

Acquisition is independent from WPF UI rendering.

Acquisition Service exists.

Acquisition Adapter exists.

Channels are independently represented.

Force channel is supported.

Extension channel is supported.

Crosshead displacement is supported.

Encoder channel is supported.

Speed channel is supported.

Raw data is preserved.

Calibrated data is separated from raw data.

Processed data is separated from calibrated data.

Derived data is separated from processed data.

Every sample has a sequence number.

Every sample has timing information.

Monotonic elapsed time is supported.

Wall-clock timestamp is supported.

Timestamp source can be identified.

Synchronous acquisition is supported.

Asynchronous acquisition can be represented.

Resampling does not overwrite raw data.

Interpolation is explicitly identifiable.

Sample quality is supported.

NaN values are rejected.

Infinity values are rejected.

Out-of-range values are identified.

Missing samples are detectable.

Duplicate samples are detectable.

Sample rate is configurable.

Requested and actual sample rates are distinguishable.

High-speed acquisition does not synchronously write SQLite.

Producer/consumer architecture is used.

Buffer is bounded.

Overflow is detectable.

Silent sample loss is prohibited.

Database writes are batched.

Database transactions are supported.

Database operations do not block WPF UI.

UI update rate is independent of acquisition rate.

Graph decimation does not modify stored data.

Analysis does not use UI graph data.

Acquisition diagnostics are available.

Queue depth can be monitored.

Database write performance can be monitored.

Acquisition configuration is snapshotted per Test.

Processing configuration is traceable.

Algorithm versions are traceable.

Final sample flushing is supported.

Final acquisition statistics are stored.

CSV export is supported.

XML export is supported.

Data lineage is preserved.

Historical Test results are reproducible.

Raw data deletion is permission-controlled and audited.

Architectural Decision (FROZEN)

The Acquisition Service is an independent subsystem and shall never depend on WPF rendering performance.

Raw acquisition data is immutable and shall never be replaced by filtered, calibrated or derived data.

Every Test sample shall have deterministic sequence information and timing information.

High-speed acquisition shall use a Producer/Consumer architecture with bounded buffering.

SQLite writes shall occur through a dedicated persistence layer and shall not execute synchronously on the acquisition thread.

UI updates shall be throttled / decimated independently from hardware acquisition.

Graph decimation shall never alter or delete stored measurement data.

Analysis engines shall consume measurement data from the processing/data layer and never from UI graph objects.

Sample loss, duplication, invalid values and timing problems shall be detectable and traceable.

The Test shall preserve Method, Calibration, Acquisition and Processing snapshots required for complete reproducibility.

Finalization shall not occur until acquisition buffers and persistent writes have been safely flushed.

This decision is permanent.

Next Chapter

ARCH-080

SQLite Database Architecture, Complete Schema v1.1, Tables, Primary Keys, Foreign Keys, Indexes, Transactions, WAL, Repository Layer, Migration System, Audit Tables, Test Samples, Methods, Calibration, Users, Reports & Backup

This chapter will define

SQLite Architecture
Database File
Schema Version
Migration
Migration History
Connection Management
WAL
Foreign Keys
Transactions
PRAGMA
Repository Pattern
Unit of Work
Test Tables
Sample Tables
Method Tables
Calibration Tables
Sensor Tables
Specimen Tables
Customer Tables
Report Tables
Audit Tables
User Tables
Settings Tables
Indexes
Constraints
Unique Keys
Soft Delete
Hard Delete
Backup
Restore
Integrity Check
Database Recovery
SQLite Schema v1.1
x86 Compatibility
.NET Framework 4.8 Compatibility