---
project: Universal Testing Machine (UTS)
document: EDR-0010
title: Identity, Session, Authorization and Security Boundary
version: 1.0
status: FROZEN
decision_date: 2026-08-09
classification: SECURITY-ARCHITECTURE
supersedes: none
related:
  - EDR-0004
  - EDR-0006
  - EDR-0007
  - EDR-0008
---

# EDR-0010 — Identity, Session, Authorization and Security Boundary

## Status boundary

This decision defines the local workstation security boundary. It does not authorize a network listener, remote control, cloud identity, database-encryption claim, digital-signature claim or physical motion.

## Decision

UTS v1 uses the authenticated Windows interactive identity as its primary authentication evidence. The application maps the immutable Windows account SID to an enabled UTS Actor and then evaluates stable UTS permission identifiers. UTS does not store or verify operator passwords in v1.

Every accountable operator, reviewer and approver must use a unique Windows account. A shared Windows account may be used only for an explicitly identified kiosk/view-only configuration and cannot release methods, approve calibration, release reports, change security configuration or enable commissioning activity.

Authentication, authorization, session state and audit identity remain separate concepts:

| Concept | Authority |
|---|---|
| Authentication | Windows access token and SID |
| Actor identity | versioned UTS Actor mapped to one SID |
| Authorization | stable permission grants assembled from versioned role assignments |
| Session | short-lived in-process UTS session bound to the current Windows identity |
| Audit | immutable actor/session/correlation evidence committed with sensitive mutations |

Role names are display/configuration data. Production authorization never compares a role-name string.

## Session contract

An Application-created session contains `SessionId`, `ActorId`, SID hash/reference, authentication method, issued/last-activity/absolute-expiry UTC, workstation identity, application build and effective permission-revision hash.

- A ViewModel supplies only `SessionId`; it cannot construct trusted Actor data.
- Windows lock, logoff, identity change, disabled Actor, expired session or permission-revision change invalidates the active session.
- Unlock/re-entry creates or refreshes a session only after the Windows identity is re-observed.
- Idle and absolute lifetime values are versioned security configuration, not hard-coded constants.
- Session invalidation prevents new mutations but cannot withdraw an accepted Stop or protective reaction.
- Stop and JOG End remain requestable through the fail-closed local safety path even when the ordinary session has expired.

## Authorization and separation of duties

The Frozen permission identifiers in EDR-0006 and the command catalog remain authoritative. Every mutating handler resolves the current Actor and permission revision immediately before effects.

Release/approval operations support a versioned separation-of-duties policy. At minimum, the same Actor cannot both create/perform and independently approve a calibration or release-controlled item when the active policy requires independence. The recorded evidence names the policy revision and both identities.

Disabling an Actor or changing a role does not rewrite historical audit records. Existing sessions using the prior permission revision become invalid.

## Secret and sensitive-data handling

- UTS source, configuration, logs, audit payloads and error receipts never contain passwords, access tokens or unrestricted PLC frames.
- Hardware/network secrets, if later required, are stored by an approved Windows-protected secret mechanism and referenced by opaque identifier. Plain-text secrets in SQLite, XML configuration or report artifacts are prohibited.
- General diagnostics use redaction and stable codes. Controlled diagnostic bundles require authorization and an explicit manifest.
- Database-file encryption is not assumed. Deployment must rely on Windows account/file permissions until a separate encryption/key-lifecycle decision is approved.
- SHA-256 content hashes provide identity/integrity evidence; they are not represented as cryptographic signatures.

## Local-only boundary

The process opens no HTTP, REST, gRPC, WebSocket, generic TCP command or remote-motion listener. Enabling any external identity or transport requires a new security and safety EDR, threat model, credential lifecycle, replay protection, rate limiting and machine risk-assessment review.

## Persistence impact

A forward migration must add stable Actor, Role, Permission, Actor-Role assignment, role-permission assignment, session audit and security-policy revision records. The active Windows SID is stored in normalized protected form suitable for deterministic comparison; reports and normal UI projections do not disclose it.

Security tables retain history and use retirement/revocation rather than deletion. Authentication/session events and all security administration mutations are audited.

## Verification requirements

Automated tests must prove:

1. payload identity/role values cannot grant authority;
2. SID-to-Actor mapping is deterministic and disabled/unknown Actors fail closed;
3. role renaming does not change permissions;
4. permission changes invalidate prior sessions;
5. expired/locked sessions cannot mutate ordinary state;
6. Stop and JOG End remain requestable;
7. separation-of-duties rejection uses a stable reason code;
8. logs, receipts and diagnostics redact secrets and unrestricted device data;
9. no network listener is enabled by the default composition root;
10. historical audit remains attributable after Actor/role retirement.

## Rejected alternatives

1. **Application-owned passwords in v1** — adds credential storage, reset, lockout and breach-response obligations without a demonstrated need.
2. **Trust the username/role in a command DTO** — client-controlled authorization is bypassable.
3. **Hard-code Administrator/Operator role names** — prevents governed role evolution and violates EDR-0006.
4. **Keep sessions valid after a permission change** — permits revoked authority to persist.
5. **Expose a remote API because the workstation is on a private network** — network location is not an authentication or safety boundary.

# End of EDR
