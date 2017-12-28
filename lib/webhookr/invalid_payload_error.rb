# frozen_string_literal: true

module Webhookr
  class InvalidPayloadError < RuntimeError
    def initialize(payload)
      super("'#{payload.inspect}' is not valid")
    end
  end
end
