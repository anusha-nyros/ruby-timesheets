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

describe IssuetypesController do

  # This should return the minimal set of attributes required to create a valid
  # Issuetype. As you add validations to Issuetype, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # IssuetypesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all issuetypes as @issuetypes" do
      issuetype = Issuetype.create! valid_attributes
      get :index, {}, valid_session
      assigns(:issuetypes).should eq([issuetype])
    end
  end

  describe "GET show" do
    it "assigns the requested issuetype as @issuetype" do
      issuetype = Issuetype.create! valid_attributes
      get :show, {:id => issuetype.to_param}, valid_session
      assigns(:issuetype).should eq(issuetype)
    end
  end

  describe "GET new" do
    it "assigns a new issuetype as @issuetype" do
      get :new, {}, valid_session
      assigns(:issuetype).should be_a_new(Issuetype)
    end
  end

  describe "GET edit" do
    it "assigns the requested issuetype as @issuetype" do
      issuetype = Issuetype.create! valid_attributes
      get :edit, {:id => issuetype.to_param}, valid_session
      assigns(:issuetype).should eq(issuetype)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Issuetype" do
        expect {
          post :create, {:issuetype => valid_attributes}, valid_session
        }.to change(Issuetype, :count).by(1)
      end

      it "assigns a newly created issuetype as @issuetype" do
        post :create, {:issuetype => valid_attributes}, valid_session
        assigns(:issuetype).should be_a(Issuetype)
        assigns(:issuetype).should be_persisted
      end

      it "redirects to the created issuetype" do
        post :create, {:issuetype => valid_attributes}, valid_session
        response.should redirect_to(Issuetype.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved issuetype as @issuetype" do
        # Trigger the behavior that occurs when invalid params are submitted
        Issuetype.any_instance.stub(:save).and_return(false)
        post :create, {:issuetype => {}}, valid_session
        assigns(:issuetype).should be_a_new(Issuetype)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Issuetype.any_instance.stub(:save).and_return(false)
        post :create, {:issuetype => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested issuetype" do
        issuetype = Issuetype.create! valid_attributes
        # Assuming there are no other issuetypes in the database, this
        # specifies that the Issuetype created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Issuetype.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => issuetype.to_param, :issuetype => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested issuetype as @issuetype" do
        issuetype = Issuetype.create! valid_attributes
        put :update, {:id => issuetype.to_param, :issuetype => valid_attributes}, valid_session
        assigns(:issuetype).should eq(issuetype)
      end

      it "redirects to the issuetype" do
        issuetype = Issuetype.create! valid_attributes
        put :update, {:id => issuetype.to_param, :issuetype => valid_attributes}, valid_session
        response.should redirect_to(issuetype)
      end
    end

    describe "with invalid params" do
      it "assigns the issuetype as @issuetype" do
        issuetype = Issuetype.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Issuetype.any_instance.stub(:save).and_return(false)
        put :update, {:id => issuetype.to_param, :issuetype => {}}, valid_session
        assigns(:issuetype).should eq(issuetype)
      end

      it "re-renders the 'edit' template" do
        issuetype = Issuetype.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Issuetype.any_instance.stub(:save).and_return(false)
        put :update, {:id => issuetype.to_param, :issuetype => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested issuetype" do
      issuetype = Issuetype.create! valid_attributes
      expect {
        delete :destroy, {:id => issuetype.to_param}, valid_session
      }.to change(Issuetype, :count).by(-1)
    end

    it "redirects to the issuetypes list" do
      issuetype = Issuetype.create! valid_attributes
      delete :destroy, {:id => issuetype.to_param}, valid_session
      response.should redirect_to(issuetypes_url)
    end
  end

end