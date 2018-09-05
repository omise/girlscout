# frozen_string_literal: true

require 'support'

module GirlScout
  class ConversationTest < GirlScoutTest
    def test_all_via_mailbox
      conversations = Mailbox.new(id: MAILBOX_ID).conversations
      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert_equal CONVERSATION_ID, conversations[0].id
    end

    def test_find
      conversation = find_conversation
      assert_instance_of Conversation, conversation
      assert_equal CONVERSATION_ID, conversation.id
      assert_equal "We're here for you", conversation.subject
    end

    def test_create_payload
      payload = spy_on(Conversation) do |spy|
        Conversation.create(build_conversation)
        spy.post_payload
      end

      assert_equal 'ConversationTest.test_create', payload['subject']
      assert_equal true, payload['reload']
      assert_equal 'customer', payload['customer']['type']
      assert_equal MAILBOX_ID, payload['mailbox']['id']

      thread = payload['threads'][1]
      assert_equal 'this is a <strong>test</strong> message.', thread['body']
      assert_equal USER_ID, thread['createdBy']['id']
    end

    def test_create
      conversation = Conversation.create(build_conversation)
      assert_equal 'ConversationTest.test_create', conversation.subject
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
      assert_equal 1, threads.length
      assert_instance_of Thread, threads[0]
      assert_equal THREAD_ID, threads[0].id
    end

    def test_customer
      customer = find_conversation.customer
      assert_instance_of Customer, customer
      assert_equal CUSTOMER_ID, customer.id
    end

    def test_as_json
      json = build_conversation.as_json
      assert_instance_of Hash, json['customer']
      assert_equal 'customer', json['customer']['type'], '"type" required for customer field.'
      assert_instance_of Hash, json['threads'][1]
      assert_instance_of Hash, json['mailbox']
    end

    private

    def find_conversation
      Conversation.find(CONVERSATION_ID)
    end

    def build_conversation
      user    = User.new(id: USER_ID)
      mailbox = Mailbox.new(id: MAILBOX_ID)

      customer = Customer.new(
        first_name: 'noitasrevnoC',
        last_name: 'tseT',
        email: 'test@example.com'
      )

      note_thread = Thread.new(
        type: 'note',
        created_by: user,
        body: 'this is a test note.'
      )

      message_thread = Thread.new(
        type: 'message',
        created_by: user,
        body: 'this is a <strong>test</strong> message.'
      )

      Conversation.new(
        type: :email,
        subject: 'ConversationTest.test_create',
        mailbox: mailbox,
        customer: customer,
        threads: [note_thread, message_thread]
      )
    end
  end
end
