module Webhookr
  mattr_accessor :basic_auth

  class Engine < ::Rails::Engine
    isolate_namespace Webhookr
  end
end
