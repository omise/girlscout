module GirlScout
  class Customer < GirlScout::Object
    endpoint '/customers'

    class << self
      def all
        List.new(resource.get, Customer)
      end

      def find(id)
        Customer.new(resource["/#{id}"].get["item"])
      end
    end
  end
end
