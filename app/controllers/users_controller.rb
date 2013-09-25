class UsersController < ApplicationController
skip_before_filter :require_login, :only => [:index, :new, :create, :activate]

def index
    @users = current_user.organization.users.where("name like ? OR email like ?", "%#{params[:q]}%", "%#{params[:q]}%")
    @users.each{|user| user.name = "#{user.name} (#{user.email})"}
    respond_to do |format|
      format.json { render json: @users.as_json(only: [:id, :name]) }
    end
end
def activate
  if (@user = User.load_from_activation_token(params[:id]))
    @user.activate!
    redirect_to(login_path, :notice => 'Thank you for done with the activation process now you can login into goteamcloud')
  else
    not_authenticated
  end
end
  
   before_filter :authorize, :except => [:new, :create, :activate]

  def new
    @user = User.new
  end
  
  # POST /admin/users
  def create
    @user = User.new(params[:user])
    @user.active = true
    @user.admin = true
    
    @organization = Organization.new(name: params[:user][:organization_name], account_type: params[:user][:account_type])
    @user.organization = @organization
    
    # verify captcha if environment is not test
    if !Rails.env.test?
      captcha = verify_recaptcha
      flash[:error] = "Incorrect captcha" unless captcha
    else
      captcha = true
    end
    
    if captcha && @user.save
      redirect_to login_path, :notice => "Thank you for registering with goteamcloud please check your mail for activation instructions."
    else
      render :new  
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes params[:user]
      flash[:notice] = "Your account has been updated successfully!"
      redirect_to account_path
    else
      render :edit
    end
  end
 
  def preference_edit
    @user = User.find(params[:id])
  end
  def preferences
    @user = current_user
    if @user.update_attributes params[:user]
      flash[:notice] = "Your account has been updated successfully!"
      redirect_to admin_root_url
    else
      render :edit
    end
  end

end
