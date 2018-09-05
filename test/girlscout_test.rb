# frozen_string_literal: true

module GirlScout
  require 'json'

  class GirlScoutTest < Minitest::Test
    MAILBOX_ID      = 158_814
    USER_ID         = 308_775
    CUSTOMER_ID     = 203_786_875
    CONVERSATION_ID = 656_937_392
    THREAD_ID       = 1_812_692_475
    ATTACHMENT_ID   = 146_283_244

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
