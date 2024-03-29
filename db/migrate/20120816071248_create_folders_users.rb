class CreateFoldersUsers < ActiveRecord::Migration
 def up
    create_table :folders_users, :force => true do |t|
      t.integer :folder_id
      t.integer :user_id
    end
    add_index :folders_users, :folder_id
    add_index :folders_users, :user_id
  end

  def down
    remove_index :folders_users, :user_id
    remove_index :folders_users, :folder_id
  end
end
