Docspec
==================================================

[![Gem Version](https://badge.fury.io/rb/docspec.svg)](https://badge.fury.io/rb/docspec)
[![Build Status](https://travis-ci.com/DannyBen/docspec.svg?branch=master)](https://travis-ci.com/DannyBen/docspec)
[![Maintainability](https://api.codeclimate.com/v1/badges/e0c15c1f33fa4aa45f70/maintainability)](https://codeclimate.com/github/DannyBen/docspec/maintainability)

Docspec lets you reuse your Markdown documents as the unit tests for your
Ruby library.

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
- If the first line of a code block includes the string `[:ignore_failure]`, 
  the example will not be considered an error if it fails.

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
# This example may fail [:ignore_failure]
# Due to the :ignore_failure flag, it will show the failure diff, but will
# not be considered a failure in the exit status.
puts 'hello world'.upcase
#=> hello world
```

```ruby
# This example must fail [:must_fail]
puts "this is a success"
#=> this is a failure
```

```ruby
# Code that does not generate any output will be executed before each
# of the subsequent examples.
def create_caption(text)
  [text.upcase, ("=" * text.length)].join "\n"
end
```

```ruby
# Example that builds upon code that was defined earlier
puts create_caption "tada!"
#=> TADA!
#=> =====
```


### Shell

```shell
# Shell commands
echo hello world
#=> hello world
```
