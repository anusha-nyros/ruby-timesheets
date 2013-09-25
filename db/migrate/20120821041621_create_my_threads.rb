class CreateMyThreads < ActiveRecord::Migration
  def change
    create_table :my_threads do |t|
      t.string :title
      t.text :description
      t.date :creation_date
      t.integer :user_id

      t.timestamps
    end
  end
end
