class CreateCategoriesUsers < ActiveRecord::Migration
  def change
    create_table :categories_users do |t|
      t.integer :category_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :categories_users, :category_id
    add_index :categories_users, :user_id
  end
end
