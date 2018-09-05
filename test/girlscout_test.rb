# frozen_string_literal: true

module GirlScout
  require 'json'

  class GirlScoutTest < Minitest::Test
    MAILBOX_ID      = 74_251
    USER_ID         = 120_780
    CUSTOMER_ID     = 81_767_317
    THREAD_ID       = 529_102_367
    ATTACHMENT_ID   = 41_031_124
    CONVERSATION_ID = 202_112_521

    def setup
      super
      Config.api_key = TEST_KEY
    end

    def run
      VCR.use_cassette(self.class.name.gsub(/::/, '_')) do
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
