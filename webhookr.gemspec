$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "webhookr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "webhookr"
  s.version     = Webhookr::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Webhookr."
  s.description = "TODO: Description of Webhookr."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  # s.add_dependency "jquery-rails"
end
