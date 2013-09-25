class CreateLinkimages < ActiveRecord::Migration
  def change
    create_table :linkimages do |t|
      t.string :link_image
      t.integer :link_id

      t.timestamps
    end
  end
end
