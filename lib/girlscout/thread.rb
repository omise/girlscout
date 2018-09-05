# frozen_string_literal: true

module GirlScout
  class Thread < GirlScout::Object
    def attachments
      @attachments ||= (self['attachments'] || []).map { |attr| Attachment.new(attr) }
    end

    def created_by
      return @created_by if defined? @created_by && @created_by

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
      json['createdBy'] = created_by.as_json if key?('created_by')
      json
    end
  end
end
