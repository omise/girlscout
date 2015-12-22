require 'support'

module GirlScout
  class CustomerTest < GirlScoutTest
    def setup
      super
      @customer = Customer.find(68344907)
    end

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
      assert_instance_of Customer, @customer
      assert_equal 68344907, @customer.id
      assert_equal "Test Customer", @customer.full_name
    end

    def test_as_json
      json = @customer.as_json
      assert_equal "customer", json["type"], '"type" field is required'
    end
  end
end
