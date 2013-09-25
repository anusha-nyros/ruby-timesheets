class AddUnameToComments < ActiveRecord::Migration
   def self.up
    add_column :comments, :uname, :string

  end
def self.down
    remove_column :comments, :uname

  end
end
