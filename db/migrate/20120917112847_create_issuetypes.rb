class CreateIssuetypes < ActiveRecord::Migration
  def change
    create_table :issuetypes do |t|
      t.string :issuetype
      t.string :usage
      t.integer :organization_id

      t.timestamps
    end
  end
end
