# frozen_string_literal: true

module Webhookr::Services::Adapter::Base
  extend ActiveSupport::Concern

  included do
    initialize! if respond_to?(:initialize!)
    Webhookr.adapters[self::SERVICE_NAME] = self
  end

  module ClassMethods
    def config
      if Webhookr.config[self::SERVICE_NAME]
        Webhookr.config[self::SERVICE_NAME]
      else
        Webhookr.config[self::SERVICE_NAME] = ActiveSupport::OrderedOptions.new
      end
    end
  end
end
