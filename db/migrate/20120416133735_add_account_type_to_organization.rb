class AddAccountTypeToOrganization < ActiveRecord::Migration
  def up
    add_column :organizations, :account_type, :string, default: 'timesheet'
    add_index :organizations, :account_type
    
    Organization.update_all(["account_type = ?", 'timesheet'])
  end
  
  def down
    remove_index :organizations, :account_type
    remove_column :organizations, :account_type
  end
end
