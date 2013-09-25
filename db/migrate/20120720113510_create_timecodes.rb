class CreateTimecodes < ActiveRecord::Migration
  def change
    create_table :timecodes do |t|
      t.string :code

      t.timestamps
    end
  end
end
