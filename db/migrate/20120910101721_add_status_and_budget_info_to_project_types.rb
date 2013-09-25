class AddStatusAndBudgetInfoToProjectTypes < ActiveRecord::Migration
  def change
    add_column :project_types, :status, :string
    add_column :project_types, :budget_info, :string
  end
end
