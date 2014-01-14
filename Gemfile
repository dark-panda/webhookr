source "http://rubygems.org"

gemspec

group :development, :test do
  gem "rails", ENV['RAILS_VERSION'] || "4.0.0"
  gem "rake", "~> 10.0"
  gem "minitest", ENV['MINITEST_VERSION'] || "~> 4.0"
  gem "minitest-reporters"
  gem "em-websocket"
  gem "guard"
  gem "guard-minitest"
  gem "guard-markdown"
  gem "guard-livereload"
  gem "simplecov", :require => false
  gem 'coveralls', :require => false
end

if File.exists?('Gemfile.local')
  instance_eval File.read('Gemfile.local')
end

