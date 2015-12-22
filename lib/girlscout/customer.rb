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

    def as_json
      json = super
      json["type"] = "customer"
      json
    end
  end
end
