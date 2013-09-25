require 'spec_helper'

describe Contact do
  describe "with valid atrribute" do
    it "should save to database" do
      Factory.build(:contact).save.should be_true
    end
    
    it "should assign the user_id for the username" do
      other_user = Factory(:user)
      contact = Factory.create(:contact, username: other_user.username, user: nil)
      contact.user.should eq(other_user)
    end
  end
  
  describe "without valid attributes" do
    it "should not save without contact_type" do
      Factory.build(:contact, contact_type: nil).save.should be_false
    end
    
    it "should not save with username that is not on database" do
      contact = Factory.build(:contact, username: 'foo', user: nil)
      contact.save.should be_false
      contact.user.should be_nil
      
    end
    
    it "should not save contact_type other then contact, client and supplier" do
      Factory.build(:contact, contact_type: 'contact').save!.should be_true
      Factory.build(:contact, contact_type: 'client').save.should be_true
      Factory.build(:contact, contact_type: 'supplier').save.should be_true
      Factory.build(:contact, contact_type: 'foo').save.should be_false
    end
    
    it "shoudl not save without organization" do
      Factory.build(:contact, organization: nil)
    end
  end
end
