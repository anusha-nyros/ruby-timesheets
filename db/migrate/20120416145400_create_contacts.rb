class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :contact_type, default: 'contact'
      t.string :contact
      t.string :company
      t.string :email
      t.string :chat_tool
      t.integer :user_id
      t.boolean :active
      t.text :notes
      t.integer :organization_id

      t.timestamps
    end
    add_index :contacts, :contact_type
    add_index :contacts, :user_id
    add_index :contacts, :organization_id
  end
end
