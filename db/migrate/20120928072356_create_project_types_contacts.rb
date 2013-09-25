class CreateProjectTypesContacts < ActiveRecord::Migration
   def self.up
   create_table :contacts_project_types, :id => false do |t|
      t.integer :contact_id
      t.integer :project_type_id
   end
  end

  def self.down
         drop_table :contacts_project_types
  end
end
