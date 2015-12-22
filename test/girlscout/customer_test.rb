require 'support'

module GirlScout
  class CustomerTest < GirlScoutTest
    def test_all_via_mailbox
      Mailbox.resource = nil
      customers = Mailbox.new(id: 61187).customers
      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal 68344907, customers[0].id
    end

    def test_all
      customers = Customer.all
      assert customers.length
      assert_instance_of Customer, customers[0]
      assert_equal 68344907, customers[0].id
    end

    def test_find
      customer = Customer.find(68344907)
      assert_instance_of Customer, customer
      assert_equal 68344907, customer.id
      assert_equal "Test Customer", customer.full_name
    end
  end
end
