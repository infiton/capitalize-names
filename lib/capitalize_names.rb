# frozen_string_literal: true

# originally based on http://dzone.com/snippets/capitalize-proper-names
require "active_support/core_ext/string/multibyte"

require "capitalize_names/errors"
require "capitalize_names/suffixes"
require "capitalize_names/surnames"
require "capitalize_names/capitalizer"

module CapitalizeNames
  class << self
    def capitalize!(name, options = {})
      Capitalizer.new(name, options).capitalize!
    end

    def capitalize(name, options = {})
      Capitalizer.new(name, options).capitalize
    end
  end
end
