class Addthreadnumtothread < ActiveRecord::Migration
  def up
  add_column :my_threads, :thread_number, :string
  end

  def down
  remove_column :my_threads, :thread_number
  
  end
end
