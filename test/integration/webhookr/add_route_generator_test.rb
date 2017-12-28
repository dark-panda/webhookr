# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'
require 'generators/webhookr/add_route_generator'

class InitGeneratorTest < Rails::Generators::TestCase
  tests Webhookr::Generators::AddRouteGenerator
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  setup :prepare_destination

  test 'it should add the engine to routes' do
    run_generator
    # TODO: Not sure how to confirm the route was added, so just run it for now
  end
end
