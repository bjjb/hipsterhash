#! /usr/bin/env ruby -w
require 'benchmark'
require_relative '../lib/hipsterhash'

h = { foo: { bar: { x: "123", y: [ 1, 2, 3 ] } }, baz: "123" }
hh = HipsterHash[h.dup]

n = 1000000
Benchmark.bmbm do |x|
  x.report("Hash#[]                   ") { n.times { h[:foo][:bar][:x] } }
  x.report("HipsterHash#[]            ") { n.times { hh[:foo][:bar][:x] } }
  x.report("Hash#fetch                ") { n.times { h.fetch(:foo).fetch(:bar).fetch(:x) } }
  x.report("HipsterHash#fetch         ") { n.times { hh.fetch(:foo).fetch(:bar).fetch(:x) } }
  x.report("HipsterHash#fetch2        ") { n.times { hh.fetch(:"Foo").fetch(:"Bar").fetch(:"X") } }
  x.report("HipsterHash#method_missing") { n.times { hh.foo.bar.x } }
end
