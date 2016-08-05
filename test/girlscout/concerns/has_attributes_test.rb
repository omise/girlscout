require 'support'

module GirlScout::Concerns
  class HasAttributesTest < GirlScout::GirlScoutTest
    def setup
      super
      h = { }
      h["hello"] = "world"
      h["camelKey"] = "Value"
      h["snake_key"] = "yey"
      @dummy = Dummy.new(h)
    end

    def test_attributes
      hash = @dummy.attributes
      assert_instance_of Hash, hash
      assert_equal "world", hash["hello"]
      assert_equal "Value", hash["camelKey"]
    end

    def test_as_json
      json = @dummy.as_json
      assert_instance_of Hash, json
      assert_equal "world", json["hello"]
    end

    def test_indexable
      assert_equal "world", @dummy[:hello]
      assert_equal "world", @dummy["hello"]
      assert_equal "Value", @dummy[:camel_key]

      @dummy[:new_key] = "new_value"
      assert_equal "new_value", @dummy[:new_key]
    end

    def test_key?
      assert @dummy.key?(:hello)
      assert @dummy.key?(:camel_key)
    end

    def test_dynamic_accessor
      assert @dummy.respond_to?(:camel_key)
      assert_equal @dummy.camel_key, "Value"
    end

    def test_normalize_attributes
      hash = @dummy.send(:normalize_attributes, @dummy.attributes)
      assert_equal hash["hello"], "world"
      assert_equal hash["snakeKey"], "yey"

      hash = @dummy.send(:normalize_attributes, @dummy)
      assert_equal hash["hello"], "world"
      assert_equal hash["snakeKey"], "yey"
    end

    private

    class Dummy
      include HasAttributes

      def initialize(attr={})
        @attributes = attr
      end
    end
  end
end
