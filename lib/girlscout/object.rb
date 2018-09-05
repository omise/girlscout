# frozen_string_literal: true

module GirlScout
  class Object
    include GirlScout::Concerns::HasAttributes
    include GirlScout::Concerns::HasResource

    def initialize(attr = {}, options = {})
      @attributes = normalize_attributes(attr)
      @resource   = options[:resource] if options[:resource]
    end
  end
end
