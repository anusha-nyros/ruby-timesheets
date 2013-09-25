class AddCreditStatusToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :credit_status, :boolean ,:default => false
  end
end
