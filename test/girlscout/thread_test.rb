require 'support'

module GirlScout
  class ThreadTest < GirlScoutTest
    def setup
      super
      @conversation = Conversation.find(152205902)
      @first_thread = @conversation.threads.first
      @second_thread = @conversation.threads.last
    end

    def test_attachments
      assert_equal 0, @first_thread.attachments.count

      attachments = @second_thread.attachments
      assert attachments.length
      assert_instance_of Attachment, attachments[0]
      assert_equal 30670383, attachments[0].id
    end

    def test_created_by
      assert_instance_of User, @first_thread.created_by
      assert_equal 99212, @first_thread.created_by.id
    end

    def test_as_json
      user = User.new(id: 123)
      thread = Thread.new(id: 456, created_by: user)

      json = thread.as_json
      assert_equal thread.id, json["id"]
      assert_equal "user", json["createdBy"]["type"]
      assert_equal user.id, json["createdBy"]["id"]
    end
  end
end
