require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe LinkAccountsController do

  # This should return the minimal set of attributes required to create a valid
  # LinkAccount. As you add validations to LinkAccount, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LinkAccountsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all link_accounts as @link_accounts" do
      link_account = LinkAccount.create! valid_attributes
      get :index, {}, valid_session
      assigns(:link_accounts).should eq([link_account])
    end
  end

  describe "GET show" do
    it "assigns the requested link_account as @link_account" do
      link_account = LinkAccount.create! valid_attributes
      get :show, {:id => link_account.to_param}, valid_session
      assigns(:link_account).should eq(link_account)
    end
  end

  describe "GET new" do
    it "assigns a new link_account as @link_account" do
      get :new, {}, valid_session
      assigns(:link_account).should be_a_new(LinkAccount)
    end
  end

  describe "GET edit" do
    it "assigns the requested link_account as @link_account" do
      link_account = LinkAccount.create! valid_attributes
      get :edit, {:id => link_account.to_param}, valid_session
      assigns(:link_account).should eq(link_account)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new LinkAccount" do
        expect {
          post :create, {:link_account => valid_attributes}, valid_session
        }.to change(LinkAccount, :count).by(1)
      end

      it "assigns a newly created link_account as @link_account" do
        post :create, {:link_account => valid_attributes}, valid_session
        assigns(:link_account).should be_a(LinkAccount)
        assigns(:link_account).should be_persisted
      end

      it "redirects to the created link_account" do
        post :create, {:link_account => valid_attributes}, valid_session
        response.should redirect_to(LinkAccount.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved link_account as @link_account" do
        # Trigger the behavior that occurs when invalid params are submitted
        LinkAccount.any_instance.stub(:save).and_return(false)
        post :create, {:link_account => {}}, valid_session
        assigns(:link_account).should be_a_new(LinkAccount)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        LinkAccount.any_instance.stub(:save).and_return(false)
        post :create, {:link_account => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested link_account" do
        link_account = LinkAccount.create! valid_attributes
        # Assuming there are no other link_accounts in the database, this
        # specifies that the LinkAccount created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        LinkAccount.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => link_account.to_param, :link_account => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested link_account as @link_account" do
        link_account = LinkAccount.create! valid_attributes
        put :update, {:id => link_account.to_param, :link_account => valid_attributes}, valid_session
        assigns(:link_account).should eq(link_account)
      end

      it "redirects to the link_account" do
        link_account = LinkAccount.create! valid_attributes
        put :update, {:id => link_account.to_param, :link_account => valid_attributes}, valid_session
        response.should redirect_to(link_account)
      end
    end

    describe "with invalid params" do
      it "assigns the link_account as @link_account" do
        link_account = LinkAccount.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        LinkAccount.any_instance.stub(:save).and_return(false)
        put :update, {:id => link_account.to_param, :link_account => {}}, valid_session
        assigns(:link_account).should eq(link_account)
      end

      it "re-renders the 'edit' template" do
        link_account = LinkAccount.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        LinkAccount.any_instance.stub(:save).and_return(false)
        put :update, {:id => link_account.to_param, :link_account => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested link_account" do
      link_account = LinkAccount.create! valid_attributes
      expect {
        delete :destroy, {:id => link_account.to_param}, valid_session
      }.to change(LinkAccount, :count).by(-1)
    end

    it "redirects to the link_accounts list" do
      link_account = LinkAccount.create! valid_attributes
      delete :destroy, {:id => link_account.to_param}, valid_session
      response.should redirect_to(link_accounts_url)
    end
  end

end
