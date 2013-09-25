class CreateSwitchTabs < ActiveRecord::Migration
   def self.up
    create_table :switch_tabs do |t|
      t.string  :module_name
      t.boolean :state, :default => 1
      t.integer :user_value 


      t.timestamps
    end
  end

  def self.down
    drop_table :switch_tabs
  end 
end
