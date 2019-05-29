# frozen_string_literal: true

require 'support'

module GirlScout
  class ResourceTest < GirlScoutTest
    TEST_URL = "#{DEFAULT_API_PREFIX}/users/me"

    def setup
      super
      @resource = Resource.new(url: TEST_URL)
    end

    def test_url
      assert_equal TEST_URL, @resource.url
    end

    def test_indexable
      child = @resource['/child']
      assert_instance_of Resource, child
      assert_equal "#{TEST_URL}/child", child.url
    end

    # Since HelpScout doesn't provide an echo API for testing,
    # actual serialization tests are done as part of endpoint tests.
    def test_get_methods_result
      assert_equal USER_ID, @resource.get['id']
    end
  end
end
