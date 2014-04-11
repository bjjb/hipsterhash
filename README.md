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

## Performance

A HipsterHash is pretty quick - faster than an OpenStruct (and more, like,
sure, man), but not as fast as a Hash. And writing is *slow*. It's nifty for
scenarios like configuration objects that get created once, and accessed many
times.

Run the performance.rb script in the test directory for a gander.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Build Status](https://travis-ci.org/bjjb/hipsterhash.svg?branch=master)](https://travis-ci.org/bjjb/hipsterhash)
