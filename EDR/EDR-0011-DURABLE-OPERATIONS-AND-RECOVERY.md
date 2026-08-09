---
project: Universal Testing Machine (UTS)
document: EDR-0011
title: Durable Operations, Recovery and Resilience
version: 1.0
status: FROZEN
decision_date: 2026-08-09
classification: OPERATIONS-ARCHITECTURE
supersedes: none
related:
  - EDR-0001
  - EDR-0003
  - EDR-0004
  - EDR-0007
  - EDR-0008
  - EDR-0009
---

# EDR-0011 — Durable Operations, Recovery and Resilience

## Decision

Long-running analysis, re-analysis, import, report generation, export, backup, restore verification and maintenance work uses a durable in-process operation model backed by SQLite. No external message broker, Windows service or distributed scheduler is introduced for v1.

Machine motion, JOG leases, Stop and protective reactions are never scheduled as background jobs. They remain on the serialized Machine command lane governed by EDR-0003, EDR-0004, EDR-0008 and EDR-0009.

## Operation model

An immutable operation request contains `OperationId`, type/schema version, RequestId, CorrelationId, Actor/Session evidence, canonical payload/hash, priority, creation UTC and exact immutable input revisions.

Lifecycle:

`Queued → Running → Completed | Failed | Cancelled`

Recovery may move an abandoned `Running` attempt back to `Queued` only when the operation type explicitly declares deterministic idempotent retry. Each execution creates an immutable attempt record with worker/build identity, lease, checkpoints, progress summary and terminal reason.

Progress is disposable/read-model data. Completion, failure, cancellation and retry decisions are durable audit/domain evidence.

## Idempotency and retry

- RequestId plus payload hash prevents duplicate operation creation.
- A worker writes outputs to a temporary identity and publishes them atomically only after validation.
- A retry never overwrites a prior attempt or released artifact.
- Automatic retry is prohibited for machine commands, approvals, releases and any operation with an unknown external side effect.
- Retry count/backoff are versioned operation-policy data.
- A timed-out/abandoned attempt is retained and correlated; it is not deleted.

## Startup recovery gate

Normal operation is blocked until startup has completed:

1. build/configuration compatibility checks;
2. migration-ledger and checksum validation;
3. SQLite quick/integrity/foreign-key checks appropriate to the startup mode;
4. artifact-root availability and maintenance-marker checks;
5. detection of incomplete Run/command/operation records;
6. driver handshake and physical-state reconciliation when a physical adapter is configured;
7. finalization or explicit faulting of incomplete raw acquisition evidence;
8. re-queuing only of retry-safe durable operations;
9. publication of a versioned recovery result.

Failure opens Diagnostics/Recovery mode only. Recovery never assumes Machine `Ready`, never resumes motion and never auto-resends a prior motion command.

## Acquisition and shutdown

Acquisition, persistence and UI rendering use independent bounded rates. Controlled shutdown:

1. blocks new Arm/Start/JOG work;
2. requests the assessed Stop when motion may exist;
3. waits for stationary/reconciliation evidence within the governed policy;
4. drains or explicitly marks accepted raw buffers;
5. commits operation and audit checkpoints;
6. disposes read models and adapter resources.

An unclean shutdown is detected from durable session/maintenance markers and always enters reconciliation.

## Backup and restore

Backup and restore verification are durable maintenance operations. A backup is successful only when the checkpointed database, artifact set and manifest hashes restore into an isolated validation location and pass the governed checks. Copying a live database file is not a backup.

Restore is an explicit maintenance action with source/target identity, Actor, reason, manifest, verification evidence and no automatic overwrite of the current installation.

## Persistence impact

A forward migration must add application request inbox, durable operation, operation attempt/checkpoint, dispatcher/projection checkpoint and recovery/maintenance session records. Lease ownership is process/build specific and expires; it is not evidence that work completed.

## Verification requirements

Tests must prove duplicate submission idempotency, payload mismatch rejection, crash between output write and publish, abandoned-attempt recovery, retry-safety policy, no motion job path, acquisition independence from UI/report workers, shutdown drain/fault evidence, no automatic motion resume, backup restore verification and bounded x86 resource behavior.

## Rejected alternatives

1. **In-memory Task list as operation authority** — loses accepted work and provenance on crash.
2. **External broker/microservice** — adds deployment and failure modes without a single-workstation requirement.
3. **Auto-retry every failure** — can duplicate irreversible or externally visible effects.
4. **Resume an interrupted Run from the last segment** — physical state and specimen evidence are not reproducible after process loss.
5. **Let operation workers write arbitrary SQLite connections** — violates the single-writer transaction boundary.

# End of EDR
