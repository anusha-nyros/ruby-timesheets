class CreateAccountHistories < ActiveRecord::Migration
  def change
    create_table :account_histories do |t|
      t.date :date
      t.string :num_invoice
      t.text :description
      t.string :type_of_account
      t.string :reference
      t.decimal :amount
      t.decimal :balance
      t.string :statement_attachment
      t.integer :contact_id
      t.integer :organization_id
      t.integer :user_id

      t.timestamps
    end
  end
end
