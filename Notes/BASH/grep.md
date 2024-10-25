tags: [[scripting]], [[shell]], [[regular expression, Regex]]

## Usage

1. `grep -oE "\"price\"\s*:\s*[0-9]*?\.[0-9]*"`

Let's break down the details of this statement:

- `-o` tells `grep` to _only_ return the matching portion
- `-E` tells `grep` to be able to use extended regex symbols such as `?`
- `\"price\"` matches the string `"price"`
- `\s*` matches any number (including 0) of whitespace (`\s`) characters
- `:` matches `:`
- `[0-9]*` matches any number of digits (from 0 to 9)
- `?\.` optionally matches a `.`