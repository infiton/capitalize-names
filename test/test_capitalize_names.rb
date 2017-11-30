require 'minitest/autorun'
require 'capitalize_names'

class CapitalizeNamesTest < Minitest::Test
  def test_capitalization
    assert_equal "Tate", CapitalizeNames.capitalize("TATE") #basic upcase
    assert_equal "Smith", CapitalizeNames.capitalize("smith") #basic downcase
    assert_equal "Clarke", CapitalizeNames.capitalize("cLaRKe") #basic mix
    assert_equal "McElroy", CapitalizeNames.capitalize("MCELROY") #mc
    assert_equal "Mc", CapitalizeNames.capitalize("MC") #mc
    assert_equal "MacElvany", CapitalizeNames.capitalize("macelvany") #mac
    assert_equal "Mac", CapitalizeNames.capitalize("mac") #mac
    assert_equal "O'Neill", CapitalizeNames.capitalize("O'NEILL") # O'
    assert_equal "VanWinkle", CapitalizeNames.capitalize("VANWINKLE") #from surnames list
    assert_equal "Rip VanWinkle", CapitalizeNames.capitalize("rip VANWINKLE") #from surnames list
    assert_equal "van Buren", CapitalizeNames.capitalize("van buren") #"van "
    assert_equal "Martin van Buren", CapitalizeNames.capitalize("MARTIN van buren") #"van "
    assert_equal "Bob Jones, III", CapitalizeNames.capitalize("bob jones, iii") #suffix
    assert_equal "Johnson-Smith", CapitalizeNames.capitalize("johnson-smith") #hypenated
    assert_equal "Sullivan", CapitalizeNames.capitalize("SULLIVAN") # IV in the middle
    assert_equal "Bumcorn", CapitalizeNames.capitalize("bumcorn") # MC in the middle
    assert_equal "Tomacron", CapitalizeNames.capitalize("TOMACRON") # MAC in the middle
    assert_equal "Treo'las", CapitalizeNames.capitalize("treo'las") # O' in the middle
    assert_equal "Ronald McDonald", CapitalizeNames.capitalize("ronald mcdonald")
    assert_equal "Sarah MacDonald", CapitalizeNames.capitalize("Sarah macdonald")
    assert_equal "Réne", CapitalizeNames.capitalize("RÉNE") # accents
    assert_equal "Élise", CapitalizeNames.capitalize("éLiSE") #accents
    assert_equal "Denise", CapitalizeNames.capitalize("DENISE")
    assert_equal "Gleny Mejia-", CapitalizeNames.capitalize("Gleny Mejia-")
    assert_equal "-Gleny Mejia-", CapitalizeNames.capitalize("-Gleny Mejia-")
    assert_equal "Cinnamon Ballantye - Clarke", CapitalizeNames.capitalize("Cinnamon Ballantye - Clarke")
    assert_equal "- Cinnamon Ballantye - Clarke-van Buren-", CapitalizeNames.capitalize(" - CinnAMon BaLLantye - Clarke-VAN BUREN- ")
    assert_equal "Marco Van-Basten", CapitalizeNames.capitalize(" Marco   van-basten ")

  end

  def test_invalid_name
    assert_raises(CapitalizeNames::Errors::InvalidName) { CapitalizeNames.capitalize!(nil) }
    assert_nil CapitalizeNames.capitalize(nil)
  end

  def test_non_mutation
    str = "TATE"
    CapitalizeNames.capitalize(str)

    assert_equal str, "TATE"
  end
end