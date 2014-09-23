# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sample_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "sample_gem"
  spec.version       = SampleGem::VERSION
  spec.authors       = ["T.J. Schuck"]
  spec.email         = ["tj@tjschuck.com"]
  spec.summary       = %q{Sample gem with C and Java extensions for demoing rake-compiler-dev-box}
  spec.description   = %q{Sample gem with C and Java extensions for demoing rake-compiler-dev-box. See https://github.com/tjschuck/rake-compiler-dev-box for more information.}
  spec.homepage      = "https://github.com/tjschuck/rake-compiler-dev-box"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/sample_gem/extconf.rb"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler", "~> 0.9.2"
end
