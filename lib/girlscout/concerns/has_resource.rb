# frozen_string_literal: true

module GirlScout
  module Concerns
    module HasResource
      attr_writer :resource

      def self.included(klass)
        klass.extend(self)
      end

      def resource
        @resource ||= build_resource
      end

      def resource_url
        "#{GirlScout::Config.api_prefix}#{@endpoint}"
      end

      def endpoint(path)
        @endpoint = path
      end

      private

      def build_resource
        return self.class.resource if self.class.respond_to?(:resource)

        Resource.new(url: resource_url)
      end
    end
  end
end
