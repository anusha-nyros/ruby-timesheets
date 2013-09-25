require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    describe "wihtout login" do
      it "returns redirect to login" do
        get 'index'
        response.status.should eq(302)
      end      
    end
    
    describe "with login" do
      it "return success" do
        @user = Factory(:user)
        login_user(@user)
        get 'index'
        response.should be_success
      end
    end
  end

end
