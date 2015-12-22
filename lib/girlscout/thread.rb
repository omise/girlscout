module GirlScout
  class Thread < GirlScout::Object
    def attachments
      @attachments ||= (self["attachments"] || []).map { |attr| Attachment.new(attr) }
    end

    def as_json
      # TODO: Test
      json = super.dup
      if key?("created_by")
        # HACK: The order of the keys being serialized is important, HelpScout will
        # complain about missing createdBy:type if we do not send it as the first arg.
        json["createdBy"] = created_by.as_json
        json["createdBy"]["type"] = created_by.class.name.downcase.split('::').last
      end

      json
    end
  end
end
