class CreateTimeRecords < ActiveRecord::Migration
  def change
    create_table :time_records do |t|
      t.date :activity_date
      t.string :description
      t.decimal :total_hours, precission: 7, scale: 2
      t.integer :pay_period_id
      t.integer :user_id

      t.timestamps
    end
    add_index :time_records, :pay_period_id
    add_index :time_records, :user_id
  end
end
