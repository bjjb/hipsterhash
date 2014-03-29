# -*- encoding : utf-8 -*-

# A HipsterHash is like a regular Hash, except the keys are semi case
# insensitive, and symbols and strings are equivalent. Therefore, :foo_bar,
# :FooBar, and "foo_bar" are considered to be the same key.
class HipsterHash < Hash

  alias store! store

  def store(key, value)
    memoize(key) do
      k, v = convert_key(key), convert_value(value)
      store!(k, v)
    end
  end

  def []=(key, value)
    memoize(key) do
      k, v = convert_key(key), convert_value(value)
      store!(k, v)
    end
  end

  def fetch(key)
    super rescue super(convert_key(key)).tap { |v| store!(key, v) }
  end

  def [](key)
    super || super(convert_key(key)).tap { |v| store!(key, v) }
  end

  def key?(sym)
    super || super(convert_key(sym))
  end

  def self.[](*args)
    new.tap { |hh| Hash[*args].each { |k, v| hh.store(k, v) } }
  end

protected
  
  def method_missing(sym, *args, &block)
    return super if block_given?
    return store(sym[0...-1], args.first) if sym[-1] == '=' and args.length == 1
    return fetch(sym) if args.empty? and key?(sym)
    super
  end

  def converted_keys
    @converted_keys ||= Hash.new do |h, k|
      h[k] = underscore(k.to_s).to_sym
    end
  end

  def convert_key(k)
    converted_keys[k]
  end

  def self.convert_value(arg)
    case arg
      when self then arg
      when Hash then self[arg]
      when Array then arg.map { |x| convert_value(x) }
      else arg
    end
  end

  def convert_value(arg)
    self.class.convert_value(arg)
  end

  def underscore(s)
    s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z])([A-Z])/, '\1_\2').downcase
  end

  def memoize(sym, &block)
    yield.tap do |x|
      eigenklass.class_eval { define_method(:"#{sym}") { x } } unless @@unmemoizable.key?(convert_key(sym))
    end
  end

  def eigenklass
    @eigenklass ||= (class << self; self; end)
  end

  @@unmemoizable = Hash[[methods + instance_methods].flatten.uniq.zip([])]
end
