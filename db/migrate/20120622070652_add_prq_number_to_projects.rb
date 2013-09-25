class AddPrqNumberToProjects < ActiveRecord::Migration
  def self.up
    #say "Creating sequenze for project 0001"
    #execute 'CREATE SEQUENCE prq_no_seq START 1001;'
   add_column :projects , :prq_number , :string
   #say "Adding NEXTVAL('prq_no_seq') to column prq_number"
    #execute "ALTER TABLE projects ALTER COLUMN prq_number SET DEFAULT NEXTVAL('prq_no_seq');"
  end


  def self.down
    remove_column :projects , :prq_number
    #execute 'DROP SEQUENCE IF EXISTS prq_no_seq;'
  end

end

   

