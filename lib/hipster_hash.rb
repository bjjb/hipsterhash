# -*- encoding : utf-8 -*-
require 'active_support/core_ext/string/inflections'

# A HipsterHash is like a regular Hash, except the keys are semi case
# insensitive, and symbols and strings are equivalent. Therefore, :foo_bar,
# :FooBar, and "foo_bar" are considered to be the same key.
class HipsterHash < Hash
  def initialize(initial = {}, &block)
    case initial
    when Hash 
      super(&block)
      initial.each { |k, v| self[k] = v }
    else
      super
    end
  end

  def [](key)
    convert_value(super(convert_key(key)))
  end

  def []=(key, value)
    super(convert_key(key), value)
  end

  def method_missing(sym, *args, &block)
    if args.empty? and !block_given?
      self[sym] || super
    else
      super
    end
  end

protected
  def convert_key(k)
    self.class.convert_key(k)
  end

  def self.convert_key(k)
    k.to_s.underscore.to_sym
  end

  def self.convert_value(arg)
    case arg
      when Hash then new(arg)
      when Array then arg.map { |a| convert_value(a) }
      else arg
    end
  end

  def convert_value(arg)
    self.class.convert_value(arg)
  end
end
