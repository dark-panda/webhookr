class MailChimpWebhook
  
  class << self
    def unsubscribe(data)
      User.find(data.email).unsubscribe_all
    end

    def subscribe(data)
      
    end
  end
end