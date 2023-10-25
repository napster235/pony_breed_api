# frozen_string_literal: true

require 'singleton'

module Pony
  module Breeds
    class RedisCaching
      include Singleton

      def initialize
        # @redis = Redis.new(host: redis_config[:host], port: redis_config[:port])
        @redis = Redis.new(url: redis_config[:url])
        @redis.ping
      rescue StandardError => e
        Rails.logger.error "Encountered an error while initializing Redis: '#{e.message}'."
      end

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
