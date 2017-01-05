# -*- encoding: utf-8 -*-
# stub: bower 0.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "bower".freeze
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Steve Agalloco".freeze]
  s.date = "2015-05-12"
  s.description = "Bower integration for your ruby projects.".freeze
  s.email = "steve.agalloco@gmail.com".freeze
  s.homepage = "https://github.com/stve/bower".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Bower integration for your ruby projects.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>.freeze, [">= 0"])
    else
      s.add_dependency(%q<multi_json>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<multi_json>.freeze, [">= 0"])
  end
end
