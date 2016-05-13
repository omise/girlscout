module GirlScout
  class Object
    include GirlScout::Concerns::HasAttributes
    include GirlScout::Concerns::HasResource

    def initialize(attr={}, options={})
      attr = attr.attributes if attr.is_a?(Object)
      attr = attr.inject({}) do |hash,(k,v)|
        hash[attr_key(k)] = v
        hash
      end

      @attributes = attr
      @resource   = options[:resource] if options[:resource]
    end
  end
end
