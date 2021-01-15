# frozen_string_literal: true

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
])
SimpleCov.command_name('Webhookr Tests')
SimpleCov.start

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('dummy/config/environment.rb', __dir__)
require 'rails/test_help'
require 'rails/generators/test_case'
require 'minitest/reporters'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)

puts "Webhookr #{Webhookr::VERSION}"
puts "Rails #{Rails::VERSION::STRING}"
puts "Ruby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} - #{RbConfig::CONFIG['RUBY_INSTALL_NAME']}"
