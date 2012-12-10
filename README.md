# webhookr: Rails Webhooks Made Easy

## <a name="introduction"></a>Introduction

### What is webhookr?

webhookr is a Rails Engine that easily and securely adds third-party
webhooks to your Rails app. It supports third-party sites with modular
plugins.

### Why use webhookr?

Webhooks are http callbacks from another service that are useful for
pushing information to your Rails application. The question is: How do I
easily and securely add them to my Rails application?

webhookr provides a single, secure route for all your webhooks, and uses an
approach similar to ActiveRecord's observer pattern to integrate the webhook
with your business logic. You can be up and running with a custom webhook in
less than an hour.

## <a name="usage"></a>Usage

webhookr works with Rails 3.1 onwards. You can add it to your Gemfile
with:

```ruby
gem 'webhookr'
```

and the extension for your third party service. Here I will use mandrill:

```ruby
gem 'webhookr-mandrill'
```

Run the bundle command to install it.

After you install it, run the webhookr generator:

```console
rails generate webhookr:install
```

And the generator for your third party extension:

```console
rails generate webhookr:mandrill:install
```

The generator will install an initializer 'config/initializers/webhookr.rb'
which describes the configuration options, as well as 'lib/webhookr' folder
with your thirdy-party service class. You will need to customize this with
your business logic.

```ruby
class Webhookr:MandrillWebhook
  def on_unsubscribe(packet)
    User.find_by_email(packet.data.email).unsubscribe_all
  end
end
```

Lastly, you will need to mount the engine in your routes file:

```ruby
mount Webhookr::Engine => "/webhookr"
```

To find the url to add to your third-party service, use: 

```console
rake webhookr:mandrill:url
```

## <a name="security"></a>Webhookr Security

### General security issues with webhooks

A webhook by design is a http post to your application, that results in code execution.
Having a well defined approach to adding such functionality can help ensure you don't open security issues
within your application. webhookr uses namespacing and ... to help ensure your application security.

Currently, many webhook providers do provide built-in security for their 
webhooks - they usually send the post over http, and they often have no authentication 
or verification mechanism. If your webhook third-party service provides hooks that way, it is 
possible for an evil person to guess your webhook URL, and attempt to wreak havoc with your system.

### How using webhookr can increase security
webhookr provides a unique url for each service, via a security token that is used in the webhook path, to help make it hard to guess your webhook url.
For example, if you were using MailChimp, your webhook url might look like: '/webhookr/mail_chimp/cdd2a24cfac821' and if you were using Mandrill, your 
webhook might look like: '/webhookr/mandrill/de69557a4d95e7'. This will help prevent someone guessing your 
webhook service url. If you are using https, the URL will be encrypted, keeping your secret_key secret.

You can also enable http basic auth, if the third party service supports it. Note that enabling http basic auth
affects all your webhooks, so be sure it is supported by all your third-party services.


### <a name="supported_services"></a>Supported Services

* MailChimp - webhookr-mail_chimp
* Mandrill - webhookr-mandrill
* Github - coming soon
* Stripe - coming soon

## <a name="works_with"></a>Works with:

webhookr works with Rails 3.1 and 3.2, and has been tested on the following Ruby
implementations:

* MRI 1.9.3
* MRI 1.8.7
* Ruby EE 1.8.7
* JRuby 1.7.0

Pending:
* Rubinius 1.2.4

### TODO
* Implement get/post strategies and responses to the controller, to support advanced Webhook responses,
such as implemented by Shopify.
* Enhance Rake tests

### License

webhookr is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Author

* [Gerry Power](https://github.com/gerrypower)

## <a name="Version History"></a>Version History
