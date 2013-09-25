require 'spec_helper'

describe Organization do
  describe "With valid parameter" do
    it "should save to database" do
      organization = Factory.build(:organization)
      organization.save.should be_true
    end
    
    it "should increase the counter cache on a new user" do
      organization = Factory(:organization)
      user = Factory(:user, organization: organization)
      organization.reload
      organization.users_count.should eq(1)
    end
  end
  
  describe "without valid parameter" do
    it "should not save without name" do
      organization = Factory.build(:organization, name: nil)
      organization.save.should be_false
    end
    
    it "should not save without account_type" do
      organization = Factory.build(:organization, account_type: nil)
      organization.save.should be_false
    end
    
    it "should not save account_type other then timesheet and project" do
      Factory.build(:organization, account_type: 'timesheet').save.should be_true
      Factory.build(:organization, account_type: 'project').save.should be_true
      Factory.build(:organization, account_type: 'foo').save.should be_false
    end
  end
end
