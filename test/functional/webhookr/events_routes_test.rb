require 'test_helper'

module Webhookr
  class EventsRoutesTest < ActionController::TestCase

    def setup
      @routes = Webhookr::Engine.routes
    end

    test ":get route to events" do
      assert_recognizes({ :controller => "webhookr/events", :action => "show", :service_id => "service_id" },
                        { :path => "/events/service_id", :method => :get })
    end

    test ":post route to events" do
      assert_recognizes({ :controller => "webhookr/events", :action => "create", :service_id => "service_id" },
                        { :path => "/events/service_id", :method => :post })
    end

  end
end
