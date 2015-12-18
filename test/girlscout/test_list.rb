require 'support'
require 'json'

module GirlScout
  describe List do
    ATTRIBUTES = JSON.load('{"page":1,"pages":1,"count":1,"items":[{"id":61187,"name":"Support","slug":"8b06d9e038840f05","email":"support@chakrit.net","createdAt":"2015-12-16T08:23:21Z","modifiedAt":"2015-12-16T08:23:34Z"}]}')

    before do
      @list = List.new(ATTRIBUTES, Mailbox)
    end

    it 'should be creatable from JSON' do
      assert @list.items.all? { |item| item.is_a?(Mailbox) }
    end

    it 'should be enumerable' do
      assert @list.count > 0
      assert @list.all? { |item| item.is_a?(Mailbox) }
    end

    it 'should have size aliases' do
      assert @list.count > 0
      assert @list.count == @list.size
      assert @list.count == @list.length
    end

    it 'should be indexable' do
      assert @list[0].is_a?(Mailbox), 'not indexable.'
    end
  end
end
