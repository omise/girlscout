require 'support'

module GirlScout
  class ConversationTest < GirlScoutTest
    def test_all_via_mailbox
      conversations = Mailbox.new(id: 61187).conversations

      refute_nil conversations
      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert_equal 150312885, conversations[0].id
    end

    def test_find
      conversation = Conversation.find(150312885)

      refute_nil conversation
      assert_instance_of Conversation, conversation
      assert_equal 150312885, conversation.id
      assert_equal "We're here for you", conversation.subject
    end
  end
end
