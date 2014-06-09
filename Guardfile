
guard 'minitest', test_folders: 'test', test_file_patterns: '*_test.rb' do
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
  watch('README.html')
end

guard 'markdown', convert_on_start: true do
 watch ('README.md') { "./README.md|./README.html" }
end

if File.exists?('Guardfile.local')
  instance_eval File.read('Guardfile.local')
end

