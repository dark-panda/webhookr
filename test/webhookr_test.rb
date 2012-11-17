require 'test_helper'

class WebhookrTest < ActiveSupport::TestCase
  test "should have Webhookr::Config module" do
    assert_kind_of Module, Webhookr::Config
  end
  
  test "should have a basic_auth hash" do
    assert_kind_of Hash, Webhookr::Config.basic_auth
  end
end
