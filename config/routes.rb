Webhookr::Engine.routes.draw do
  get "/events/:service_id(/:security_token)" => "events#show", :as => "events"
  post "/events/:service_id(/:security_token)" => "events#create", :as => "events"
end
