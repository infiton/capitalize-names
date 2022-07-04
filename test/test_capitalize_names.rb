# frozen_string_literal: true

require "minitest/autorun"
require "capitalize_names"

class CapitalizeNamesTest < Minitest::Test
  def test_capitalization
    assert_equal("Tate", CapitalizeNames.capitalize("TATE")) # basic upcase
    assert_equal("Smith", CapitalizeNames.capitalize("smith")) # basic downcase
    assert_equal("Clarke", CapitalizeNames.capitalize("cLaRKe")) # basic mix
    assert_equal("McElroy", CapitalizeNames.capitalize("MCELROY")) # mc
    assert_equal("Mc", CapitalizeNames.capitalize("MC")) # mc
    assert_equal("MacElvany", CapitalizeNames.capitalize("macelvany")) # mac
    assert_equal("Mac", CapitalizeNames.capitalize("mac")) # mac
    assert_equal("O'Neill", CapitalizeNames.capitalize("O'NEILL")) # O'
    assert_equal("VanWinkle", CapitalizeNames.capitalize("VANWINKLE")) # from surnames list
    assert_equal("Rip VanWinkle", CapitalizeNames.capitalize("rip VANWINKLE")) # from surnames list
    assert_equal("Maclean", CapitalizeNames.capitalize("maclean")) # from surnames list with mac
    assert_equal("van Buren", CapitalizeNames.capitalize("van buren")) # "van "
    assert_equal("Martin van Buren", CapitalizeNames.capitalize("MARTIN van buren")) # "van "
    assert_equal("Bob Jones, III", CapitalizeNames.capitalize("bob jones, iii")) # suffix
    assert_equal("Johnson-Smith", CapitalizeNames.capitalize("johnson-smith")) # hypenated
    assert_equal("Sullivan", CapitalizeNames.capitalize("SULLIVAN")) # IV in the middle
    assert_equal("Bumcorn", CapitalizeNames.capitalize("bumcorn")) # MC in the middle
    assert_equal("Tomacron", CapitalizeNames.capitalize("TOMACRON")) # MAC in the middle
    assert_equal("Treo'las", CapitalizeNames.capitalize("treo'las")) # O' in the middle
    assert_equal("Ronald McDonald", CapitalizeNames.capitalize("ronald mcdonald"))
    assert_equal("Sarah MacDonald", CapitalizeNames.capitalize("Sarah macdonald"))
    assert_equal("Réne", CapitalizeNames.capitalize("RÉNE")) # accents
    assert_equal("Élise", CapitalizeNames.capitalize("éLiSE")) # accents
    assert_equal("Jorge de la Rosa", CapitalizeNames.capitalize("JORGE DE LA ROSA"))
    assert_equal("Jorge de Rosa", CapitalizeNames.capitalize("JORGE DE ROSA"))
    assert_equal("Martin dit Buren", CapitalizeNames.capitalize("MARTIN DIT BUREN"))
    assert_equal("Denise", CapitalizeNames.capitalize("DENISE"))
    assert_equal("Gleny Mejia-", CapitalizeNames.capitalize("Gleny Mejia-"))
    assert_equal("-Gleny Mejia-", CapitalizeNames.capitalize("-Gleny Mejia-"))
    assert_equal("Cinnamon Ballantye - Clarke", CapitalizeNames.capitalize("Cinnamon Ballantye - Clarke"))
    assert_equal(" - Cinnamon Ballantye - Clarke-van Buren- ",
      CapitalizeNames.capitalize(" - CinnAMon BaLLantye - Clarke-VAN BUREN- "))
    assert_equal("Macie MacDonald", CapitalizeNames.capitalize("macie macdonald"))
    assert_equal("Macie MacDonald, (4th)", CapitalizeNames.capitalize("macie macdonald, (4TH)"))
    assert_equal("Mackenzie Mackenzie", CapitalizeNames.capitalize("mackenzie mackenzie"))
    assert_equal("Macdonald-John Johnson-MacDonald", CapitalizeNames.capitalize("macdonald-john johnson-macdonald"))
    assert_equal("Jean-Louis-Deveau deCote-MacDonald-DeVeau",
      CapitalizeNames.capitalize("jean-louis-deveau decote-macdonald-deveau"))
  end

  def test_format
    assert_equal("Macie", CapitalizeNames.capitalize("macie", format: :firstname))
    assert_equal("MacIe", CapitalizeNames.capitalize("macie", format: :lastname))
    assert_equal("MacIe", CapitalizeNames.capitalize("macie", format: :fullname))

    assert_equal("Macie Macdonald, Iii", CapitalizeNames.capitalize("macie macdonald, iii", format: :firstname))
    assert_equal("Macie Macdonald, Iii", CapitalizeNames.capitalize("macie macdonald, iii", format: :givenname))
    assert_equal("MacIe MacDonald, III", CapitalizeNames.capitalize("macie macdonald, iii", format: :lastname))
    assert_equal("MacIe MacDonald, III", CapitalizeNames.capitalize("macie macdonald, iii", format: :surname))
    assert_equal("Macie MacDonald, III", CapitalizeNames.capitalize("macie macdonald, iii", format: :fullname))

    assert_equal("Jean-Louis", CapitalizeNames.capitalize("jean-louis", format: :firstname))

    assert_equal("Macarthur MacArthur", CapitalizeNames.capitalize("macarthur macarthur"))
    assert_equal("Macarthur MacArthur", CapitalizeNames.capitalize("macarthur macarthur", format: :fullname))
    assert_equal("MacArthur MacArthur", CapitalizeNames.capitalize("macarthur macarthur", format: :surname))
    assert_equal("Macarthur Macarthur", CapitalizeNames.capitalize("macarthur macarthur", format: :givenname))
    assert_equal("Macarthur Macarthur", CapitalizeNames.capitalize("macarthur macarthur", skip_mac: true))
  end

  def test_skip_rules
    assert_equal("Jim McElroy", CapitalizeNames.capitalize("JIM MCELROY"))
    assert_equal("Jim Mcelroy", CapitalizeNames.capitalize("JIM MCELROY", skip_mc: true))

    assert_equal("Macy MacElvany", CapitalizeNames.capitalize("MACY macelvany"))
    assert_equal("Macy Macelvany", CapitalizeNames.capitalize("MACY macelvany", skip_mac: true))

    assert_equal("Sara O'Brian", CapitalizeNames.capitalize("SARA O'BRIAN"))
    assert_equal("Sara O'brian", CapitalizeNames.capitalize("SARA O'BRIAN", skip_o_apostrophe: true))

    assert_equal("Martin van Buren", CapitalizeNames.capitalize("MARTIN van buren"))
    assert_equal("Martin Van Buren", CapitalizeNames.capitalize("MARTIN van buren", skip_van_space: true))

    assert_equal("Jorge de la Rosa", CapitalizeNames.capitalize("JORGE DE LA ROSA"))
    assert_equal("Jorge De La Rosa", CapitalizeNames.capitalize("JORGE DE LA ROSA", skip_de_la_space: true))
    assert_equal("Jorge de la Rosa", CapitalizeNames.capitalize("JORGE DE LA ROSA", skip_de_space: true))

    assert_equal("Jorge de Rosa", CapitalizeNames.capitalize("JORGE DE ROSA"))
    assert_equal("Jorge de Rosa", CapitalizeNames.capitalize("JORGE DE ROSA", skip_de_la_space: true))
    assert_equal("Jorge De Rosa", CapitalizeNames.capitalize("JORGE DE ROSA", skip_de_space: true))

    assert_equal("Martin dit Buren", CapitalizeNames.capitalize("MARTIN DIT BUREN"))
    assert_equal("Martin Dit Buren", CapitalizeNames.capitalize("MARTIN DIT BUREN", skip_dit_space: true))
  end

  def test_invalid_name
    assert_raises(CapitalizeNames::Errors::InvalidName) { CapitalizeNames.capitalize!(nil) }
    assert_nil(CapitalizeNames.capitalize(nil))
  end

  def test_invalid_option
    assert_raises(CapitalizeNames::Errors::InvalidOption) { CapitalizeNames.capitalize!("foo", format: :bar) }
    assert_equal("foo", CapitalizeNames.capitalize("foo", format: :bar))
  end

  def test_non_mutation
    str = "TATE"
    CapitalizeNames.capitalize(str)

    assert_equal(str, "TATE")
  end
end
