Docspec
==================================================

[![Gem Version](https://badge.fury.io/rb/docspec.svg)](https://badge.fury.io/rb/docspec)

Inline tests in Markdown documents.

---


Installation
--------------------------------------------------

    $ gem install docspec


Usage
--------------------------------------------------

Add ruby or shell code blocks to your `README.md` document, then run 
`docspec` to evaluate them.


Rules
--------------------------------------------------

- Anything outside of a code fence is ignored.
- Both `ruby` and `shell` code blocks are supported.
- Inside a code block, any piece of code that we care about should print
  something.
- Inside a code block, anything starting with `#=>` should define the 
  expected output.
- If a piece of code raises an error, the captured output will be the 
  `#inspect` string of that exception.

To test the `README.md` in the current folder, just run:

    $ docspec

To test a different file, provide it as the first argument:

    $ docspec TESTS.md


Examples
--------------------------------------------------

These will be tested with `docspec`:

### Ruby

```ruby
# The first line is an optional label
puts 'hello world'.upcase
#=> HELLO WORLD
```

```ruby
# Exceptions are captured
raise ArgumentError, "Testing error raising"
#=> #<ArgumentError: Testing error raising>
```

```ruby
# Multiple lines of code
string = "hello"
3.times do 
  puts string
end
#=> hello
#=> hello
#=> hello
```

```ruby
# Interleaving code and output 
puts 2 + 3
#=> 5

puts 2 - 3
#=> -1
```

```ruby
# This example should fail
puts 'hello world'.upcase
#=> hello world
```

### Shell

```shell
# Shell commands
echo hello world
#=> hello world
```
