class AddExpiryDatesToUsersOrganizations < ActiveRecord::Migration
    def self.up
  add_column :users ,:expiry_date ,:date 
  add_column :organizations ,:expiry_date ,:date
  end
  def self.down
  remove_column :users , :expiry_date
  remove_column :organizations , :expiry_date
  end 
end
