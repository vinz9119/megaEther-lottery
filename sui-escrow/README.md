# Sui Escrow

An original Move smart-contract prototype for a buyer/seller escrow workflow on Sui.

## Status

This is an educational prototype prepared for further development. It has not been compiled or deployed yet.

## Intended workflow

1. Buyer creates an escrow with a seller and amount.
2. Buyer funds the escrow with the exact amount.
3. Buyer releases payment after the agreed condition is met.
4. Seller can cancel before funding.

## Planned improvements

- Store the escrowed Coin<SUI> directly in the escrow object.
- Add expiry and refund handling.
- Add authorization and invalid-amount tests.
- Add events for creation, funding, release, and cancellation.
- Compile and test against a pinned Sui framework revision.

## Disclaimer

Educational prototype only; not production financial software.
