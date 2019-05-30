# frozen_string_literal: true

require 'support'

module GirlScout
  class CustomerTest < GirlScoutTest
    def test_all_via_mailbox
      customers = Mailbox.new(id: MAILBOX_ID).customers
      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal CUSTOMER_ID, customers[0].id
    end

    def test_all
      customers = Customer.all
      assert customers.length
      assert_instance_of Customer, customers[0]
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
