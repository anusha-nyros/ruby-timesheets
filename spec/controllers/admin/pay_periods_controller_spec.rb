require 'spec_helper'

describe Admin::PayPeriodsController do
  before(:each) do
    @organization = Factory(:organization)
    @admin = Factory(:admin, organization: @organization)
    login_user(@admin)
    @pay_period = Factory(:pay_period, organization: @organization)
  end

  describe "GET index" do
    describe "with empty pay periods" do
      it "should not raise error" do
        PayPeriod.destroy_all
        expect { get :index, {} }.to_not raise_error
        assigns(:pay_periods).should eq([])        
      end
    end
    
    it "assigns only pay_periods that belong to a user" do
      pay_period = Factory(:pay_period)
      get :index, {}
      assigns(:pay_periods).include?(pay_period).should be_false
      assigns(:pay_periods).should eq([@pay_period])
    end
  end
  
  describe "GET new" do
    it "should assign a new pay period" do
      get :new
      assigns(:pay_period).should be_a_new(PayPeriod)
      response.should render_template(:new)
    end
  end
  
  describe "GET edit" do
    describe "with pay_period belonging to the user" do
      it "should assign a new pay period" do
        get :edit, id: @pay_period.to_param
        assigns(:pay_period).should eq(@pay_period)
        response.should render_template(:edit)
      end      
    end
    
    describe "with pay_period not belonging to the user" do
      it "should raise an error" do
        pay_period = Factory(:pay_period)
        expect { get :edit, id: pay_period.to_param }.to raise_error
        assigns(:pay_period).should be_nil
      end
    end
  end
  
  describe "POST create" do
    describe "with valid parameter" do
      it "should assign the pay_period organization to admin's" do
        pay_period_hash = {pay_start: '2012-03-05', pay_end: '2012-03-11', active: true}
        
        expect { post :create, pay_period: pay_period_hash }.to change(PayPeriod, :count).by(1)
        assigns(:pay_period).should be_a(PayPeriod)
        assigns(:pay_period).organization.should eq(@admin.organization)
        assigns(:pay_period).should be_persisted
        response.should redirect_to(admin_pay_periods_path)
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved time_record as @pay_period" do
        # Trigger the behavior that occurs when invalid params are submitted
        PayPeriod.any_instance.stub(:save).and_return(false)
        post :create, {:pay_period => {}}
        assigns(:pay_period).should be_a_new(PayPeriod)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        PayPeriod.any_instance.stub(:save).and_return(false)
        post :create, {:pay_period => {}}
        response.should render_template("new")
      end
    end
  end
  
  describe "POST update" do
    describe "with pay_period does not belong to admin's organization" do
      it "should raise an errors" do
        pay_period = Factory(:pay_period)
        expect { 
          put :update, id: pay_period.to_param
        }.to raise_error        
      end
    end
    
    describe "with valid parameter" do
      before(:each) do
        @pay_period_hash = {"pay_start" => '2012-03-05', "pay_end" => '2012-03-11', "active" => true}        
      end

      it "should update the requested pay_period" do
        PayPeriod.any_instance.should_receive(:update_attributes).with(@pay_period_hash)
        put :update, id: @pay_period.to_param, pay_period: @pay_period_hash
      end
      
      it "assigns the requested time_record as @time_record" do
        put :update, id: @pay_period.to_param, pay_period: @pay_period_hash
        assigns(:pay_period).should eq(@pay_period)
      end
      
      it "should assign the pay_period organization to admin's" do
        expect { post :create, pay_period: @pay_period_hash }.to change(PayPeriod, :count).by(1)
        response.should redirect_to(admin_pay_periods_path)
        assigns(:pay_period).organization.should eq(@admin.organization)
      end
      
      it "should redirect to admin_pay_periods_path" do
        put :update, id: @pay_period.to_param, pay_period: @pay_period_hash
        response.should redirect_to(admin_pay_periods_path)
      end
    end
    
     it "assigns the pay_period as @pay_period" do
        # Trigger the behavior that occurs when invalid params are submitted
        PayPeriod.any_instance.stub(:save).and_return(false)
        put :update, id: @pay_period.to_param, pay_period: @pay_period_hash
        assigns(:time_record).should eq(@time_record)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        PayPeriod.any_instance.stub(:save).and_return(false)
        put :update, id: @pay_period.to_param, pay_period: @pay_period_hash
        response.should_not redirect_to(admin_pay_periods_path)
        response.should render_template("edit")
      end
  end
  
  describe "DELETE destroy" do
    describe "with pay_period not associated with user" do
      it "should raise error" do
        pay_period = Factory(:pay_period)
        expect {
          delete :destroy, {:id => pay_period.to_param}
        }.to raise_error
      end
    end
    
    describe "with time_record associated with user" do
      it "destroys the requested time_record" do
        expect {
          delete :destroy, { :id => @pay_period.to_param }
        }.to change(PayPeriod, :count).by(-1)
      end

      it "redirects to the time_records list" do
        delete :destroy, {:id => @pay_period.to_param}
        response.should redirect_to(admin_pay_periods_url)
      end      
    end
  end
end