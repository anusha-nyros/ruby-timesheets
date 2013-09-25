class Admin::UsersController < Admin::AdminController
     
 layout "super", :only => [:superadmin_index, :users_edit, :super_home, :creditcards]
  # GET /admin/users
  def index
    @users = current_user.organization.users.order('name asc')
  end
  
  # GET /admin/users/new
  def new
     @user = User.new
     @user.active = true
     @orgtabs = Orgtab.all
  end
  
  # GET /admin/user/:id/edit
  def edit
    @user = current_user.organization.users.find(params[:id])
    @orgtabs = Orgtab.all
  end

  # POST /admin/users
  def create
    @user = User.new(params[:user], :as => "admin")
    @orgtabs = Orgtab.all
    @user.organization = current_user.organization
    checked_modules = check_modules_using(params[:module_list])
    uncheck_missing_modules(@orgtabs, checked_modules)  
    if @user.save
      redirect_to admin_users_path, :notice => "Sucessfully signed up!"
    else
      render :new  
    end
  end
  
  def update
    @user = current_user.organization.users.find(params[:id])
    @orgtabs = Orgtab.all
    checked_modules = check_modules_using(params[:module_list])
    uncheck_missing_modules(@orgtabs, checked_modules)
    if @user.update_attributes params[:user], :as => "admin"
      flash.notice = "Successfully updated user #{@user.username}"
      redirect_to admin_users_path
    else
      render :edit
    end
  end
    # DELETE /admin/user/:id
  def destroy
    @user = current_user.organization.users.find(params[:id])
    if @user.destroy
      flash[:notice] = "Sucessfully Deleted #{@user.username}"
    end
    redirect_to admin_users_path 
  end
   
  def superadmin_index
   @q = User.search(params[:q])
  @users = @q.result(:distinct  => true).find(:all, :order => 'admin DESC',  :conditions => {:admin => 1 })
  end
  
  def users_edit
    @user = User.find(params[:id], :conditions => {:admin => 1})
    puts "##############"
    puts @user.id
    
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
  end
  
  def sup_edit
  #render :text => "stop" and return
  @user = User.find(params[:id], :conditions => {:admin => 1})
  params[:user][:expiry_date] = change_date_format(params[:user][:expiry_date]) if !(params[:user][:expiry_date]).blank?
   if @user.update_attributes params[:user], :as => "admin"
  	if params[:user][:active] == "0"
  	 @user.organization.users.each {|u| u.update_attribute("active",0)}
  	else
  	 @user.organization.users.each {|u| u.update_attribute("active",1)}
  	end
      flash.notice = "Successfully Updated user #{@user.username}"
      redirect_to('/superadmin')
    end
   if params[:user][:expiry_date]
        @user.organization.update_attribute("expiry_date", @user.expiry_date)# if !@user.expiry_date.blank?
    end
  end
  
  def super_home
  end
  
 
  def creditcards
    @q = User.search(params[:q])
    @users = @q.result(:distinct => true).where("admin=?",true).includes(:creditcard).order('creditcards.updated_at DESC').page(params[:page]).per(25)
  end
  
  def upgrade_plans
    @user = current_user  
  end


   private #-------------------------

  def check_modules_using( module_id_array )
    checked_modules = []
    checked_params = module_id_array || []  
    for check_box_id in checked_params
      modules = Orgtab.find(check_box_id)
      if not @user.orgtabs.include?(modules)
        @user.orgtabs << modules
      end
      checked_modules <<  modules
    end
    return checked_modules
  end

  def uncheck_missing_modules( group_modules, checked_modules)
    missing_modules = group_modules - checked_modules
    for modl in missing_modules
      if @user.orgtabs.include?(modl)
         @user.orgtabs.delete(modl)
       end
    end
  end

end
