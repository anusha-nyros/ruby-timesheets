class Addcontenttypetolinkimages < ActiveRecord::Migration

  def up
  add_column :linkimages, :content_type, :string
  add_column :linkimages, :file_size, :string 
  end

  def down
  remove_column :linkimages, :content_type
  remove_column :linkimages, :file_size 
  end

end
