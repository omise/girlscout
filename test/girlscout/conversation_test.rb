require 'support'

module GirlScout
  class ConversationTest < GirlScoutTest
    def setup
      super
      @conversation = Conversation.find(150312885)
    end

    def test_all_via_mailbox
      conversations = Mailbox.new(id: 61187).conversations
      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert_equal 150312885, conversations[0].id
    end

    def test_find
      assert_instance_of Conversation, @conversation
      assert_equal 150312885, @conversation.id
      assert_equal "We're here for you", @conversation.subject
    end

    def test_mailbox
      mailbox = @conversation.mailbox
      assert_instance_of Mailbox, mailbox
      assert_equal 61187, mailbox.id
    end

    def test_threads
      threads = @conversation.threads
      assert_equal 1, threads.length
      assert_instance_of Thread, threads[0]
      assert_equal 388656732, threads[0].id
    end
  end
end
