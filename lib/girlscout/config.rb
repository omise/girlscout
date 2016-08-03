module GirlScout
  DEFAULT_API_PREFIX = 'https://api.helpscout.net/v1'

  class Config
    class << self
      attr_accessor :api_key
      attr_writer :api_prefix

      def api_prefix
        @api_prefix ||= DEFAULT_API_PREFIX
      end

      def reset!
        @api_key = nil
        @api_prefix = DEFAULT_API_PREFIX
      end
    end
  end
end
