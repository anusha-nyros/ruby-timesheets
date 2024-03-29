require 'spec_helper'

describe ProjectsController do
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
  

  describe "User is logged in" do
   before(:each) do
      @organization = Factory(:organization, account_type: 'project')
      @user = Factory(:user, organization: @organization)
      login_user(@user)
      @project = Factory(:project, organization: @organization)
    end
    
    def valid_attributes
      {"title"=>"Project Title",
       "project_type"=>"Project type",
       "description"=>"Project Description",
       "amount"=>"Project Amount",
       "notes"=>"Project notes"}
    end
    
    describe "GET index" do
      it "assigns all projects as @projects" do
        other_project = Factory(:project)
        get :index, {}
        assigns(:projects).should eq([@project])
      end
    end

    describe "GET show" do
      it "assigns the requested project as @project" do
        get :show, {:id => @project.to_param}
        assigns(:project).should eq(@project)
      end
      
      it "should raise an exception if the project doesn't belong to organization" do
        other_project = Factory(:project)
        expect { get :show, {:id => other_project.to_param} }.to raise_exception
      end
    end

    describe "GET new" do
      it "assigns a new project as @project" do
        get :new, {}
        assigns(:project).should be_a_new(Project)
      end
    end

    describe "GET edit" do
      it "assigns the requested project as @project" do
        get :edit, {:id => @project.to_param}
        assigns(:project).should eq(@project)
      end
      
      it "should raise an exception if project deosn't belong to organization" do
        other_project = Factory(:project)
        expect { get :edit, {:id => other_project.to_param} }.to raise_exception
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Project" do
          expect {
            post :create, {:project => valid_attributes}
          }.to change(Project, :count).by(1)
        end

        it "assigns a newly created project as @project" do
          post :create, {:project => valid_attributes}
          assigns(:project).should be_a(Project)
          assigns(:project).should be_persisted
        end
        
        it "should assisgn project organization to current user organization" do
          post :create, {:project => valid_attributes}
          assigns(:project).organization.should eq(@organization)
        end

        it "redirects to the created project" do
          post :create, {:project => valid_attributes}
          response.should redirect_to(Project.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved project as @project" do
          Project.any_instance.stub(:save).and_return(false)
          post :create, {:project => {}}
          assigns(:project).should be_a_new(Project)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          post :create, {:project => {}}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested project" do
          Project.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => @project.to_param, :project => {'these' => 'params'}}
        end

        it "assigns the requested project as @project" do
          put :update, {:id => @project.to_param, :project => valid_attributes}
          assigns(:project).should eq(@project)
        end

        it "redirects to the project" do
          put :update, {:id => @project.to_param, :project => valid_attributes}
          response.should redirect_to(@project)
        end
      end

      describe "with invalid params" do
        it "raise an exception if project doesn't belong to organization" do
          project = Factory(:project)
          expect { put :update, {:id => project.to_param, :project => valid_attributes}}.to raise_exception
        end
        
        it "assigns the project as @project" do
          Project.any_instance.stub(:save).and_return(false)
          put :update, {:id => @project.to_param, :project => {}}
          assigns(:project).should eq(@project)
        end

        it "re-renders the 'edit' template" do
          Project.any_instance.stub(:save).and_return(false)
          put :update, {:id => @project.to_param, :project => {}}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested project" do
        expect {
          delete :destroy, {:id => @project.to_param}
        }.to change(Project, :count).by(-1)
      end

      it "redirects to the projects list" do
        delete :destroy, {:id => @project.to_param}
        response.should redirect_to(projects_url)
      end
      
      it "should raise an exception if it try to delete other organization" do
        project = Factory(:project)
        expect { delete :destroy, {:id => project.to_param} }.to raise_exception
      end
    end
  end
end
