module GirlScout
  class Search < GirlScout::Object
    endpoint '/search'

    class << self
      def conversations(query)
        search(Conversation, query)
      end

      def customers(query)
        search(Customer, query)
      end

      private

      def search(klass, query)
        result = resource[klass.resource_path].get(query: { query: query })
        List.new(result, klass)
      end
    end
  end
end
