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

describe MeetingsController do

  # This should return the minimal set of attributes required to create a valid
  # Meeting. As you add validations to Meeting, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MeetingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all meetingses as @meetingses" do
      meeting = Meeting.create! valid_attributes
      get :index, {}, valid_session
      assigns(:meetings).should eq([meeting])
    end
  end

  describe "GET show" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :show, {:id => meeting.to_param}, valid_session
      assigns(:meeting).should eq(meeting)
    end
  end

  describe "GET new" do
    it "assigns a new meeting as @meeting" do
      get :new, {}, valid_session
      assigns(:meeting).should be_a_new(Meeting)
    end
  end

  describe "GET edit" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :edit, {:id => meeting.to_param}, valid_session
      assigns(:meeting).should eq(meeting)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Meeting" do
        expect {
          post :create, {:meeting => valid_attributes}, valid_session
        }.to change(Meeting, :count).by(1)
      end

      it "assigns a newly created meeting as @meeting" do
        post :create, {:meeting => valid_attributes}, valid_session
        assigns(:meeting).should be_a(Meeting)
        assigns(:meeting).should be_persisted
      end

      it "redirects to the created meeting" do
        post :create, {:meeting => valid_attributes}, valid_session
        response.should redirect_to(Meeting.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved meeting as @meeting" do
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        post :create, {:meeting => {}}, valid_session
        assigns(:meeting).should be_a_new(Meeting)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        post :create, {:meeting => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested meeting" do
        meeting = Meeting.create! valid_attributes
        # Assuming there are no other meetings in the database, this
        # specifies that the Meeting created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Meeting.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => meeting.to_param, :meeting => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested meeting as @meeting" do
        meeting = Meeting.create! valid_attributes
        put :update, {:id => meeting.to_param, :meeting => valid_attributes}, valid_session
        assigns(:meeting).should eq(meeting)
      end

      it "redirects to the meeting" do
        meeting = Meeting.create! valid_attributes
        put :update, {:id => meeting.to_param, :meeting => valid_attributes}, valid_session
        response.should redirect_to(meeting)
      end
    end

    describe "with invalid params" do
      it "assigns the meeting as @meeting" do
        meeting = Meeting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        put :update, {:id => meeting.to_param, :meeting => {}}, valid_session
        assigns(:meeting).should eq(meeting)
      end

      it "re-renders the 'edit' template" do
        meeting = Meeting.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Meeting.any_instance.stub(:save).and_return(false)
        put :update, {:id => meeting.to_param, :meeting => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested meeting" do
      meeting = Meeting.create! valid_attributes
      expect {
        delete :destroy, {:id => meeting.to_param}, valid_session
      }.to change(Meeting, :count).by(-1)
    end

    it "redirects to the meetings list" do
      meeting = Meeting.create! valid_attributes
      delete :destroy, {:id => meeting.to_param}, valid_session
      response.should redirect_to(meetings_url)
    end
  end

end
