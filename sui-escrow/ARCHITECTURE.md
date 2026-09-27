# Escrow Architecture

## Actors

- Buyer: creates and funds an escrow and controls settlement actions.
- Seller: receives payment after the buyer releases the escrow.
- Sui runtime: owns object lifecycle and transaction authorization.

## State

The escrow concept has four important fields:

- buyer
- seller
- amount
- optional payment coin

The optional payment represents whether funding has occurred.

## Lifecycle

```
Created
  |
  +--> Cancelled
  |
  +--> Funded
          |
          +--> Released
          |
          +--> Refunded
```

## Invariants

1. Only the buyer can change the escrow's financial state.
2. Funding must match the configured amount exactly.
3. An escrow cannot be funded twice.
4. Settlement must only occur after funding.
5. The escrowed payment is transferred as part of settlement.

## Production considerations

A production implementation would need expiry/dispute handling, comprehensive adversarial tests, event indexing, a pinned compatible framework/toolchain, and independent security review.
