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
      List.new(folder_resource.get, Folder)
    end

    def conversations
      List.new(conversation_resource.get, Conversation)
    end

    protected

    def folder_resource
      @folder_resource ||= resource["/#{id}/folders"]
    end

    def conversation_resource
      @conversation_resource ||= resource["/#{id}/conversations"]
    end
  end
end
