module GirlScout
  class Conversation < GirlScout::Object
    endpoint '/conversations'

    class << self
      def find(id)
        Conversation.new(resource["/#{id}"].get["item"])
      end
    end
  end
end
