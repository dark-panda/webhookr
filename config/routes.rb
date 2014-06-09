
Webhookr::Engine.routes.draw do
  get "/events/:service_id(/:security_token)" => "events#show",
    as: "events",
    defaults: { format: 'json' },
    constraints: { format: 'json' }

  post "/events/:service_id(/:security_token)" => "events#create",
    as: "new_event",
    defaults: { format: 'json' },
    constraints: { format: 'json' }
end
