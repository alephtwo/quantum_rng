require 'minitest/autorun'
require 'quantum_rng'

# Tests for the Quantum RNG Module
class TestQuantumRNG < Minitest::Test
  def test_uint8
    assert_equal 1, QuantumRNG.uint8.size
    assert_equal 1, QuantumRNG.uint8(1).size
    assert_equal 5, QuantumRNG.uint8(5).size

    r = QuantumRNG.uint8(1000).reject { |n| n < 0 || n > 255 }
    assert_equal 1000, r.size
  end

  def test_uint16
    assert_equal 1, QuantumRNG.uint16.size
    assert_equal 1, QuantumRNG.uint16(1).size
    assert_equal 5, QuantumRNG.uint16(5).size

    r = QuantumRNG.uint16(1000).reject { |n| n < 0 || n > 65_535 }
    assert_equal 1000, r.size
  end

  def test_hex16
    assert_equal 1, QuantumRNG.hex16(2).size
    assert_equal 1, QuantumRNG.hex16(2, 1).size
    assert_equal 5, QuantumRNG.hex16(2, 5).size
  end

  def test_random
    assert_equal 1, QuantumRNG.random.size
    assert_equal 1, QuantumRNG.random(1).size
    assert_equal 5, QuantumRNG.random(5).size

    r = QuantumRNG.random(1000).reject { |n| n < 0 || n > 1 }
    assert_equal 1000, r.size
  end

  def test_int
    assert_equal 1, QuantumRNG.int(10).size
    assert_equal 1, QuantumRNG.int(10, 1).size
    assert_equal 5, QuantumRNG.int(10, 5).size

    r = QuantumRNG.int(100, 1000).reject { |n| n < 0 || n > 100 }
    assert_equal 1000, r.size
  end

  def test_float
    awesome = Math::E**Math::PI**2
    assert_equal 1, QuantumRNG.float(awesome).size
    assert_equal 1, QuantumRNG.float(awesome, 1).size
    assert_equal 5, QuantumRNG.float(awesome, 5).size

    r = QuantumRNG.float(awesome, 1000).reject { |n| n < 0 || n > awesome }
    assert_equal 1000, r.size
  end
end
