module GirlScout
  class Thread < GirlScout::Object
    def attachments
      @attachments ||= (self["attachments"] || []).map { |attr| Attachment.new(attr) }
    end

    def created_by
      return @created_by if @created_by

      attr = @attributes["createdBy"]
      creator_type = attr["type"].capitalize.constantize rescue User
      @created_by ||= creator_type.new(attr)
    end

    def as_json
      json = super
      json["createdBy"] = created_by.as_json if key?("created_by")
      json
    end
  end
end
