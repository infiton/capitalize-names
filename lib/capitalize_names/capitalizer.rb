module CapitalizeNames
  class Capitalizer
    attr_accessor :name

    MC = /^Mc(\w)(?=\w)/i 
    MAC = /^Mac(\w)(?=\w)/i
    O_APOSTROPHE = /^O'(\w)(?=\w)/i

    def initialize(name)
      @name = name
    end

    def capitalize!
      can_process?
      _capitalize
    end

    def capitalize
      begin
        capitalize!
      rescue CapitalizeNames::Errors::GenericError
        name
      end
    end

    private
      def can_process?
        raise CapitalizeNames::Errors::InvalidName, "Cannot capitalize nil" unless name
        true
      end

      def surname_suffix_position?(position, name, surname_or_suffix)
        # surname/suffix must be:
        # 1. at start of name or after a space or a -
        #          -and-
        # 2. followed by the end of string or a space or a -
        (
          (position == 0) || \
          (
            position > 0 && (name[position-1] == ' ' || name[position-1] == '-')
          )
        ) && (
          (name.length == position+surname_or_suffix.length) || \
          (name[position+surname_or_suffix.length] == ' ') || (name[position+surname_or_suffix.length] == '-')
        )
      end

      def _capitalize
        _name = name

        hyphens_index = []

        while _name.index('-') do
          index = _name.index('-')
          hyphens_index << index
          _name = _name[0...index] << ' ' << _name[index+1..-1]
        end

        _name = _name.split.map{ |w| 
          w.mb_chars.capitalize.to_str 
        }.map{ |w|
          w.gsub(MC) { "Mc#{$1.upcase}" }\
           .gsub(MAC) { "Mac#{$1.upcase}" }\
           .gsub(O_APOSTROPHE) { "O'#{$1.upcase}" }
        }

        _name = _name.join(' ')
        hyphens_index.each do |idx|
          _name = _name[0...idx] << '-' << (_name[idx+1..-1] || "")
        end
            
        _name = _name.gsub("Van ", "van ").gsub("De ", "de ").gsub("Dit ", "dit ")
        _name << ' '

        (CapitalizeNames::SURNAMES + CapitalizeNames::SUFFIXES).each do |surname_or_suffix|
          position = _name.downcase.index(surname_or_suffix.downcase)
          if position and surname_suffix_position?(position, _name, surname_or_suffix)
            _name = _name[0...position] << surname_or_suffix << _name[position+surname_or_suffix.length..-1]
          end
        end
        _name.strip
      end
  end
end