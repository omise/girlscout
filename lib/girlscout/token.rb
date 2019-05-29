# frozen_string_literal: true

module GirlScout
  class Token
    @expires_at = Time.now

    class << self
      def retrieve
        expired? ? request : @token
      end

      def expired?
        @expires_at.to_i <= Time.now.to_i
      end

      private

      def request
        response = Excon.post(url, body: credential, headers: headers)
        raise GirlScout::Error, JSON.parse(response.body) if response.status >= 400

        response = JSON.parse(response.body)
        @token = response['access_token']
        @expires_at = Time.now + response['expires_in']
        @token
      end

      def credential
        URI.encode_www_form(
          client_id: Config.client_id,
          client_secret: Config.client_secret,
          grant_type: 'client_credentials'
        )
      end

      def headers
        { 'Content-Type' => 'application/x-www-form-urlencoded' }
      end

      def url
        "#{Config.api_prefix}/oauth2/token"
      end
    end
  end
end
