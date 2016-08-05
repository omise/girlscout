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
      response = Excon.new(url, auth).request(options)
      if response.status != 200
        raise GirlScout::Error.new(JSON.parse(response.body))
      end

      JSON.parse(response.body)
    end

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
