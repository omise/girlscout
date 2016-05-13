require 'support'
require 'json'

module GirlScout
  class ListTest < GirlScoutTest
    def test_initialize
      assert get_list.items.all? { |item| item.is_a?(Object) }
    end

    def test_enumerable
      assert_operator get_list.count, :>, 0
      assert get_list.all? { |item| item.is_a?(Object) }
    end

    def test_size_aliases
      count = get_list.count
      assert_equal count, get_list.size
      assert_equal count, get_list.length
    end

    def test_indexable
      assert_instance_of Object, get_list[0], 'not indexable'
    end

    private

    def get_list
      url = "#{DEFAULT_API_PREFIX}/mailboxes/#{MAILBOX_ID}/conversations"
      List.new(Resource.new(url: url).get, Object)
    end
  end
end
