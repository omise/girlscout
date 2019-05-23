# frozen_string_literal: true

require 'json'

module GirlScout
  class Resource
    METHODS = %i[get put post patch delete].freeze

    def initialize(url: '')
      @url = url
    end

    def [](path)
      Resource.new(url: "#{@url}#{path}")
    end

    METHODS.each do |method|
      define_method(method) do |payload: nil, query: nil|
        options = { method: method }
        options[:headers] = {
          'Content-Type': 'application/json',
          'Authorization': "Bearer #{Token.access_token}"
        }
        options[:body] = JSON.generate(payload) if payload
        options[:query] = query if query

        request(options)
      end
    end

    def request(options = {})
      response = Excon.new(@url).request(options)
      raise GirlScout::Error, JSON.parse(response.body) if response.status >= 400

      JSON.parse(response.body)
    end
  end
end
