require 'rake'
require 'rake/testtask'

task :default => [:test_unit]

desc "Run basic tests"
Rake::TestTask.new("test_unit") { |t|
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = true
}