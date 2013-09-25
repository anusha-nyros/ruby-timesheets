class TimeRecordsController < ApplicationController
  before_filter :authorize
  before_filter :update_timesheet_number, :only=>'index'
  skip_before_filter  :verify_authenticity_token
  # GET /time_records
  # GET /time_records.json
  def index
     if params[:FILTER] == "ALL"
        @pay_periods = current_user.pay_periods.order('pay_start desc').find(:all)
         
        @chosen = "ALL"
   elsif params[:FILTER] == "Inactive"
       @pay_periods = current_user.pay_periods.order('pay_start desc').find(:all, :conditions => {:active => 0 })
       
       @chosen = "Inactive"
  elsif params[:FILTER] == "Active"
        @pay_periods = current_user.pay_periods.order('pay_start desc').find(:all, :conditions => {:active => 1 })
        
        @chosen = "Active"
   elsif params[:status] == "Open"
      @pay_periods = current_user.organization.pay_periods.find(:all, :conditions => {:status => 'Open' }) 
   elsif params[:status] == "Pending"
      @pay_periods = current_user.pay_periods.find(:all, :conditions => {:status => 'Pending'})
   elsif params[:FILTER].blank?

    @pay_periods = current_user.pay_periods.order('pay_start desc').find(:all, :conditions => {:active => 1 })
    @chosen = "Active"
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pay_periods }
    end
  end

  # GET /time_records/1
  # GET /time_records/1.json
  def show
    
   if current_user.admin == true
    @pay_period = current_user.pay_periods.find(params[:id])
    @q = @pay_period.time_records.search(params[:q])
    @time_records = @q.result(:distinct  => true).find(:all)
    else 
    @pay_period = current_user.pay_periods.find(params[:id])
    @q = @pay_period.time_records.where(:user_id  => current_user).search(params[:q])
    @time_records = @q.result(:distinct  => true).find(:all)
    end  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pay_period }
    end
  end

  # GET /time_records/new
  # GET /time_records/new.json
  def new
    @pay_period = current_user.pay_periods.find(params[:pay_period])
     
    if current_user.admin == true
     @projects = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @projects = contact.projects.find(:all, :order => "title")
     else
     @projects = []  #user doesnot have the contact type
     end

     if !params[:project_id].blank?
       @pay_period.project_id =	 params[:project_id]
     end
 
    unless @pay_period.active?
      flash[:error] = "The Period is not active!"
      redirect_to time_records_path and return
    end
    
    @time_record = @pay_period.time_records.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_record }
    end
  end

  # GET /time_records/1/edit
  def edit
   
  if current_user.admin == true
     @projects = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @projects = contact.projects.find(:all, :order => "title")
     else
     @projects = []  #user doesnot have the contact type
     end

    @time_record = current_user.time_records.find(params[:id])
    if !params[:project_id].blank?
     @time_record.project_id = params[:project_id]
    end
    @pay_period = @time_record.pay_period
    if @pay_period.nil?
      flash[:error] = "The records has no pay period associated with"
      redirect_to time_records_path and return
    end
  end

  # POST /time_records
  # POST /time_records.json
  def create
    @pay_period = current_user.pay_periods.find(params[:pay_period])
    unless @pay_period.active?
      flash[:error] = "The Period is not active!"
      redirect_to time_records_path and return
    end
    
    if current_user.admin == true
     @projects = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @projects = contact.projects.find(:all, :order => "title")
     else
     @projects = []  #user doesnot have the contact type
     end
    
    @time_record = TimeRecord.new(params[:time_record])
    @time_record.pay_period = @pay_period
    @time_record.project_id = @time_record.project_id
    @time_record.user = current_user
    #change default date format
    @time_record.activity_date = change_date_format(params[:time_record][:activity_date]) if !(params[:time_record][:activity_date]).blank?
    respond_to do |format|
      if @time_record.save
        if !@time_record.project_id.blank?
          fill_actual_new(@time_record.project_id)
          update_variance_new(@time_record.project_id)
        end 
        format.html { redirect_to time_record_path(@pay_period), notice: 'Time record was successfully created.' }
        format.json { render json: @time_record, status: :created, location: @time_record }
      else
        format.html { render action: "new" }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_records/1
  # PUT /time_records/1.json
  def update
  @time_record = current_user.time_records.find(params[:id])

   if !params[:project_id].blank?
     @time_record.project_id = params[:project_id]
   end
   @pay_period = @time_record.pay_period
   
  if current_user.admin == true
     @projects = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @projects = contact.projects.find(:all, :order => "title")
     else
     @projects = []  #user doesnot have the contact type
     end
   
   #change default date format when update time
   params[:time_record][:activity_date] = change_date_format(params[:time_record][:activity_date]) if !(params[:time_record][:activity_date]).blank?
    respond_to do |format|
      if @time_record.update_attributes(params[:time_record])
        if !@time_record.project_id.blank?
          fill_actual_new(@time_record.project_id)
          update_variance_new(@time_record.project_id)
        end 
        format.html { redirect_to time_record_path(@pay_period), notice: 'Time record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def status
   @pay_periods = current_user.pay_periods.find(params[:id])	
   if @pay_periods.active == true 
  flash[:notice] = "Time Sheet is Inactivated successfully"
  @pay_periods.active = 0
  elsif @pay_periods.active == false
    flash[:notice] = "Time Sheet is activated successfully"
     @pay_periods.active = 1         
  end
  if @pay_periods.update_attributes(params[:time_record])      
      redirect_to :action => :index,:page => params[:page]
    else
      flash[:notice] = "Unable to Active/Deactive Project" 
    end
   end


  # DELETE /time_records/1
  # DELETE /time_records/1.json
  def destroy
    @time_record = current_user.time_records.find(params[:id])
    @pay_period = @time_record.pay_period
    @time_record.destroy
        if !@time_record.project_id.blank?
          fill_actual_new(@time_record.project_id)
          update_variance_new(@time_record.project_id)
        end 

    respond_to do |format|
      format.html { redirect_to time_record_path(@pay_period) }
      format.json { head :no_content }
    end
  end
  
  
  def all_time
  if current_user.admin == true
    @pay_periods = current_user.pay_periods.find(:all)
    time_records = []
    @pay_periods.each do |pay_period|
    @q = pay_period.time_records.search(params[:q])
    time_records << @q.result(:distinct  => true).find(:all)
    end
    
    time_records.flatten!
    @time_records = time_records
    
 else
    @pay_periods = current_user.pay_periods.find(:all)
    time_records = []
    @pay_periods.each do |pay_period|
    @q = pay_period.time_records.where(:user_id  => current_user).search(params[:q])
    time_records << @q.result(:distinct  => true).find(:all)
    end
    
    time_records.flatten!
    @time_records = time_records
 end

  end
  
  def search
     #change dateformat in search with activity date
    params[:q][:activity_date_cont] = change_date_format(params[:q][:activity_date_cont]) if !(params[:q][:activity_date_cont]).blank?
    if current_user.admin == true
    @pay_periods = current_user.pay_periods.find(:all)
    time_records = []
    @pay_periods.each do |pay_period|
    @q = pay_period.time_records.search(params[:q])
    time_records << @q.result(:distinct  => true).find(:all)
    end
    
    time_records.flatten!
    if params[:q]
      @time_records = time_records
    end
    
 else
    @pay_periods = current_user.pay_periods.find(:all)
    time_records = []
    @pay_periods.each do |pay_period|
    @q = pay_period.time_records.where(:user_id  => current_user).search(params[:q])
    time_records << @q.result(:distinct  => true).find(:all)
    end
    
    time_records.flatten!
   if params[:q]
      @time_records = time_records
    end
   end
     
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  def view
    @pay_period_id = params[:id]
   if current_user.admin == true
    @pay_period = current_user.pay_periods.find(params[:id])
    @q = @pay_period.time_records.search(params[:q])
    @time_records = @q.result(:distinct  => true).find(:all)
    @cntcts = current_user.organization.contacts
    else 
    @pay_period = current_user.pay_periods.find(params[:id])
    @q = @pay_period.time_records.where(:user_id  => current_user).search(params[:q])
    @time_records = @q.result(:distinct  => true).find(:all)
    @cntcts = current_user.organization.contacts
    end  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pay_period }
    end
end

def maillist
    @pay_period_id = params[:id]
    if current_user.admin == true
    @pay_period = current_user.pay_periods.find(params[:id])
    @q = @pay_period.time_records.search(params[:q])
    @time_records = @q.result(:distinct  => true).find(:all)
    @cntcts = current_user.organization.contacts
    else 
    @pay_period = current_user.pay_periods.find(params[:id])
    @q = @pay_period.time_records.where(:user_id  => current_user).search(params[:q])
    @time_records = @q.result(:distinct  => true).find(:all)
    @cntcts = current_user.organization.contacts
    end  
  render :partial => "maillist", :layout => false
end

def user_recap
    @pay_period_id = params[:pay_period_id]
    if current_user.admin == true
    @pay_period = current_user.pay_periods.find(params[:pay_period_id])
    @user_time_records = @pay_period.time_records.joins(:user).order('users.name desc').group_by { |rec| rec.user }
    @cntcts = current_user.organization.contacts
    else
    @pay_period = current_user.pay_periods.find(params[:pay_period_id])
    @user_time_records = @pay_period.time_records.joins(:user).where(:user_id  => current_user).order('users.name desc').group_by { |rec| rec.user }
    @cntcts = current_user.organization.contacts
    end
end


def usrecap
    @pay_period_id = params[:id]
    if current_user.admin == true
    @pay_period = current_user.pay_periods.find(params[:id])
    @user_time_records = @pay_period.time_records.joins(:user).order('users.name desc').group_by { |rec| rec.user }
    @cntcts = current_user.organization.contacts
    else
    @pay_period = current_user.pay_periods.find(params[:id])
    @user_time_records = @pay_period.time_records.joins(:user).where(:user_id  => current_user).order('users.name desc').group_by { |rec| rec.user }
    @cntcts = current_user.organization.contacts
    end
    render :partial => "usrecap", :layout => false
end

def project_recap
        @pay_period_id = params[:pay_period_id]
        if current_user.admin == true
           @pay_period = current_user.pay_periods.find(params[:pay_period_id])
          @user_time_records = @pay_period.time_records.joins(:project).order('projects.title desc').group_by { |rec| rec.project }
          @cntcts = current_user.organization.contacts
         else
          @pay_period = current_user.pay_periods.find(params[:pay_period_id])
          @user_time_records = @pay_period.time_records.joins(:project).where(:user_id  => current_user).order('projects.title desc').group_by { |rec| rec.project }
           @cntcts = current_user.organization.contacts
        end
   end
 
 def pjrecap
  
      @pay_period_id = params[:id]
        if current_user.admin == true
           @pay_period = current_user.pay_periods.find(params[:id])
          @user_time_records = @pay_period.time_records.joins(:project).order('projects.title desc').group_by { |rec| rec.project }
          @cntcts = current_user.organization.contacts
         else
          @pay_period = current_user.pay_periods.find(params[:id])
          @user_time_records = @pay_period.time_records.joins(:project).where(:user_id  => current_user).order('projects.title desc').group_by { |rec| rec.project }
           @cntcts = current_user.organization.contacts
        end
      render :partial => "pjrecap", :layout => false
 end



  def mail_time_records
   if current_user.admin == true
    @pay_period = current_user.pay_periods.find(params[:mailed_projects])
    @time_records = @pay_period.time_records
    @cntcts = current_user.organization.contacts
    else 
     @pay_period = current_user.pay_periods.find(params[:mailed_projects])
    @time_records = @pay_period.time_records.where(:user_id  => current_user)
    @cntcts = current_user.organization.contacts
    end  
    @cntcts = current_user.organization.contacts
    mycontacts=Array.new
    myemails = Array.new
    params[:project_check_all].split(",").map do |can_id|
    @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
      #mycontacts.push(@contact.email)
       mycontacts.push(@contact.contact)
       myemails.push(@contact.email)
    end
    emails = mycontacts.join(", ")
    myemails1 = myemails.join(", ")
    @curr_user = current_user.name
    @tot_hrs = @pay_period.total_hours(current_user)
    @cur_admin = current_user.admin 
    StatusMailer.send_detail_view_email(myemails1,@time_records,@pay_period,@tot_hrs,@cur_admin,@curr_user,params[:msg]).deliver
    render :partial => "success", :layout => false
     
  end  #end of mail_time_records

  def user_recap_mail
     if current_user.admin == true
    @pay_period = current_user.pay_periods.find(params[:mailed_projects])
    @user_time_records = @pay_period.time_records.joins(:user).order('users.name desc').group_by { |rec| rec.user }
    @cntcts = current_user.organization.contacts
    else
    @pay_period = current_user.pay_periods.find(params[:mailed_projects])
    @user_time_records = @pay_period.time_records.joins(:user).where(:user_id  => current_user).order('users.name desc').group_by { |rec| rec.user }
    @cntcts = current_user.organization.contacts
    end
    @cntcts = current_user.organization.contacts
    mycontacts=Array.new
    myemails = Array.new
    params[:project_check_all].split(",").map do |can_id|
    @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
      #mycontacts.push(@contact.email)
       mycontacts.push(@contact.contact)
       myemails.push(@contact.email)
    end
    emails = mycontacts.join(", ")
    myemails1 = myemails.join(", ")
    @curr_user = current_user.name
    StatusMailer.send_user_recap_email(myemails1,@user_time_records,@pay_period,@curr_user,params[:msg]).deliver
    render :partial => "success", :layout => false
  end  #end of user_recap_mail



  def project_recap_mail
   if current_user.admin == true
      @pay_period = current_user.pay_periods.find(params[:mailed_projects])
      @user_time_records = @pay_period.time_records.joins(:project).order('projects.title desc').group_by { |rec| rec.project }
      @cntcts = current_user.organization.contacts
   else
     @pay_period = current_user.pay_periods.find(params[:mailed_projects])
     @user_time_records = @pay_period.time_records.joins(:project).where(:user_id  => current_user).order('projects.title desc').group_by { |rec| rec.project }
     @cntcts = current_user.organization.contacts
    end
    @cntcts = current_user.organization.contacts
    mycontacts=Array.new
    myemails = Array.new
    params[:project_check_all].split(",").map do |can_id|
    @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
      #mycontacts.push(@contact.email)
       mycontacts.push(@contact.contact)
       myemails.push(@contact.email)
    end
    emails = mycontacts.join(", ")
    myemails1 = myemails.join(", ")
    @curr_user = current_user.name
    StatusMailer.send_project_recap_email(myemails1,@user_time_records,@pay_period,@curr_user,params[:msg]).deliver
    render :partial => "success", :layout => false
  end  #end of project_recap_mail

  
end
