module CapitalizeNames
  module Errors
    class << self
      def all_exceptions
        self.constants
          .map { |c| self.const_get(c) }
          .select{ |c| c < Exception }
      end
    end

    class InvalidName < Exception; end;
  end
end