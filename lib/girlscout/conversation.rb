# frozen_string_literal: true

module GirlScout
  class Conversation < GirlScout::Object
    endpoint '/conversations'

    class << self
      def find(id)
        Conversation.new(resource["/#{id}"].get)
      end

      def list(query = {})
        List.new(resource.get(query: query), Conversation)
      end

      def create(attributes)
        attributes = attributes.as_json if attributes.respond_to?(:as_json)
        resource.post(payload: attributes)
      end
    end

    def customer
      @customer ||= Customer.new(self['customer'] || self['primary_customer'] || {})
    end

    def threads
      # `threads` is a number in response but must be an array in request payload.
      @threads ||= begin
        if self['threads'].is_a?(Array)
          (self['threads'] || []).map { |attr| Thread.new(attr) }
        else
          List.new(threads_resouce.get, Thread)
        end
      end
    end

    def mailbox
      @mailbox ||= begin
        if self['mailbox'].is_a?(Hash)
          Mailbox.new(self['mailbox'] || {})
        else
          Mailbox.new(Resource.new(url: self['Links']['mailbox']['href']).get)
        end
      end
    end

    def as_json
      json = super
      json['customer'] = customer.as_json if key?('customer')
      json['threads'] = threads.map(&:as_json) if key?('threads')
      json['mailbox'] = mailbox.as_json if key?('mailbox')
      json
    end

    private

    def threads_resouce
      @threads_resouce ||= Resource.new(url: self['Links']['threads']['href'])
    end
  end
end
