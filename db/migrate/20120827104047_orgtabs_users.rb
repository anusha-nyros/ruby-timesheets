class OrgtabsUsers < ActiveRecord::Migration
  def self.up
   create_table :orgtabs_users, :id => false  do |t|
   t.integer :user_id
   t.integer :orgtab_id
  end
  end

  def self.down
	drop_table :orgtabs_users
  end
end
