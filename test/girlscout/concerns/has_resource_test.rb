require 'support'

module GirlScout::Concerns
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

    def test_resource_path
      assert_equal '/dummy', Dummy.resource_path
      assert_equal '/dummy', dummy.resource_path
    end

    def test_resource_fallback
      instance = dummy
      resource = Dummy.resource
      assert_equal resource, instance.resource, 'should fallback to parent resource'
    end

    def test_endpoint
      assert_equal "#{GirlScout::DEFAULT_API_PREFIX}/dummy.json", dummy.resource.url
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
