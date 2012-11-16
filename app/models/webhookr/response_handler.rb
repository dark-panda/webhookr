module Webhookr
  class ResponseHandler
    
    class << self
      def process(service_name, body)
        service_protocol_class(service_name).send(:process, body)
      end

      def service_protocol_class(service_name)
        ("Webhookr::" + service_name.camelize + "::Protocol").constantize
      end
    end

    private_class_method :service_protocol_class

  end
end