class CreateThreadComments < ActiveRecord::Migration
  def change
    create_table :thread_comments do |t|
      t.text :title
      t.integer :my_thread_id

      t.timestamps
    end
  end
end
