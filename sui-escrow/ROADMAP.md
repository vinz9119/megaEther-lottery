# Development Roadmap

## Phase 1 — Core prototype

- [x] Define buyer/seller escrow state
- [x] Add funding validation
- [x] Document lifecycle and invariants
- [x] Document security assumptions

## Phase 2 — Verification

- [ ] Compile with a pinned Sui toolchain
- [ ] Add scenario tests for happy paths
- [ ] Add authorization failure tests
- [ ] Add invalid-amount tests
- [ ] Run Move linting

## Phase 3 — Application integration

- [ ] Add lifecycle events
- [ ] Add TypeScript PTB client
- [ ] Add a minimal frontend flow
- [ ] Add indexer-facing documentation

## Phase 4 — Hardening

- [ ] Add expiry/dispute design
- [ ] Threat-model shared-object access
- [ ] Review coin-handling edge cases
- [ ] Independent security review before any real-value deployment
