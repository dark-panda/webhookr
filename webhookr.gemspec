# frozen_string_literal: true

require File.expand_path('lib/webhookr/version', __dir__)

Gem::Specification.new do |s|
  s.name = 'webhookr'
  s.version = Webhookr::VERSION

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.required_ruby_version = '>= 2.5.0'
  s.authors = ['J Smith']
  s.email = ['dark.panda@gmail.com']
  s.description = 'Webhookr - easily and securely add webhooks to your Rails app.'
  s.summary = s.description

  s.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  s.executables = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.homepage = 'http://github.com/dark-panda/webhookr'
  s.require_paths = ['lib']

  s.add_dependency 'rails', ['>= 3.1']
  s.add_dependency 'securecompare'
end
