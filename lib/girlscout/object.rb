module GirlScout
  class Object
    include GirlScout::Attributes

    class << self
      def api_key
        @api_key || GirlScout::Config.api_key
      end

      def api_key=(value)
        @api_key = value
        @resource = nil
      end

      def api_prefix
        @api_prefix || GirlScout::Config.api_prefix
      end

      def api_prefix=(value)
        @api_prefix = value
        @resource = nil
      end

      def resource
        @resource ||= build_resource
      end

      def resource=(value)
        @resource = value
      end

      def endpoint(path)
        @path = path
        @resource = nil
      end

      private

      def build_resource
        Resource.new("#{api_prefix}#{@path}", {
          user: api_key,
          password: 'X',
          content_type: :json,
          accept: :json
        })
      end
    end

    def initialize(attr={})
      @attributes = attr
    end

    protected

    def resource
      self.class.resource
    end
  end
end
