module GirlScout
  class Object
    include GirlScout::Concerns::HasAttributes
    include GirlScout::Concerns::HasResource

    def initialize(attr={}, options={})
      attr = attr.inject({}) { |h,(k,v)| h[k.to_s] = v; h }
      @attributes = attr
      @resource = options[:resource] if options[:resource]
    end
  end
end
