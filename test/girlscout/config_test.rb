# frozen_string_literal: true

require 'support'

module GirlScout
  class ConfigTest < GirlScoutTest
    def setup
      # don't setup the keys!
    end

    def test_client_credentials
      assert Config.client_id.nil?, 'should defaults to nil'
      assert Config.client_secret.nil?, 'should defaults to nil'
    end

    def test_api_prefix
      assert Config.api_prefix == GirlScout::DEFAULT_API_PREFIX,
             'should defaults to defined constant'
    end

    def test_reset!
      Config.client_id = 'asdf'
      Config.client_secret = 'asdf'
      Config.api_prefix = 'zxcv'
      Config.reset!

      assert Config.client_id != 'asdf', 'should resets client_id'
      assert Config.client_secret != 'asdf', 'should resets client_secret'
      assert Config.api_prefix != 'zxcv', 'should resets api_prefix'
    end
  end
end
