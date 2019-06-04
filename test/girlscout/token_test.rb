# frozen_string_literal: true

require 'support'

module GirlScout
  class TokenTest < GirlScoutTest
    def setup
      super
      Token.reset!
    end

    def test_retrieve
      refute_nil Token.retrieve
      refute Token.expired?
    end

    def test_token_not_change
      token = Token.retrieve
      assert_equal token, Token.retrieve
    end

    def test_refresh_when_expired
      token = Token.retrieve
      expires_at = Token.expires_at

      Timecop.freeze expires_at + 1 do
        assert Token.expired?
        refute_equal token, Token.retrieve
      end
    end
  end
end
