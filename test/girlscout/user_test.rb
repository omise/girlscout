# frozen_string_literal: true

require 'support'

module GirlScout
  class UserTest < GirlScoutTest
    def test_list_query
      users = User.list(email: 'a.phureewat@gmail.com')

      assert users.length
      assert_instance_of User, users[0]
      assert_equal 'Phureewat', users[0].first_name
    end

    def test_list_via_mailbox
      users = User.list(mailbox_id: MAILBOX_ID)
      assert users.length
      assert_instance_of User, users[0]
      assert_equal USER_ID, users[0].id
    end

    def test_list
      users = User.list
      assert users.length
      assert_instance_of User, users[0]
      assert_equal USER_ID, users[0].id
    end

    def test_find
      user = User.find(USER_ID)
      assert_instance_of User, user
      assert_equal USER_ID, user.id
      assert_equal 'Phureewat', user.first_name
    end

    def test_me
      me = User.me
      assert_instance_of User, me
      assert_equal USER_ID, me.id
      assert_equal 'Phureewat', me.first_name
    end

    def test_as_json
      json = User.me.as_json
      assert_equal 'user', json['type'], '"type" field is required."'
      assert_equal USER_ID, json['id']

      json = User.new(id: 123).as_json
      assert_equal 'user', json['type'], '"type" field is required."'
      assert_equal 123, json['id']
    end
  end
end
