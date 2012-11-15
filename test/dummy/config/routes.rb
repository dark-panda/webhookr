Rails.application.routes.draw do

  mount Webhookr::Engine => "/webhookr"
end
