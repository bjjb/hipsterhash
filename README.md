# Hipsterhash

A completely indifferent Hash.

## Installation

Add this line to your application's Gemfile:

    gem 'hipsterhash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hipsterhash

## Usage

```ruby
hh = HipsterHash.new
hh[:foo_bar] = "Pigs"
hh["FooBar"] # => "Pigs"
```

It uses [ActiveSupport][1] [Inflectors][2] internally, so you can probably muck
around with them to modify the behaviour.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: https://github.com/rails/rails/tree/master/activesupport/lib/active_support
[2]: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/inflections.rb
