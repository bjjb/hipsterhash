# -*- encoding : utf-8 -*-
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/string/inflections'

# A HipsterHash is like a regular Hash, except the keys are semi case
# insensitive, and symbols and strings are equivalent. Therefore, :foo_bar,
# :FooBar, and "foo_bar" are considered to be the same key.
class HipsterHash < HashWithIndifferentAccess
  def [](key, *extras)
    super(convert_key(key), *extras)
  end

protected
  def convert_key(k)
    k.to_s.underscore.to_sym
  end
end
