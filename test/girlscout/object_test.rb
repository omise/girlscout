require 'support'

module GirlScout
  class ObjectTest < GirlScoutTest
    def test_initialize
      attr = { }
      attr["hello"] = "world"

      resource = 'assigned_resource'

      instance = Object.new(attr, resource: resource)
      assert_equal attr, instance.attributes
      assert_equal resource, instance.resource
    end
  end
end
