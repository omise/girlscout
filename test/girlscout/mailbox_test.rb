require 'support'

module GirlScout
  class MailboxTest < GirlScoutTest
    def test_all
      mailboxes = Mailbox.all

      refute_nil mailboxes
      assert mailboxes.length
      assert_instance_of Mailbox, mailboxes[0]
      assert_equal MAILBOX_ID, mailboxes[0].id
    end

    def test_find
      mailbox = Mailbox.find(MAILBOX_ID)
      assert_instance_of Mailbox, mailbox
      assert_equal MAILBOX_ID, mailbox.id
      assert_equal "Support", mailbox.name
    end
  end
end
