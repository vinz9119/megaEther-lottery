# Design

## Data model

Guestbook is a shared object containing a map from author address to message.

## Invariants

- each address has at most one active entry
- signing again replaces the prior message
- reads do not mutate state
- writes are authorized by the transaction sender

## Test plan

1. create a guestbook
2. sign from one address
3. read the message
4. sign again and verify replacement
5. verify another address cannot overwrite the first user's entry
