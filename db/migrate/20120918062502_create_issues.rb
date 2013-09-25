class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.integer :issuetype_id
      t.integer :project_type_id
      t.integer :project_id
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
