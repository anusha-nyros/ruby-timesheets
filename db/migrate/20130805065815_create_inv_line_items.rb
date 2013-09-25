class CreateInvLineItems < ActiveRecord::Migration
  def change
    create_table :inv_line_items do |t|
      t.string :reference
      t.text :description
      t.string :quantity
      t.string :unit
      t.integer :amount
      t.string :extended
      t.text :text_comment
      t.integer :invoice_id

      t.timestamps
    end
  end
end
