require 'support'

module GirlScout
  class ThreadTest < GirlScoutTest
    def test_attachments
      attachments = find_thread.attachments
      assert attachments.length > 0
      assert_instance_of Attachment, attachments[0]
      assert_equal ATTACHMENT_ID, attachments[0].id
    end

    def test_created_by
      assert_instance_of User, find_thread.created_by
      assert_equal USER_ID, find_thread.created_by.id
    end

    def test_as_json
      user = User.new(id: 123)
      thread = Thread.new(id: 456, created_by: user)

      json = thread.as_json
      assert_equal thread.id, json["id"]
      assert_equal "user", json["createdBy"]["type"]
      assert_equal user.id, json["createdBy"]["id"]
    end

    private

    def find_conversation
      @conversation ||= Conversation.find(CONVERSATION_ID)
    end

    def find_thread
      find_conversation.threads.first
    end
  end
end
