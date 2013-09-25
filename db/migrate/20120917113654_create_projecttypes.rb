class CreateProjecttypes < ActiveRecord::Migration
  def change
    create_table :projecttypes do |t|
      t.string :projecttype
      t.string :usage
      t.integer :organization_id

      t.timestamps
    end
  end
end
