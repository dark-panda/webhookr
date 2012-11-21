$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "webhookr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  gem.name          = "webhookr"
  gem.version       = Webhookr::Services::Mailchimp::VERSION
  gem.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  gem.authors       = ["Gerry Power"]
  gem.email         = ["code@zoocasa.com"]
  gem.description   = "A Rails Engine to enable webhooks from supported third-party services to your application."
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/zoocasa/webhookr"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  s.add_dependency "rails", ["~> 3.1"]
  s.add_development_dependency("rake", ["~> 10.0"])
  s.add_development_dependency("guard")
  s.add_development_dependency("guard-test")
  s.add_development_dependency("rb-fsevent")
  s.add_development_dependency("guard-markdown")
  s.add_development_dependency("guard-livereload")
end
