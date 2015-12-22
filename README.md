# GIRLSCOUT

**BETA** This software is half-finished beta-quality software. Until 1.0 is released, use
at your own risk!

This is a gem for talking to the [HelpScout Help Desk API][0].

# REQUIREMENTS

You will need a valid [HelpScout account][1] setup for the API key in order to use this
gem. This gem has been developed and tested on Ruby 2.2.3p173

# INSTALLATION

Using [bundler][2]:

```sh
gem 'girlscout'
```

Or manually via [rubygems][3]:

```sh
$ gem install girlscout
```

# USAGE

### Configuration

Before starting out, obtain your **HelpScout API Key** from the HelpScout dashboard and
configure your `api_key` in the application:

```ruby
require 'girlscout'

GirlScout::Config.api_key = 'put your helpscout API key here'
```

### Accesses

GirlScout provides AR-style accessor methods on model classes, use them to retrieve data
from HelpScout:

```ruby
mailboxes = GirlScout::Mailbox.all
puts mailboxes.first.name
# => "Support"

conversation = GirlScout::Conversation.find(12345)
puts conversation.id
# => 12345
```

To create a new conversation, build the models and use the `create` method on the model
class:

```ruby
user = GirlScout::User.me
mailbox = GirlScout::Mailbox.new(id: 123)
customer = GirlScout::Customer.new(email: "customer@example.com")

thread = GirlScout::Thread.new({
  type: "message",
  created_by: user,
  body: "You may reply to this email directly for support!"
})

conversation = GirlScout::Conversation.new(
  type: :email,
  subject: "Thanks for registering at Awesome SaaS company XYZ!",
  mailbox: mailbox,
  customer: customer,
  threads: [thread]
)

conversation = GirlScout::Conversation.create(conversation)
```

# LICENSE

MIT


[0]: http://developer.helpscout.net/help-desk-api/
[1]: http://www.helpscout.net
[2]: http://bundler.io
[3]: https://rubygems.org

