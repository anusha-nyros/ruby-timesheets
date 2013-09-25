class CreateOrgtabs < ActiveRecord::Migration
  def change
    create_table :orgtabs do |t|
      t.string :tabname

      t.timestamps
    end
  end
end
