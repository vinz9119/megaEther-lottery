# Data Model

## Transaction

A transaction record should capture:

- chain
- transaction digest/hash
- timestamp
- sender
- recipient or affected objects
- gas used
- success/failure
- application/protocol label where known

## Derived metrics

Metrics should be calculated from normalized records rather than scraped presentation-layer values.

## Reproducibility

Every analysis should record its input window, source, filtering assumptions, and calculation method.
