#! /usr/bin/env ruby -w

require_relative '../lib/hipsterhash'


require 'profile'
hh = HipsterHash[foo: { bar: { x: "123" } }]

n = 1000
n.times do
  hh.foo["Bar"].x
end
