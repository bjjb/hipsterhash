# -*- encoding : utf-8 -*-
require 'test_helper'
require 'hipster_hash'

describe HipsterHash do
  it "acts like a hash" do
    hh = HipsterHash.new
    hh.must_be_kind_of Hash
    hh.store(:foo, :bar)
    hh.fetch(:foo).must_equal :bar
    hh[:bar] = 123
    hh[:bar].must_equal 123
    hh.keys.must_equal [:foo, :bar]
    hh.delete(:foo).must_equal :bar
    hh.keys.must_equal [:bar]
    lambda { hh.fetch(:foo) }.must_raise KeyError
    lambda { hh.fetch('foo') }.must_raise KeyError
    lambda { hh.fetch('Foo') }.must_raise KeyError
    hh[:foo].must_be_nil
    hh = HipsterHash[:foo, 123, :bar, 234]
    hh[:foo].must_equal 123
    hh[:bar].must_equal 234
    hh.fetch(:foo).must_equal 123
    hh.fetch('foo').must_equal 123
    hh.fetch('Foo').must_equal 123
    hh = HipsterHash[[[:foo, 123], [:bar, 234]]]
    hh[:foo].must_equal 123
    hh[:bar].must_equal 234
    hh = HipsterHash[{foo: 123, bar: 234}]
    hh[:foo].must_equal 123
    hh[:bar].must_equal 234
    hh[:bar] = 77
    hh[:bar].must_equal 77
  end

  it "treats symbols and strings equally" do
    hh = HipsterHash[foo: "bar"]
    hh.keys.must_equal [:foo]
    hh.key?(:foo).must_equal true
    hh.foo.must_equal "bar"
    hh['foo'] = 'baz'
    hh.keys.must_equal [:foo]
    hh[:foo].must_equal "baz"
  end

  it "handles nested hashes" do
    hh = HipsterHash[foo: { bar: :baz }]
    hh.foo.must_be_kind_of HipsterHash
    hh["Foo"][:Bar].must_equal :baz
  end

  it "handles nested arrays" do
    hh = HipsterHash[{foo: { bar: [ { baz: 1 } ] }}]
    hh.foo.must_be_kind_of HipsterHash
    hh.foo.bar[0].baz.must_equal 1
    hh = HipsterHash[{"foo" => { "bar" => [ { "baz" => 1 } ] }}]
    hh.foo.bar[0].baz.must_equal 1
  end

  it "is indifferent to case" do
    hh = HipsterHash.new
    hh[:foo_bar] = "bar"
    hh["FooBar"].must_equal "bar"
    hh['FooBar'] = "baz"
    hh[:foo_bar].must_equal "baz"
  end

  it "can be inherited" do
    hc = Class.new(HipsterHash)
    hh = hc[foo_bar: "Baz"]
    hh[:foo_bar].must_equal "Baz"
    hh[:FooBar].must_equal "Baz"
    hh["FooBar"].must_equal "Baz"
    hh["foo_bar"].must_equal "Baz"
    hh.foo_bar.must_equal "Baz"
  end

  it "acts like an openstruct" do
    hh = HipsterHash[:foo, 123]
    hh.bar = 234
    hh.foo.must_equal 123
    hh.bar.must_equal 234
    lambda { hh.baz }.must_raise NoMethodError
    hh[:foo] = "bar"
    hh.foo.must_equal "bar"
    hh.foo = "baz"
    hh.foo.must_equal "baz"
    hh.store("foo", "bpb")
    hh.foo.must_equal "bpb"
    hh2 = HipsterHash[:foo, 999]
    hh2.foo.must_equal 999
    hh.foo.must_equal "bpb"
  end

  it "doesn't break if you use a special method name" do
    hh = HipsterHash.new
    hh[:foo] = 1
    hh.foo.must_equal 1
    m = hh.method(:[])
    hh['[]'] = "blah"
    hh.method(:[]).must_equal m
    hh.foo.must_equal 1
    hh['[]'].must_equal "blah"
    hh.eigenklass = "blah"
    hh.foo.must_equal 1
    hh.foo = 2
    hh.foo.must_equal 2
  end

  it "doesn't break with funny keys" do
    hh = HipsterHash.new
    hh[0] = 1
    hh[0].must_equal 1
    hh[":blah"] = 99
    hh.send(":blah").must_equal 99
    hh[nil] = "klm"
    hh[nil].must_equal "klm"
    hh[:'→'] = "arrow"
    hh.send('→').must_equal 'arrow'
  end

  describe "key conversion" do
    it "leaves underscored symbols alone" do
      convert(:foo).must_equal :foo
    end
    it "converts underscored strings to symbols" do
      convert("foo").must_equal :foo
    end
    it "underscores camelcase symbols" do
      convert(:FooBar).must_equal :foo_bar
    end
    it "underscores and symbolizes camelcased strings" do
      convert("FooBar").must_equal :foo_bar
    end
    def convert(k)
      HipsterHash.new.send(:convert_key, k)
    end
  end
end
