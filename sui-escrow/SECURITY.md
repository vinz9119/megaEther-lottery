# Security Notes

This project is an educational prototype and is not audited.

## Current design assumptions

The buyer address is stored with the escrow and is intended to authorize funding and settlement. The escrow amount is fixed when the object is created.

## Threats to address before production

- unauthorized state transitions
- incorrect coin amounts
- double funding
- settlement of unfunded escrows
- expiry and dispute races
- shared-object contention
- malicious or unexpected transaction composition
- insufficient testing around object destruction and coin ownership

## Deployment policy

No real-value deployment should be made until the package has been compiled with a pinned compatible Sui toolchain, covered by scenario tests, and reviewed for security.
