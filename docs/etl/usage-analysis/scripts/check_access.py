"""Probe access to all databases on the server, including ones not in our list."""
from db import query

# All DBs on the instance — not just ONLINE / non-system
cols, rows, _ = query(
    "SELECT name, state_desc, HAS_DBACCESS(name) AS can_access "
    "FROM sys.databases ORDER BY name"
)
print(f"{'name':30s} {'state':12s} {'access'}")
for name, state, access in rows:
    print(f"{name:30s} {state:12s} {access}")
