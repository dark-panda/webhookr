
require 'test_helper'

module Webhookr
  class EventsRoutesTest < ActionController::TestCase

    def setup
      @routes = Webhookr::Engine.routes
      @show_controller = { format: "json", controller: "webhookr/events", action: "show", service_id: "service_id" }
      @show_controller_with_token = @show_controller.merge(security_token: "secure")
      @create_controller = { format: "json", controller: "webhookr/events", action: "create", service_id: "service_id" }
      @create_controller_with_token = @create_controller.merge(security_token: "secure")
      @path = "/events/service_id"
      @path_with_token = "/events/service_id/secure"
    end

    test ":get route to events" do
      assert_recognizes(@show_controller, path: @path, method: :get)
    end

    test ":get route to events with optional :security_token" do
      assert_recognizes(@show_controller_with_token, path: @path_with_token, method: :get)
    end

    test ":post route to events" do
      assert_recognizes(@create_controller, path: @path, method: :post)
    end

    test ":post route to events with optional :security_token" do
      assert_recognizes(@create_controller_with_token, path: @path_with_token, method: :post)
    end
  end
end

