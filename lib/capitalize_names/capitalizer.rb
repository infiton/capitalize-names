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

      def _capitalize
        nm = name.mb_chars

        hyphens_index = []

        while nm.index('-') do
          index = nm.index('-')
          hyphens_index << index
          nm = nm[0...index] + ' ' + nm[index+1..-1]
        end

        nm = nm.split.map{|w| w.capitalize}.map{ |w| 
          begin 
            w.gsub(MC, "Mc" + w[2].upcase)
          rescue
            w 
          end
        }.map{|w| 
          begin 
            w.gsub(MAC, "Mac" + w[3].upcase)
          rescue
            w 
          end
        }.map{|w| 
          begin 
            w.gsub(O_APOSTROPHE, "O'" + w[2].upcase)
          rescue
            w 
          end
        }

        nm = nm.join(' ')
        hyphens_index.each do |idx|
          nm = nm[0...idx] + '-' + (nm[idx+1..-1] || "")
        end
            
        nm = nm.gsub("Van ", "van ").gsub("De ", "de ").gsub("Dit ", "dit ")
        nm += ' '

        (CapitalizeNames::SURNAMES + CapitalizeNames::SUFFIXES).each do |surname|
          pos = nm.downcase.index(surname.downcase)
          if pos 
            # surname/suffix must be:
            # 1. at start of name or after a space or a -
            #          -and-
            # 2. followed by the end of string or a space or a -
            if ( ((pos == 0) or (pos > 0 and (nm[pos-1] == ' ' or nm[pos-1] == '-'))) and ((nm.length == pos+surname.length) or (nm[pos+surname.length] == ' ') or (nm[pos+surname.length] == '-')) )
              nm = nm[0...pos] + surname + nm[pos+surname.length..-1]
            end
          end
        end
        nm.strip
      end
  end
end