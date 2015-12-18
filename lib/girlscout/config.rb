module GirlScout
  DEFAULT_API_PREFIX = 'https://api.helpscout.net/v1'

  class Config
    class << self
      def api_key
        @api_key
      end

      def api_key=(value)
        @api_key = value
        GirlScout::Object.resource = nil
      end

      def api_prefix
        @api_prefix || DEFAULT_API_PREFIX
      end

      def api_prefix=(value)
        @api_prefix = value
        GirlScout::Object.resource = nil
      end

      def reset!
        @api_key = nil
        @api_prefix = DEFAULT_API_PREFIX
      end
    end
  end
end
