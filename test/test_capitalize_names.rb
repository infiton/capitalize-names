require 'minitest/autorun'
require 'capitalize_names'

class CapitalizeNamesTest < Minitest::Test
  def test_capitalization
    assert_equal "Tate", CapitalizeNames.capitalize("TATE") #basic upcase
    assert_equal "Smith", CapitalizeNames.capitalize("smith") #basic downcase
    assert_equal "Clarke", CapitalizeNames.capitalize("cLaRKe") #basic mix
    assert_equal "McElroy", CapitalizeNames.capitalize("MCELROY") #mc
    assert_equal "MacElvany", CapitalizeNames.capitalize("macelvany") #mac
    assert_equal "O'Neill", CapitalizeNames.capitalize("O'NEILL") # O'
    assert_equal "VanWinkle", CapitalizeNames.capitalize("VANWINKLE") #from surnames list
    assert_equal "van Buren", CapitalizeNames.capitalize("van buren") #"van "
    assert_equal "Bob Jones, III", CapitalizeNames.capitalize("bob jones, iii") #suffix
    assert_equal "Johnson-Smith", CapitalizeNames.capitalize("johnson-smith") #hypenated
    assert_equal "Sullivan", CapitalizeNames.capitalize("SULLIVAN") # IV in the middle
    assert_equal "Bumcorn", CapitalizeNames.capitalize("bumcorn") # MC in the middle
    assert_equal "Réne", CapitalizeNames.capitalize("RÉNE") # accents
    assert_equal "Denise", CapitalizeNames.capitalize("DENISE")
  end
end