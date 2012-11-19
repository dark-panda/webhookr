Webhookr::Engine.routes.draw do
  get "/events/:service_id" => "events#show"
  post "/events/:service_id" => "events#create"
end
