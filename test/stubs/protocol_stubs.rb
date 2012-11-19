module Webhookr
  module NoOpStubService
    mattr_accessor :callback
    class Protocol

      def self.process(raw_response)
        return []
      end

    end
  end
end
