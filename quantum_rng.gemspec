# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quantum_rng/version'

Gem::Specification.new do |spec|
  spec.name          = 'quantum_rng'
  spec.version       = QuantumRNG::VERSION
  spec.authors       = ['Ben Christianson']
  spec.email         = ['thhuntertgm@gmail.com']

  spec.summary       = 'A random number generator that leverages the ANU Quantum Random Nubmers API.'
  spec.description   = 'Please see http://qrng.anu.edu.au/FAQ.php#api for more information on the bare JSON API, as well as the science behind it.'
  spec.homepage      = 'https://github.com/alephtwo/quantum_rng'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8'
end
