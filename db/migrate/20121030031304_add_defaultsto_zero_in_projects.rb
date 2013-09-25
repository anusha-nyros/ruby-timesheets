class AddDefaultstoZeroInProjects < ActiveRecord::Migration
  def self.up
  change_column :projects ,:amount ,:decimal , :precision => 10 , :scale => 1 , :default => 0.0
  change_column :projects ,:actual ,:decimal , :precision => 10 , :scale => 1 , :default => 0.0
  end

  def self.down
  change_column :projects ,:amount ,:decimal , :precision => 10 , :scale => 1
  change_column :projects ,:actual ,:decimal , :precision => 10 , :scale => 1
  end
end
