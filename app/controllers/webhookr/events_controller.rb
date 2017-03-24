module Webhookr
  class EventsController < ActionController::Base
    http_basic_authenticate_with(
      :name => Webhookr.config.basic_auth.username,
      :password => Webhookr.config.basic_auth.password
    ) if Webhookr.config.basic_auth.username && Webhookr.config.basic_auth.password

    before_action :create_service

    def show
      head :ok
    end

    def create
      @service.process!
      head :ok
    end

    private

    def create_service
      begin
        # Rails 4.0.0 fix: https://github.com/rails/rails/pull/11353
        request.body.rewind

        @service = Webhookr::Service.new(
          params[:service_id], :payload => request.body.read, :security_token => params[:security_token]
        )
      rescue NameError => e
        raise ActionController::RoutingError.new("No service '#{params[:service_id]}' is available.")
      rescue Webhookr::InvalidSecurityTokenError => e
        raise ActionController::InvalidAuthenticityToken.new("Invalid or missing security token for service '#{params[:service_id]}'.")
      end
    end

  end
end
