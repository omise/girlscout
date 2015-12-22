module GirlScout
  class User < GirlScout::Object
    endpoint '/users'

    class << self
      def all
        List.new(resource.get, User)
      end

      def find(id)
        User.new(resource["/#{id}"].get["item"])
      end

      def me
        find("me")
      end
    end
  end
end
