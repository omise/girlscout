module GirlScout
  class Conversation < GirlScout::Object
    endpoint '/conversations'

    has_many :threads, as: Thread
    has_one :mailbox, as: Mailbox

    class << self
      def find(id)
        Conversation.new(resource["/#{id}"].get["item"])
      end
    end

    def threads
      @threads ||= (self["threads"] || []).map { |attr| Thread.new(attr) }
    end

    def mailbox
      return nil unless key?("mailbox")
      @mailbox ||= Mailbox.new(self["mailbox"])
    end
  end
end
