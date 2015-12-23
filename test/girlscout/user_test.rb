require 'support'

module GirlScout
  class UserTest < GirlScoutTest
    def test_all_via_mailbox
      users = Mailbox.new(id: 61187).users
      assert users.length
      assert_instance_of User, users[0]
      assert_equal 99212, users[0].id
    end

    def test_all
      users = User.all
      assert users.length
      assert_instance_of User, users[0]
      assert_equal 99212, users[0].id
    end

    def test_find
      user = User.find(99212)
      assert_instance_of User, user
      assert_equal 99212, user.id
      assert_equal "Chakrit", user.first_name
    end

    def test_me
      me = User.me
      assert_instance_of User, me
      assert_equal 99212, me.id
      assert_equal "Chakrit", me.first_name
    end

    def test_as_json
      json = User.me.as_json
      assert_equal "user", json["type"], '"type" field is required."'
      assert_equal 99212, json["id"]

      json = User.new(id: 123).as_json
      assert_equal "user", json["type"], '"type" field is required."'
      assert_equal 123, json["id"]
    end
  end
end
