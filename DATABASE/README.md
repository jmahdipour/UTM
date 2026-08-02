# UTS Database Package

This package implements the persistence decision governed by EDR-0007.

| Path | Purpose |
|---|---|
| `Migrations/0001_initial.sql` | executable initial SQLite schema |
| `MIGRATION_POLICY.md` | controlled upgrade, backup and recovery procedure |
| `REQUIREMENTS_TRACEABILITY.md` | requirement-to-source-to-SQL-to-test matrix |
| `ACCEPTANCE_TESTS.sql` | database-level invariant checks for the initial migration |

The SQL intentionally avoids optional SQLite extensions. The future VB.NET persistence project must run migrations through one controlled writer and execute the acceptance checks in CI against the pinned x86 SQLite provider.

