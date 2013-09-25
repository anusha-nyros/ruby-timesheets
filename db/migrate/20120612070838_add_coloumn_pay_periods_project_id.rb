class AddColoumnPayPeriodsProjectId < ActiveRecord::Migration
  def up
     add_column :pay_periods, :project_id, :integer
  end

  def down
     remove_column :pay_periods, :project_id
  end
end
