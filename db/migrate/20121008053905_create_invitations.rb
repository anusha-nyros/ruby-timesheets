class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :username
      t.text :description
      t.string :send_to
      t.integer :user_id

      t.timestamps
    end
  end
end
