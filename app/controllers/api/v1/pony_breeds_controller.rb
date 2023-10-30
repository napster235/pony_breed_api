# frozen_string_literal: true

require 'pony/breeds/read_pony_data'
require 'pony/breeds/redis_caching'
require 'pony/breeds/cache_key'

module Api
  module V1
    class PonyBreedsController < ApplicationController
      # This method retrieves a random pony from the Pony::Breeds::ReadPonyData
      # module and then renders the result as JSON.
      # If no pony data is available, it will return an appropriate error message.
      def random_pony
        @result = Pony::Breeds::ReadPonyData.retrieve_random_pony

        if @result.nil?
          render json: 'No pony data available'
        else
          render json: @result
        end
      end

      # This method retrieves a pony by name from the Pony::Breeds::ReadPonyData
      # module and then renders the result as JSON.
      # If no pony data is available, it will return an appropriate error message.
      def pony_by_name
        cache_key = Pony::Breeds::CacheKey.new.redis_key("#{params[:name]}")

        @result = Pony::Breeds::RedisCaching.instance.cache_data(cache_key) do
          Pony::Breeds::ReadPonyData.get_pony_by_name(params[:name])
        end

        if @result.nil?
          render json: "No data available for the following name: '#{params[:name]}'"
        else
          render json: @result
        end
      end

      # This method retrieves a pony by key from the Pony::Breeds::ReadPonyData
      # module and then renders the result as JSON.
      # If no pony data is available, it will return an appropriate error message.
      def pony_by_key
        cache_key = Pony::Breeds::CacheKey.new.redis_key("#{params[:key]}")

        @result = Pony::Breeds::RedisCaching.instance.cache_data(cache_key) do
          Pony::Breeds::ReadPonyData.get_pony_by_key(params[:key])
        end

        if @result.nil?
          render json: "No data available for the following key: '#{params[:key]}'"
        else
          render json: @result
        end
      end
    end
  end
end
