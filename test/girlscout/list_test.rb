require 'support'
require 'json'

module GirlScout
  class ListTest < GirlScoutTest
    ATTRIBUTES = JSON.load('{"page":1,"pages":1,"count":1,"items":[{"id":61187,"name":"Support","slug":"8b06d9e038840f05","email":"support@chakrit.net","createdAt":"2015-12-16T08:23:21Z","modifiedAt":"2015-12-16T08:23:34Z"}]}')

    def setup
      super
      @list = List.new(ATTRIBUTES, ListItem)
    end

    def test_initialize
      assert @list.items.all? { |item| item.is_a?(ListItem) }
    end

    def test_enumerable
      assert_operator @list.count, :>, 0
      assert @list.all? { |item| item.is_a?(ListItem) }
    end

    def test_size_aliases
      count = @list.count
      assert_equal count, @list.size
      assert_equal count, @list.length
    end

    def test_indexable
      assert_instance_of ListItem,  @list[0], 'not indexable'
    end

    private

    class ListItem < Object
    end
  end
end
