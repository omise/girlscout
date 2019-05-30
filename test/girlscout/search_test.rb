# frozen_string_literal: true

require 'support'

module GirlScout
  class SearchTest < GirlScoutTest
    CONVERSATION_QUERY = '(subject:"Test")'
    CUSTOMER_QUERY     = '(firstName:"Girl")'

    def test_conversations_params
      query = spy_on(Search) do |spy|
        Search.conversations(query: CONVERSATION_QUERY)
        spy.get_query
      end

      assert_equal CONVERSATION_QUERY, query[:query]
    end

    def test_conversations_query
      conversations = Search.conversations(query: CONVERSATION_QUERY)

      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert_equal 'Test Conversation', conversations[0].subject
    end

    def test_by_mailbox
      conversations = Search.conversations(mailbox: MAILBOX_ID)

      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert_equal MAILBOX_ID, conversations[0].mailbox_id
    end

    def test_customers_params
      query = spy_on(Search) do |spy|
        Search.customers(query: CUSTOMER_QUERY)
        spy.get_query
      end

      assert_equal CUSTOMER_QUERY, query[:query]
    end

    def test_customers_query
      customers = Search.customers(query: CUSTOMER_QUERY)

      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal 'Girl', customers[0].first_name
    end
  end
end
