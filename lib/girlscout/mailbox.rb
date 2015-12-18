module GirlScout
  class Mailbox < GirlScout::Object
    endpoint '/mailboxes'

    class << self
      def all
        List.new(resource.get, Mailbox)
      end

      def find(id)
        Mailbox.new(resource["/#{id}"].get["item"])
      end
    end

    def folders
      @folders ||= List.new(resource["/#{id}/folders"].get, Folder)
    end

    def conversations
      @conversations ||= List.new(resource["/#{id}/conversations"].get, Conversation)
    end
  end
end
