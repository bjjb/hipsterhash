#!/usr/bin/env rake
# -*- encoding : utf-8 -*-

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Run profiler to see what's slow"
task :profile do
  require_relative './test/profile'
end

desc "Run benchmarks against Hash"
task :performance do
  require_relative './test/performance'
end

task :default => :test
