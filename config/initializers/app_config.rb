# frozen_string_literal: true

Rails.application.configure do
  redis_config = config_for(:redis_config).symbolize_keys
  config.redis = redis_config
end
