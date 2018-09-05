# frozen_string_literal: true

require 'support'

module GirlScout
  class CustomerTest < GirlScoutTest
    def test_all_via_mailbox
      Mailbox.resource = nil
      customers = Mailbox.new(id: MAILBOX_ID).customers
      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal CUSTOMER_ID, customers[0].id
    end

    def test_all
      customers = Customer.all
      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal CUSTOMER_ID, customers[0].id
    end

    def test_find
      customer = Customer.find(CUSTOMER_ID)
      assert_instance_of Customer, customer
      assert_equal CUSTOMER_ID, customer.id
      assert_equal 'noitasrevnoC tseT', customer.full_name
    end

    def test_as_json
      json = Customer.find(CUSTOMER_ID).as_json
      assert_equal 'customer', json['type'], '"type" field is required'
    end
  end
end
