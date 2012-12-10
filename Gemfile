source "http://rubygems.org"

gemspec

gem "rake", "~> 10.0"
gem "minitest"
gem "minitest-reporters"
gem "em-websocket"
gem "guard"
gem "guard-minitest"
gem "guard-markdown"
gem "guard-livereload"
gem "simplecov", :require => false

if File.exists?('Gemfile.local')
  instance_eval File.read('Gemfile.local')
end

