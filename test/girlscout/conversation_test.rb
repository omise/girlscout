require 'support'

module GirlScout
  class ConversationTest < GirlScoutTest
    def setup
      super
      @conversation = Conversation.find(150312885)
    end

    def teardown
      super
      Conversation.resource = nil
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

    def test_create_payload
      conversation = build_conversation
      result = { }
      result["item"] = conversation

      resource = fake_resource_for(Conversation, result) do
        Conversation.create(conversation)
      end

      payload = resource.post_payload
      assert_equal "ConversationTest.test_create", payload["subject"]
      assert_equal true, payload["reload"]
      assert_equal "customer", payload["customer"]["type"]
      assert_equal 61187, payload["mailbox"]["id"]

      thread = payload["threads"][1]
      assert_equal "this is a test message.", thread["body"]
      assert_equal 99212, thread["createdBy"]["id"]
    end

    def test_create
      conversation = Conversation.create(build_conversation)
      assert_equal "ConversationTest.test_create", conversation.subject
      assert_equal "test@example.com", conversation.customer.email
      assert_equal "this is a test note.", conversation.threads[1].body
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

    def test_customer
      customer = @conversation.customer
      assert_instance_of Customer, customer
      assert_equal 67941617, customer.id
    end

    def test_as_json
      json = build_conversation.as_json
      assert_instance_of Hash, json["customer"]
      assert_equal "customer", json["customer"]["type"], '"type" required for customer field.'
      assert_instance_of Hash, json["threads"][1]
      assert_instance_of Hash, json["mailbox"]
    end

    protected

    def build_conversation
      user = User.new(id: 99212)
      mailbox = Mailbox.new(id: 61187)
      customer = Customer.new(
        first_name: "noitasrevnoC",
        last_name: "tseT",
        email: "test@example.com"
      )
      note_thread = Thread.new(
        type: "note",
        created_by: user,
        body: "this is a test note."
      )
      message_thread = Thread.new(
        type: "message",
        created_by: user,
        body: "this is a test message."
      )

      Conversation.new(
        type: :email,
        subject: "ConversationTest.test_create",
        mailbox: mailbox,
        customer: customer,
        threads: [note_thread, message_thread]
      )
    end
  end
end
