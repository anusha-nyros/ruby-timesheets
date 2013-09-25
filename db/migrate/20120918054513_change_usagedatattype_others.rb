class ChangeUsagedatattypeOthers < ActiveRecord::Migration
  def self.up
change_column :projecttypes ,:usage, :text
change_column :expensetypes ,:usage, :text
change_column :issuetypes ,:usage, :text
#change_column :tasktypes ,:usage, :text
end

def self.down
change_column :projecttypes ,:usage, :string
change_column :expensetypes ,:usage, :string
change_column :issuetypes ,:usage, :string
#change_column :tasktypes ,:usage, :string
end 

end
