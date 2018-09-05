# frozen_string_literal: true

require 'json'

module GirlScout
  class Resource
    METHODS = %i[get put post patch delete].freeze

    def initialize(url: '')
      @url = url
    end

    def url
      "#{@url}.json"
    end

    def [](path)
      Resource.new(url: "#{@url}#{path}")
    end

    METHODS.each do |method|
      define_method(method) do |payload: nil, query: nil|
        options = { method: method }
        if payload
          options[:body] = JSON.generate(payload)
          options[:headers] ||= {}
          options[:headers]['Content-Type'] = 'application/json'
        end
        options[:query] = query if query

        request(options)
      end
    end

    def request(options = {})
      auth = { user: Config.api_key, password: 'X' }
      response = Excon.new(url, auth).request(options)
      if response.status >= 400 && response.status < 600
        raise GirlScout::Error, JSON.parse(response.body)
      end

      JSON.parse(response.body)
    end
  end
end
