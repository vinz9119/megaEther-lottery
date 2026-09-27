# Threat Model

## Assets

The vault protects user balances held by the application.

## Trust boundaries

- user transaction signer
- shared application state
- token object ownership
- any future administrative controls

## Required invariants

1. A withdrawal cannot exceed the caller's recorded balance.
2. One user's balance cannot be spent by another user.
3. Deposit accounting must equal assets held by the vault.
4. Failed operations must leave accounting unchanged.

## Future review

Before real-value deployment, test arithmetic edge cases, object ownership transitions, abort paths, and concurrent transaction behavior.
