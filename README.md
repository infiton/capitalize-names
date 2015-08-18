# capitalize-names
Simple proper name capitalization that handles edge cases. Based off of http://dzone.com/snippets/capitalize-proper-names

## Installation
```
gem install capitalize-names
```

## Quick Start

```
require 'capitalize-names'

CapitalizeNames.capitalize("TATE") # => "Tate"
CapitalizeNames.capitalize("JoHn O'NEILL") # => "John O'Neill"
CapitalizeNames.capitalize("macarthur") # => "MacArthur"
CapitalizeNames.capitalize("rick johnson-smith") # => "Rick Johnson-Smith"
CapitalizeNames.capitalize("bob jones, iii") # => "Bob Jones, III"
```