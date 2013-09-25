class AddAmountChangesToExpensesProjectTypes < ActiveRecord::Migration
 def self.up
  change_column :payments , :amount ,:decimal, :precision => 10, :scale => 1,:default => 0
   change_column :expenses , :amount ,:decimal, :precision => 10, :scale => 1,:default => 0
add_column :project_types , :hours_budget , :decimal, :precision => 10, :scale => 1,:default => 0
  add_column :project_types , :expense_budget , :decimal, :precision => 10, :scale => 1,:default => 0
 add_column :project_types , :status_check, :string ,:default => "active"
add_column :expenses , :total_approved_amt , :decimal, :precision => 10, :scale => 1,:default => 0
change_column :payments , :approved_amt ,:decimal, :precision => 10, :scale => 1,:default => 0
  add_column :payments , :pay_amount ,:decimal, :precision => 10, :scale => 1,:default => 0
  add_column :expenses , :paid_expense_amt ,:decimal, :precision => 10, :scale => 1,:default => 0
  end

  def self.down
  change_column :payments , :amount ,:decimal
  change_column :expenses , :amount ,:decimal
   remove_column :project_types , :hours_budget
  remove_column :project_types , :expense_budget
  remove_column :project_types , :status_check
  remove_column :expenses , :total_approved_amt
change_column :payments , :approved_amt ,:decimal
  remove_column :payments , :pay_amount 
   remove_column :expenses , :paid_expense_amt
  end
end
