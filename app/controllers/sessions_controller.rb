class SessionsController < ApplicationController
 layout 'app1'  
def new
    if current_user
      if current_user.admin? 
        redirect_to admin_root_path
      else
        redirect_to root_path
      end
    end
  end
  
  def create
    
    @user = login(params[:username], params[:password], params[:remember_me])
    if @user
      if !@user.active?
       logout
        flash.now[:error] = "Your account is not activated please follow the mailed instructions sent by goteamcloud"
       render :new
       elsif @user.superadmin == true
        redirect_to('/superadmin')
       elsif @user.admin?
          if plan_check?
             redirect_back_or_to new_creditcard_path, notice: "Please enter credit card info ..."
          else
             redirect_back_or_to admin_root_url, notice: "You have successfully logged in!" 
          end      
       else
          if admin_credit_check(@user)
            redirect_back_or_to root_url, notice: "You have successfully logged in!" 
          else
            logout
            flash.now[:error] = "Your plan is expired . please contact your administrator"
             render :new
          end
      end
    else
      flash.now[:error] = "Please make sure that username and password are valid and your account is activated"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to login_url, notice: "Your session is expired  thank you for using goteamcloud"
  end
  def custom_new
       #render :text => "#{params[:id]}" and return
       @user = User.find(params[:id])
       auto_login(@user)
    if @user
      if !@user.active?
       logout
       flash.now[:error] = "Your account is not activated please follow the mailed instructions sent by goteamcloud"
       render :new
      elsif @user.admin?
        redirect_back_or_to admin_root_url, notice: "You have successfully logged in!"
      else
        redirect_back_or_to root_url, notice: "You have successfully logged in!"
      end
    else
      flash.now[:error] = "Please make sure that username and password are valid and your account is activated"
      render :new
    end
 end

end
