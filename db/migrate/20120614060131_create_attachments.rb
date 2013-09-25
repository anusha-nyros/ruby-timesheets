class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :doc
      t.integer :project_id

      t.timestamps
    end
  end
end
