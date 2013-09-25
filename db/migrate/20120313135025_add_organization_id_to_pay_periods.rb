class AddOrganizationIdToPayPeriods < ActiveRecord::Migration
  def change
    add_column :pay_periods, :organization_id, :integer
    add_index :pay_periods, :organization_id

  end
end
