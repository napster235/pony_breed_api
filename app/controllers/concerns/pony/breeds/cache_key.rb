# frozen_string_literal: true

module Pony
  module Breeds
    # The CacheKey class provides utility functions for generating
    # Redis cache keys with a standardized format.
    class CacheKey
      KEY_FORMAT = 'cache_key_name:%s'

      # Formats the processed key name using the KEY_FORMAT pattern.
      #
      # @param key_name [String] the raw string input that represents the name of
      # a key to be stored in Redis
      #
      # return [String] the formatted key ready to be used in Redis
      def redis_key(key_name)
        format_key = key_name.split.join('_').downcase
        format(KEY_FORMAT, format_key.tr(':', '-'))
      end
    end
  end
end
