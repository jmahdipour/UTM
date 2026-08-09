# ARCHITECTURE
# Chapter 66
# Measurement Acquisition, Sampling, Synchronization & Live Data Pipeline

Document ID

ARCH-066

Version

0.1

Status

FROZEN

Related EDR

EDR-071

Depends On

ARCH-064 Hardware Abstraction Layer

ARCH-065 Machine State Machine

ARCH-053 Test Execution Architecture

ARCH-056 Engineering Detection & Mechanical Property Algorithms

ARCH-063 Repository & Persistence Architecture

---

# Purpose

This chapter defines the measurement acquisition architecture for the Universal Testing Machine.

The architecture covers

```text
Load Cell

Extensometer

Crosshead Encoder

Sampling

Timestamping

Synchronization

Validation

Buffering

Live Data

Raw Data

Storage

Graph Rendering

The objective is to guarantee that the measurement dataset used for engineering calculations remains independent from the user-interface refresh rate.

Core Principle

The acquisition pipeline is authoritative.

The UI is only a consumer.

Hardware

↓

Acquisition

↓

Validation

↓

Timestamping

↓

Authoritative Dataset

↓

Calculation / Storage

and separately

Authoritative Dataset

↓

Live Data Pipeline

↓

Graph / UI

The UI must never become the source of the authoritative measurement data.

Measurement Channels

The machine context includes

Load Cell

Extensometer

Crosshead Position

with multiple physical load cells and extensometers.

Load Cells

Supported load-cell capacities include

25 ton

10 ton

2 ton

500 kg

100 kg

The active load cell is selected by machine configuration and Method.

Extensometers

The project context includes three extensometer configurations

100 mm

50 mm

25 mm

These values represent the configured gauge-length classes / associated measurement configurations.

The exact physical mapping shall remain configuration-controlled.

Crosshead Encoder

The crosshead encoder provides displacement information.

Typical logical value

Crosshead Position

Unit = mm
Logical Measurement Model

Every acquired sample should have a common logical representation.

Conceptually

MeasurementSample

Timestamp

SequenceNumber

Load

Position

Extension

ChannelStatus

Quality
Example
Timestamp      = 12:01:10.245123

Sequence       = 15482

Load           = 125.42 kN

Position       = 14.823 mm

Extension      = 0.812 mm

Quality        = Valid
Sample Identity

Every authoritative sample shall have a sequence identifier whenever the acquisition architecture supports it.

The sequence number helps detect

Dropped Samples

Duplicate Samples

Out-of-order Samples
Timestamp

Every measurement sample should contain a timestamp.

Timestamping shall use a consistent clock source.

Monotonic Timing

Elapsed-time calculations should use a monotonic timing source where available.

Wall-clock timestamps are retained for traceability and reporting.

Timestamp Ordering

For a single acquisition stream

T(n+1) >= T(n)

must normally hold.

A violation should generate a data-quality event.

Sampling Rate

The acquisition rate is a hardware / communication property and may vary according to the connected hardware.

The application shall not assume that

UI Refresh Rate = Acquisition Rate
Example

The acquisition pipeline may operate at

1000 samples/sec

while the UI updates at

20–60 updates/sec

without reducing the authoritative sample rate.

Acquisition Frequency

The configured acquisition frequency shall be treated as an engineering configuration parameter.

It shall not be silently changed during a running Test.

Sampling Modes

The architecture may support

Fixed Frequency

Hardware Triggered

Communication Driven

Timestamp Driven

depending on actual hardware capability.

Hardware-Driven Acquisition

Preferred architecture where supported

Hardware

↓

Measurement Frame

↓

Acquisition Adapter

The software consumes measurements instead of artificially generating them.

Communication-Driven Acquisition

If measurements arrive through PLC communication

PLC / Communication Server

↓

Communication Adapter

↓

HAL

↓

Acquisition Service

The arrival time and measurement timestamp shall be distinguished when possible.

Arrival Timestamp vs Measurement Timestamp

These are different concepts.

Measurement Timestamp

=

When the physical measurement was taken
Arrival Timestamp

=

When the software received it

Both may be useful for diagnostics.

Acquisition Latency

Communication delay does not necessarily mean that the measurement itself is invalid.

The architecture should preserve enough information to identify latency.

Synchronization

Different channels must be associated with a common time basis where possible.

Example

Load

+

Position

+

Extension

↓

Same Logical Sample Time
Hardware-Synchronized Channels

If the hardware supplies synchronized channels, that synchronization shall be preserved.

Software Synchronization

If channels arrive independently, the Acquisition Service may associate samples using timestamps.

Example

Load @ 10.001 s

Position @ 10.002 s

Extension @ 10.001 s

may require controlled alignment according to the acquisition policy.

Synchronization Rule

The software must not falsely claim perfect synchronization when the hardware does not provide it.

Sample Association

A synchronized logical sample may contain

Load Sample

Position Sample

Extension Sample

with channel-specific timestamps retained where required.

Missing Channel

If a channel is missing for a sample period

Load = Valid

Position = Valid

Extension = Missing

the system shall preserve the missing status.

It shall not silently copy the previous value and mark it Valid.

Hold-Last-Value

A hold-last-value representation may be used for certain live-display scenarios.

It shall be clearly marked as derived display data.

It shall never overwrite the authoritative raw dataset.

Interpolation

Interpolation may be used for specific calculation workflows only where explicitly permitted.

Interpolated values must be distinguishable from measured values.

Raw Measurement

Raw measurement means the value obtained from the acquisition source before engineering processing.

Examples

ADC Count

PLC Raw Value

Encoder Count
Engineering Measurement

Engineering measurement is the calibrated value.

Examples

Force = kN

Position = mm

Extension = mm
Conversion Boundary

The conversion pipeline is

Raw Hardware Value

↓

Scaling

↓

Calibration

↓

Engineering Value
Calibration

Calibration is applied according to the active approved calibration configuration.

Calibration shall not be modified during Test Execution.

Calibration Version

The acquired dataset should retain the calibration configuration identity used for conversion.

Calibration Traceability

A completed Test should be able to identify

Load Cell

Calibration Version

Calibration Date / Status

Reference Configuration

where applicable.

Unit Conversion

Engineering units should be normalized before calculation.

Examples

Force → kN

Length → mm

Stress → MPa

The actual internal unit policy is defined by the domain model.

No Hidden Unit Conversion

A conversion must never occur without being represented in the configuration or calculation layer.

Measurement Quality

Each measurement should have a quality state.

Recommended values

Valid

Invalid

Missing

OutOfRange

Stale

Estimated

Interpolated
Valid

The sample is a valid measured value.

Invalid

The hardware or acquisition system explicitly identifies the value as invalid.

Missing

No measurement was received for the expected sample period.

OutOfRange

The value lies outside an accepted physical or configured range.

Stale

The communication system continues providing an unchanged or outdated value beyond the configured validity window.

Estimated

The value has been generated through an approved estimation process.

Interpolated

The value has been derived between measured points.

Quality Propagation

Quality information must propagate through the pipeline.

Raw Sample

↓

Quality

↓

Processed Sample

↓

Calculation

The calculation layer decides whether the quality is acceptable for the relevant property.

Sensor Health

Sensor health is distinct from measurement value.

Example

Load = 100 kN

Sensor Health = Fault

This may be possible if the hardware reports a fault concurrently with a numerical value.

Channel State

Each channel may expose

Connected

Ready

Active

Invalid

Fault

Disconnected
Acquisition State

The Acquisition Service may use

Stopped

Starting

Running

Stopping

Fault
Acquisition Start

Acquisition shall be started before Test motion when the Method requires measurement from the beginning of motion.

Acquisition Sequence

Recommended

Prepare Acquisition

↓

Clear Runtime Buffer

↓

Initialize Sequence

↓

Capture Start Timestamp

↓

Start Acquisition

↓

Verify Samples

↓

Allow Test Motion
Acquisition Verification

The Runtime should confirm that required channels are producing valid data before automatic motion begins where practical.

Acquisition Stop

Normal sequence

Stop Motion

↓

Confirm Appropriate Machine State

↓

Stop Acquisition

↓

Flush Buffer

↓

Finalize Dataset
Flush

The Acquisition Service shall provide a controlled flush mechanism where buffered samples remain after the stop command.

Buffering

The acquisition pipeline requires buffering between hardware communication and processing.

Hardware

↓

Input Buffer

↓

Processing Queue

↓

Authoritative Dataset
Buffer Requirements

The buffer shall support

High Acquisition Rate

Temporary Processing Delay

UI Independence

Controlled Shutdown
Buffer Overflow

Buffer overflow must not silently discard authoritative measurements.

If overflow occurs

Buffer Overflow

↓

Data Integrity Fault

↓

Runtime Response

according to the configured policy.

Overflow Policy

The default policy for authoritative Test acquisition should be conservative.

If complete measurement integrity cannot be guaranteed, the Test shall not be falsely represented as a fully valid measurement.

Threading

Acquisition should run independently from the WPF UI thread.

Recommended conceptual architecture

Communication Thread

↓

Acquisition Queue

↓

Processing Worker

↓

Persistence / Runtime

↓

UI Dispatcher
UI Thread Rule

The UI thread must never perform blocking hardware acquisition.

Forbidden

UI Thread

↓

Read PLC

↓

Wait

↓

Update Graph
Recommended
Background Acquisition

↓

Publish Measurement

↓

UI Dispatcher

↓

Update View
Thread Safety

Shared acquisition structures shall be thread-safe.

Possible mechanisms include

ConcurrentQueue

Lock

Immutable Snapshot

Channel / Producer-Consumer Pattern

The implementation must remain compatible with .NET Framework 4.8.

Producer

The acquisition adapter is the producer.

Hardware

↓

Producer
Consumer

Consumers may include

Runtime Processor

Persistence

Calculation Pipeline

Live Graph
Multiple Consumers

The authoritative measurement stream should not depend on one consumer keeping up.

Data Distribution

Conceptually

                   +--> Persistence
                   |
Acquisition ------>+--> Calculation
                   |
                   +--> Live Graph
                   |
                   +--> Runtime Detection
Authoritative Stream

The authoritative stream is the complete measurement stream retained for the Test.

Live Stream

The live stream is optimized for immediate presentation.

It may use

Decimation

Downsampling

Aggregation

Windowing
Live Graph

The graph shall never determine what gets stored.

Graph Downsampling

If acquisition is high frequency

1000 samples/sec

the graph may display a reduced number of points for performance.

Example

1000 samples/sec acquisition

↓

50–100 visual points/update window

The exact strategy depends on the graph implementation.

Downsampling Rule

Downsampling must preserve important curve characteristics as far as practical.

Simple fixed-point skipping may be insufficient for engineering curves.

Peak Preservation

For load-displacement curves, downsampling should avoid hiding important

Maximum Force

Yield Region

Break Point

Local Peaks
Min/Max Decimation

A suitable graph strategy may preserve minimum and maximum values within each display bucket.

Raw Data Preservation

Regardless of graph optimization

Raw / Authoritative Data

=

Complete
Live Data Latency

The UI should display measurements with low practical latency while maintaining acquisition integrity.

Latency Monitoring

The system may track

Acquisition Timestamp

Processing Timestamp

UI Presentation Timestamp

to identify bottlenecks.

Live Value Display

The operator may view selected live channels.

The display should support configurable channels.

Possible values

Force

Position

Extension

Speed
Fixed Sensors

The current UI concept references three fixed measurement sensors plus a configurable fourth value.

The exact display configuration shall remain part of the UI / Method configuration.

Live Value Source

Live values must come from the same authoritative acquisition stream or a clearly derived live stream.

The UI shall not independently poll hardware.

Sample Rate vs Display Rate

Example

Acquisition = 500 Hz

UI = 30 Hz

The UI may show the latest available sample or a controlled aggregation.

Latest Value

For a live display

Latest Valid Sample

may be used.

The timestamp of the displayed value should remain available to identify stale conditions.

Stale Display

If no valid measurement has arrived within the configured display timeout

Value = Stale

The UI should visually distinguish this condition.

Acquisition Fault

Acquisition faults shall generate Runtime events.

Examples

AcquisitionStarted

AcquisitionStopped

SampleLost

ChannelFault

BufferOverflow

TimestampError

AcquisitionCommunicationFault
Measurement Event

Conceptual event

MeasurementReceived

TestId

Sequence

Timestamp

Measurements

Quality
Event Rate

Publishing every raw sample directly to WPF is not required.

High-frequency raw events should remain inside the acquisition pipeline.

Runtime Detection

Engineering detection algorithms may consume the authoritative stream.

Examples

Yield Detection

Maximum Force Detection

Break Detection

Extensometer Events
Detection Independence

Detection algorithms must not depend on graph rendering.

Acquisition

↓

Detection

not

Graph

↓

Detection
Force Detection

The force channel shall retain sufficient resolution to identify relevant events.

Yield Detection

The detection engine may process the complete force/displacement dataset according to the Method and configured standard.

The acquisition layer does not determine yield.

Break Detection

The acquisition layer provides the measurements.

Break detection belongs to the engineering detection layer.

Synchronization With Motion

The acquisition pipeline shall preserve sufficient temporal information to correlate

Commanded Speed

Actual Position

Force

Extension
Command Timestamp

Motion commands may optionally be timestamped.

Example

SetSpeed(10 mm/min)

Timestamp = T1

This is useful for diagnostics and traceability.

Feedback Timestamp

Actual hardware feedback is timestamped independently.

Command vs Actual

The system should distinguish

Requested Speed

Actual Speed

and

Requested Position

Actual Position

where available.

Data Integrity

The following conditions must be detectable

Duplicate Sequence

Missing Sequence

Non-Monotonic Timestamp

Unexpected Gap

Invalid Channel

Buffer Overflow
Sample Gap

A sample gap occurs when the expected acquisition interval is exceeded.

Example

Expected

10.000 ms

Received

10.000 ms

then

45.000 ms

This should be flagged.

Gap Classification

A gap may be classified as

Minor

Warning

Critical

according to Method and data-integrity policy.

Test Validity

Not every communication irregularity automatically invalidates the Test.

The effect depends on

Duration

Channel

Test Stage

Required Measurement

Calculation Dependency
Example

A short UI update delay

UI Delay

≠

Measurement Loss

and should not invalidate the dataset.

Example

Loss of the primary load-cell channel during maximum-force determination may be critical.

Persistence

The authoritative acquisition dataset shall be persisted in accordance with the persistence architecture.

SQLite Integration

The project uses SQLite as the application database.

The acquisition architecture shall not depend directly on SQL commands.

Acquisition

↓

Repository / Persistence Service

↓

SQLite
Batch Persistence

High-frequency samples should normally be persisted using controlled batching rather than one database transaction per sample.

Batch Example

Conceptually

Acquire

↓

Buffer 500 samples

↓

Persist Transaction

↓

Continue

The exact batch size shall be performance-tested.

Transaction Integrity

A failed persistence transaction must be detectable.

The system must not mark samples as permanently stored before successful persistence.

Persistence Queue

A dedicated persistence queue may be used.

Acquisition

↓

Persistence Queue

↓

SQLite Writer
Persistence Failure

If SQLite becomes unavailable during a Test

Acquisition

↓

Local Runtime Buffer

↓

Persistence Failure

The system shall apply a defined fault policy.

No Silent Data Loss

If the persistence layer cannot guarantee preservation, the Test shall be marked accordingly.

Temporary Storage

Where required, temporary local storage may be used to protect samples during transient database problems.

Recovery

Temporary data should be reconciled with the final Test dataset after recovery.

Dataset Completion

A Test dataset becomes finalized only after

Acquisition Stopped

+

Pending Samples Flushed

+

Persistence Confirmed

=

Dataset Finalized
Dataset Metadata

The dataset should retain

Test ID

Method ID / Version

Hardware Configuration Version

Calibration Reference

Channel Configuration

Acquisition Configuration

Start Time

End Time

Sample Count
Sample Metadata

Each authoritative sample may retain

Sequence

Timestamp

Load

Position

Extension

Quality

Additional channel values may be added according to the configured measurement model.

Channel Metadata

Each channel should identify

Channel ID

Logical Name

Physical Source

Unit

Calibration Reference

Quality
Measurement Units

Units shall be explicit.

Never store a numeric measurement without an identifiable unit in the domain model.

Conversion Example
Raw PLC Value

↓

Scale

↓

Calibration

↓

Force

↓

kN
Precision

Measurement precision shall not be unnecessarily reduced during acquisition.

Example

Hardware Value

↓

Double / appropriate precision

↓

Engineering Calculation

The final display precision may be lower than the calculation precision.

Display Precision

Example

Internal

125.423781 kN

Display

125.42 kN

The stored authoritative value remains the higher precision value.

Numerical Stability

The acquisition pipeline should avoid unnecessary conversions such as

Raw

↓

String

↓

Double


during normal acquisition.

String Conversion

String formatting belongs to the presentation layer.

Acquisition Diagnostics

Diagnostic information may include

Current Sampling Rate

Expected Sampling Rate

Actual Sampling Rate

Sample Count

Dropped Count

Invalid Count

Buffer Occupancy

Persistence Queue Size

Processing Latency
Buffer Occupancy

A diagnostic percentage may be calculated

Current Occupancy / Maximum Capacity

High occupancy may trigger a warning before overflow.

Performance Thresholds

Thresholds shall be configuration-driven where practical.

Example conceptual states

Normal

Warning

Critical
Acquisition Performance

The system shall be tested under worst-case expected conditions.

Testing should include

Maximum Sampling Rate

Maximum Test Duration

Maximum Data Size

Graph Active

Persistence Active

Detection Active

simultaneously.

Long Test

The architecture must support long-running Tests without unbounded memory growth.

Memory Rule

The complete Test dataset shall not be required to remain entirely in RAM.

The system should persist data incrementally.

Live Window

The UI may maintain only a recent display window.

Example

Last 30 seconds

while the full dataset remains persisted.

Graph Window

Graph navigation may allow

Zoom

Pan

Full Test

Recent Window

without changing the authoritative dataset.

Acquisition Stop on Application Close

If a Test is active and the user closes the application

Close Request

↓

Check Active Test

↓

Warn / Block

↓

Controlled Shutdown

The application should not simply terminate the acquisition process without handling the active Test state.

Application Crash

After an unexpected crash

Previous Test

↓

Possibly Interrupted

↓

Recover Persisted Samples

↓

Determine Dataset Integrity

↓

Mark Test Accordingly
Acquisition Service Interface

Conceptual interface

IAcquisitionService

Start()

Stop()

Flush()

GetState()

GetChannelStatus()

GetDiagnostics()
Measurement Stream Interface

Conceptually

IMeasurementStream

Subscribe()

Unsubscribe()

GetLatest()

GetDiagnostics()

The exact implementation may use events, observable streams or another .NET Framework 4.8-compatible mechanism.

Acquisition Configuration

Configuration may include

Sampling Rate

Buffer Size

Timeout

Channel Set

Quality Rules

Persistence Batch Size

UI Update Rate
Configuration Immutability

Critical acquisition parameters shall be frozen when a Test enters Running.

Test Snapshot

The Test should retain the effective acquisition configuration used during execution.

Acquisition Security

Only authorized users should be able to change acquisition configuration that affects measurement integrity.

Acquisition Audit

Changes to acquisition configuration should be auditable.

Unit Testing

Acquisition components shall be testable using simulated measurement streams.

Tests should include

Normal Samples

Missing Samples

Duplicate Samples

Out-of-Order Samples

Invalid Samples

Channel Loss

Timestamp Gaps

High Rate

Buffer Overflow
Integration Testing

Hardware integration testing shall verify

Channel Discovery

Sample Acquisition

Timestamping

Channel Synchronization

Stop

Flush

Persistence
Performance Testing

Performance tests shall measure

CPU

RAM

Acquisition Latency

Persistence Latency

Queue Occupancy

UI Latency
Stress Testing

The system should be tested with

Maximum Expected Sampling Rate

Maximum Number of Channels

Long Test Duration

High Graph Activity

High Persistence Activity
Acceptance Criteria

The acquisition architecture is acceptable only when

Authoritative data is independent of UI refresh.

Required channels are traceable.

Samples are timestamped.

Missing / invalid data is detectable.

Raw and engineering values are distinguishable.

Acquisition continues independently from UI rendering.

Persistence does not silently lose samples.

The Test Runtime receives reliable acquisition state.

The full dataset is preserved for engineering calculations.
Architectural Decision (FROZEN)

The Measurement Acquisition Layer is the authoritative source of Test measurement data.

Acquisition is independent from WPF rendering and UI refresh.

Every authoritative sample shall have a consistent identity and timestamp where supported.

Measurement quality shall be explicit.

Missing, invalid, stale, estimated and interpolated values shall never be silently represented as valid measured values.

The live graph may downsample or decimate data for performance, but graph optimization shall never modify or replace the authoritative dataset.

High-frequency acquisition shall use background processing and controlled buffering.

Persistence shall be incremental and transactionally controlled.

The complete measurement dataset shall remain available for engineering calculations, detection algorithms and reporting.

The acquisition layer shall remain independent of the specific PLC, Fatek communication mechanism, VS20NL-P1 implementation and WPF UI.

This decision is permanent.

Next Chapter

ARCH-067

Engineering Data Model, Stress-Strain Dataset & Sample Storage

This chapter will define

Test Measurement Dataset
Sample Entity
Force
Displacement
Extension
Engineering Stress
Engineering Strain
True Stress / True Strain
Cross-Section Geometry
Gauge Length
Initial Length
Area
Units
Dataset Version
Sample Storage
SQLite Measurement Tables
Raw vs Processed Data
Derived Values
Data Integrity
Traceability
Calculation Inputs
Calculation Outputs
Dataset Immutability
End of Chapter