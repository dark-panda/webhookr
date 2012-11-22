module Webhookr
  class Service
    attr_reader :service_name

    def initialize(service_name, options = Hash.new(""))
      @service_name = (service_name || "").downcase
      @raw_payload = options[:payload]
      available?
    end

    def process!
      Array.wrap(service_adapter.send(:process, @raw_payload)).each do |payload|
        callback(callback_class, payload)
      end
    end

    private

    def callback(object, payload)
      method = method_for(payload)
      object.send(method, payload) if object.respond_to?(method)
    end

    def method_for(payload)
      "on_" + payload.event_type
    end

    def callback_class
      callback = Webhookr.config[service_name].try(:callback)
      raise "No callback is configured for the service '#{service_name}'." if callback.nil?
      @call_back_class || callback.new
    end

    def service_adapter
      if defined?(@service_adapter)
        @service_adapter
      else
        raise NameError.new(%{Bad service name "#{service_name}"}) unless Webhookr.adapters[service_name]

        @service_adapter = Webhookr.adapters[service_name]
      end
    end

    alias_method :available?, :service_adapter

  end
end
