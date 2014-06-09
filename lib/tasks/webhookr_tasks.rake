
namespace :webhookr do
  desc "List the configured services and paths"
  task :services => :environment do
    puts "No webhookr services configured - add and configure webhookr plugins." and next if Webhookr.adapters.empty?

    include Webhookr::Engine.routes.url_helpers

    Webhookr.adapters.each do |key, adapter|
      puts "\n\n#{key}:"
      %w{ GET POST}.each do |x|
        puts "  #{x}\t#{events_path(key, :security_token => Webhookr.config[key].try(:security_token))}\n"
      end
    end
  end
end

