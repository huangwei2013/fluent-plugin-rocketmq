require 'fluent/plugin/input'
require 'rocketmq-client-ruby'
require 'json'

module Fluent
  module Plugin
    class RocketMQInput < Input
      Fluent::Plugin.register_input('rocketmq', self)

      config_param :host, :string, default: 'localhost'
      config_param :port, :integer, default: 9876
      config_param :consumer_group, :string , default: 'rocketmq_group'
      config_param :topics, :string, default: ''
      config_param :tag, :string, default: 'rocketmq'

      config_param :source_key, :string, default: ''
      config_param :source_value, :string, default: ''

      def configure(conf)
        super
        @topic_list = @topics.split(',')
        @consumers = []
      end

      def start
        super

        @consumers = @topic_list.map do |topic|
          create_consumer(topic)
        end
      end

      def shutdown
        super
        @consumers.each(&:shutdown)
      end

      private

      def create_consumer(topic)
        callback = -> (message) {
          run(message, topic)
          return Rocketmq::C::ConsumeStatus[:consume_success]
        }

        name_server = "#{@host}:#{@port}"
        consumer_name = "#{consumer_group}:#{topic}"

        consumer = Client::PushConsumer.new(consumer_name) 
        consumer.set_name_server_address(name_server)
        consumer.subscribe(topic, callback)
        consumer.start

        consumer
      end

      def run(message, topic)
        begin
          send_flag = false
          jsonBody = JSON.parse(message.body)

          # 补充自己需要的逻辑
          send_flag == true

          if send_flag == true
            record = {
              'message_id' => message.id,
              'topic' => topic,
              'body' => message.body
            }
            unless @source_key.empty?
              record[@source_key] = @source_value
            end

            router.emit(@tag, Fluent::Engine.now, record)
          end
        rescue => e
          log.error("Error processing message: #{e.message}")
        end
      end
    end
  end
end
