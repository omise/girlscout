module GirlScout
  module Concerns
    module HasResource
      attr_writer :resource

      def self.included(klass)
        klass.extend self
      end

      def resource
        @resource ||= build_resource
      end

      def endpoint(path)
        @path = path
      end

      private

      def build_resource
        klass = self.class
        return klass.resource if klass.respond_to?(:resource)

        url = "#{GirlScout::Config.api_prefix}#{@path}"
        Resource.new(url, {
          user: Config.api_key,
          password: 'X',
          content_type: :json,
          accept: :json
        })
      end
    end
  end
end

