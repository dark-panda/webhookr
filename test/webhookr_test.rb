require 'test_helper'

class WebhookrTest < ActiveSupport::TestCase
  test "should have Webhookr configuration" do
    assert_kind_of Hash, Webhookr.config
  end
  
  test "should have a basic_auth hash" do
    assert_kind_of Hash, Webhookr.config.basic_auth
  end
end
