require 'support'

module GirlScout
  describe Resource do
    PREFIX = "https://test.example.com/resource"

    before do
      @resource = Resource.new(PREFIX, resource_class: FakeRestResource)
    end

    it 'should append .json to underlying url' do
      assert @resource.url == "#{PREFIX}.json"
    end

    it 'should be indexable for child resource' do
      assert @resource['/child'].url == "#{PREFIX}/child.json"
    end

    describe 'http methods' do
      before do
        @resource.rest_resource.result = '{"hello": "world"}'
      end

      it 'should parses JSON response' do
        assert @resource.get["hello"] == "world"
      end

      it 'should responds to required HTTP methods' do
        [:get, :put, :post, :patch, :delete].each do |sym|
          assert @resource.respond_to?(sym), "resource does not support #{sym.to_s.upcase}"
        end
      end

      it 'should serializes params to query string' do
        params = { id: 1 }
        @resource.get(params)
        assert @resource.rest_resource.get_params == params, 'params not sent'
      end

      it 'should serializes payload to JSON' do
        payload = { hello: "world" }
        @resource.post(payload)
        assert payload.to_json == @resource.rest_resource.post_payload
      end

      it 'should not send payload if one was not given' do
        @resource.post
        assert @resource.rest_resource.post_payload.nil?
      end
    end
  end
end
