class AddFieldsToLineItems < ActiveRecord::Migration
   def self.up
  add_column :line_items ,:schedule_date, :date
  add_column :line_items ,:start_date ,:date
  add_column :line_items ,:end_date ,:date
  add_column :line_items ,:status_date,:date
  add_column :line_items ,:entered_by,:string
  add_column :line_items ,:reference,:string
  add_column :line_items ,:owner,:string
  add_column :line_items ,:amount,:decimal, :precision => 10, :scale => 1
  add_column :line_items ,:variance,:decimal, :precision => 10, :scale => 1
  add_column :line_items ,:percent_variance,:decimal, :precision => 10, :scale => 1
  add_column :line_items ,:actual,:decimal, :precision => 10, :scale => 1
 add_column :line_items,:contact_id , :integer
  add_column :line_items,:organization_id , :integer
  end

  def self.down
  remove_column :line_items ,:schedule_date
  remove_column :line_items ,:start_date
  remove_column :line_items ,:end_date
  remove_column :line_items ,:status_date
  remove_column :line_items ,:entered_by
  remove_column :line_items ,:reference
  remove_column :line_items ,:owner
  remove_column :line_items ,:amount
  remove_column :line_items ,:variance
  remove_column :line_items ,:percent_variance
  remove_column :line_items ,:actual
  remove_column :line_items,:contact_id
  remove_column :line_items,:organization_id
  end
end
