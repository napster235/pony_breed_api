# frozen_string_literal: true

require 'singleton'

module Pony
  module Breeds
    # The RedisCaching class has the ability to create, store and retrieve cached items
    # from a Redis server
    class RedisCaching
      include Singleton

      # Initializes a new RedisCaching object
      def initialize
        @redis = Redis.new(url: redis_config[:url])
        @redis.ping
      rescue StandardError => e
        Rails.logger.error "Encountered an error while initializing Redis: '#{e.message}'."
      end

      # Retrieve a cached value from Redis. If there is no cached value, a call will be performed
      # and the value will be stored inside a Redis cache key.
      #
      # @param key [String] the cache key stored in Redis
      #
      # return [Object] the cached value
      def cache_data(key)
        return yield unless redis_connected?

        response = @redis.get(key)

        if response.nil?
          unless yield.nil?
            @redis.setex(key, 604_800, yield.to_json)

            return yield.to_json
          end

          return yield
        end

        response
      end

      private

      def redis_config
        Rails.configuration.redis
      end

      def redis_connected?
        true if @redis.connected?
      end
    end
  end
end
