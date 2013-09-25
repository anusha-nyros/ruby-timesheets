class AddFieldsToExpenses < ActiveRecord::Migration
  def self.up
  add_column :expenses, :expense_type, :string
  add_column :expenses, :contact_type, :string
    add_column :expenses, :reference, :string
  end

def self.down 

  remove_column :expenses, :expense_type
  remove_column :expenses, :contact_type
  remove_column :expenses, :reference

end 
end
