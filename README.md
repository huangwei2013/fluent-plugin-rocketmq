# Fluent::Plugin::RocketMQ

Fluent plugin for RocketMQ 

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-rocketmq'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-rocketmq

## Usage

This client works as ONLY Rocketmq client.
Rocketmq topics array is set as "#".

```
<source>
  type rocketmq
  bind 127.0.0.1
  port 9876
  username username
  password password
</source>
```

### Changelog version 0.0.10

 - Support multiple subscriptions (put more coma separated topic in topics parameter)

## Contributing

1. Fork it ( somewhere not yet )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
