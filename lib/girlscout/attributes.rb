module GirlScout
  module Attributes
    def attributes
      @attributes || {}
    end

    def as_json
      attributes
    end

    def [](key)
      @attributes[key.to_s]
    end

    def key?(key)
      @attributes.key?(attr_name(key))
    end

    def respond_to?(method_name)
      key?(method_name) || super
    end

    def method_missing(method_name, *args, &block)
      if key?(method_name)
        @attributes[attr_name(method_name)]
      else
        super
      end
    end

    private

    def attr_name(sym)
      parts = sym.to_s.split('_') # camelize w/o active support
      parts[0] + parts[1..-1].map(&:capitalize).join('')
    end
  end
end
