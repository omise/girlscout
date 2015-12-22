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

    protected

    def record_to(path, klass)
      Config.api_key = TEST_KEY
      original_resource = klass.resource
      klass.resource = nil

      path = File.absolute_path("#{FIXTURES_PATH}/api.helpscout.net/v1#{path}")

      WebMock.allow_net_connect!
      WebMock.after_request(real_requests_only: true) do |signature, response|
        require 'zlib'
        require 'stringio'

        body = Zlib::GzipReader.new(StringIO.new(response.body)).read rescue response.body
        body = JSON.pretty_generate(JSON.load(body)) rescue body
        File.write(path, body)
      end

      puts
      puts "RECORDING REQUEST FOR #{klass}"
      puts "TO: #{path}"
      puts
      yield

    ensure
      Config.reset!
      WebMock.disable_net_connect!
      klass.resource = original_resource
    end
  end
end
