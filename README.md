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

Docspec expects one or more Markdown files with embedded code snippets to 
test.

Code snippets should be enclosed in a `ruby` or `shell` code fence:

    ```ruby
    puts "code to test (should output something)"
    #=> code to test (should output something)
    ```

This document itself serves as the test suite for this gem, so you can take a
look at its source.


### Testing with the `docspec` command line

Test the examples in `./README.md`:

    $ docspec

Test a different file:

    $ docspec TESTS.md


### Testing from Ruby code

```ruby
# Running from Ruby code
document = Docspec::Document.from_file 'sample.md'
document.test
#=> pass : Sample Test

puts document.success?
#=> true
```


Examples
--------------------------------------------------

Code examples that you want to test, should output something to stdout. 
Specify the expected output by prefixing it with `#=>`:

```ruby
# The first line is an optional label
puts 'hello world'.upcase
#=> HELLO WORLD
```

If an example raises an exception, the captured output will be the `#inspect`
string of that exception:

```ruby
# Exceptions are captured
raise ArgumentError, "Testing error raising"
#=> #<ArgumentError: Testing error raising>
```

Your code and expected output can contain multiple lines of code:

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

and you can alternate between code and expected output:

```ruby
# Interleaving code and output 
puts 2 + 3
#=> 5

puts 2 - 3
#=> -1
```

or have the expected output in the same line as its code:

```ruby
puts 2 * 3    #=> 6
puts 'works'  #=> works
```

The first line of the example may contain specially formatted flags. Flags 
are always formatted like this: `[:flag_name]`. 

The `[:ignore_failure]` flag allows the example to fail. It will show the 
failure in the output, but will not elevate the exit status to a failure 
state:

```ruby
# This example may fail [:ignore_failure]
# Due to the :ignore_failure flag, it will show the failure diff, but will
# not be considered a failure in the exit status.
puts 'hello world'.upcase
#=> hello world
```

Another available flag, is the `[:skip]` flag, which will omit the example
from the test run:

```ruby
# [:skip]
this will not be executed
```

Sometimes it is useful to build the example over several different code 
blocks. To help achieve this, docspec will treat any example that does not 
expect any output (no `#=> markers`) as a code that needs to be executed
before all subsequent examples:

```ruby
# Define functions or variables for later use
def create_caption(text)
  [text.upcase, ("=" * text.length)].join "\n"
end

message = 'tada!'
```

All the examples below this line, will have the above function available:

```ruby
# Use a previously defined function or variable
puts create_caption message
#=> TADA!
#=> =====
```


Examples marked with a `shell` code fence will be executed by the
shell, and not by ruby:

```shell
# Shell commands
echo hello world
#=> hello world
```

and they also support chaining of examples:

```shell
# Prepend shell example to all subsequent shell examples
# (since this example does not define an expected output)
SOME_ENV_VAR=yes
```

```shell
echo $SOME_ENV_VAR
#=> yes
```

