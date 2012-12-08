
$: << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'
require 'generators/webhookr/init_generator'

class InitGeneratorTest < Rails::Generators::TestCase
  tests Webhookr::Generators::InitGenerator
  destination File.expand_path("../../../tmp", File.dirname(__FILE__))
  setup :prepare_destination

  def setup
    @name = "test_initializer"
    @initializer = "config/initializers/#{@name}.rb"
    run_generator Array.wrap(@name)
  end

  test "it should create the initializer" do
    assert_file @initializer
  end

  test "it should have authorization information" do
    assert_file @initializer do |content|
      assert_match(%r{basic_auth\.username}, content)
      assert_match(%r{basic_auth\.password}, content)
    end
  end
end