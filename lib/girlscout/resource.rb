require 'json'

module GirlScout
  class Resource
    METHODS = [:get, :put, :post, :patch, :delete]

    def initialize(url: "")
      @url = url
    end

    def url
      "#{@url}.json"
    end

    def [](path)
      Resource.new(url: "#{@url}#{path}")
    end

    METHODS.each do |method|
      define_method(method) do |payload: nil, query: nil, &block|
        options = { method: method }
        if payload
          options[:body] = JSON.generate(payload)
          options[:headers] ||= {}
          options[:headers]["Content-Type"] = "application/json"
        end
        if query
          options[:query] = query
        end

        request(options)
      end
    end

    def request(options={})
      auth = { user: Config.api_key, password: 'X' }
      JSON.parse(Excon.new(url, auth).request(options).body)
    end

    # def get(query=nil)
    #   opts = { }
    #   opts[:headers] = { params: query } if query

    #   parse(rest_resource.get(opts))
    # end

    # [:put, :post, :patch, :delete].each do |method|
    #   define_method(method.to_s) do |payload=nil|
    #     payload = serialize(payload) if payload
    #     parse(rest_resource.send(method, payload, content_type: :json))
    #   end
    # end

    private

    def parse(response)
      JSON.load(response)
    end

    def serialize(payload)
      payload.to_json
    end

    def call
    end
  end
end
