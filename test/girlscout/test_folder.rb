require 'support'

module GirlScout
  describe Folder do
    before do
      Folder.api_key = TEST_KEY
    end

    it 'should be retrievable via Mailbox' do
      folders = Mailbox.new(id: 61187).folders

      assert !folders.nil?
      assert folders.length
      assert folders[0].is_a?(Folder)
      assert folders[0].name == "Unassigned"
    end
  end
end
