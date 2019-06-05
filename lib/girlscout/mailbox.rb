# frozen_string_literal: true

module GirlScout
  class Mailbox < GirlScout::Object
    endpoint '/mailboxes'

    class << self
      def find(id)
        Mailbox.new(resource["/#{id}"].get)
      end

      def list
        List.new(resource.get, Mailbox)
      end
    end

    def folders
      @folders ||= List.new(resource["/#{id}/folders"].get, Folder)
    end
  end
end
