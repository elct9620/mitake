# Mitake (三竹簡訊)
[![Build Status](https://travis-ci.com/elct9620/mitake.svg?branch=master)](https://travis-ci.com/elct9620/mitake) [![Gem Version](https://badge.fury.io/rb/mitake.svg)](https://badge.fury.io/rb/mitake) [![Maintainability](https://api.codeclimate.com/v1/badges/2da932d77d1a2d37a18a/maintainability)](https://codeclimate.com/github/elct9620/mitake/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/2da932d77d1a2d37a18a/test_coverage)](https://codeclimate.com/github/elct9620/mitake/test_coverage)

This is a Ruby implement to help user send SMS via 三竹簡訊 easier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mitake'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mitake

## Usage

To send the SMS, you need to specify the username and password.

```ruby
Mitake.credential = Mitake::Credential.new('YOUR_USERNAME', 'YOUR_PASSWORD')
```

If you prefer to config it by the environment variable, please setup `MITAKE_USERNAME` and `MITAKE_PASSWORD`, the gem will automatic create credential.

> The default server is `https://smsapi.mitake.com.tw` if you use a different server, please specify it manual.

```ruby
# Get the balance in the account
puts "Point: #{Mitake::Balance.amount}"

# Create recipient and give phone number
recipient = Mitake::Recipient.new(phone_number: '09xxxxxxxx', name: 'John')

# Create message with body
message = Mitake::Message.new(recipient: recipient, body: 'Hello World!')

# Delivery message
message.delivery

# Check status
puts message.status unless message.sent?
```

### Switch Credential

If you have multiple credentials, you can switch it in the runtime.

```ruby
external = Mitake::Credential.new('xxx', 'xxx')

Mitake.use(external) do
  # Replace default credential with external
end

# Switch back to use default credential
```

### Message Attributes

|Name|Type|Description
|----|----|-----------
|id|String| `Readonly` The message ID from Mitake
|source_id|String| The customize identity, if same `source_id` send to Mitake, it will response duplicate flag
|recipient|Mitake::Recipient| The recipient of message
|body|String| The message body
|schedule_at|Time| The schedule time to send message
|expired_at|Time| The message expire time, max value is `+ 24h`
|duplicate|TrueClass/FalseClass| `Readonly` The message is duplicate (already sent)
|status_code|Integer| `Readonly` The message status

## Roadmap

* [ ] Rspec tests
* [ ] Message
  * [x] Delivery
  * [ ] Batch Delivery
  * [ ] Webhook
  * [ ] Query Status
  * [ ] Cancel

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/mitake. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Mitake project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elct9620/mitake/blob/master/CODE_OF_CONDUCT.md).
