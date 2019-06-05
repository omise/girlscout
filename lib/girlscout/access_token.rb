# frozen_string_literal: true

module GirlScout
  class AccessToken
    include GirlScout::Concerns::HasAttributes

    attr_reader :expires_at

    class << self
      def refresh
        response = Excon.post(
          "#{Config.api_prefix}/oauth2/token",
          body: credential,
          headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
        )
        raise GirlScout::Error, JSON.parse(response.body) if response.status >= 400

        new(JSON.parse(response.body))
      end

      private

      def credential
        URI.encode_www_form(
          client_id: Config.client_id,
          client_secret: Config.client_secret,
          grant_type: 'client_credentials'
        )
      end
    end

    def initialize(attr = {})
      @attributes = normalize_attributes(attr)
      @expires_at = Time.now + expires_in
    end

    def expired?
      @expires_at.to_i <= Time.now.to_i
    end

    def to_s
      access_token
    end
  end
end
