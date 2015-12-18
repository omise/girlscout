require 'support'

module GirlScout
  describe Conversation do
    it 'should be retrievable via Mailbox' do
      conversations = Mailbox.new(id: 61187).conversations

      refute conversations.nil?
      assert conversations.length, 'result should not be empty'
      assert conversations[0].is_a?(Conversation), 'result is not a Conversation object'
    end
  end
end
