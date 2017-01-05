# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'match_regex/version'

Gem::Specification.new do |spec|
  spec.name          = "match_regex"
  spec.version       = MatchRegex::VERSION
  spec.authors       = ["Tunghsiao Liu"]
  spec.email         = ["t@sparanoid.com"]

  spec.summary       = "A Liquid filter to perform regex match"
  spec.homepage      = "https://github.com/sparanoid/match_regex"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
