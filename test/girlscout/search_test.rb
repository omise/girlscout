require 'support'

module GirlScout
  class SearchTest < GirlScoutTest
    CONVERSATION_QUERY = 'ConversationTest.test_create'
    CUSTOMER_QUERY = 'Test Customer'

    def test_conversations_params
      rest_resource = fake_resource_for(Search) do
        Search.conversations(CONVERSATION_QUERY)
      end

      params = rest_resource.get_params
      assert_equal CONVERSATION_QUERY, params[:query]
    end

    def test_conversations
      conversations = Search.conversations(CONVERSATION_QUERY)

      assert conversations.length
      assert_instance_of Conversation, conversations[0]
      assert_equal 150312845, conversations[0].id
      assert_equal "Learning the basics", conversations[0].subject
    end

    def test_customers_params
      rest_resource = fake_resource_for(Search) do
        Search.customers(CUSTOMER_QUERY)
      end

      params = rest_resource.get_params
      assert_equal CUSTOMER_QUERY, params[:query]
    end

    def test_customers
      customers = Search.customers(CUSTOMER_QUERY)

      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal 67941617, customers[0].id
      assert_equal "Help Scout", customers[0].full_name
    end
  end
end
