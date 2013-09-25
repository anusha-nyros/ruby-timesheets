require 'spec_helper'

describe TimeRecord do
  before(:each) do
    @hash = {}
  end
  
  describe "with valid parameter" do
    it "should save to database" do
      time_record = Factory.build(:time_record)
      time_record.save.should be_true
    end
  end
  
  describe "With invalid parameter" do
    it "should not save without activity date" do
      time_record = Factory.build(:time_record, activity_date: nil)
      time_record.save.should be_false
    end
    
    it "should not save without description" do
      time_record = Factory.build(:time_record, description: nil)
      time_record.save.should be_false
    end
  end
  
  describe "total_hours" do
    it "should exists" do
      time_record = Factory.build(:time_record, total_hours: nil)
      time_record.save.should be_false
    end
    
    it "should not have negative value" do
      time_record = Factory.build(:time_record, total_hours: -1)
      time_record.save.should be_false        
    end
    
    it "should not be more then 24" do
      time_record = Factory.build(:time_record, total_hours: 24.1)
      time_record.save.should be_false        
    end
  end
  
  describe "activity_date" do
    before(:each) do
      @pay_period = Factory(:pay_period, pay_start: '2012-03-05', pay_end: '2012-03-11') 
    end
    
    it "should save within pay period" do
      time_record = Factory.build(:time_record, activity_date: '2012-03-05', pay_period: @pay_period)
      time_record.save.should be_true
      time_record = Factory.build(:time_record, activity_date: '2012-03-11', pay_period: @pay_period)
      time_record.save.should be_true
      time_record = Factory.build(:time_record, activity_date: '2012-03-08', pay_period: @pay_period)
      time_record.save.should be_true
    end
    
    it "should not save outside of pay_period" do
      time_record = Factory.build(:time_record, activity_date: '2012-03-04', pay_period: @pay_period)
      time_record.save.should be_false
      time_record = Factory.build(:time_record, activity_date: '2012-03-12', pay_period: @pay_period)
      time_record.save.should be_false
    end
  end
end
