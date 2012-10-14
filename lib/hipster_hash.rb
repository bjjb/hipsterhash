# -*- encoding : utf-8 -*-
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/string/inflections'

class HipsterHash < HashWithIndifferentAccess
  def [](key, *extras)
    super(convert_key(key), *extras)
  end

protected
  def convert_key(k)
    k.to_s.underscore.to_sym
  end
end
