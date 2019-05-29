# frozen_string_literal: true

module GirlScout
  class Thread < GirlScout::Object
    def attachments
      @attachments ||= (self['Embedded']['attachments'] || []).map do |attr|
        Attachment.new(attr)
      end
    end

    def created_by
      @created_by = nil unless defined? @created_by
      return @created_by if @created_by

      attr = @attributes['createdBy']
      creator_type = begin
                       "GirlScout::#{attr['type'].capitalize}".constantize
                     rescue StandardError
                       User
                     end
      @created_by ||= creator_type.new(attr)
    end

    def as_json
      json = super
      json['created_by'] = created_by.as_json if key?('created_by')
      json
    end
  end
end
