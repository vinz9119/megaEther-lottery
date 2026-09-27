# Test Plan

## Happy path

1. Create a guestbook.
2. Sign with address A.
3. Read address A's message.
4. Sign again with address A.
5. Confirm the new message replaces the old one.
6. Sign with address B.
7. Confirm A and B retain independent entries.

## Failure/edge cases

- reading an address with no entry
- empty message handling
- repeated updates
- many distinct authors
- shared-object transaction contention

## Verification

Tests should be executed with a pinned compatible Sui CLI and framework before results are described as verified.
