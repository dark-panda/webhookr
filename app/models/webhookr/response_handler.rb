module Webhookr
  class ResponseHandler
    
    class << self
      def process(service_name, body)
        service_protocol_class(service_name).send(:process, body).each do |r|
          klass = service_call_back_class(service_name)
          method = r.event_type
          klass.send(method, r.data) if klass.respond_to?(method)
        end
      end

      def service_protocol_class(service_name)
        ("Webhookr::" + service_name.camelize + "::Protocol").constantize
      end

      def service_call_back_class(service_name)
        Object.const_get((service_name + "_webhook").camelize)
      end
    end

    private_class_method :service_protocol_class, :service_call_back_class

  end
end