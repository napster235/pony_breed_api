# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home_page#index'
  get 'api/v1/random_pony' => 'api/v1/pony_breeds#random_pony', as: :random_pony
  get 'api/v1/pony_by_name' => 'api/v1/pony_breeds#pony_by_name', as: :pony_by_name
  get 'api/v1/pony_by_key' => 'api/v1/pony_breeds#pony_by_key', as: :pony_by_key
end
