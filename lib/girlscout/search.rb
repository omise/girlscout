# frozen_string_literal: true

module GirlScout
  class Search < GirlScout::Object
    class << self
      def conversations(query)
        search(Conversation, query)
      end

      def users(query)
        search(User, query)
      end

      def customers(query)
        search(Customer, query)
      end

      private

      def search(klass, query)
        resource.url = klass.resource.url
        List.new(resource.get(query: query), klass)
      end
    end
  end
end
