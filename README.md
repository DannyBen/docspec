Docspec
==================================================

Rules:

- Anything outside of a ruby code fence is ignored.
- Inside a code block, anything piece of code that we care about should 
  print something to screen.
- Inside a code block, anything starting with `#=>` should define the 
  expected output.
- If a piece of code raises an error, the captured output will be
  formatted as `ExceptionType: message`.

```ruby
# Ths first line is an optional label
puts 'hello world'.upcase
#=> HELLO WORLD
```

```ruby
# Exceptions are captured
raise ArgumentError, "Testing error raising"
#=> ArgumentError: Testing error raising
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
