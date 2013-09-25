class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :exp_number
      t.string :username
      t.date :date
      t.decimal :amount
      t.boolean :status
      t.date :approved_date
      t.integer :organization_id
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end
end
