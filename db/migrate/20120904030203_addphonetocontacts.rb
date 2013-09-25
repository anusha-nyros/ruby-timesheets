class Addphonetocontacts < ActiveRecord::Migration
  
  def up
  add_column :contacts, :mobile_phone, :string 
  end

  def down
  remove_column :contacts, :mobile_phone
  end
  
end
