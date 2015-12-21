module GirlScout
  class Thread < GirlScout::Object
    def attachments
      @attachments ||= (self["attachments"] || []).map { |attr| Attachment.new(attr) }
    end
  end
end
