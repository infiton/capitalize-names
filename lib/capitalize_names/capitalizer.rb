# frozen_string_literal: true

module CapitalizeNames
  class Capitalizer
    attr_reader :name, :options

    NAME = %r{
      (                                                 # start capture
        (?:                                             # start first name token
          (?:(?:van\ )|(?:de\ (?:la\ )?)|(?:dit\ ))?    # optionally match one of van, de, de la, dit and space
          (?:[[:alnum:]]|'|\(|\))+                      # match any unicode character, number, apostrophe or bracket
        )                                               # end first name token
        (?:                                             # start optional additional name tokens
          -                                             # additional name tokens start with -
          (?:                                           # start additional name token
            (?:(?:van\ )|(?:de\ (?:la\ )?)|(?:dit\ ))?  # optionally match one of van, de, de la, dit and space
            (?:[[:alnum:]]|'|\(|\))+                    # match any unicode character, number, apostrophe or bracket
          )                                             # end additional name token
        )*                                              # end optional additional name tokens
      )                                                 # end capture
    }ix

    MC = /(?<=\A|-)Mc(\w)(?=\w)/i
    MAC = /(?<=\A|-)Mac(\w)(?=\w)/i
    O_APOSTROPHE = /(?<=\A|-)O'(\w)(?=\w)/i
    VAN_SPACE = /(?<=\A|-)Van /i
    DE_LA_SPACE = /(?<=\A|-)De La /i
    DE_SPACE = /(?<=\A|-)De /i
    DIT_SPACE = /(?<=\A|-)Dit /i

    VALID_FORMATS = [:fullname, :firstname, :givenname, :lastname, :surname]

    DEFAULT_OPTIONS = {
      format: :fullname,
      skip_mc: false,
      skip_mac: false,
      skip_o_apostrophe: false,
      skip_van_space: false,
      skip_de_space: false,
      skip_de_la_space: false,
      skip_dit_space: false,
    }

    SUFFIX_MAP = CapitalizeNames::SUFFIXES.each_with_object({}) { |suffix, map| map[suffix.downcase] = suffix }
    SURNAME_MAP = CapitalizeNames::SURNAMES.each_with_object({}) { |surname, map| map[surname.downcase] = surname }

    def initialize(name, options = {})
      @name = name
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def capitalize!
      can_process?
      capitalize_name
    end

    def capitalize
      capitalize!
    rescue CapitalizeNames::Errors::GenericError
      name
    end

    private

    def can_process?
      raise CapitalizeNames::Errors::InvalidName, "Cannot capitalize nil" unless name

      true
    end

    def name_format
      @name_format ||= validate_name_format
    end

    def validate_name_format
      unless VALID_FORMATS.include?(options[:format])
        raise CapitalizeNames::Errors::InvalidOption,
          "Invalid format: #{@options[:format]}, must be one of #{VALID_FORMATS.join(", ")}"
      end

      options[:format]
    end

    def tokenize_name
      name.split(NAME).map do |token|
        {
          value: token,
          is_name: token.match?(NAME),
        }
      end
    end

    def suffix?(str)
      SUFFIX_MAP.key?(str.downcase)
    end

    def surname?(str)
      SURNAME_MAP.key?(str.downcase)
    end

    def capitalize_str(str, surname_rules)
      str.split(/(\s|-)/).map do |word|
        next word if word.match?(/(\s|-)/)

        output = word.capitalize
        next output unless surname_rules
        next capitalize_surname(output) if surname?(output)

        output = output.gsub(MC) { "Mc#{Regexp.last_match(1).upcase}" } unless options[:skip_mc]
        output = output.gsub(MAC) { "Mac#{Regexp.last_match(1).upcase}" } unless options[:skip_mac]
        output = output.gsub(O_APOSTROPHE) { "O'#{Regexp.last_match(1).upcase}" } unless options[:skip_o_apostrophe]

        output
      end.join("")
    end

    def capitalize_givenname(str)
      capitalize_str(str, false)
    end

    def capitalize_suffix(str)
      SUFFIX_MAP[str.downcase]
    end

    def capitalize_surname(str)
      SURNAME_MAP[str.downcase]
    end

    def capitalize_lastname(str)
      return capitalize_suffix(str) if suffix?(str)

      output = capitalize_str(str, true)

      output = output.gsub(VAN_SPACE, "van ") unless options[:skip_van_space]
      output = output.gsub(DIT_SPACE, "dit ") unless options[:skip_dit_space]

      if output.match?(DE_LA_SPACE)
        output = output.gsub(DE_LA_SPACE, "de la ") unless options[:skip_de_la_space]
      else
        output = output.gsub(DE_SPACE, "de ") unless options[:skip_de_space]
      end

      output
    end

    def capitalize_name
      tokens = tokenize_name

      has_capitalized_last_name = false

      tokens.reverse.map do |token|
        token_value = token[:value]
        next token_value unless token[:is_name]

        case name_format
        when :firstname, :givenname
          capitalize_givenname(token_value)
        when :lastname, :surname
          capitalize_lastname(token_value)
        else
          if has_capitalized_last_name
            capitalize_givenname(token_value)
          else
            has_capitalized_last_name = !suffix?(token_value)
            capitalize_lastname(token_value)
          end
        end
      end.reverse.join("")
    end
  end
end
