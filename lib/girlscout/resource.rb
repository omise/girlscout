require 'json'

module GirlScout
  class Resource
    def initialize(url="", options={})
      @url = url
      @options = options
    end

    def rest_resource
      return @rest_resource if @rest_resource
      return @rest_resource = @options[:resource] if @options[:resource]

      resource_class = @options[:resource_class] || RestClient::Resource
      @rest_resource = resource_class.new("#{@url}.json", @options)
    end

    def url
      rest_resource.url
    end

    def [](path)
      Resource.new("#{@url}#{path}", @options)
    end

    def get(query=nil)
      opts = { }
      opts[:headers] = { params: query } if query

      parse(rest_resource.get(opts))
    end

    [:put, :post, :patch, :delete].each do |method|
      define_method(method.to_s) do |payload=nil|
        payload = serialize(payload) if payload
        parse(rest_resource.send(method, payload))
      end
    end

    private

    def parse(response)
      JSON.load(response)
    end

    def serialize(payload)
      payload.to_json
    end
  end
end
