module Webhookr
  class Service
    
    def initialize(service_name, options = Hash.new(""))
      @service_name = service_name
      @service_protocol_class = service_protocol_class(service_name || "")
      @payload = options[:payload]
    end

    def process!
       result = @service_protocol_class.send(:process, @payload)
       [*result].each do |r|
         klass = new_service_callback_class(@service_name)
         klass.send(method_for(r.event), r) if klass.respond_to?(method_for(r.event))
       end
    end

    private

    def method_for(event)
      "on_" + event
    end

    def new_service_callback_class(service_name)
      raise "No callback configured for service: #{service_name}" unless
            call_back_class(service_name)
      call_back_class(service_name).new
    end

    def call_back_class(service_name)
      ("Webhookr::Services::" + service_name.camelize).constantize.callback
    end

    def service_protocol_class(service_name)
      ("Webhookr::Services::" + service_name.camelize + "::Adapter").constantize
    end

  end
end