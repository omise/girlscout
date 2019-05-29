# frozen_string_literal: true

require 'support'
require 'json'

module GirlScout
  class ListTest < GirlScoutTest
    def test_initialize
      list.items.each do |item|
        assert item.is_a?(Object)
      end
    end

    def test_enumerable
      assert_operator list.count, :>, 0
      list.each do |item|
        assert item.is_a?(Object)
      end
    end

    def test_size_aliases
      count = list.count
      assert_equal count, list.size
      assert_equal count, list.length
    end

    def test_indexable
      assert_instance_of Mailbox, list[0], 'not indexable'
    end

    private

    def list
      # url = "#{DEFAULT_API_PREFIX}/mailboxes/#{MAILBOX_ID}/conversations"
      url = "#{DEFAULT_API_PREFIX}/mailboxes"
      List.new(Resource.new(url: url).get, Mailbox)
    end
  end
end
