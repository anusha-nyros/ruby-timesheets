class ChangedatatypeofcalNum < ActiveRecord::Migration
 def self.up
    change_table :calendars do |t|
      t.change :cal_num, :string
    end
  end
  def self.down
    change_table :calendars do |t|
      t.change :cal_num, :integer
    end
  end
end
