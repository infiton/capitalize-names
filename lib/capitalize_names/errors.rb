# frozen_string_literal: true

module CapitalizeNames
  module Errors
    class GenericError < StandardError; end
    class InvalidName < GenericError; end
    class InvalidOption < GenericError; end
  end
end
