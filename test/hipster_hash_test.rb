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
    hh = HipsterHash.new(:foo => "bar")
    assert_equal "bar", hh["foo"]
    hh['foo'] = "baz"
    assert_equal "baz", hh[:foo]
  end

  def test_nesting
    hh = HipsterHash.new(:foo => { :bar => :baz })
    assert_kind_of HipsterHash, hh[:foo]
    assert_equal :baz, hh["Foo"][:Bar]
  end

  def test_case_indifference
    hh = HipsterHash.new
    hh[:foo_bar] = "bar"
    assert_equal "bar", hh["FooBar"]
    hh['FooBar'] = "baz"
    assert_equal "baz", hh[:foo_bar]
  end

  def test_creation_with_a_hash
    hh = HipsterHash.new(:foo_bar => "Bar")
    assert_equal "Bar", hh["FooBar"]
  end

  def test_subclassing
    hc = Class.new(HipsterHash)
    hh = hc.new(:foo_bar => "Baz")
    assert_equal "Baz", hh["FooBar"]
  end

  def test_method_missing
    hh = HipsterHash.new(:Foo => :bar)
    assert_equal :bar, hh.foo
    assert_equal :bar, hh.FOO
  end
end
