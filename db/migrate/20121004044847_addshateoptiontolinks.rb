class Addshateoptiontolinks < ActiveRecord::Migration
   def up
  add_column :links, :share_option, :string
  end

  def down
  remove_column :links, :share_option
  end
end
