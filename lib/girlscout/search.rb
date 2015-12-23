module GirlScout
  class Search < GirlScout::Object
    endpoint '/search'

    class << self
      def conversations(query)
        List.new(resource['/conversations'].get(query: query), Conversation)
      end

      def customers(query)
        List.new(resource['/customers'].get(query: query), Customer)
      end
    end
  end
end
