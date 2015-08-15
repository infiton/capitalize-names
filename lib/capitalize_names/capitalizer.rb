module CapitalizeNames
  class Capitalizer
    attr_accessor :name

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
      rescue *CapitalizeNames::Errors.all_exceptions
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
        mc = /^Mc(\w)(?=\w)/i 
        mac = /^Mac(\w)(?=\w)/i
        oap = /^O'(\w)(?=\w)/i
        hyphens_index = []
        while nm.index('-') do
          index = nm.index('-')
          hyphens_index << index
          nm = nm[0...index] + ' ' + nm[index+1..-1]
        end

        nm = nm.split.map{|w| w.capitalize}.map{ |w| 
          begin 
            w.gsub(mc, "Mc" + w[2].upcase)
          rescue
            w 
          end
        }.map{|w| 
          begin 
            w.gsub(mac, "Mac" + w[3].upcase)
          rescue
            w 
          end
        }.map{|w| 
          begin 
            w.gsub(oap, "O'" + w[2].upcase)
          rescue
            w 
          end
        }

        nm = nm.join(' ')
        hyphens_index.each do |index|
          nm = nm[0...index] + '-' + nm[index+1..-1]
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