# Sui Token Vault

An educational Move design for a simple user-controlled token vault.

## Intended behavior
Users deposit assets into a vault object and can later withdraw their own balance. The design focuses on object ownership, balance accounting, and authorization boundaries.

## Engineering goals
- explicit accounting invariants
- no cross-user balance access
- tests for deposits and withdrawals
- event-based auditability
- frontend integration through programmable transaction blocks

## Status
Design-stage prototype; no deployment or production claims.
