class CreateActivities < ActiveRecord::Migration
  def self.up
     create_table :activities do |t|
      t.date :date
      t.text :info
      t.integer :category_id
      t.integer :user_id
      t.integer :organization_id
      t.string :tags
      t.string :attachment
      t.integer :attachments_count ,default: 0
      t.string :priority

      t.timestamps
    end
    add_index :activities, :date
    add_index :activities, :category_id
    add_index :activities, :user_id
    add_index :activities, :organization_id
    add_index :activities, :tags
    add_index :activities, :priority
  end

  def self.down
    drop_table :activities
  end
end
