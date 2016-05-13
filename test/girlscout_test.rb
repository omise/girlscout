module GirlScout
  require 'json'

  class GirlScoutTest < Minitest::Test
    MAILBOX_ID      = 74251
    USER_ID         = 120780
    CUSTOMER_ID     = 81767317
    THREAD_ID       = 529102367
    ATTACHMENT_ID   = 41031124
    CONVERSATION_ID = 202112521

    def setup
      super
      Config.api_key = TEST_KEY
    end

    def run
      VCR.use_cassette(self.class.name.gsub(/::/,'_')) do
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
      return yield spy

    ensure
      object.resource = original_resource
    end
  end
end
