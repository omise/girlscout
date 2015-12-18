module GirlScout
  class Conversation < GirlScout::Object
    class << self
      def all
        resource.get
      end
    end
  end
end
