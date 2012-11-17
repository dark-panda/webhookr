module Webhookr
  module Config
    # Enables basic auth for all services when `:username` and
    # `:password` are set.
    mattr_accessor :basic_auth
    self.basic_auth = {}
  end

  class Engine < ::Rails::Engine
    isolate_namespace Webhookr
  end
end
