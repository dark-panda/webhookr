require 'test_helper'

class AdapterResponseTest < ActiveSupport::TestCase
  def setup
    @subject = Webhookr::AdapterResponse.new("service_name", "event_type", "payload")
  end

  test "should respond to event_type" do
    assert_respond_to(@subject, :event_type)
  end

  test "should respond to payload" do
    assert_respond_to(@subject, :payload)
  end

  test "should respond to service_name" do
    assert_respond_to(@subject, :service_name)
  end

end