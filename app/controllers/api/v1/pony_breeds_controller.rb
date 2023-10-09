# frozen_string_literal: true

require 'pony/breeds/read_pony_data'

module Api
  module V1
    class PonyBreedsController < ApplicationController
      def random_pony
        @result = Pony::Breeds::ReadPonyData.retrieve_random_pony

        if @result.nil?
          render json: 'No pony data available'
        else
          render json: @result
        end
      end

      def pony_by_name
        @result = Pony::Breeds::ReadPonyData.get_pony_by_name(params[:name])
        render_result('No data available for the following name:')
      end

      def pony_by_key
        @result = Pony::Breeds::ReadPonyData.get_pony_by_key(params[:key])
        render_result('No data available for the following key:')
      end

      private

      def render_result(message)
        if @result.nil?
          render json: "#{message} '#{params[:key] || params[:name]}'"
        else
          render json: @result
        end
      end
    end
  end
end
