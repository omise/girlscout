require 'support'

module GirlScout
  class TestSimpleChild < Object
    def resource
      super
    end
  end

  class TestNestedChild < TestSimpleChild
    endpoint '/children'
  end

  describe Object do
    before do
      Object.api_key = nil
      Object.api_prefix = nil
      Config.reset!
    end

    it 'should contains base resource' do
      assert Object.resource.url == 'https://api.helpscout.net/v1.json'
    end

    it 'should allows nested child resource' do
      assert !TestNestedChild.resource.nil?
      assert TestNestedChild.resource.url == 'https://api.helpscout.net/v1/children.json'
    end

    it 'should wraps rest client resource' do
      assert Object.resource.is_a?(Resource)
    end

    it 'should allows instance to access resource' do
      assert Object.resource.url == TestSimpleChild.new.resource.url
    end

    [:api_key, :api_prefix].each do |attr|
      getter = attr
      setter = "#{attr}=".to_sym

      describe attr do
        it "should defaults to Config.#{attr}" do
          Config.send(setter, '123')
          Object.send(setter, nil)
          assert Object.send(getter) == Config.send(getter)
        end

        it 'should be settable separately from Config' do
          Object.send(setter, 'asdf')
          assert Object.send(getter) != Config.send(getter)
        end

        it 'should resets Resource' do
          resource = Object.resource
          Object.send(setter, '123')
          assert Object.resource != resource
        end
      end
    end # each
  end # describe Object
end
