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

      def key?(key)
        @attributes.key?(attr_key(key))
      end

      def respond_to?(method_name)
        key?(method_name) || super
      end

      def method_missing(method_name, *args, &block)
        key = attr_key(method_name)
        return super unless key?(key)

        @attributes[key]
      end

      private

      def attr_key(sym)
        parts = sym.to_s.split('_') # camelize w/o active support
        key = parts[0] + parts[1..-1].map(&:capitalize).join('')
      end
    end
  end
end

