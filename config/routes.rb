Webhookr::Engine.routes.draw do
  get "/events/:id" => "events#show"
  post "/events/:id" => "events#create"
end
