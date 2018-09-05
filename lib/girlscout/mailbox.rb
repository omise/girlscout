# frozen_string_literal: true

module GirlScout
  class Mailbox < GirlScout::Object
    endpoint '/mailboxes'

    class << self
      def all
        List.new(resource.get, Mailbox)
      end

      def find(id)
        Mailbox.new(resource["/#{id}"].get['item'])
      end
    end

    def folders
      @folders ||= List.new(folder_resource.get, Folder)
    end

    def conversations
      @conversations ||= List.new(conversation_resource.get, Conversation)
    end

    def users
      @users ||= List.new(user_resource.get, User)
    end

    def customers
      @customers ||= List.new(customer_resource.get, Customer)
    end

    protected

    def folder_resource
      @folder_resource ||= resource["/#{id}/folders"]
    end

    def conversation_resource
      @conversation_resource ||= resource["/#{id}/conversations"]
    end

    def user_resource
      @user_resource ||= resource["/#{id}/users"]
    end

    def customer_resource
      @customer_resource ||= resource["/#{id}/customers"]
    end
  end
end
