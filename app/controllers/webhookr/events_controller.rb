module Webhookr
  class EventsController < ActionController::Base
    def show
      render :nothing => true
    end

    def create
      Webhookr::ResponseHandler.process(params[:id], request.body.read)
      render :nothing => true
    end
  end
end
