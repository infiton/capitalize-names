module CapitalizeNames
  module Errors
    class GenericError < Exception; end
    class InvalidName < GenericError; end
  end
end
