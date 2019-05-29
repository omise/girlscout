# frozen_string_literal: true

module GirlScout
  class User < GirlScout::Object
    endpoint '/users'

    class << self
      def all
        List.new(resource.get, User)
      end

      def find(id)
        User.new(resource["/#{id}"].get)
      end

      def me
        find('me')
      end
    end

    def as_json
      json = super
      json['type'] = 'user'
      json
    end
  end
end
