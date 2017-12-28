# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'
require 'stubs/service_under_test_stubs'

module Webhookr
  class EventsControllerTest < ActionController::TestCase
    include Webhookr::ServiceUnderTest

    def setup
      @routes = Webhookr::Engine.routes
      PlainOldCallBackClass.reset!
      Webhookr::ServiceUnderTest::Adapter.config.security_token = nil
      @security_token = 'secure_blort'
    end

    test ':get with no service id should return a ActionController::RoutingError' do
      assert_raise(ActionController::RoutingError) do
        get(:show, params: { service_id: '' })
      end
    end

    test ':get with an unknown service id should return a ActionController::RoutingError' do
      assert_raise(ActionController::RoutingError) do
        get(:show, params: { service_id: 'blort' })
      end
    end

    test ':get with known service id should return success and an empty body' do
      get(:show, params: { service_id: stub.service_name })
      assert_response :success
      assert(@response.body.blank?, "Expected an empty reponse, but got '#{@response.body}'")
    end

    test ':post with valid payload should return success' do
      PlainOldCallBackClass.reset!
      Webhookr::ServiceUnderTest::Adapter.config.callback = PlainOldCallBackClass
      post(
        :create,
        params: {
          service_id: stub.service_name,
          event: stub.event_type,
          data: {
            email: stub.email
          }
        }
      )
      assert_equal 1, PlainOldCallBackClass.call_count
    end

    test ':get with :security_token configured and not passed should return :InvalidAuthenticityToken' do
      Webhookr::ServiceUnderTest::Adapter.config.security_token = @security_token

      assert_raise(ActionController::InvalidAuthenticityToken) do
        get(:show, params: { service_id: stub.service_name })
      end
    end

    test ':get with :security_token configured and passed should return :success' do
      Webhookr::ServiceUnderTest::Adapter.config.security_token = @security_token
      get(
        :show,
        params: {
          service_id: stub.service_name,
          security_token: @security_token
        }
      )
      assert_response(:success)
    end
  end
end
