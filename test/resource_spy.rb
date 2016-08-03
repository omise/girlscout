module GirlScout
  class ResourceSpy
    attr_accessor :parent_resource
    attr_accessor :url

    def initialize(parent_resource)
      @parent_resource = parent_resource
    end

    def [](path)
      @parent_resource = @parent_resource[path]
      @url = "#{@url}#{path}" if defined? @url and @url
      self
    end

    Resource::METHODS.each do |method|
      attr_accessor :"#{method}_payload"
      attr_accessor :"#{method}_query"
      attr_accessor :"#{method}_result"

      define_method method do |payload: nil, query: nil, &block|
        instance_variable_set("@#{method}_payload", payload)
        instance_variable_set("@#{method}_query", query)

        result = @parent_resource.send(method, payload: payload, query: query, &block)
        instance_variable_set("@#{method}_result", result)

        result
      end
    end
  end
end
