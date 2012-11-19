require 'test_helper'
require 'stubs/service_under_test_stubs'

module Webhookr
  class EventsControllerTest < ActionController::TestCase
    
    include Webhookr::Services::ServiceUnderTest

    def setup
      @routes = Webhookr::Engine.routes
    end

    test ":get with no service id should return a ActionController::RoutingError" do
      assert_raise(ActionController::RoutingError) {
        get(:show)
      }
    end
    
    test ":get with an unknown service id should return a ActionController::RoutingError" do     
      assert_raise(ActionController::RoutingError) {
        get(:show, {:service_id => "blort"})
      }
    end
    
    test ":get with known service id should return success and an empty body" do
      get(:show, {:service_id => stub.service_name})
      assert_response :success
      assert(@response.body.blank?, "Expected an empty reponse, but got'#{@response.body}'")
    end

    test ":post with valid payload should return success" do
      PlainOldCallBackClass.reset!
      Webhookr::Services::ServiceUnderTest.callback = PlainOldCallBackClass
      post(:create, {
                      :service_id => stub.service_name,
                      :event => stub.event
                    }
           )
      assert_equal 1, PlainOldCallBackClass.call_count
    end
  end
end
