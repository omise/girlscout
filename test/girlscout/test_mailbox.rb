require 'support'

module GirlScout
  describe Mailbox do
    before do
      Mailbox.api_key = TEST_KEY
    end

    it 'should be retrievable' do
      mailboxes = Mailbox.all

      assert !mailboxes.nil?
      assert mailboxes.length
      assert mailboxes.first.is_a?(Mailbox)
    end

    it 'should be retrievable by id' do
      mailbox = Mailbox.find(61187)

      assert mailbox.is_a?(Mailbox)
      assert mailbox.email == "test@example.com"
    end
  end
end
