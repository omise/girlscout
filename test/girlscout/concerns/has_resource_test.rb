# frozen_string_literal: true

require 'support'

module GirlScout
  module Concerns
    class HasResourceTest < GirlScout::GirlScoutTest
      def test_resource
        instance = dummy
        resource = instance.resource
        refute_nil resource, 'should have default resource'
        assert_instance_of GirlScout::Resource, resource

        instance.resource = 'new resource'
        assert_equal 'new resource', instance.resource

        resource = Dummy.resource
        refute_nil resource, 'class should have default resource, too'
        assert_instance_of GirlScout::Resource, resource
      end

      def test_resource_fallback
        instance = dummy
        resource = Dummy.resource
        assert_equal resource, instance.resource, 'should fallback to parent resource'
      end

      def test_endpoint
        assert_equal "#{GirlScout::DEFAULT_API_PREFIX}/dummy", Dummy.resource.url
        assert_equal "#{GirlScout::DEFAULT_API_PREFIX}/dummy", dummy.resource.url
      end

      private

      class Dummy
        include HasResource
        endpoint '/dummy'
      end

      def dummy
        Dummy.new
      end
    end
  end
end
