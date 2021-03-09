# -*- encoding: utf-8 -*-
require File.expand_path('../lib/capitalize_names/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'capitalize-names'
  s.version     = CapitalizeNames::VERSION
  s.date        = '2017-09-20'
  s.summary     = 'Capitalizes names; handles edge cases.'
  s.description = 'A simple gem to capitalize names, based off of: http://dzone.com/snippets/capitalize-proper-names'
  s.authors     = ['Kyle Tate']
  s.email       = 'kbt.tate@gmail.com'
  s.files       = Dir.glob("{lib}/**/*")

  s.required_ruby_version = '> 2.0'
  s.add_runtime_dependency "activesupport", [">= 3"]
  s.add_development_dependency 'minitest', ' ~>5.8.4'
  s.homepage    = 'http://github.com/infiton/capitalize-names'
  s.license     = 'MIT'
end
