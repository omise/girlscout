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
      @conversations ||= List.new(conversation_resource.get(query: { mailbox: id }), Conversation)
    end

    def users
      @users ||= List.new(user_resource.get(query: { mailbox: id }), User)
    end

    def customers
      @customers ||= List.new(customer_resource.get, Customer)
    end

    protected

    def folder_resource
      @folder_resource ||= resource["/#{id}/folders"]
    end

    def customer_resource
      @customer_resource ||= resource["/#{id}/customers"]
    end

    # FIXME: Hack for API v2 by rebuild the resource.
    def conversation_resource
      @conversation_resource ||= Resource.new(url: "#{Config.api_prefix}/conversations")
    end

    # FIXME: Hack for API v2 by rebuild the resource.
    def user_resource
      @user_resource ||= Resource.new(url: "#{Config.api_prefix}/users")
    end
  end
end
