#based on http://dzone.com/snippets/capitalize-proper-names
require 'capitalize_names/errors'
require 'capitalize_names/capitalizer'
require 'capitalize_names/suffixes'
require 'capitalize_names/surnames'
require 'active_support/core_ext/string/multibyte'

module CapitalizeNames

  class << self

    def capitalize!(name)
      Capitalizer.new(name).capitalize!
    end

    def capitalize(name)
      Capitalizer.new(name).capitalize
    end
  end
end