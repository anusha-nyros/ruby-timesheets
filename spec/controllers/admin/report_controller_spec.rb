require 'spec_helper'

describe Admin::ReportController do
  before(:each) do
    @admin = Factory(:admin)
    login_user(@admin)
    @pay_period = Factory(:pay_period, organization: @admin.organization)
  end
  
  describe "GET 'index'" do
    it "should only include pay_periods that belong to admin's organization" do
      pay_period = Factory(:pay_period)
      get 'index'
      assigns(:pay_periods).include?(pay_period).should be_false
      assigns(:pay_periods).should eq([@pay_period])
    end
  end

  describe "GET 'show'" do
    describe "with pay_period not belong to user" do
      it "should raise an exception" do
        pay_period = Factory(:pay_period)
        expect { get 'show', {pay_period_id: pay_period.to_param} }.to raise_error
        assigns(:pay_period).should be_nil
      end
    end
    
    describe "with pay_period belonging to user" do
      it "should assign pay_period" do
        get 'show', {pay_period_id: @pay_period.to_param} 
        assigns(:pay_period).should eq(@pay_period)
      end
      
      it "should not include time record not belong to an organization" do
        time_record = Factory(:time_record)
        get 'show', {pay_period_id: @pay_period.to_param} 
        assigns(:user_time_records).include?(time_record).should be_false
      end
    end
  end

  describe "GET 'detail'" do
    describe "with pay_period not belong to user" do
      it "should raise an exception" do
        pay_period = Factory(:pay_period)
        expect { 
          get 'details', {pay_period_id: pay_period.to_param} 
        }.to raise_error
        assigns(:pay_period).should be_nil
      end
    end
    
    describe "with pay_period belonging to user" do
      it "should assign pay_period" do
        get 'details', {pay_period_id: @pay_period.to_param} 
        assigns(:pay_period).should eq(@pay_period)
      end
      
      it "should not include time record not belong to an organization" do
        time_record = Factory(:time_record)
        get 'details', {pay_period_id: @pay_period.to_param} 
        assigns(:user_time_records).include?(time_record).should be_false
      end
    end
  end

end
