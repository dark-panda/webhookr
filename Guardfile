
guard 'minitest', :test_folders => 'test', :test_file_patterns => '*_test.rb' do
  watch(%r|^test/(.+)_test\.rb|)
  watch(%r|^test/stubs/(.+)\.rb$|) { "test" }

  # Rails
  watch(%r{^app/models/(.+)\.rb$}) { |m|
    "test/unit/#{m[1]}_test.rb"
  }

  watch(%r{^app/controllers/(.+)\.rb$}) { |m|
    "test/functional/#{m[1]}_test.rb"
  }

  watch('config/routes.rb') {
    ["test/functional", "test/integration"]
  }
end

guard 'livereload' do
  watch('README.md')
end
