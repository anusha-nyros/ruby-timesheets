class AddPhoneAndFaxAndWebsiteAndFbAndLinkedinAddressToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :phone, :string
    add_column :contacts, :fax, :string
    add_column :contacts, :website, :string
    add_column :contacts, :fb, :string
    add_column :contacts, :linkedin, :string
    add_column :contacts, :address, :string
  end
end
