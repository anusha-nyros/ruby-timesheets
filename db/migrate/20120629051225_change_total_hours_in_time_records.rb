class ChangeTotalHoursInTimeRecords < ActiveRecord::Migration
  def up
  change_column :time_records , :total_hours ,:decimal, :precision => 10, :scale => 1
  end

  def down
  change_column :time_records , :total_hours ,:decimal
  end
end
