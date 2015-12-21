module GirlScout
  class GirlScoutTest < Minitest::Test
    def setup
      super
      Config.reset!
    end
    def teardown
      super
      Config.reset!
    end
  end
end
