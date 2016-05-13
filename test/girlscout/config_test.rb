require 'support'

module GirlScout
  class ConfigTest < GirlScoutTest
    def setup
      # don't setup the keys!
    end

    def test_api_key
      assert Config.api_key.nil?, 'should defaults to nil'
    end

    def test_api_prefix
      assert Config.api_prefix == GirlScout::DEFAULT_API_PREFIX,
        'should defaults to defined constant'
    end

    def test_reset!
      Config.api_key = 'asdf'
      Config.api_prefix = 'zxcv'
      Config.reset!

      assert Config.api_key != 'asdf', 'should resets api_key'
      assert Config.api_prefix != 'zxcv', 'should resets api_prefix'
    end
  end
end
