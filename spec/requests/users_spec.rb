require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "with valid parameter" do
      it "register the user" do
        visit signup_path
        fill_in "Username", with: 'user1'
        fill_in "Name", with: 'user1'
        fill_in "Email", with: 'user@email.com'
        fill_in "Password", with: 'secret'
        fill_in "Password confirmation", with: 'secret'
        fill_in "Organization name", with: 'My Organization'
        click_button "Create User"
        
        page.should have_content('Sucessfully signed up!')
      end
    end    
  end
end