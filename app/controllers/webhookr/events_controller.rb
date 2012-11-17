module Webhookr
  class EventsController < ActionController::Base
    http_basic_authenticate_with :name => Webhookr.basic_auth[:username],
                                 :password => Webhookr.basic_auth[:password] if Webhookr.basic_auth &&
                                                                                Webhookr.basic_auth[:username] &&
                                                                                Webhookr.basic_auth[:password]

    def show
      render :nothing => true
    end

    def create
      Webhookr::ResponseHandler.process(params[:id], request.body.read)
      render :nothing => true
    end
  end
end
