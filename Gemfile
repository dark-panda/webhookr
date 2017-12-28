source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'coveralls', require: false
  gem 'em-websocket'
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-markdown'
  gem 'guard-minitest'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'rake', '~> 10.0'
  gem 'simplecov', require: false
end

instance_eval File.read('Gemfile.local') if File.exist?('Gemfile.local')
