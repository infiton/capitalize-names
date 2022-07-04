[![Circle CI](https://circleci.com/gh/infiton/capitalize-names.svg?style=shield)](https://circleci.com/gh/infiton/capitalize-names)
# capitalize-names
Simple proper name capitalization that handles edge cases. Originally based off of http://dzone.com/snippets/capitalize-proper-names

## Installation
```
gem install capitalize-names
```

## Quick Start

```ruby
require 'capitalize_names'

CapitalizeNames.capitalize("TATE") # => "Tate"
CapitalizeNames.capitalize("JoHn O'NEILL") # => "John O'Neill"
CapitalizeNames.capitalize("macarthur") # => "MacArthur"
CapitalizeNames.capitalize("rick johnson-smith") # => "Rick Johnson-Smith"
CapitalizeNames.capitalize("bob jones, iii") # => "Bob Jones, III"
```

## Name Formats

`CapitalizeNames` uses different rules depending on whether the name being capitalized is thought to be a given name or a surname. For given names the only difference from [Ruby's capitalize](https://apidock.com/ruby/String/capitalize) is that they will be capitalized around hyphens:

```ruby
CapitalizeNames.capitalize("jean-louis", format: :firstname) # "Jean-Louis"
```

For surnames the capitalization will also be done across hyphens however a series of further rules are applied:

- If the name is included in the [list](https://github.com/infiton/capitalize-names/blob/master/lib/capitalize_names/surnames.rb) of `CapitalizeNames::SURNAMES` it will be capitalized as it is in the list.
- Otherwise a series of rules are applied each of which can be skipped:
    - The letter after an initial "Mc" will be capitalized (to skip pass `skip_mc: true`).
    - The letter after an initial "Mac" will be capitalized (to skip pass `skip_mac: true`).
    - The letter after an initial "O'" will be capitalized (to skip pass `skip_o_apostrophe: true`).
    - An initial "van " will be downcased (to skip pass `skip_van_space: true`).
    - An initial "dit " will be downcased (to skip pass `skip_dit_space: true`).
    - An initial "de la " will be downcased (to skip pass `skip_de_la_space: true`).
    - An initial "de " will be downcased (to skip pass `skip_de_space: true`).

By default `CapitalizeNames` will use `format: :fullname` which will use surname rules on the last name in the string being capitalized (excluding suffixes) and given name rules on all other names. If there is only one name, `format: :fullname` will format it as a surname. To format all names as given names pass `format: :givenname` or `format: :firstname`. To format all names as surnames pass `format: :surname` or `format: :lastname`.

Examples:

```ruby
CapitalizeNames.capitalize("macarthur macarthur") # => "Macarthur MacArthur"
CapitalizeNames.capitalize("macarthur macarthur", format: :fullname) # => "Macarthur MacArthur"
CapitalizeNames.capitalize("macarthur macarthur", format: :surname) # => "MacArthur MacArthur"
CapitalizeNames.capitalize("macarthur macarthur", format: :givenname) # => "Macarthur Macarthur"
CapitalizeNames.capitalize("macarthur macarthur", skip_mac: true) # => "Macarthur Macarthur"
```

## Exceptions

`CapitalizeNames` comes with two methods `capitalize!` which will raise an exception if the input or options are invalid and `capitalize` which will return the input without doing anything if the input or options are invalid:

```ruby
CapitalizeNames.capitalize!(nil) # => raises an exception
CapitalizeNames.capitalize(nil) # => nil

CapitalizeNames.capitalize!("bob sacamano", format: :junk) # => raises an exception
CapitalizeNames.capitalize("bob sacamano", format: :junk) # => "bob sacamano"
```