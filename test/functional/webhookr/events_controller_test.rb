require 'test_helper'

module Webhookr
  class EventsControllerTest < ActionController::TestCase

    def setup
      @routes = Webhookr::Engine.routes
    end

    test ":get should return success" do
      get(:show, {:id => "mandrill"})
      assert_response :success
    end

    test ":get should return empty body" do
      get(:show, {:id => "mandrill"})
      assert_response :success
      assert(@response.body.blank?, "Expected an empty reponse, but got'#{@response.body}'")
    end

  end
end
