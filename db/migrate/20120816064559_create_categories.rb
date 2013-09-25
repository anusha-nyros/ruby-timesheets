class CreateCategories < ActiveRecord::Migration
  def self.up
     create_table :categories do |t|
      t.string :name
      t.string :slug
      t.integer :organization_id
      t.string :color
      t.string :group
      t.integer :folder_id
      t.boolean :use_privacy ,:default => false;
      t.timestamps
    end
    add_index :categories, :organization_id
    add_index :categories, :slug
    add_index :categories, :name
    add_index :categories, :use_privacy  
    add_index :categories, :folder_id 
    add_index :categories, :group
    add_index :categories, :color
  end

  def self.down
      drop_table :categories
  end
end
