class RenamePasswordInLinks < ActiveRecord::Migration
  def self.up
  rename_column :links ,:password , :pwd_hint
  end

  def self.down
  rename_column :links ,:pwd_hint,:password 
  end
end
