
module Webhookr
  module Generators
    class AddRouteGenerator < Rails::Generators::Base
      desc 'This generator adds \'mount Webhookr::Engine => "/webhookr", as: "webhookr"\' to your routes'
      def add_route
        route 'mount Webhookr::Engine => "/webhookr", as: "webhookr"'
      end
    end
  end
end

