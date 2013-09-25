class Addcoltopayperiod < ActiveRecord::Migration
 def up
  add_column :pay_periods, :timecode, :string 
  end

  def down
  remove_column :pay_periods, :timecode
  
  end
end
