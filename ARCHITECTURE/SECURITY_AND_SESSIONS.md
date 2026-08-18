---
project: Universal Testing Machine (UTS)
document: SECURITY_AND_SESSIONS
version: 0.1
status: FROZEN
governing_edr: EDR-0010
last_revision: 2026-08-09
---

# Security and Session Architecture

## Trust flow

```mermaid
flowchart TD
    WIN["Windows identity / SID"] --> SES["UTS session service"]
    SES --> ACT["Actor + permission revision"]
    ACT --> PIPE["Application command pipeline"]
    PIPE --> AUD["Transactional audit"]
```

Presentation provides a SessionId and command payload only. Application resolves the trusted Windows identity, Actor, permissions and separation policy. Infrastructure persists identity mappings and audit but never decides command authorization.

## Fail-closed conditions

Unknown/disabled Actor, changed Windows identity, expired session, Windows lock/logoff, retired permission revision and unavailable security configuration deny ordinary mutations. They never cancel an accepted Stop or protective reaction.

## Project ownership

| Component | Responsibility |
|---|---|
| `UTS.Core` | immutable Actor/permission identifiers and pure policy value objects |
| `UTS.Application.Contracts` | session-aware command/query contracts; no trusted role in payload |
| `UTS.Application` | Windows identity/session resolution, authorization and separation policy |
| `UTS.Infrastructure.SQLite` | Actor/role/permission/session-audit persistence |
| `UTS.Presentation.Wpf` | lock state, permission projections and localized rejection messages |
| `UTS.Bootstrapper` | selects Windows-integrated identity provider; opens no listener |

Passwords, access tokens and unrestricted device frames are prohibited from DTOs, audit payloads, logs and diagnostics.
