# frozen_string_literal: true

module GirlScout
  class Mailbox < GirlScout::Object
    endpoint '/mailboxes'

    class << self
      def all
        List.new(resource.get, Mailbox)
      end

      def find(id)
        Mailbox.new(resource["/#{id}"].get)
      end
    end

    def folders
      @folders ||= List.new(folder_resource.get, Folder)
    end

    def conversations
      @conversations ||= Search.conversations(mailbox: id)
    end

    def users
      @user_resource ||= Search.users(mailbox: id)
    end

    def customers
      @customers ||= Search.customers(mailbox: id)
    end

    private

    def folder_resource
      @folder_resource ||= resource["/#{id}/folders"]
    end
  end
end
