require 'spec_helper'

describe ApplicationHelper do
  describe "alert_class" do
    it "display the class of the error" do
      helper.alert_class(:error).should eq("alert-error")
      helper.alert_class(:notice).should eq("alert-success")
      helper.alert_class(:alert).should eq("alert-info")
    end
  end
  
  describe "short_period" do
    it "format the period date" do
      pay_period = Factory.build(:pay_period)
      helper.short_period(pay_period).should eq("12 Mar - 18 Mar")
    end
  end
  
  describe "detail_date" do
    it "should display detail date format" do
      pay_period = Factory.build(:pay_period, pay_start: '2012-03-05')
      helper.detail_date(pay_period.pay_start).should eq('Monday March 05, 2012')
    end
  end
  
  describe "two_lines_or_200" do
    it "display normal if character less then 200" do
      text = "a" * 200
      helper.two_lines_or_200(text).should eq(text)
    end
    
    it "display only first two line" do
      text = "lorem\nipsum\ndolor"
      helper.two_lines_or_200(text).should eq("lorem\nipsum\n")
    end
    
    it "turncate if character is more then 200" do
      text_from = 'a' * 201
      text_to = 'a' * 197 + '...'
      helper.two_lines_or_200(text_from).should eq(text_to)
    end
  end
end