class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :entry_date
      t.string :event

      t.timestamps
    end
  end
end
