class AddDateCreatedToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :date_created, :date
  end
end
