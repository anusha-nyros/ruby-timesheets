class AddcolstothreadComments < ActiveRecord::Migration
  def up
  add_column :thread_comments, :organization_id, :integer
  add_column :thread_comments, :user_id, :integer
  end

  def down
  remove_column :thread_comments, :organization_id
  remove_column :thread_comments, :user_id
  end
end
