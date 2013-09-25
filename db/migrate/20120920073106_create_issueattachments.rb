class CreateIssueattachments < ActiveRecord::Migration
  def change
    create_table :issueattachments do |t|
      t.string :issue_attach
      t.integer :issue_id

      t.timestamps
    end
  end
end
