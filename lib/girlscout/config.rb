# frozen_string_literal: true

module GirlScout
  DEFAULT_API_PREFIX = 'https://api.helpscout.net/v2'

  class Config
    class << self
      attr_accessor :client_id, :client_secret
      attr_writer :api_prefix

      def api_prefix
        @api_prefix ||= DEFAULT_API_PREFIX
      end

      def reset!
        @client_id = nil
        @client_secret = nil
        @api_prefix = DEFAULT_API_PREFIX
      end
    end
  end
end
