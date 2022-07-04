# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |test|
  test.pattern = "test/test_*.rb"
end

desc "Run tests"
task default: :test
