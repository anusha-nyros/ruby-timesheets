class CreateExpensetypes < ActiveRecord::Migration
  def change
    create_table :expensetypes do |t|
      t.string :expensetype
      t.string :usage
      t.integer :organization_id

      t.timestamps
    end
  end
end
