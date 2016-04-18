Gem::Specification.new do |s|
  s.name        = 'capitalize-names'
  s.version     = '1.0.3'
  s.date        = '2016-04-17'
  s.summary     = 'Capitalizes names; handles edge cases.'
  s.description = 'A simple gem to capitalize names, based off of: http://dzone.com/snippets/capitalize-proper-names'
  s.authors     = ['Kyle Tate']
  s.email       = 'kbt.tate@gmail.com'
  s.files       = [
    'lib/capitalize_names.rb',
    'lib/capitalize_names/errors.rb',
    'lib/capitalize_names/capitalizer.rb',
    'lib/capitalize_names/suffixes.rb',
    'lib/capitalize_names/surnames.rb'
  ]

  s.required_ruby_version = '~> 2.0'
  s.add_runtime_dependency "activesupport", [">= 3"]
  s.add_development_dependency 'minitest', ' ~>5.8.4'
  s.homepage    = 'http://github.com/infiton/capitalize-names'
  s.license     = 'MIT'
end