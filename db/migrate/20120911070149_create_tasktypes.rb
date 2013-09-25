class CreateTasktypes < ActiveRecord::Migration
  def change
    create_table :tasktypes do |t|
      t.string :tasktype
      t.date :datecreated
      t.integer :organization_id
      t.integer :projects_count

      t.timestamps
    end
  end
end
