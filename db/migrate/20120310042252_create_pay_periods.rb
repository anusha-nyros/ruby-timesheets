class CreatePayPeriods < ActiveRecord::Migration
  def change
    create_table :pay_periods do |t|
      t.date :pay_start
      t.date :pay_end
      t.boolean :active

      t.timestamps
    end
  end
end
