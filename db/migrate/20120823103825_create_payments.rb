class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :vendor
      t.text :exp_description
      t.string :paymethod
      t.string :date
      t.integer :expense_id
      t.integer :user_id

      t.timestamps
    end
  end
end
