# frozen_string_literal: true

module GirlScout
  module Concerns
    module HasAttributes
      def attributes
        @attributes || {}
      end

      def as_json
        @attributes
      end

      def [](key)
        @attributes[attr_key(key)]
      end

      def []=(key, value)
        @attributes[attr_key(key)] = value
      end

      def key?(key)
        @attributes.key?(attr_key(key))
      end

      def respond_to_missing?(method_name, include_all = false)
        key?(method_name) || super
      end

      def method_missing(method_name, *args, &block)
        key = attr_key(method_name)
        return super unless key?(key)

        @attributes[key]
      end

      protected

      def normalize_attributes(attr)
        attr ||= @attributes
        attr = attr.attributes if attr.respond_to?(:attributes)

        attr.each_with_object({}) do |(k, v), hash|
          hash[attr_key(k)] = v
        end
      end

      def attr_key(sym)
        parts = sym.to_s.split('_') # camelize w/o active support
        parts[0] + parts[1..-1].map(&:capitalize).join('')
      end
    end
  end
end
