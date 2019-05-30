# frozen_string_literal: true

require 'support'

module GirlScout
  class ThreadTest < GirlScoutTest
    def test_attachments
      attachments = find_thread.attachments
      assert !attachments.empty?
      assert_instance_of Attachment, attachments[0]
      assert_equal ATTACHMENT_ID, attachments[0].id
    end

    def test_as_json
      thread = Thread.new(id: 456)

      json = thread.as_json
      assert_equal thread.id, json['id']
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
