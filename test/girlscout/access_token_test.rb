# frozen_string_literal: true

require 'support'

module GirlScout
  class AccessTokenTest < GirlScoutTest
    def setup
      super
    end

    def test_refresh
      token = AccessToken.refresh
      refute token.expired?
      assert token.expires_at > Time.now
    end

    def test_expired
      token = AccessToken.refresh
      Time.stub(:now, token.expires_at) do
        assert token.expired?
      end
    end

    def test_to_string
      token = AccessToken.refresh
      assert_respond_to token, :to_s
      assert_equal token.to_s, token.access_token
    end
  end
end
