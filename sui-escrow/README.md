# Sui Escrow

An educational Move prototype for a buyer/seller escrow workflow on Sui.

## Scope

The project explores:

- shared-object state
- buyer authorization
- exact payment validation
- funding and settlement flows
- refund handling
- lifecycle events
- integration-friendly read helpers

## Status

This is an original educational prototype and has not been compiled or deployed from this environment. It should not be treated as production-ready or audited.

Before deployment, the package should be built, linted, and tested with the Sui CLI against a pinned, compatible framework/toolchain.

## Intended lifecycle

Created -> Funded -> Released

Created -> Funded -> Refunded

Created -> Cancelled before funding

## Future work

- expiry using Sui Clock
- dispute/arbitration flow
- comprehensive authorization/state-transition tests
- TypeScript PTB client
- reproducible CI build
- security review

## Disclaimer

Educational prototype only; not financial software and not audited.
