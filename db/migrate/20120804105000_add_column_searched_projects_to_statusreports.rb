class AddColumnSearchedProjectsToStatusreports < ActiveRecord::Migration
def change
    add_column :statusreports, :searched_projects, :string
  end
end
