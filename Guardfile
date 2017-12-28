
guard 'minitest', test_folders: 'test', test_file_patterns: '*_test.rb' do
  watch(%r|^test/(.+)_test\.rb|)
  watch(%r|^test/stubs/(.+)\.rb$|) { 'test' }

  # Rails
  watch(%r{^app/models/(.+)\.rb$}) do |m|
    "test/unit/#{m[1]}_test.rb"
  end

  watch(%r{^app/controllers/(.+)\.rb$}) do |m|
    "test/functional/#{m[1]}_test.rb"
  end

  watch('config/routes.rb') do
    ['test/functional', 'test/integration']
  end
end

guard 'livereload' do
  watch('README.html')
end

guard 'markdown', convert_on_start: true do
  watch('README.md') { './README.md|./README.html' }
end

instance_eval File.read('Guardfile.local') if File.exist?('Guardfile.local')
