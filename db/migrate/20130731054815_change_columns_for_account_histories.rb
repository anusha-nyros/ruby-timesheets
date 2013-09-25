class ChangeColumnsForAccountHistories < ActiveRecord::Migration
  def up
  
  add_column :account_histories, :amount , :decimal ,:precision => 10, :scale => 5
  add_column :account_histories, :balance , :decimal , :precision => 10, :scale => 5
  
  end

  def down
  end
end
