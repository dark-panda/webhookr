
# -*- ruby -*-

require 'rubygems'
require 'rubygems/package_task'
require 'rake/testtask'
require 'rdoc/task'
require 'bundler/gem_tasks'

$:.push File.expand_path(File.dirname(__FILE__), 'lib')

version = Webhookr::VERSION

desc 'Test Webhookr'
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = !!ENV['VERBOSE_TESTS']
  t.warning = !!ENV['WARNINGS']
end

desc 'Build docs'
Rake::RDocTask.new do |t|
  t.main = 'README.md'
  t.title = "Webhookr #{version}"
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README.md', 'MIT-LICENSE', 'lib/**/*.rb')
end

namespace :webhookr do
  namespace:test do
    desc 'Install gems in all Rubies'
    task :install do
      sh %{rbenv each -v bundle install}
    end

    desc 'Test with all Rubies'
    task :test_versions do
      sh %{rbenv each -v bundle exec rake test}
    end

    desc 'Install and test all'
    task all: [:install, :test_versions]
  end
end

task default: :test
