require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:cucumber)

require 'rspec/core/rake_task'
rspec = RSpec::Core::RakeTask.new
rspec.rspec_opts = "--require spec_helper"

task :test => %w[cucumber spec]

task :default => :test
