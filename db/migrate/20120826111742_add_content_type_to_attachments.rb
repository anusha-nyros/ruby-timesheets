class AddContentTypeToAttachments < ActiveRecord::Migration
   def self.up
  add_column :attachments , :content_type ,:string
    end

  def self.down
  remove_column :attachments , :content_type 
    end
end
