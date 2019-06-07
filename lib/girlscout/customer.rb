# frozen_string_literal: true

module GirlScout
  class Customer < GirlScout::Object
    endpoint '/customers'

    class << self
      def find(id)
        Customer.new(resource["/#{id}"].get)
      end

      def list(query = {})
        List.new(resource.get(query: query), Customer)
      end
    end
  end
end
