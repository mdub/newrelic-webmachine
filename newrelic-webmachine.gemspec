# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'new_relic/webmachine/version'

Gem::Specification.new do |spec|

  spec.name          = "newrelic-webmachine"
  spec.version       = NewRelic::Webmachine::VERSION
  spec.authors       = ["Mike Williams"]
  spec.email         = ["mdub@dogbiscuit.org"]
  spec.summary       = %q{NewRelic instrumentation for Webmachine.}
  spec.homepage      = "https://github.com/mdub/newrelic-webmachine"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("newrelic_rpm")
  spec.add_runtime_dependency("webmachine")

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

end
