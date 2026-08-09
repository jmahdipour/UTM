# ARCHITECTURE
# Chapter 74
# Measurement Acquisition Pipeline, Sensor Normalization, Sampling, Buffering, Real-Time Data Flow & Persistence Worker

Document ID

ARCH-074

Version

0.1

Status

FROZEN

Related EDR

EDR-079

Depends On

ARCH-069 Machine Controller

ARCH-071 SQLite Database Architecture

ARCH-072 Application Services

ARCH-073 Test Lifecycle State Machine

---

# Purpose

This chapter defines the complete measurement acquisition architecture.

The architecture covers

```text
Load Cell

Crosshead Encoder

Extensometer

Controller

Sampling

Timestamping

Calibration

Normalization

Engineering Conversion

Quality

Buffering

Real-Time Graph

Persistence

Recovery

The primary requirement is that measurement acquisition must remain independent from WPF rendering and database write speed.

Core Principle

The measurement pipeline shall never depend on the UI refresh rate.

Hardware Sampling Rate

!=

Graph Refresh Rate

!=

Database Write Rate
Measurement Architecture
+---------------------------+
| Physical Sensors          |
|                           |
| Load Cell                 |
| Crosshead Encoder         |
| Extensometer              |
+-------------+-------------+
              |
              v
+---------------------------+
| Machine Controller        |
|                           |
| PLC / Drive / Acquisition |
+-------------+-------------+
              |
              v
+---------------------------+
| Acquisition Service       |
+-------------+-------------+
              |
              v
+---------------------------+
| Raw Measurement           |
+-------------+-------------+
              |
              v
+---------------------------+
| Calibration / Normalizer  |
+-------------+-------------+
              |
              v
+---------------------------+
| Engineering Measurement   |
+-------------+-------------+
              |
       +------+------+
       |             |
       v             v
+-------------+ +-------------+
| Live Buffer | | Persistence |
|             | | Queue       |
+------+------+ +------+------+
       |               |
       v               v
+-------------+ +-------------+
| WPF Graph   | | SQLite      |
+-------------+ +-------------+
Measurement Categories

The application supports at minimum

Force

Crosshead Displacement

Extensometer Displacement / Strain

Time

Stress

Strain

Additional channels may be supported by the machine configuration.

Sensor Architecture

The system must identify every measurement source explicitly.

Example

LoadCell_25T

LoadCell_10T

LoadCell_2T

LoadCell_500kg

LoadCell_100kg

Crosshead

Extensometer_100

Extensometer_50

Extensometer_25
Active Sensor

Only the sensor selected by the Method shall be used as the authoritative measurement source for the corresponding channel.

Load Cell Selection

A Method may specify

25 ton

10 ton

2 ton

500 kg

100 kg
Load Cell Capacity

The system must know

Nominal Capacity

Unit

Calibration

Active Status

Serial / Identifier
Load Cell Validation

Before Test

Selected Load Cell Exists

Calibration Exists

Calibration Valid

Capacity Is Compatible

Sensor Is Connected

must be confirmed.

Crosshead Encoder

The crosshead encoder provides displacement information.

Typical engineering quantity

Crosshead Displacement [mm]
Encoder Calibration

The encoder calibration must be applied consistently.

Extensometer

The system supports multiple extensometers.

Example

100 mm

50 mm

25 mm
Extensometer Configuration

Each extensometer should have

Identifier

Gauge Length

Measurement Range

Resolution

Calibration

Status
Measurement Channel

Every channel shall contain

ChannelId

SensorId

SensorType

RawValue

EngineeringValue

Unit

Timestamp

Quality
Raw Measurement

Raw measurement is the value received from the acquisition source before engineering transformation.

Example

ADC Count

Register Value

Encoder Count
Engineering Measurement

Engineering measurement is the calibrated value used by the Test Engine.

Example

Force = 125.4 kN

Displacement = 12.35 mm
Raw Data Preservation

Raw measurements should be preserved where practical and where the configured data-storage policy requires them.

Reason

Raw data allows

Recalculation

Diagnostics

Calibration Verification

Traceability

Post-Test Analysis
Measurement Timestamp

Every measurement sample requires a timestamp.

Timestamp Source

The preferred timestamp is generated as close to acquisition as possible.

Timestamp Precision

The internal timestamp should support at least millisecond precision.

If the controller provides higher-resolution timestamps, they may be preserved.

Timestamp Consistency

All channels belonging to the same acquisition cycle should use a common acquisition timestamp where possible.

Sample Sequence

Each acquisition sample should have a monotonically increasing sequence number.

Example

Sample 10001

Sample 10002

Sample 10003
Sequence Purpose

The sequence number allows detection of

Missing Samples

Duplicate Samples

Out-of-order Data
Measurement Packet

Conceptual structure

MeasurementPacket

TestId

SequenceNumber

Timestamp

Force

Crosshead

Extensometer

Quality
Example
MeasurementPacket

TestId = T20260802001

Sequence = 15231

Timestamp = 2026-08-02 10:25:31.245

Force = 125.42 kN

Crosshead = 18.324 mm

Extensometer = 1.245 mm

Quality = Valid
Sampling Frequency

The sampling frequency is a machine / acquisition configuration property.

It must not be hard-coded into the UI.

Sampling Rate Requirements

The acquisition rate must be sufficient to capture the important mechanical events of the Test.

Important Events
Yield

Peak Force

Break

Rapid Force Drop

Extensometer Response

Crosshead Motion
Sampling and Speed

Higher crosshead speed generally requires sufficient sampling frequency to preserve the mechanical event.

Nyquist Principle

The system should avoid selecting an acquisition rate that is obviously insufficient for the dynamics of the Test.

Practical Rule

The acquisition rate should be selected based on

Machine Capability

Controller Capability

Expected Test Speed

Required Measurement Resolution

Storage Capacity
Acquisition Rate vs UI

Example

Acquisition = 1000 samples/sec

Graph = 30 frames/sec

Database = 100 samples/batch

All three can operate independently.

Acquisition Loop

Conceptual loop

while AcquisitionActive

    Read Controller

    Timestamp

    Assign Sequence

    Normalize

    Validate Quality

    Push Buffer

end while
Acquisition Thread

The acquisition loop should execute outside the WPF UI thread.

UI Thread Restriction

No direct blocking hardware acquisition call should run on the WPF Dispatcher thread.

Raw Acquisition Stage
Controller

↓

RawSample

The RawSample contains controller-originated values.

Normalization Stage
RawSample

↓

Sensor Calibration

↓

Unit Conversion

↓

Engineering Value
Calibration Application

Calibration must be determined by the active sensor calibration record.

Force Calibration

Conceptually

Force = CalibrationFunction(RawForce)
Linear Calibration

For a simple linear calibration

EngineeringValue = A × RawValue + B
Multi-Point Calibration

Where multiple calibration points are configured, the calibration engine may use

Piecewise Linear

Polynomial

Other Approved Calibration Function

according to the calibration configuration.

Calibration Version

Every Test should retain the calibration version used for its measurements.

Historical Traceability

Changing a calibration later must not change historical Test data.

Unit Normalization

Internally, engineering values should use a consistent canonical unit.

Recommended

Force = N

Displacement = mm

Stress = MPa

Strain = dimensionless

Time = ms / high-resolution internal representation
Display Units

The UI may display

N

kN

kgf

mm

%

MPa

depending on user configuration.

Internal vs Display

The internal engineering value must not change simply because the operator changes the display unit.

Example

Internal

Force = 125420 N

Display

125.42 kN
Stress Calculation

For a specimen with cross-sectional area A

Stress = Force / Area

with consistent units.

Example

If

Force = 100000 N

Area = 100 mm²

then

Stress = 1000 MPa
Strain Calculation

For extensometer displacement

Strain = ΔL / L0
Percentage Strain
StrainPercent = Strain × 100
Gauge Length

The initial gauge length must be stored as part of the Test snapshot.

Crosshead Strain

If the Method permits crosshead-based strain

Strain = CrossheadDisplacement / L0

subject to the Method definition.

Sensor Quality

Each measurement must carry quality information.

Quality Values

Recommended

Valid

Invalid

Stale

Missing

OutOfRange

CommunicationError

CalibrationError
Valid Sample

A sample is Valid when

Controller Data Available

Sensor Connected

Value Within Valid Range

Calibration Valid

Timestamp Valid
Invalid Sample

Invalid samples must not silently become zero.

Critical Rule
Missing Force

!=

Force = 0
Stale Data

If the controller repeatedly returns an unchanged sample when movement is expected, the system may classify the channel as stale.

Stale Detection

Stale detection should consider

Expected Sampling Rate

Expected Sensor Dynamics

Controller Status
Out-of-Range

A measurement outside the configured sensor range should be marked

OutOfRange
Sensor Failure

A critical sensor failure during Test must generate an event.

Example
LoadCellFailureEvent
Measurement Quality and Result Engine

The Result Engine must receive quality information.

It must not interpret an invalid sample as valid engineering data.

Invalid Data Policy

The Method / Result Engine determines whether invalid samples

Can Be Ignored

Require Interpolation

Terminate Test
No Silent Interpolation

Interpolation must never occur silently.

If interpolation is used, it must be identifiable in the data-processing metadata.

Measurement Buffer

The Measurement Buffer separates acquisition from consumers.

Buffer Architecture
Acquisition

↓

MeasurementBuffer

+------------------+
| Sample           |
| Sample           |
| Sample           |
| Sample           |
+------------------+

      |
      +----> Result Engine
      |
      +----> Graph
      |
      +----> Persistence
Buffer Requirements

The buffer should support

Thread Safety

Ordering

High Throughput

Bounded Memory

Monitoring
Buffer Size

The buffer size must be configurable or calculated based on

Sampling Rate

Expected Maximum Delay

Memory Limit
Buffer Overflow

Buffer overflow is a critical condition.

Overflow Policy

The application must not silently discard engineering samples.

Overflow Response

Possible sequence

Buffer Near Full

↓

Warning

↓

Increase Persistence Throughput

↓

If Critical

↓

Fault / Controlled Stop
Graph Buffer

The live graph may use a separate display buffer.

Why

The graph does not need to render every acquisition sample individually.

Graph Decimation

Example

1000 samples/sec

↓

Graph Display

30-60 updates/sec

The display layer may decimate or aggregate samples.

Important Rule

Graph decimation must not modify the stored raw measurement data.

Graph Data

The graph may use

Min

Max

Average

Representative Point

depending on the rendering strategy.

Peak Preservation

When decimating, the algorithm should preserve important peaks and abrupt changes.

Example

If a graph bucket contains

100

105

110

200

115

the displayed representation should not eliminate the 200 peak.

Persistence Queue

Persistence shall be decoupled from acquisition.

Persistence Flow
MeasurementBuffer

↓

PersistenceQueue

↓

BatchWriter

↓

SQLite
Batch Writing

Measurements should normally be written in batches rather than one SQL transaction per sample.

Reason

Batching reduces

Disk Operations

Transaction Overhead

SQLite Locking
Batch Size

The exact batch size is implementation-configurable.

Example

100

250

500

1000

depending on sampling rate and hardware performance.

Persistence Timing

The persistence worker should use both

Maximum Batch Size

Maximum Wait Time
Example
If batch >= 500

OR

oldest sample >= 100 ms

↓

Write Batch
SQLite Connection

The persistence worker should use its own database connection.

UI Database Access

The WPF UI must not execute measurement INSERT operations directly.

SQLite Write Rule

A single controlled persistence pipeline should own measurement writes.

Read Operations

Read operations may use separate read connections as appropriate.

WAL

SQLite WAL mode may be used where compatible with the deployment requirements.

Measurement Table

The measurement schema must support at least

MeasurementId

TestId

SequenceNumber

Timestamp

ForceRaw

Force

CrossheadRaw

Crosshead

ExtensometerRaw

Extensometer

Quality

CreatedAt
Sensor-Specific Tables

If the number of sensor channels becomes dynamic, a normalized channel model may be preferable.

Dynamic Channel Model

Conceptually

Measurement

MeasurementChannelValue

ChannelDefinition
Fixed Channel Model

For the current machine configuration, fixed columns may provide simpler and faster storage.

Architecture Decision

The implementation should choose fixed or dynamic channel storage based on the final database schema.

The decision must not be made inconsistently between acquisition and persistence layers.

Measurement Metadata

Each Test should retain

Sampling Rate

Controller Configuration

Sensor Configuration

Calibration Version

Method Version
Test Snapshot

At Test start, execution-critical configuration must be snapshotted.

Snapshot Contents
Method

Method Version

Load Cell

Calibration

Extensometer

Gauge Length

Cross-Section

Speed

Clutch

Controller Settings
Historical Integrity

A Test must always be interpretable from its stored snapshot.

Sensor Disconnect

If a sensor disconnects

SensorStatus = Disconnected
Disconnect Event

Generate

SensorDisconnectedEvent
Recovery

When reconnected

SensorReconnectedEvent

may be generated.

Reconnection does not automatically make the Test valid again.

Force Sensor Disconnection

Force sensor disconnection during a force-controlled Test should normally cause

Controlled Stop

↓

Fault
Extensometer Disconnection

If required

Controlled Stop

↓

Fault

If optional

Warning

Continue According to Method
Controller Communication

The acquisition service communicates through the controller abstraction.

Controller Polling

If the controller uses polling, polling must run independently of the UI.

Controller Push

If the controller supports event-based acquisition, the acquisition layer may consume pushed samples.

Abstraction

The upper layers must not care whether acquisition is

Polling

Push

Buffered Controller Data
Acquisition Interface

Conceptually

IMeasurementAcquisition
Operations
Start()

Stop()

Read()

Subscribe()

GetStatus()
Acquisition Status
Stopped

Starting

Running

Stopping

Fault
Measurement Pipeline Timing

Each sample passes through

T0 = Acquisition

T1 = Timestamp

T2 = Normalization

T3 = Quality

T4 = Buffer

T5 = Result Processing

T6 = Persistence Queue
Latency

The application should monitor acquisition latency.

Acquisition Latency
Timestamp_now - AcquisitionTimestamp

or equivalent measurement depending on timestamp source.

Processing Latency

The system may monitor

ProcessingTimestamp - AcquisitionTimestamp
Persistence Latency

The system may monitor

DatabaseCommitTimestamp - AcquisitionTimestamp
Monitoring

Operational metrics should include

Samples/sec

Buffer Depth

Queue Depth

Dropped Samples

Invalid Samples

Persistence Latency

Acquisition Latency
Dropped Samples

The application must count dropped samples explicitly.

Zero Dropping Goal

Normal operation target

DroppedSamples = 0
Dropped Samples During Critical Test

If samples are dropped during an engineering-critical Test, the system must flag the Test data integrity.

Data Integrity Status

Recommended

Complete

Warning

Compromised
Data Integrity Warning

Example

Measurement data was affected by acquisition overload.

Review Test validity before reporting final results.
Real-Time Result Processing

The Result Engine may process measurements asynchronously.

Ordering Requirement

Result processing must preserve measurement sequence order.

Parallel Processing

Parallel processing may be used only where it does not alter the required chronological order.

Yield Detection

Yield detection receives the ordered engineering measurement stream.

Break Detection

Break detection also receives the ordered stream.

Peak Detection

Maximum force should be updated continuously.

Peak State

Conceptually

MaximumForce

MaximumStress

MaximumForceSequence

MaximumForceTimestamp
Break Detection Example

A Method may define break as

Force decreases after MaximumForce

with a configured threshold.

Important

Break detection logic belongs to the Result / Method Engine, not the acquisition service.

Acquisition Service Responsibility

Acquisition answers

What did the machine report?

Result Engine answers

What does this measurement mean?
Database Responsibility

Database answers

What historical measurements were stored?
Graph Responsibility

Graph answers

How should current data be displayed?
Persistence Failure

If SQLite write fails

Persistence Worker

↓

Retry According to Policy

↓

If Still Failing

↓

Recovery Buffer

↓

Raise Persistence Fault
Retry

Retries must be bounded.

Retry Policy

Example

Attempt 1

Attempt 2

Attempt 3

Recovery
No Infinite Retry

Infinite database retry is prohibited.

Recovery Buffer

If the database is temporarily unavailable, critical unsaved measurements should be placed into a recovery mechanism.

Recovery Buffer Format

The recovery mechanism should preserve

TestId

Sequence

Timestamp

Raw Values

Engineering Values

Quality

Method Version

Calibration Version
Recovery Replay

After database recovery

Recovery Data

↓

Validate

↓

Replay

↓

Commit

↓

Mark Recovered
Duplicate Prevention

Recovery replay must be idempotent.

Unique Measurement Identity

Recommended uniqueness

TestId + SequenceNumber
Duplicate Insert

If the same measurement is replayed twice, the database must prevent duplicate historical records.

Acquisition Stop

When Test stops

Stop Acquisition

↓

Drain Buffer

↓

Flush Persistence Queue

↓

Finalize Results
Drain Requirement

The system must not finalize the Test while required buffered measurements remain unprocessed.

Flush Timeout

A controlled timeout should exist.

Flush Timeout Failure

If the queue cannot be flushed

Finalizing

↓

Persistence Fault

↓

Fault
Normal Completion
RUNNING

↓

Stop Condition

↓

STOPPING

↓

Acquisition Stop

↓

Buffer Drain

↓

Persistence Flush

↓

Result Finalization

↓

COMPLETED
Abnormal Completion
RUNNING

↓

Fault

↓

Controlled Stop

↓

Preserve Buffer

↓

Persistence / Recovery

↓

FAULT or ABORTED
UI Notification

The UI receives summarized updates.

It should not consume the raw high-frequency stream directly if doing so would overload the Dispatcher.

UI Update Rate

A configurable update frequency may be used.

Typical range

20-60 updates/sec

depending on graph complexity.

UI Throttling

If measurements arrive faster than the UI can render

Acquisition continues

UI updates are throttled
UI Must Not Backpressure Acquisition

A slow graph must never stop the measurement acquisition loop.

Live Graph Architecture
Acquisition

↓

MeasurementBuffer

↓

Display Aggregator

↓

Dispatcher

↓

Graph
Status Bar

The status bar may display

Force

Crosshead

Extensometer

Sampling Rate

Connection

Buffer Status

but should not query the controller independently on every UI frame.

Sensor Name

The status bar should identify the active sensor using the configured sensor name.

Example

Load Cell: 25T
Measurement Units

Display formatting belongs to Presentation.

Engineering Units

Calculation remains in the Domain / Application layer.

Example

Domain

Force = 125420 N

Presentation

Force = 125.42 kN
Acquisition Diagnostics

The application should provide diagnostic information for service engineers.

Diagnostics

Recommended

Current Sample Rate

Last Sample Timestamp

Last Sequence Number

Queue Depth

Buffer Depth

Invalid Count

Dropped Count

Controller Status
Diagnostics Must Not Alter Test Data

Diagnostics are observational.

Performance Requirement

The acquisition system must support the maximum configured Test speed and sampling frequency without uncontrolled data loss.

Memory Requirement

Memory consumption must remain bounded during long-duration Tests.

Long Test

The system must not hold the complete raw dataset indefinitely in RAM.

Streaming Persistence

Long Tests should stream measurement data to persistent storage.

Historical Data

SQLite becomes the long-term storage mechanism.

In-Memory Data

Memory should contain only the active working set required for

Live Graph

Current Calculation

Buffering

Recent Data
Post-Test Loading

Completed Test data can be loaded from SQLite when required.

Measurement Compression

Compression is optional.

If implemented, it must not destroy the required engineering traceability.

Raw Data Policy

The final deployment configuration must explicitly define whether

Raw Only

Engineering Only

Raw + Engineering

data is retained.

Recommended
Raw + Engineering

for maximum traceability.

Acquisition Security

Measurement data must not be modifiable by the UI during active acquisition.

Immutability

Once a measurement is committed to a Completed Test, it should be treated as immutable.

Audit

Any data-repair operation must create an Audit record.

Acceptance Criteria

ARCH-074 is accepted when

Acquisition is independent from WPF rendering.

Acquisition runs outside the UI thread.

All measurement samples have timestamps.

Samples have sequence numbers.

Raw values can be preserved.

Engineering values are normalized.

Calibration is applied through the calibration layer.

Canonical internal units are defined.

Display units are separated from engineering units.

Measurement quality is explicitly represented.

Invalid samples are not silently converted to zero.

Stale data can be detected.

Out-of-range values can be detected.

Measurement buffering is thread-safe.

Buffer overflow is detectable.

Persistence is asynchronous.

SQLite writes are batched.

Persistence does not block acquisition.

Graph rendering is decoupled from acquisition.

Graph decimation does not modify stored data.

Peak information is preserved during visualization.

Dropped samples are counted.

Persistence failures are detected.

Recovery buffering is supported.

Recovery replay is idempotent.

Measurement identity prevents duplicate records.

Buffer draining occurs before final Test completion.

Historical measurement data is immutable.

Long Tests do not require unlimited RAM.

Sampling diagnostics are available.

Sensor disconnect is detected.

Controller communication loss is detected.

Load cell failure is handled.

Extensometer failure is handled according to Method requirements.

Acquisition and Result Processing remain separate responsibilities.

Architectural Decision (FROZEN)

Measurement acquisition shall be implemented as an independent high-priority pipeline.

The WPF UI shall never control acquisition timing.

Raw and engineering values shall remain distinguishable.

Every sample shall have a timestamp and sequence number.

Measurement quality shall be explicit.

Invalid measurements shall never silently become valid zero values.

Calibration shall be applied through the defined calibration layer.

Internal engineering units shall remain independent of display units.

Measurement buffering shall separate acquisition from processing, visualization and persistence.

SQLite persistence shall be asynchronous and batched.

The UI graph may decimate data for visualization but must never alter stored engineering data.

Critical measurement data shall not be silently discarded.

Dropped samples and persistence failures shall be explicitly detected.

Long-running Tests shall stream measurements to persistent storage rather than retaining the complete dataset indefinitely in memory.

Recovery data shall be idempotent and protected against duplicate insertion.

The measurement pipeline shall preserve sufficient information to reconstruct and audit the Test.

This decision is permanent.

Next Chapter

ARCH-075

Sensor Architecture, Load Cells, Extensometers, Crosshead Encoder, Calibration Mapping, Sensor Selection & Multi-Sensor Management

This chapter will define

25T Load Cell
10T Load Cell
2T Load Cell
500 kg Load Cell
100 kg Load Cell
100 mm Extensometer
50 mm Extensometer
25 mm Extensometer
Crosshead Encoder
Sensor IDs
Sensor Metadata
Sensor Capacity
Sensor Range
Resolution
Accuracy
Calibration
Calibration Points
Reference Load Cell
Active Sensor
Sensor Compatibility
Sensor Switching
Sensor Validation
Sensor Fault
Sensor Availability
Multi-Sensor Architecture
Sensor UI
Sensor Status
Sensor Database Schema
Historical Sensor Snapshot
Calibration Versioning
Traceability
Sensor Safety Limits
End of Chapter