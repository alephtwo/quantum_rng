require "quantum_rng/version"
require 'net/http'
require 'json'

module QuantumRNG

  @@base = "http://qrng.anu.edu.au/API/jsonI.php?"

  def self.uint8(count = 1)
    uri = URI.parse "#{@@base}length=#{count}&type=uint8"
    parse_api(uri)
  end

  def self.uint16(count = 1)
    uri = URI.parse "#{@@base}length=#{count}&type=uint16"
    parse_api(uri)
  end

  def self.hex16(block_size, count = 1)
    uri = URI.parse "#{@@base}length=#{count}&type=hex16&size=#{block_size}"
    parse_api(uri)
  end

  def self.random(count = 1)
    result = uint16(count).map { | r | r / 65535.0 }
  end

  def self.int(max, count = 1)
    random(count).map { | r | (r * max).to_i }
  end

  def self.float(max, count = 1)
    random(count).map { | r | (r * max).to_f }
  end

  private
    def self.parse_api(uri)
      packet = JSON.parse Net::HTTP.get uri
      if packet["success"]
        rng = packet["data"]
      else
        raise "[ERROR] #{JSON.pretty_generate(packet)}"
      end
      rng
    end
end