class CreateCreditcards < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|
      t.integer :number ,:limit => 8
      t.date :expiryon
      t.integer :organization_id
      t.integer :user_id

      t.timestamps
    end
  end
end
