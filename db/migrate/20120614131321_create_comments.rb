class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :coment
      t.integer :project_id

      t.timestamps
    end
  end
end
