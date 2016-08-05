module GirlScout
  class Error < ::StandardError
    include GirlScout::Concerns::HasAttributes

    def initialize(attr={})
      @attributes = normalize_attributes(attr)
      super @attributes["error"]
    end
  end
end
