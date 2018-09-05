# frozen_string_literal: true

require 'support'

module GirlScout
  class SearchTest < GirlScoutTest
    CONVERSATION_QUERY = 'ConversationTest.test_create'
    CUSTOMER_QUERY     = 'noitasrevnoC tseT'

    def test_conversations_params
      query = spy_on(Search) do |spy|
        Search.conversations(CONVERSATION_QUERY)
        spy.get_query
      end

      assert_equal CONVERSATION_QUERY, query[:query]
    end

    def test_conversations
      conversations = Search.conversations(CONVERSATION_QUERY)

      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert_equal CONVERSATION_ID, conversations[0].id
      assert_equal CONVERSATION_QUERY, conversations[0].subject
    end

    def test_customers_params
      query = spy_on(Search) do |spy|
        Search.customers(CUSTOMER_QUERY)
        spy.get_query
      end

      assert_equal CUSTOMER_QUERY, query[:query]
    end

    def test_customers
      customers = Search.customers(CUSTOMER_QUERY)
      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal CUSTOMER_ID, customers[0].id
      assert_equal CUSTOMER_QUERY, customers[0].full_name
    end
  end
end
