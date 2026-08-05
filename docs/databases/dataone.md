---
name: DataOne
status: blocked
owner: Unknown (RL DBA)
access: blocked
server: 20.65.216.199:49577 (RL_MSSQL in .env)
discovery-date: 2026-06-14
researcher: Alicia Salazar
updated: 2026-06-14
---

# DataOne — Access Blocked

`ConflictAI` login does not have access to the `DataOne` database on `20.65.216.199:49577`.

## What is known

- Accessible by backup history via `msdb`: 1.26 GB as of 2026-06-08, growing +0.14 GB/month.
- Name suggests a vehicle data/VIN data service (DataOne is a known automotive VIN data provider).
- Size (1.26 GB) suggests a reference database — not a transactional volume store.

## Access fix required

DBA must run on `20.65.216.199`:
```sql
USE DataOne;
CREATE USER ConflictAI FOR LOGIN ConflictAI;
EXEC sp_addrolemember 'db_datareader', 'ConflictAI';
```

Escalate to the DAS DBA contact for the RL server (unknown — ask Ron Mulder or Dan Aston).
