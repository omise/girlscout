# frozen_string_literal: true

require 'support'

module GirlScout
  class CustomerTest < GirlScoutTest
    def test_list
      customers = Customer.list
      assert customers.length
      assert_instance_of Customer, customers[0]
    end

    def test_list_via_mailbox
      customers = Customer.list(mailbox_id: MAILBOX_ID)
      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal CUSTOMER_ID, customers[0].id
    end

    def test_find
      customer = find_customer
      assert_instance_of Customer, customer
      assert_equal CUSTOMER_ID, customer.id
      assert customer.first_name
      assert customer.last_name
    end

    private

    def find_customer
      Customer.find(CUSTOMER_ID)
    end
  end
end
