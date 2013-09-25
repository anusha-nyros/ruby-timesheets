require 'spec_helper'

describe PayPeriod do
  describe "with valid parameter" do
    it "should save" do
      pay_period = Factory.build(:pay_period)
      pay_period.save.should be_true
    end
  end
  
  describe "without valid parameter" do
    it "should not save without pay_start" do
      pay_period = Factory.build(:pay_period, pay_start: nil)
      pay_period.save.should be_false
    end
    
    it "should not save without pay_end" do
      pay_period = Factory.build(:pay_period, pay_end: nil)
      pay_period.save.should be_false
    end
  end
  
  describe "total_hours" do
    before(:each) do
      @pay_period = Factory(:pay_period)
    end
    
    it "should return 0 if no time_record" do
      @pay_period.total_hours.to_i.should eq(0)
    end
    
    describe "with multiple time records" do
      before(:each) do
        @user = Factory(:user)
        Factory(:time_record, pay_period: @pay_period, total_hours: 2, user: @user)
        Factory(:time_record, pay_period: @pay_period, total_hours: 2)
        Factory(:time_record, pay_period: @pay_period, total_hours: 2)        
      end
      
      it "should return the total time_hours belonging to the period" do
        @pay_period.total_hours.should eq(6.0)
      end

      it "should return the total time_hours belongint to specific user if parameter exists" do
        @pay_period.total_hours(@user).should eq(2.0)
      end
    end  
  end
  
  describe "user_with_total_hours" do
    before(:each) do
      @pay_period = Factory(:pay_period)
      @user = Factory(:user, name: 'usertest')
      Factory(:time_record, pay_period: @pay_period, total_hours: 2, user: @user)
      Factory(:time_record, pay_period: @pay_period, total_hours: 2, user: @user)
      Factory(:time_record, pay_period: @pay_period, total_hours: 2)      
    end
    
    it "should return user name and total hours" do
      retval = @pay_period.user_with_total_hours.where(user_id: @user).first
      retval.name.should eq('usertest')
      retval.total.to_s.should eq("4.0")
    end
  end
end
