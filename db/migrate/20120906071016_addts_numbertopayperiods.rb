class AddtsNumbertopayperiods < ActiveRecord::Migration
  
  def self.up
   add_column :pay_periods , :timesheet_number , :string
  end
  
  def self.down
    remove_column :pay_periods , :timesheet_number
  end
  
end
