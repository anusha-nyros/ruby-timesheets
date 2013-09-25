class AddOwnerAndIssueNumberToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :owner, :string
    add_column :issues, :issue_number, :string
  end
end
