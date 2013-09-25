class CreateLinkAccounts < ActiveRecord::Migration
  def change
    create_table :link_accounts do |t|
      t.string :source
      t.string :target
      t.integer :source_id
      t.integer :target_id
      t.integer :source_admin_id
      t.integer :target_admin_id
      t.string :accept
      t.string :request
      t.boolean :ignor
      t.boolean :remove

      t.timestamps
    end
  end
end
