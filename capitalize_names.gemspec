# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require File.expand_path("../lib/capitalize_names/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "capitalize-names"
  s.version     = CapitalizeNames::VERSION
  s.summary     = "Capitalizes names; handles edge cases."
  s.description = "A simple gem to capitalize names, based off of: http://dzone.com/snippets/capitalize-proper-names"
  s.authors     = ["Kyle Tate"]
  s.email       = "kbt.tate@gmail.com"
  s.files       = Dir.glob("{lib}/**/*")

  s.required_ruby_version = "> 2.0"
  s.add_runtime_dependency("activesupport", [">= 3"])
  s.add_development_dependency("minitest")
  s.add_development_dependency("rake")
  s.add_development_dependency("rubocop")
  s.add_development_dependency("rubocop-shopify")
  s.homepage    = "http://github.com/infiton/capitalize-names"
  s.license     = "MIT"
end
