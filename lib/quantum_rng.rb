require 'quantum_rng/version'
require 'securerandom'
require 'net/http'
require 'json'

# QuantumRNG gets random numbers from the ANU Quantum RNG API.
module QuantumRNG
  def self.uint8(count = 1)
    make_request(
      -> { Array.new(count).map { SecureRandom.random_number 255 } },
      length: count,
      type: 'uint8'
    )
  end

  def self.uint16(count = 1)
    make_request(
      -> { Array.new(count).map { SecureRandom.random_number 65_535 } },
      length: count,
      type: 'uint16'
    )
  end

  def self.hex16(block_size, count = 1)
    make_request(
      -> { Array.new(count).map { SecureRandom.hex block_size } },
      length: count,
      type: 'hex16',
      size: block_size
    )
  end

  def self.random(count = 1)
    uint16(count).map { |r| r / 65_535.0 }
  end

  def self.int(max, count = 1)
    random(count).map { |r| (r * max).to_i }
  end

  def self.float(max, count = 1)
    random(count).map { |r| (r * max).to_f }
  end

  private_class_method

  def self.make_request(backup, queries)
    q = URI.encode_www_form(queries)
    uri = URI.parse("http://qrng.anu.edu.au/API/jsonI.php?#{q}")
    packet = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
    if packet[:success]
      packet[:data]
    else
      backup.call
    end
  rescue
    backup.call
  end
end
