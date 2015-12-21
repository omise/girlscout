require 'support'

module GirlScout
  class ResourceTest < GirlScoutTest
    METHODS = [:get, :put, :post, :patch, :delete]
    PREFIX = "https://test.example.com/resource"
    RESULT = '{"hello":"world"}'

    def setup
      super
      @resource = Resource.new(PREFIX, resource_class: FakeRestResource)
      @rest_resource = @resource.rest_resource
      @rest_resource.result = RESULT
    end

    def test_url
      assert_match /\.json$/, @resource.url, 'should append .json to underlying url'
    end

    def test_indexable
      child = @resource['/child']
      assert_instance_of Resource, child
      assert_equal "#{PREFIX}/child.json", child.url
    end

    def test_http_methods
      METHODS.each do |sym|
        assert @resource.respond_to?(sym)
      end
    end

    # Request pipeline

    def test_should_parse_result
      assert_equal "world", @resource.get["hello"]
    end

    def test_should_serialize_params
      params = { id: 1 }
      @resource.get(params)
      assert_equal params, @rest_resource.get_params
    end

    def test_should_serialize_payload
      payload = { hello: "world" }
      @resource.post(payload)
      assert_equal payload.to_json, @rest_resource.post_payload
    end

    def test_should_skip_nil_payload
      @resource.post
      assert_nil @rest_resource.post_payload
    end
  end
end
