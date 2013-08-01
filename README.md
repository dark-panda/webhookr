# webhookr: Rails Webhooks Made Easy
[![Build Status](https://travis-ci.org/zoocasa/webhookr.png?branch=master)](https://travis-ci.org/zoocasa/webhookr)
[![Dependency Status](https://gemnasium.com/zoocasa/webhookr.png)](https://gemnasium.com/zoocasa/webhookr)
[![Code Climate](https://codeclimate.com/github/zoocasa/webhookr.png)](https://codeclimate.com/github/zoocasa/webhookr)
[![Coverage Status](https://coveralls.io/repos/zoocasa/webhookr/badge.png?branch=master)](https://coveralls.io/r/zoocasa/webhookr?branch=master)

## <a name="introduction"></a>Introduction

### What is webhookr?

webhookr is a Rails Engine that easily and securely adds third-party
webhooks to your Rails app. It supports third-party sites with modular
plugins.

### What are 'webhooks'?

From 30,000 feet, webhooks allow disparate cloud services to coordinate and
asynchronously notify each other of events of interest. For example, a shopping app might
want to process a [customer credit card transaction](https://stripe.com/docs/webhooks),
and be notified of success or failure.

From 10,000 feet, webhooks allow external third parties the ability to
execute code within your application, using a well defined message exchange
protocol.

From 1,000 feet and below, webhooks are application routes and controller
endpoints, third-party API discovery, security decisions, and code that
executes within your application.


### Why use webhookr?

Webhooks are http callbacks from another service that are useful for
pushing information to your Rails application. The question is: How do I
easily and securely add them to my Rails application?

webhookr provides a single, secure route for all your webhooks, and uses
the observer pattern to integrate the webhook with your business logic.
Using webhookr you can be up and running with a third-party webhook in less
than an hour.

### How does webhookr work?

Webhookr provides a standard approach for third-party webhooks via plugins. The
author of a plugin implements code to standardize any webhook into an action and
data packet. Your task is to write glue code that is called whenever an action is
received, and to use the resulting data packet for your application logic. Here is
a subset of the MailChimp handler that might be written to deal with the 'unsubscribe'
action sent from MailChimp:

```ruby
class MailChimpHooks
  def on_unsubscribe(payload)
    User.unsubscribe_newletter(payload.data.email)
  end
end
```

## <a name="usage"></a>Usage & Setup

webhookr works with Rails 3.1 onwards. It generally requires a plugin to be
useful, such as the [MailChimp plugin](https://github.com/zoocasa/webhookr-mailchimp).

## Setup

Add webhookr to your Gemfile with:

```ruby
gem 'webhookr'
```

Run the bundle command to install it and then run the generator to
add the engine route to your config/routes.rb:

```console
rails g webhookr:add_route
```

or, add the routing information manually to config/routes.rb

```ruby
mount Webhookr::Engine => "/webhookr", :as => "webhookr"
```

The initialization file for webhookr is optional. To see what
options are available, you can run the generator and review the
sample config file:

```console
rails g webhookr:init *initializer_name*
```

Once you have added third-party plugins, you can use the provided
rake task to output your applications urls for each service:

```console
rake webhookr:services
```

## <a name="security"></a>Webhookr Security

### General security issues with webhooks

A webhook is by design, a http post to your application that results in code execution.
Having a well defined approach to adding such functionality can help ensure you don't open security issues
within your application.

Many webhook providers do not provide built-in security for their
webhooks - they usually send the post over http, and they often have no authentication
or verification mechanism. If your webhook third-party service responds to hooks, it is
possible for an evil person to guess your webhook URL, and attempt to wreak havoc with your system.

### How using webhookr can increase security
webhookr provides a unique url for each service, via a security token that is used in the webhook path, to help make it hard to guess your webhook url.
For example, if you were using MailChimp, your webhook url might look like: '/webhookr/mailchimp/cdd2a24cfac821' and if you were using Mandrill, your
webhook might look like: '/webhookr/mandrill/de69557a4d95e7'. This will help prevent someone guessing your
webhook service url. If you are using https, the URL will be encrypted, keeping your security token a secret.

You can also enable http basic auth, if the third party service supports it. Note that enabling http basic auth
affects all your webhooks, so be sure it is supported by all your third-party services.

If you are sending sensitive data via webhooks, it is recommended you use HTTPS.

### <a name="supported_services"></a>Supported Services

* MailChimp - [webhookr-mail_chimp](https://github.com/zoocasa/webhookr-mailchimp)
* Mandrill - [webhookr-mandrill](https://github.com/gerrypower/webhookr-mandrill)
* Stripe - [webhookr-stripe](https://github.com/gerrypower/webhookr-stripe)
* Github - coming soon

## <a name="works_with"></a>Works with:

webhookr works with Rails 4.0 and 3.1, and has been tested on the following Ruby
implementations:

* JRuby 1.7.4
* MRI 1.9.3
* MRI 2.0.0

### TODO
* Implement get/post strategies and responses so the controller can return variable text to the service.
This allows support for advanced Webhook responses for services that require it.
* Enhance testing of Rake tasks
* Clean up the stubs with FactoryGirl

### Versioning
This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, that
version should be immediately yanked and/or a new version should be immediately released that restores
compatibility. Breaking changes to the public API will only be introduced with new major versions. As a
result of this policy, once this gem reaches a 1.0 release, you can (and should) specify a dependency on
this gem using the [Pessimistic Version Constraint](http://docs.rubygems.org/read/chapter/16#page74) with
two digits of precision. For example:

    spec.add_dependency 'webhookr', '~> 1.0'

While this gem is currently a 0.x release, suggestion is to require the exact version that works for your code:

    spec.add_dependency 'webhookr', '0.0.2'

### License

webhookr is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Author

* [Gerry Power](https://github.com/gerrypower)

