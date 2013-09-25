class AddCompanyNameToPages < ActiveRecord::Migration
 def self.up
 add_column :pages , :company_name ,:string 
 end 
  
 def self.down
 remove_column :pages ,:company_name
 end 
end
