# frozen_string_literal: true

module GirlScout
  class User < GirlScout::Object
    endpoint '/users'

    class << self
      def find(id)
        User.new(resource["/#{id}"].get)
      end

      def list(query = {})
        List.new(resource.get(query: query), User)
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
