# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magic_reveal/version'

Gem::Specification.new do |spec|
  spec.name          = "magic_reveal"
  spec.version       = MagicReveal::VERSION
  spec.authors       = ["Christian Höltje"]
  spec.email         = ["docwhat@gerf.org"]
  spec.description   = %q{Create presentations with markdown and ease!}
  spec.summary       = %q{Create presentations using markdown and reveal.js}
  spec.homepage      = "https://github.com/docwhat/magic_reveal"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "sinatra",     "~> 1.4"
  spec.add_dependency             "redcarpet",   "~> 2.3"
  spec.add_dependency             "archive-zip", "~> 0.6"

  spec.add_development_dependency "bundler",     "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec",       "~> 2.13"
end
