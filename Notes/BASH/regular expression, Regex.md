
tags:  [[Regex]]
# Regular Expressions Cheat Sheet

## Basic Syntax

- **.** : Matches any single character except newline
- **^** : Matches the start of a string
- **$** : Matches the end of a string
- **\*** : Matches 0 or more repetitions of the preceding element
- **+** : Matches 1 or more repetitions of the preceding element
- **?** : Matches 0 or 1 repetition of the preceding element
- **{n}** : Matches exactly n repetitions of the preceding element
- **{n,}** : Matches n or more repetitions of the preceding element
- **{n,m}** : Matches between n and m repetitions of the preceding element

## Character Classes

- **[abc]** : Matches any one of a, b, or c
- **[^abc]** : Matches any character except a, b, or c
- **[a-z]** : Matches any character from a to z
- **[A-Z]** : Matches any character from A to Z
- **[0-9]** : Matches any digit from 0 to 9
- **\d** : Matches any digit (equivalent to `[0-9]`)
- **\D** : Matches any non-digit
- **\w** : Matches any word character (equivalent to `[a-zA-Z0-9_]`)
- **\W** : Matches any non-word character
- **\s** : Matches any whitespace character
- **\S** : Matches any non-whitespace character

## Groups and Alternations

- **(abc)** : Matches the exact sequence abc
- **a|b** : Matches either a or b
- **(a|b)** : Matches either a or b within a group

## Assertions

- **\b** : Matches a word boundary
- **\B** : Matches a non-word boundary
- **(?=abc)** : Positive lookahead, matches a group before a certain substring without including it in the result
- **(?!abc)** : Negative lookahead, matches a group not followed by a certain substring

## Examples

- **\d{3}-\d{2}-\d{4}** : Matches a Social Security number format (e.g., 123-45-6789)
- **[A-Za-z]\w{5,}** : Matches a string with at least 6 characters starting with a letter
- **(foo|bar)** : Matches either 'foo' or 'bar'

## Escape Sequences

- **\\** : Escape special characters
- **\n** : Newline
- **\r** : Carriage return
- **\t** : Tab

## Sample Regex Patterns

1. **Email Validation:**
   ```regex
   ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
   ```
2. **URL Validation:**
   ```regex
   ^(https?|ftp)://[^\s/$.?#].[^\s]*$
   ```
3. **Phone Number Validation (US):**
   ```regex
   ^\(\d{3}\) \d{3}-\d{4}$
   ```
4. **Date Validation (YYYY-MM-DD):**
   ```regex
   ^\d{4}-\d{2}-\d{2}$
   ```

This cheat sheet should help you get started with regular expressions and serve as a quick reference for commonly used patterns and syntax.