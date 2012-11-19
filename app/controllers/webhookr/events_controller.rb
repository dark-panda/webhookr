module Webhookr
  class EventsController < ActionController::Base
    http_basic_authenticate_with :name => Webhookr::Config.basic_auth[:username],
                                 :password => Webhookr::Config.basic_auth[:password] if Webhookr::Config.basic_auth[:username] &&
                                                                                        Webhookr::Config.basic_auth[:password]
    before_filter :create_service

    def show
      render :nothing => true
    end

    def create
      @service.process!
      render :nothing => true
    end

    private

    def create_service
      begin
        @service = Webhookr::Service.new(params[:service_id], :payload => request.body.read)
      rescue NameError
        raise ActionController::RoutingError.new("Unknown service: '#{params[:service_id]}'")
      end
    end

  end
end