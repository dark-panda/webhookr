# frozen_string_literal: true

module Webhookr
  class EventsController < ActionController::Base
    if Webhookr.config.basic_auth.username && Webhookr.config.basic_auth.password
      http_basic_authenticate_with(
        name: Webhookr.config.basic_auth.username,
        password: Webhookr.config.basic_auth.password
      )
    end

    if respond_to?(:before_action)
      before_action :create_service
    else
      before_filter :create_service
    end

    def show
      render body: nil
    end

    def create
      @service.process!
      render body: nil
    end

    private

      def create_service
        # Rails 4.0.0 fix: https://github.com/rails/rails/pull/11353
        request.body.rewind

        @service = Webhookr::Service.new(
          params[:service_id],
          payload: request.body.read,
          security_token: params[:security_token]
        )
      rescue Webhookr::InvalidServiceNameError
        raise ActionController::RoutingError, "No service '#{params[:service_id]}' is available."
      rescue Webhookr::InvalidSecurityTokenError
        raise ActionController::InvalidAuthenticityToken, "Invalid or missing security token for service '#{params[:service_id]}'."
      end
  end
end
