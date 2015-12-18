require 'support'

module GirlScout
  describe Mailbox do
    before do
      Config.reset!
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

    it 'should have folders' do
      folders = Mailbox.find(61187).folders

      assert !folders.nil?
      assert folders.length
      assert folders[0].is_a?(Folder)
      assert folders[0].name == "Unassigned"
    end
  end
end
