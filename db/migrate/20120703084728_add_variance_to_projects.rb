class AddVarianceToProjects < ActiveRecord::Migration
  def self.up
  add_column :projects , :variance , :decimal, :precision => 10, :scale => 1
  add_column :projects , :percent_variance ,:decimal, :precision => 10, :scale => 1
  end

  def self.down
  remove_column :projects , :variance 
  remove_column :projects , :percent_variance
  end
end
