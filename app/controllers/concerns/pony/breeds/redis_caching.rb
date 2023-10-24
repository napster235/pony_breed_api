# frozen_string_literal: true

require 'singleton'

module Pony
  module Breeds
    class RedisCaching
      include Singleton

      def initialize
        @redis = Redis.new(host: redis_config[:host], port: redis_config[:port])
      end

      def cache_data(key)
        response = @redis.get(key)

        if response.nil?
          @redis.setex(key, 604_800, yield.to_json)
        else
          @redis.setex(key, 604_800, response)
        end

        return yield if response.nil?

        response
      end

      private

      def redis_config
        Rails.configuration.redis
      end
    end
  end
end
