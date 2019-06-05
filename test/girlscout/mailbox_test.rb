# frozen_string_literal: true

require 'support'

module GirlScout
  class MailboxTest < GirlScoutTest
    def test_list
      mailboxes = Mailbox.list

      refute_nil mailboxes
      assert mailboxes.length
      assert_instance_of Mailbox, mailboxes[0]
      assert mailboxes[0].id
      assert mailboxes[0].name
    end

    def test_find
      mailbox = Mailbox.find(MAILBOX_ID)
      assert_instance_of Mailbox, mailbox
      assert_equal MAILBOX_ID, mailbox.id
      assert mailbox.name
    end
  end
end
