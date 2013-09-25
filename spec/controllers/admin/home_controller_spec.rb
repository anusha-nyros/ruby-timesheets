require 'spec_helper'

describe Admin::HomeController do
  before(:each) do
    admin = Factory(:admin)
    login_user(admin)
    @pay_period = Factory(:pay_period)
  end
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
