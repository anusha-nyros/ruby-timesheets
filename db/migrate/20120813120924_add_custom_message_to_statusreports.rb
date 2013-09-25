class AddCustomMessageToStatusreports < ActiveRecord::Migration
  def self.up
  add_column :statusreports , :custom_message , :text
  end
  def self.down
  remove_column :statusreports , :custom_message
  end
end
