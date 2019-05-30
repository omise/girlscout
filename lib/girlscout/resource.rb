# frozen_string_literal: true

require 'json'

module GirlScout
  class Resource
    METHODS = %i[get put post patch delete].freeze

    attr_accessor :url

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

    private

    def request(options = {})
      response = Excon.new(@url).request(options)
      case response.status
      when 200
        JSON.parse(response.body)
      when 201
        response.headers['Resource-ID']
      else
        raise GirlScout::Error, message: error_message(response.body), code: response.status
      end
    end

    def error_message(body)
      body = JSON.parse(body)
      body['message'] || body['error_description']
    rescue JSON::ParserError
      body
    end
  end
end
