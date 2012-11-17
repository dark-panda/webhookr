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

  s.add_dependency "rails", "~> 3.1"
  s.add_development_dependency("rake", ["~> 10.0"])
  s.add_development_dependency("guard")
  s.add_development_dependency("guard-test")
  s.add_development_dependency("rb-fsevent")
  s.add_development_dependency("guard-markdown")
  s.add_development_dependency("guard-livereload")
end
