class ChangeAmountType < ActiveRecord::Migration
  def self.up
  change_column :projects , :amount ,:decimal, :precision => 10, :scale => 1
  end

  def self.down
  change_column :projects , :amount ,:decimal
  end
end
