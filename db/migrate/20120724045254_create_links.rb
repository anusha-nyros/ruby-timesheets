class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :product
      t.string :link
      t.string :user
      t.string :password
      t.text :notes

      t.timestamps
    end
  end
end
