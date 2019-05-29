# frozen_string_literal: true

module GirlScout
  require 'json'

  class GirlScoutTest < Minitest::Test

    MAILBOX_ID      = 185_191
    USER_ID         = 382_693
    CUSTOMER_ID     = 259_533_163
    CONVERSATION_ID = 866_372_793
    THREAD_ID       = 2_422_566_376
    ATTACHMENT_ID   = 196_819_958

    def setup
      super
      Config.client_id = TEST_CLIENT_ID
      Config.client_secret = TEST_CLIENT_SECRET
    end

    def run
      VCR.use_cassette(self.class.name.gsub(/::/, '_').downcase) do
        super
      end
    end

    def teardown
      super
      Config.reset!
    end

    protected

    def spy_on(object)
      original_resource = object.resource
      spy = ResourceSpy.new(original_resource)
      object.resource = spy
      yield spy
    ensure
      object.resource = original_resource
    end
  end
end
