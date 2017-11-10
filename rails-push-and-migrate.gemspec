# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-push-and-migrate/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-push-and-migrate"
  spec.version       = RailsPushAndMigrate::VERSION
  spec.authors       = ["Phuong Nguyen"]
  spec.email         = ["phuongnd08@gmail.com"]
  spec.summary       = %q{Library to help push and then run migration for rails if necessary}
  spec.description   = %q{Library to help push and then run migration for rails if necessary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec"
end
