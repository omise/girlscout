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
          'Content-Type' => 'application/json; charset=UTF-8',
          'Authorization' => "Bearer #{Token.retrieve}"
        }
        options[:body] = JSON.generate(payload) if payload
        options[:query] = URI.encode_www_form(query) if query

        request(options)
      end
    end

    def request(options = {})
      response = Excon.new(@url).request(options)
      if response.status >= 400
        raise GirlScout::Error, JSON.parse(response.body)
      end

      JSON.parse(response.body)
    end
  end
end
