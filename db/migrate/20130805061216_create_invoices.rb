class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :invoice
      t.date :date
      t.string :client
      t.string :reference
      t.integer :amount
      t.integer :paid
      t.string :balance
      t.date :last_payment
      t.string :days_old
      t.string :aging
      t.integer :user_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
