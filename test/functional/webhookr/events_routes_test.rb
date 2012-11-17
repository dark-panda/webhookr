require 'test_helper'

module Webhookr
  class EventsRoutesTest < ActionController::TestCase

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

  end
end
