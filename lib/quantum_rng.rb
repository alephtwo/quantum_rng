require 'quantum_rng/version'
require 'net/http'
require 'json'

# QuantumRNG gets random numbers from the ANU Quantum RNG API.
module QuantumRNG
  def self.uint8(count = 1)
    make_request(length: count, type: 'uint8')
  end

  def self.uint16(count = 1)
    make_request(length: count, type: 'uint16')
  end

  def self.hex16(block_size, count = 1)
    make_request(length: count, type: 'hex16', size: block_size)
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

  private

  def self.make_request(queries)
    q = URI.encode_www_form(queries)
    uri = URI.parse("http://qrng.anu.edu.au/API/jsonI.php?#{q}")
    packet = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
    if packet[:success]
      packet[:data]
    else
      fail "[ERROR] #{JSON.pretty_generate(packet)}"
    end
  end
end
