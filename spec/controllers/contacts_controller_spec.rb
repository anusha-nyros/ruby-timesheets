require 'spec_helper'

describe ContactsController do
  describe "User did not logged in" do
    it "should redirect to login page" do
      get :index, {}
      response.should redirect_to(login_path)
    end
  end
  
  describe "Account type is not project" do
    it "redirect to root page" do
      organization = Factory(:organization, account_type: 'timesheet')
      user = Factory(:user, organization: organization)
      login_user(user)

      get :index
      response.should redirect_to(root_url)
      flash[:alert].should_not be_nil
    end
  end
  
  describe "user logged in" do    
    before(:each) do
      @organization = Factory(:organization, account_type: 'project')
      @user = Factory(:user, organization: @organization)
      login_user(@user)
      @contact = Factory(:contact, organization: @organization)
    end
    
    def valid_attributes
      {"contact_type"=>"contact",
       "contact"=>"Contact name",
       "company"=>"company name",
       "email"=>"email@email.com",
       "chat_tool"=>"Chat tools",
       "active"=>true,
       "notes"=>"Notes"}
    end
    
    it "should not redirect to login path" do
      get :index
      response.should_not redirect_to(login_path)
    end
    
    describe "GET index" do
      it "assigns all contacts as @contacts in the same organization" do
        other_contact = Factory(:contact)
        get :index, {}
        assigns(:contacts).should eq([@contact])
      end
    end

    describe "GET show" do
      it "assigns the requested contact as @contact" do        
        get :show, {:id => @contact.to_param}
        assigns(:contact).should eq(@contact)
      end
      
      it "should not assign other organization @contact" do
        other_contact = Factory(:contact)
        expect { get :show, {:id => other_contact.to_param} }.to raise_error
      end
    end

    describe "GET new" do
      it "assigns a new contact as @contact" do
        get :new, {}
        assigns(:contact).should be_a_new(Contact)
      end
    end

    describe "GET edit" do
      it "assigns the requested contact as @contact" do
        get :edit, {:id => @contact.to_param}
        assigns(:contact).should eq(@contact)
      end
      
      it "should raise error if editing other organization contacs" do
        other_contact = Factory(:contact)
        expect { get :edit, {:id => other_contact.to_param} }.to raise_error
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Contact" do
          expect {
            post :create, {:contact => valid_attributes}
          }.to change(Contact, :count).by(1)
        end

        it "assigns a newly created contact as @contact" do
          post :create, {:contact => valid_attributes}
          assigns(:contact).should be_a(Contact)
          assigns(:contact).should be_persisted
        end
        
        it "should assign the organization as the current user's organization" do
          post :create, {:contact => valid_attributes}
          assigns(:contact).organization.should eq(@organization)
        end

        it "redirects to the created contact" do
          post :create, {:contact => valid_attributes}
          response.should redirect_to(Contact.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved contact as @contact" do
          # Trigger the behavior that occurs when invalid params are submitted
          Contact.any_instance.stub(:save).and_return(false)
          post :create, {:contact => {}}
          assigns(:contact).should be_a_new(Contact)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Contact.any_instance.stub(:save).and_return(false)
          post :create, {:contact => {}}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested contact" do
          Contact.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => @contact.to_param, :contact => {'these' => 'params'}}
        end

        it "assigns the requested contact as @contact" do
          put :update, {:id => @contact.to_param, :contact => valid_attributes}
          assigns(:contact).should eq(@contact)
        end

        it "redirects to the contact" do
          put :update, {:id => @contact.to_param, :contact => valid_attributes}
          response.should redirect_to(@contact)
        end
      end

      describe "with invalid params" do
        it "should raise error if try to edit other organization's contact" do
          other_contact = Factory(:contact)
          expect { put :update, {:id => other_contact.to_param, :contact => valid_attributes} }.to raise_error
        end
        
        it "assigns the contact as @contact" do
          Contact.any_instance.stub(:save).and_return(false)
          put :update, {:id => @contact.to_param, :contact => {}}
          assigns(:contact).should eq(@contact)
        end

        it "re-renders the 'edit' template" do
          Contact.any_instance.stub(:save).and_return(false)
          put :update, {:id => @contact.to_param, :contact => {}}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested contact" do
        expect {
          delete :destroy, {:id => @contact.to_param}
        }.to change(Contact, :count).by(-1)
      end

      it "redirects to the contacts list" do
        delete :destroy, {:id => @contact.to_param}
        response.should redirect_to(contacts_url)
      end
      
      it "should raise an error if try to delete other organization's contact" do
        other_contact = Factory(:contact)
        expect {
          delete :destroy, {id: other_contact.to_param}
        }.to raise_error
      end
    end
  end
end
