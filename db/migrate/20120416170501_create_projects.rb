class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :project_type
      t.string :description
      t.string :amount
      t.integer :contact_id
      t.integer :organization_id
      t.text :notes

      t.timestamps
    end
    add_index :projects, :contact_id
    add_index :projects, :organization_id
  end
end
