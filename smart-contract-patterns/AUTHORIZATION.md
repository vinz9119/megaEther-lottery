# Authorization Pattern Notes

## Capability-based access

A capability can represent authority to perform privileged operations without relying on a global administrator address.

## Questions for every pattern

- Who receives the capability?
- Can it be duplicated?
- Can it be transferred?
- Can it be revoked?
- What happens after package upgrade?
- Can a malicious caller construct an equivalent-looking resource?

Examples should be tested around both successful and unauthorized transactions.
