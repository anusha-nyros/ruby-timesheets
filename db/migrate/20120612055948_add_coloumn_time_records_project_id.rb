class AddColoumnTimeRecordsProjectId < ActiveRecord::Migration
  def up
     add_column :time_records, :project_id, :integer
  end

  def down
     remove_column :time_records, :project_id
  end
end
