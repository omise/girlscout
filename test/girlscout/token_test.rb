# frozen_string_literal: true

require 'support'

module GirlScout
  class TokenTest < GirlScoutTest
    def test_retrieve
      token = Token.retrieve
      refute_nil token
    end
  end
end
