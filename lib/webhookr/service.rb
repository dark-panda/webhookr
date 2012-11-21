module Webhookr
  class Service
    attr_reader :service_name

    def initialize(service_name, options = Hash.new(""))
      @service_name = service_name || ""
      @raw_payload = options[:payload]
      configure!
    end

    def process!
      payloads = service_adapter.send(:process, @raw_payload)
      [*payloads].each do |payload|
        callback(callback_class, payload)
      end
    end

    private

    def configure!
      service_adapter
    end

    def callback(object, payload)
      method = method_for(payload)
      object.send(method, payload) if object.respond_to?(method)
    end

    def method_for(payload)
      "on_" + payload.event_type
    end

    def callback_class
      raise "No callback is configured for the service '#{service_name}'." if service_module.config.callback.nil?
      @call_back_class || service_module.config.callback.new
    end

    def service_module
      @service_module || ("Webhookr::Services::" + service_name.camelize).constantize
    end

    def service_adapter
      @service_adapter || ("Webhookr::Services::" + service_name.camelize + "::Adapter").constantize
    end

  end
end