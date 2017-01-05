# -*- encoding: utf-8 -*-
require File.expand_path('../lib/metadata/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Colin Young"]
  gem.email         = ["me@colinyoung.com"]
  gem.description   = %q{Generate metadata from any ruby object (works great with rails.)}
  gem.summary       = %q{Metadata is an easy way to represent an object in a human or machine readable format.}
  gem.homepage      = "https://github.com/colinyoung/metadata"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "metadata"
  gem.require_paths = ["lib"]
  gem.version       = Metadata::VERSION
end
