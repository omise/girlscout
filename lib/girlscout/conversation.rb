module GirlScout
  class Conversation < GirlScout::Object
    endpoint '/conversations'

    class << self
      def find(id)
        Conversation.new(resource["/#{id}"].get["item"])
      end

      def create(attributes)
        attributes = attributes.as_json if attributes.is_a?(Object)
        attributes["reload"] ||= true
        Conversation.new(resource.post(attributes)["item"])
      end
    end

    def customer
      # TODO: Test
      @customer ||= Customer.new(self["customer"] || {})
    end

    def threads
      @threads ||= (self["threads"] || []).map { |attr| Thread.new(attr) }
    end

    def mailbox
      @mailbox ||= Mailbox.new(self["mailbox"] || {})
    end

    def as_json
      # TODO: Test
      json = super.dup
      if key?("customer")
        json["customer"] = customer.as_json
        json["customer"]["type"] = customer.class.name.downcase.split('::').last
      end

      json["threads"] = threads.map(&:as_json) if key?("threads")
      json["mailbox"] = mailbox.as_json if key?("mailbox")

      json
    end
  end
end
