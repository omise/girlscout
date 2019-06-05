# frozen_string_literal: true

require 'support'

module GirlScout
  class ConversationTest < GirlScoutTest
    def test_list
      conversations = Conversation.list
      assert conversations.length
      assert_instance_of Conversation, conversations[0]
    end

    def test_list_via_mailbox
      conversations = Conversation.list(mailbox_id: MAILBOX_ID)
      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert conversations[0].id
    end

    def test_list_via_status
      conversations = Conversation.list(status: :active)
      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert conversations[0].id
    end

    def test_find
      conversation = find_conversation
      assert_instance_of Conversation, conversation
      assert_equal CONVERSATION_ID, conversation.id
      assert conversation.subject
    end

    def test_create_payload
      payload = spy_on(Conversation) do |spy|
        Conversation.create(build_conversation)
        spy.post_payload
      end

      assert_equal 'Test Conversation', payload['subject']
      assert_equal MAILBOX_ID, payload['mailboxId']

      thread = payload['threads'][1]
      assert_equal 'this is a <strong>test</strong> message.', thread['text']
    end

    def test_create
      new_id = Conversation.create(build_conversation)
      conversation = Conversation.find(new_id)

      assert_equal 'Test Conversation', conversation.subject
      assert_equal 'test@example.com', conversation.customer.email
      assert_equal 'this is a test note.', conversation.threads[1].body
    end

    def test_mailbox
      mailbox = find_conversation.mailbox
      assert_instance_of Mailbox, mailbox
      assert_equal MAILBOX_ID, mailbox.id
    end

    def test_threads
      threads = find_conversation.threads
      assert threads.length
      assert_instance_of Thread, threads[0]
      assert_equal THREAD_ID, threads[0].id
    end

    def test_customer
      customer = find_conversation.customer
      assert_instance_of Customer, customer
      assert_equal 259_532_077, customer.id
    end

    def test_as_json
      json = build_conversation.as_json
      assert_instance_of Hash, json['customer']
      assert_instance_of Hash, json['threads'][1]
    end

    private

    def find_conversation
      Conversation.find(CONVERSATION_ID)
    end

    def build_conversation
      customer = Customer.new(
        first_name: 'Girl',
        last_name: 'Scout',
        email: 'test@example.com'
      )

      note_thread = Thread.new(
        customer: customer,
        type: 'note',
        text: 'this is a test note.'
      )

      customer_thread = Thread.new(
        customer: customer,
        type: 'customer',
        text: 'this is a <strong>test</strong> message.'
      )

      Conversation.new(
        type: :email,
        subject: 'Test Conversation',
        status: :active,
        mailbox_id: MAILBOX_ID,
        customer: customer,
        threads: [note_thread, customer_thread]
      )
    end
  end
end
