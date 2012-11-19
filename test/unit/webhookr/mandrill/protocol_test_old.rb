require 'test_helper'

module Webhookr
  class Mandrill::ProtocolTest < ActiveSupport::TestCase

    def setup
      @fired_at = "2009-03-26 22:01:00"
      @event_type = "spam"
      @single_response = '{ "event": "' + @event_type + '", "ts": "' + @fired_at + '", "msg": { "email": "gerry%2Bagent1@zoocasa.com" }} '
      @valid_response = 'mandrill_events=[' + @single_response + ']' 
      @valid_responses = 'mandrill_events=[' + @single_response + ',' + @single_response + ']' 
    end

    test "should not raise an exception for a valid packet" do
      assert_nothing_raised { Webhookr::Mandrill::Protocol.process(@valid_response) }
    end

    test "should process multiple responses" do
      responses = Webhookr::Mandrill::Protocol.process(@valid_responses)
      assert_equal(responses.size, 2)
    end

    test "should return the correct data type" do
      response = Webhookr::Mandrill::Protocol.process(@valid_response).first
      assert_equal(response.event_type, @event_type)
    end

    test "should have the correct protocol" do
      response = Webhookr::Mandrill::Protocol.process(@valid_response).first
      assert_equal(response.protocol, "Webhookr::Mandrill::Protocol")
    end

    test "should have the correct event fired date" do
      response = Webhookr::Mandrill::Protocol.process(@valid_response).first
      assert_equal(response.fired_at, @fired_at)
    end

    test "should raise Webhookr::InvalidProtocolError for no packet" do
      assert_raise(Webhookr::InvalidProtocolError) {
        Webhookr::Mandrill::Protocol.process("")
      }
    end

    test "should raise MailObserver::InvalidProtocolError for a missing event type" do
      assert_raise(Webhookr::InvalidProtocolError) {
        Webhookr::Mandrill::Protocol.process('mandrill_events=[ { "msg": { "email": "gerry%2Bagent1@zoocasa.com" }} ]')
      }
    end

    test "should raise MailObserver::InvalidProtocolError for a missing data packet" do
      assert_raise(Webhookr::InvalidProtocolError) {
        Webhookr::Mandrill::Protocol.process('mandrill_events=[ { "event": "spam" } ]')
      }
    end

  end
end
