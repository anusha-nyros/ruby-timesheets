class AddCreditStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit_status, :boolean ,:default => false
  end
end
