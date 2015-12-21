require 'support'

module GirlScout::Concerns
  class HasAttributesTest < GirlScout::GirlScoutTest
    def test_attributes
      hash = dummy.attributes
      assert_instance_of Hash, hash
      assert_equal "world", hash["hello"]
    end

    def test_as_json
      json = dummy.as_json
      assert_instance_of Hash, json
      assert_equal "world", json["hello"]
    end

    def test_indexable
      assert_equal "world", dummy[:hello]
      assert_equal "world", dummy["hello"]
      assert_equal "Value", dummy[:camel_key]
    end

    def test_key?
      assert dummy.key?(:hello)
      assert dummy.key?(:camel_key)
    end

    def test_dynamic_accessor
      assert dummy.respond_to?(:camel_key)
      assert_equal dummy.camel_key, "Value"
    end

    private

    class Dummy
      include HasAttributes

      def initialize(attr={})
        @attributes = attr
      end
    end

    def dummy
      h = { }
      h["hello"] = "world"
      h["camelKey"] = "Value"

      Dummy.new(h)
    end
  end
end
