# GirlScout

[![Ruby](https://github.com/omise/girlscout/actions/workflows/ruby.yml/badge.svg)](https://github.com/omise/girlscout/actions/workflows/ruby.yml)

**BETA** GirlScout is half-finished beta-quality software. Until 1.0 is released, use
at your own risk!

This is a gem for talking to the [HelpScout Mailbox API v2][0].

# Requirements

To use this gem, you will need a valid [HelpScout account][1] setup for the API key. This gem has been developed and tested on Ruby 2.5.1.

# Installation

Using [bundler][2]:

```sh
gem 'girlscout'
```

Or manually via [rubygems][3]:

```sh
$ gem install girlscout
```

# Usage

## Configuration

Before starting out, obtain your **HelpScout API Key** from the HelpScout dashboard and
configure your `client_id` and `client_secret` in the application:

```ruby
require 'girlscout'

GirlScout::Config.client_id = 'your helpscout application id'
GirlScout::Config.client_secret = 'your helpscout application secret here'
```

## Accesses

GirlScout provides AR-style accessor methods for model classes; use them to retrieve data from HelpScout:

### Mailbox
```ruby
mailboxes = GirlScout::Mailbox.list
puts mailboxes.first.name
# => "Support"

mailbox = GirlScout::Mailbox.find(6789)
puts mailbox.name
# => "Support"
```

### Customer
```ruby
customer = GirlScout::Customer.find(2468)
puts customer.name
# => "Chakrit"

customers = GirlScout::Customer.list
puts customers.first.name
# => "Chakrit"

customers = GirlScout::Customer.list(mailbox_id: 6789)
puts customers.first.name
# => "Chakrit"
```

### User
```ruby
me = GirlScout::User.me
puts me.first_name
# => "Phureewat"

user = GirlScout::User.find(12345)
puts user.first.first_name
# => "Phureewat"

users = GirlScout::User.list
puts users.first.first_name
# => "Phureewat"

users = GirlScout::User.list(email: 'abc@omise.co')
puts users.first.first_name
# => "Phureewat"
```


### Conversation
```ruby
conversation = GirlScout::Conversation.find(12345)
puts conversation.id
# => 12345

conversations = GirlScout::Conversation.list
puts conversations.first.id
# => 12345

conversations = GirlScout::Conversation.list(status: :active)
puts conversations.first.id
# => 12345

conversations = GirlScout::Conversation.list(mailbox_id: 6789)
puts conversations.first.id
# => 12345
```

To create a new conversation, build the models and use the `create` method on the model
class:

```ruby
mailbox = GirlScout::Mailbox.new(id: 123)
customer = GirlScout::Customer.new(email: "customer@example.com")

thread = GirlScout::Thread.new({
  type: "customer",
  customer: customer,
  text: "You may reply to this email directly for support!"
})

conversation = GirlScout::Conversation.new(
  type: :email,
  subject: "Thanks for registering at Awesome SaaS company XYZ!",
  status: :active,
  mailbox_id: mailbox.id,
  customer: customer,
  threads: [thread]
)

id = GirlScout::Conversation.create(conversation)
conversation = GirlScout::Conversation.find(id)
```

# License

MIT


[0]: https://developer.helpscout.com/mailbox-api/
[1]: http://www.helpscout.net
[2]: http://bundler.io
[3]: https://rubygems.org
