# frozen_string_literal: true

require 'support'

module GirlScout
  class ObjectTest < GirlScoutTest
    def test_initialize
      resource = 'assigned_resource'
      attributes = { hello: 'world' }

      instance = Object.new(attributes, resource: resource)
      assert_equal resource, instance.resource
      assert_equal 'world', instance.hello
    end

    def test_initialize_normalize_keys
      attributes = {}
      attributes[:symbol_key] = 'Sym'
      attributes['ruby_style'] = 'Matz'

      instance = Object.new(attributes)
      assert_equal 'Sym', instance.symbol_key
      assert_equal 'Matz', instance.ruby_style

      json = instance.as_json
      assert_equal 'Sym', json['symbolKey']
      assert_equal 'Matz', json['rubyStyle']
    end

    def test_initialize_instance
      attributes = { hello: 'world' }
      instance1 = Object.new(attributes)
      instance2 = Object.new(instance1)

      assert_equal 'world', instance2.hello
    end

    def test_initialize_dup_attributes
      attributes = { hello: 'world' }
      instance = Object.new(attributes)

      attributes['added'] = 'key'
      refute_equal 'key', instance['added']
    end
  end
end
