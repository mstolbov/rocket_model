# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rocket_model/version'

Gem::Specification.new do |spec|
  spec.name          = "rocket_model"
  spec.version       = RocketModel::VERSION
  spec.authors       = ["Mike Stolbov"]
  spec.email         = ["mstolbov@gmail.com"]

  spec.summary       = %q{Simple implementation of ActiveRecord}
  spec.description   = %q{Simple implementation of ActiveRecord}
  spec.homepage      = "https://github.com/mstolbov/rocket_model"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
