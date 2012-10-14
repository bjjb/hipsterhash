# -*- encoding : utf-8 -*-
require 'test/unit'
require File.expand_path('../../lib/hipster_hash', __FILE__)

class HipsterHashTest < Test::Unit::TestCase
  def test_normal_behaviour
    hh = HipsterHash.new
    hh["foo"] = "bar"
    assert_kind_of Hash, hh
    assert_equal "bar", hh[:foo]
    assert_nil hh[:pigs]
  end

  def test_indifference_to_input_type
    hh = HipsterHash.new({ :foo => "bar" })
    assert_equal "bar", hh["foo"]
    hh['foo'] = "baz"
    assert_equal "baz", hh[:foo]
  end

  def test_case_indifference
    hh = HipsterHash.new
    hh[:foo_bar] = "bar"
    assert_equal "bar", hh["FooBar"]
    hh['FooBar'] = "baz"
    assert_equal "baz", hh[:foo_bar]
  end
end
