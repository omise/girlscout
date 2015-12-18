require 'support'

module GirlScout
  describe Config do
    TEST_KEY = '04f46582b440fc579d96fa50294131940158b089'
    TEST_PREFIX = 'https://www.example.com'

    before do
      Config.reset!
    end

    describe 'api_key' do
      it 'should defaults to nil' do
        assert Config.api_key.nil?
      end

      it 'should be settable' do
        Config.api_key = TEST_KEY
        assert Config.api_key == TEST_KEY
      end

      it 'should reset base resource' do
        resource = Object.resource
        Config.api_key = TEST_KEY
        assert Object.resource != resource
      end
    end

    describe 'api_prefix' do
      it 'should defaults to exported default' do
        assert !Config.api_prefix.nil?
        assert Config.api_prefix == GirlScout::DEFAULT_API_PREFIX
      end

      it 'should be settable' do
        Config.api_prefix = TEST_PREFIX
        assert Config.api_prefix == TEST_PREFIX
      end

      it 'should reset base resource' do
        resource = Object.resource
        Config.api_key = TEST_KEY
        assert Object.resource != resource
      end
    end
  end # describe Config
end
