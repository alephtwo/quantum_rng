# QuantumRNG
A Ruby gem that leverages the [ANU Quantum Random Numbers Server API](http://qrng.anu.edu.au/index.php).

# Acknowledgements
This gem exists entirely as an interface to the ANU Quantum Random Numbers API. **All of the heavy lifting is done on their side, and any credit belongs entirely to them.** I have just generalized access to the JSON API. 
Please give them a visit: [http://photonics.anu.edu.au/qoptics/Research/qrng.php](http://photonics.anu.edu.au/qoptics/Research/qrng.php)

### So, you want random numbers...
Computers are great at creating pseudorandom numbers, but true randomness requires a little bit more effort.

That's where the fine folks at the [ANU Quantum Random Numbers Server](http://qrng.anu.edu.au/index.php) come in. They've provided a handy JSON API for accessing what they guess are truly random numbers. You can read more about the science behind this and why they believe they've achieved true randomness at their site.

## Installation
```
gem install quantum_rng
```

If you're using Bundler, include the gem in your `Gemfile`:
```
gem 'quantum_rng'
```

## Usage

| Method | Argument(s)               | Description                                     |
| ------ | :-----------------------: | ----------------------------------------------- |
| uint8  | `count = 1`               | `count` integers between 0 and 255              |
| uint16 | `count = 1`               | `count` integers between 0 and 65535            |
| hex16  | `block_size`, `count = 1` | `count` hex numbers of `block_size` bytes       |
| random | `count = 1`               | `count` real numbers between 0 and 1, inclusive |
| int    | `max`, `count = 1`        | `count` integers in the range `[0, max)`        |
| float  | `max`, `count = 1`        | `count` real numbers in the range `[0, max)`    |

Every method returns an array of numbers.

## Errors
* If you are unable to connect to the ANU RNG server for any reason, this gem won't function at all.
* Requesting too many numbers (usually where `count > 1025`) or passing invalid arguments will likely cause a RuntimeError. In future versions, this behavior will be softened.

## Examples
```ruby
  # A single random uint8
  QuantumRNG.uint8
  # 5 random uint8
  QuantumRNG.uint8(5)

  # A single random uint16
  QuantumRNG.uint16
  # 5 random uint16
  QuantumRNG.uint16(5)

  # A single 1-byte hex number
  QuantumRNG.hex16(1)
  # 5 random 1-byte hex numbers
  QuantumRNG.hex16(1, 5)

  # A single random between 0 and 1, inclusive
  QuantumRNG.random
  # 5 randoms between 0 and 1, inclusive
  QuantumRNG.random(5)

  # A single random int less than 100
  QuantumRNG.int(100)
  # 5 ints less than 100
  QuantumRNG.int(100, 5)

  # A single random float less than 100
  QuantumRNG.float(100)
  # 5 random floats less than 100
  QuantumRNG.float(100, 5)
```

# TODO
Future versions will include better error handling.
