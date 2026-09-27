# Test Plan

## Core flows
- create escrow
- fund with exact amount
- release funded escrow
- refund funded escrow
- cancel unfunded escrow

## Failure cases
- non-buyer attempts financial state change
- second funding attempt
- incorrect funding amount
- release before funding
- refund before funding
- cancellation after funding

## Verification
Run Move unit/scenario tests with a pinned compatible Sui CLI and framework before treating results as verified.
