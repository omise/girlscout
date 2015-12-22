module GirlScout
  class Conversation < GirlScout::Object
    endpoint '/conversations'

    class << self
      def find(id)
        Conversation.new(resource["/#{id}"].get["item"])
      end
    end

    def threads
      @threads ||= (self["threads"] || []).map { |attr| Thread.new(attr) }
    end

    def mailbox
      @mailbox ||= Mailbox.new(self["mailbox"] || {})
    end
  end
end
