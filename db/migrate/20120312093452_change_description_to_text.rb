class ChangeDescriptionToText < ActiveRecord::Migration
  def self.up
    change_table :time_records do |t|
      t.change :description, :text
    end
  end

  def self.down
    change_table :time_records do |t|
      t.change :description, :string
    end
  end
end
