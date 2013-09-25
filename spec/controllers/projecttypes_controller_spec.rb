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

describe ProjecttypesController do

  # This should return the minimal set of attributes required to create a valid
  # Projecttype. As you add validations to Projecttype, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProjecttypesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all projecttypes as @projecttypes" do
      projecttype = Projecttype.create! valid_attributes
      get :index, {}, valid_session
      assigns(:projecttypes).should eq([projecttype])
    end
  end

  describe "GET show" do
    it "assigns the requested projecttype as @projecttype" do
      projecttype = Projecttype.create! valid_attributes
      get :show, {:id => projecttype.to_param}, valid_session
      assigns(:projecttype).should eq(projecttype)
    end
  end

  describe "GET new" do
    it "assigns a new projecttype as @projecttype" do
      get :new, {}, valid_session
      assigns(:projecttype).should be_a_new(Projecttype)
    end
  end

  describe "GET edit" do
    it "assigns the requested projecttype as @projecttype" do
      projecttype = Projecttype.create! valid_attributes
      get :edit, {:id => projecttype.to_param}, valid_session
      assigns(:projecttype).should eq(projecttype)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Projecttype" do
        expect {
          post :create, {:projecttype => valid_attributes}, valid_session
        }.to change(Projecttype, :count).by(1)
      end

      it "assigns a newly created projecttype as @projecttype" do
        post :create, {:projecttype => valid_attributes}, valid_session
        assigns(:projecttype).should be_a(Projecttype)
        assigns(:projecttype).should be_persisted
      end

      it "redirects to the created projecttype" do
        post :create, {:projecttype => valid_attributes}, valid_session
        response.should redirect_to(Projecttype.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved projecttype as @projecttype" do
        # Trigger the behavior that occurs when invalid params are submitted
        Projecttype.any_instance.stub(:save).and_return(false)
        post :create, {:projecttype => {}}, valid_session
        assigns(:projecttype).should be_a_new(Projecttype)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Projecttype.any_instance.stub(:save).and_return(false)
        post :create, {:projecttype => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested projecttype" do
        projecttype = Projecttype.create! valid_attributes
        # Assuming there are no other projecttypes in the database, this
        # specifies that the Projecttype created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Projecttype.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => projecttype.to_param, :projecttype => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested projecttype as @projecttype" do
        projecttype = Projecttype.create! valid_attributes
        put :update, {:id => projecttype.to_param, :projecttype => valid_attributes}, valid_session
        assigns(:projecttype).should eq(projecttype)
      end

      it "redirects to the projecttype" do
        projecttype = Projecttype.create! valid_attributes
        put :update, {:id => projecttype.to_param, :projecttype => valid_attributes}, valid_session
        response.should redirect_to(projecttype)
      end
    end

    describe "with invalid params" do
      it "assigns the projecttype as @projecttype" do
        projecttype = Projecttype.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Projecttype.any_instance.stub(:save).and_return(false)
        put :update, {:id => projecttype.to_param, :projecttype => {}}, valid_session
        assigns(:projecttype).should eq(projecttype)
      end

      it "re-renders the 'edit' template" do
        projecttype = Projecttype.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Projecttype.any_instance.stub(:save).and_return(false)
        put :update, {:id => projecttype.to_param, :projecttype => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested projecttype" do
      projecttype = Projecttype.create! valid_attributes
      expect {
        delete :destroy, {:id => projecttype.to_param}, valid_session
      }.to change(Projecttype, :count).by(-1)
    end

    it "redirects to the projecttypes list" do
      projecttype = Projecttype.create! valid_attributes
      delete :destroy, {:id => projecttype.to_param}, valid_session
      response.should redirect_to(projecttypes_url)
    end
  end

end