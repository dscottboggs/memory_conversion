# Memory Conversion

[![Build Status](https://cloud.drone.io/api/badges/dscottboggs/memory_conversion/status.svg)](https://cloud.drone.io/dscottboggs/memory_conversion)

Quick and easy conversion between memory values.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     memory_conversion:
       github: dscottboggs/memory_conversion
   ```

2. Run `shards install`

## Usage

```crystal
require "memory_conversion"

1.terabyte.to_kilobits # => 8589934592.0
```

**Please see the [documentation](https://dscottboggs.github.io/memory_conversion/Number.html)**, and the [spec file](https://github.com/dscottboggs/memory_conversion/blob/master/spec/memory_conversion_spec.cr) for a few examples.

## Contributing

1. Fork it (<https://github.com/dscottboggs/memory_conversion/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Scott Boggs](https://github.com/dscottboggs) - creator and maintainer
