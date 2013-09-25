class CreateFolders < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.string :name
      t.integer :organization_id
      t.string :slug
      t.integer :position
      t.boolean  :use_privacy ,:default => false
      t.timestamps
    end
    add_index :folders, :name
    add_index :folders, :organization_id
    add_index :folders, :use_privacy
    add_index :folders, :position
    add_index :folders, :slug
  end
     
  def self.down
      drop_table :folders
  end
end
