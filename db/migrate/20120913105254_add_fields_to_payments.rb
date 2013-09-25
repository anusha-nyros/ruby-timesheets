class AddFieldsToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :amount, :decimal,:precision => 10, :scale => 1
    add_column :payments, :project, :string
    add_column :payments, :task, :string
   add_column :payments, :approved_amt, :decimal,:precision => 10, :scale => 1
  end

def self.down 
 remove_column :payments, :amount
remove_column :payments, :project
remove_column :payments, :task
remove_column :payments, :approved_amt

end 
end
