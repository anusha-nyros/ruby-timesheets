class ChangeColumnsInInvoices < ActiveRecord::Migration
  def up
  change_column :invoices, :balance, :integer
  change_column :invoices, :paid, :boolean
  end

  def down
  end
end
