Rails.application.routes.draw do

  mount Webhookr::Engine => "/webhookr", :as => "webhookr"
end
