class AddColumnToAccountHistories < ActiveRecord::Migration
  def change
    add_column :account_histories, :assign_to, :string
  end
end
