require 'test_helper'

module Webhookr
  class EventsControllerTest < ActionController::TestCase

    def setup
      @routes = Webhookr::Engine.routes
    end

    test ":get route to events" do
      assert_recognizes({ controller: "webhookr/events", action: "show", id: "mandrill" },
                        { path: "/events/mandrill", method: :get })
    end

    test ":post route to events" do
      assert_recognizes({ controller: "webhookr/events", action: "create", id: "mandrill" },
                        { path: "/events/mandrill", method: :post })
    end

    test ":get should return success" do
      get(:show, {:id => "madrill"})
      assert_response :success
    end

    test ":get should return empty body" do
      get(:show, {:id => "madrill"})
      assert_response :success
      assert(@response.body.blank?, "Expected an empty reponse, but got'#{@response.body}'")
    end

    test ":post should return success" do
      post(:create, {:id => "madrill"})
      assert_response :success
    end
  end
end
