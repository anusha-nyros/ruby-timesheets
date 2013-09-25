class Addstatustopayperiod < ActiveRecord::Migration
   
  def self.up
   add_column :pay_periods , :status, :string
  end
  
  def self.down
    remove_column :pay_periods , :status
  end
  
end
