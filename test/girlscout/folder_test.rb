require 'support'

module GirlScout
  class FolderTest < GirlScoutTest
    def test_all_via_mailbox
      folders = Mailbox.new(id: MAILBOX_ID).folders

      refute_nil folders.nil?
      assert folders.length
      assert_instance_of Folder, folders[0]
      assert_equal "Unassigned", folders[0].name
    end
  end
end
