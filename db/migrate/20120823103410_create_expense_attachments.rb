class CreateExpenseAttachments < ActiveRecord::Migration
  def change
    create_table :expense_attachments do |t|
      t.string :doc
      t.integer :expense_id

      t.timestamps
    end
  end
end
