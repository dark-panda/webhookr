module Webhookr
  module Generators
    class InitGenerator < Rails::Generators::NamedBase

      desc "This generator creates an initializer file 'config/initializers/NAME.rb'"
      def init
        initializer("#{file_name}.rb") do
          file_contents
        end
      end

      def file_contents
<<-eos
# Webhookr Initializer

## Turn on http basic authentication for all plugins
  # Webhookr.config.basic_auth.username = "admin"
  # Webhookr.config.basic_auth.password = "password"

## Plugin Initializers go here ##
eos
      end

      private
        def generate_security_token
          SecureRandom.hex(32)
        end
    end
  end
end
