class AddExpensetypeIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :expensetype_id, :integer
  end
end
