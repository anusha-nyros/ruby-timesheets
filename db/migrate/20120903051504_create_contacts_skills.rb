class CreateContactsSkills < ActiveRecord::Migration
  def self.up
create_table :contacts_skills, :id => false do |t|
      t.integer :contact_id
      t.integer :skill_id
  end
end

  def self.down
drop_table :contacts_skills
  end
end
