require 'spec_helper'

describe User do
  before(:each) do
    @user = { username: 'usertest', name: 'User Test', password: 'secret', password_confirmation: 'secret', group: 'User group1', email: 'user@foo.com', organization_name: 'organization_name'}
  end
  describe "Create user without valid parameter" do
    it "should not save without password" do
      userh = @user.dup
      userh[:password] = nil
      userh[:password_confirmation] = nil
      user = User.new userh
      user.organization = Factory(:organization)
      user.save.should be_false
    end
    
    it "should not save with unmatch password" do
      userh = @user.dup
      userh[:password] = '123456'
      userh[:password_confirmation] = '654321'
      user = User.new userh
      user.organization = Factory(:organization)
      user.save.should be_false
    end
    
    it "Should not assign property admin and active if not admin" do
      userh = @user.dup
      userh[:admin] = true
      lambda {
        user = User.new userh
        user.organization = Factory(:organization)
        user.save }.should raise_error
    end
    
    it "should not save with password less then 5 character" do
      userh = @user.dup
      userh[:password] = '1234'
      userh[:password_confirmation] = '1234'
      user = User.new userh
      user.organization = Factory(:organization)
      user.save.should be_false      
    end
    
    it "should not save without email" do
      userh = @user.dup
      userh[:email] = nil
      user = User.new userh
      user.organization = Factory(:organization)
      user.save.should be_false
    end
    
    it "should not save without name" do
      userh = @user.dup
      userh[:name] = nil
      user = User.new userh
      user.organization = Factory(:organization)      
      user.save.should be_false
    end
    
    it "should be unique username" do
      userh = @user.dup
      userb = @user.dup
      userb[:email] = "tester@else.com"
      user1 = User.new userh
      user1.organization = Factory(:organization)      
      user1.save.should be_true
      user2 = User.new userb
      user2.organization = Factory(:organization)    
      user2.save.should be_false
    end
    
    it "should be unique email" do
      userh = @user.dup
      userb = @user.dup
      userb[:username] = "others"
      user1 = User.new userh
      user1.organization = Factory(:organization)      
      user1.save.should be_true
      user2 = User.new userb
      user2.organization = Factory(:organization)      
      user2.save.should be_false
    end
    
    it "should not save when username is lessthen 5 character" do
      userh = @user.dup
      userh[:username] = '1234'
      user = User.new userh
      user.organization = Factory(:organization)      
      user.save.should be_false
    end
  end
  
  describe "pay_periods" do
    it "return nil if no organization" do
      user = Factory.build(:user, organization: nil)
      user.save(validation: false)
      user.organization.should be_nil
      expect { user.pay_periods }.to raise_error
    end
    
    it "return pay_period if organizatio exitst" do
      pay_period = Factory(:pay_period)
      user = Factory(:user, organization: pay_period.organization)
      user.organization.should_not be_nil
      user.pay_periods.should_not be_empty
      user.pay_periods.should eq([pay_period])
    end    
  end
end

