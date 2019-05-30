# frozen_string_literal: true

module GirlScout
  class Thread < GirlScout::Object
    def attachments
      @attachments ||= (self['Embedded']['attachments'] || []).map do |attr|
        Attachment.new(attr)
      end
    end

    def customer
      @customer ||= Customer.new(self['customer'] || {})
    end

    def as_json
      json = super
      json['customer'] = customer.as_json if key?('customer')
      json
    end
  end
end
