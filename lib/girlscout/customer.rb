# frozen_string_literal: true

module GirlScout
  class Customer < GirlScout::Object
    endpoint '/customers'

    class << self
      def all
        List.new(resource.get, Customer)
      end

      def find(id)
        Customer.new(resource["/#{id}"].get)
      end
    end
  end
end
