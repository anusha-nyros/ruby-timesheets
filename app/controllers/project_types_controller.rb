class ProjectTypesController < ApplicationController
   before_filter :authorize
   before_filter :update_proj_number, :only =>'index'
   before_filter :update_created_at , :only =>'index'
   skip_before_filter :verify_authenticity_token
   
    def index
   @cntcts = current_user.organization.contacts
  @active1 = current_user.organization.project_types.find(:first)
  @active_projects = current_user.organization.project_types.find(:all, :conditions => {:status => 'Active'}).count
    @pending_projects = current_user.organization.project_types.find(:all, :conditions => {:status => 'Pending'}).count 
    @completed_projects = current_user.organization.project_types.find(:all, :conditions => {:status => 'Closed'}).count 
    @all_projects   = current_user.organization.project_types.find(:all).count
 if params[:name] == "active" 
       @q = current_user.organization.project_types.search(params[:q])
          if params[:sel]
            @projects = @q.result(:distinct  => true).where(:status => 'Active').order('end_date IS NULL, end_date').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
           @projects = @q.result(:distinct  => true).where(:status => 'Active').order('end_date IS NULL, end_date').page(params[:page]).per(50)
            @choosed = 50
          end   

    @chosen = "active"

 elsif params[:name] == "pending" 
 @q = current_user.organization.project_types.search(params[:q])

       if params[:sel]
            @projects = @q.result(:distinct  => true).where(:status => 'Pending').order('end_date IS NULL, end_date').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
       else
           @projects = @q.result(:distinct  => true).where(:status => 'Pending').order('end_date IS NULL, end_date').page(params[:page]).per(50)
            @choosed = 50
       end  

     @chosen = "pending" 

 elsif params[:name] == "closed"
 @q = current_user.organization.project_types.search(params[:q])

        
       if params[:sel]
            @projects = @q.result(:distinct  => true).where(:status => 'Closed').order('end_date IS NULL, end_date').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
      else
           @projects = @q.result(:distinct  => true).where(:status => 'Closed').order('end_date IS NULL, end_date').page(params[:page]).per(50)
            @choosed = 50
      end  
    @chosen = "closed" 
 

 elsif params[:name] == "all"
    @q = current_user.organization.project_types.search(params[:q])     
      
       if params[:sel]
            @projects = @q.result(:distinct  => true).order('end_date IS NULL, end_date').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
      else
           @projects = @q.result(:distinct  => true).order('end_date IS NULL, end_date').page(params[:page]).per(50)
            @choosed = 50
      end  
  @chosen =  "all" 

  elsif params[:name] == "past_due"
    @q = current_user.organization.project_types.search(params[:q])    

      if params[:sel]
            @projects = @q.result(:distinct  => true).where("status =? and end_date = ?",'Pending',Date.today).order('end_date IS NULL, end_date').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
      else
           @projects = @q.result(:distinct  => true).where("status =? and end_date = ?",'Pending',Date.today).order('end_date IS NULL, end_date').page(params[:page]).per(50)
            @choosed = 50
      end  
  @chosen = "past_due"
   # @projects = @q.result(:distinct  => true).find(:all,:order => 'end_date IS NULL, end_date', :conditions => ['status =? AND end_date < ?','Pending',Date.today])  

 else 
    @q = current_user.organization.project_types.search(params[:q])     

      if params[:sel]
            @projects = @q.result(:distinct  => true).where(:status =>'Active').order('end_date IS NULL, end_date').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
      else
            @projects = @q.result(:distinct  => true).where(:status =>'Active').order('end_date IS NULL, end_date').page(params[:page]).per(50)
            @choosed = 50
      end  
   @chosen = "active"

 end 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project_types }
    end

  end


 
  def new
    @project_type = ProjectType.new
    @contacts = current_user.organization.contacts
@active1 = current_user.organization.project_types.find(:first)
    @cntcts = current_user.organization.contacts
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project_type }
    end
  end
  
  def edit
    @project_type = current_user.organization.project_types.find(params[:id])
    @contacts = current_user.organization.contacts
  end

  def show
  @project_type = ProjectType.find(params[:id])
  @tasks= @project_type.projects
  end 


  def create  
   
    #render :text => "stop" and return
  @org_projects= current_user.organization.project_types(:order=>'created_at ASC')
    @org_last_project=@org_projects.find(:last)
    if !@org_projects.blank? && !@org_last_project.blank?
    y= @org_last_project.proj_number.gsub!("PROJ-","")
    m=y.to_i
    m = m +1
    x = ("PROJ-%0.5d" %m.to_i).to_s
    params[:project_type][:proj_number] = x
    @project_type = ProjectType.new(params[:project_type])
    @project_type.organization = current_user.organization
    @project_type.created_by = current_user.username
          @contacts = current_user.organization.contacts
    checked_contacts = check_contacts_using(params[:contact_list])
    uncheck_missing_contacts(@contacts, checked_contacts)
    else 
    m = 1
    x = ("PROJ-%0.5d" %m.to_i).to_s
    puts x
    params[:project_type][:proj_number] = x
    @project_type = ProjectType.new(params[:project_type])
    @project_type.organization = current_user.organization
    @project_type.created_by = current_user.username
      @contacts = current_user.organization.contacts
    checked_contacts = check_contacts_using(params[:contact_list])
    uncheck_missing_contacts(@contacts, checked_contacts)
    end
     
    @project_type.date_created= Date.today
  @project_type.start_date=change_date_format(params[:project_type][:start_date]) if !(params[:project_type][:start_date]).blank?
  @project_type.end_date=change_date_format(params[:project_type][:end_date]) if !(params[:project_type][:end_date]).blank?
   @contacts = current_user.organization.contacts
    respond_to do |format|
      if @project_type.save
        format.html { redirect_to project_types_url, notice: 'Project was successfully created.' }
        format.json { render json: @project_type, status: :created, location: @project_type }
      else
        format.html { render action: "new" }
        format.json { render json: @project_type.errors, status: :unprocessable_entity }
      end
    end
  end

    def stat
     @projects1 = current_user.organization.project_types.find(:all)
     
  @active1 = current_user.organization.project_types.find(:first)	
   if @active1.status_check == "active"
      @projects1.each do |k|
        k.update_attribute("status_check","inactive")
      end
  flash[:notice] = " Budget Views Turned Off successfully"
  
  elsif @active1.status_check == "inactive"
    flash[:notice] = " Budget Views Turned On successfully"
     @projects1.each do |k|
        k.update_attribute("status_check","active")
      end       
  end
    redirect_to :action => "index" 

 end


  
  def update
    @project_type = current_user.organization.project_types.find(params[:id])
   # @project_type.created_by = current_user.username
   # for update module mails
    start_date = change_date_form(@project_type.start_date) if !@project_type.start_date.blank?
    end_date = change_date_form(@project_type.end_date) if !@project_type.end_date.blank?
        val1 = Hash.new
        val2 = Hash.new 
        a=@project_type.contacts.collect{|pt| pt.id.to_s}
       @proj_emails = Array.new
       @proj_contacts = @project_type.contacts
       @proj_contacts.each do |c|
          @proj_emails << c.email
        end 
        @proj_contact_emails  = @proj_emails.join(",") if @proj_emails.any?
   val1 = {"start_date"=>"#{start_date}","end_date"=>"#{end_date}","budget_info"=>"#{@project_type.budget_info}","hours_budget"=>@project_type.hours_budget, "expense_budget"=>@project_type.expense_budget,"contact_list"=>a.sort}
      @contacts = current_user.organization.contacts
    checked_contacts = check_contacts_using(params[:contact_list])
    uncheck_missing_contacts(@contacts, checked_contacts)

  params[:project_type][:date_created]=change_date_format(params[:project_type][:date_created]) if !(params[:project_type][:date_created]).blank?
  params[:project_type][:start_date]=change_date_format(params[:project_type][:start_date]) if !(params[:project_type][:start_date]).blank?
 params[:project_type][:end_date]=change_date_format(params[:project_type][:end_date]) if !(params[:project_type][:end_date]).blank?
  
    respond_to do |format|
      if @project_type.update_attributes(params[:project_type])
        
         val2 =   {"start_date"=>params[:project_type][:start_date],"end_date"=>params[:project_type][:end_date],"budget_info"=>params[:project_type][:budget_info],"hours_budget"=>params[:project_type][:hours_budget].to_f, "expense_budget"=>params[:project_type][:expense_budget].to_f,"contact_list"=>params[:contact_list]}
  
        if val1 != val2       
        emails = Array.new 
        contacts = @project_type.contacts 
        contacts.each do |c|
           emails << c.email
        end 
        notification_contacts = emails.join(",") if emails.any?
         if !notification_contacts.blank?
           StatusMailer.notification_project_type_mail(notification_contacts,@project_type,val1,@proj_contact_emails).deliver
           end 
         end 
        format.html { redirect_to project_types_url, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project_type.errors, status: :unprocessable_entity }
      end
    end
  end



 def taskstatus
  #render :text => "stop" and return
	@project_types = current_user.organization.project_types.find(:all)
  @project = current_user.organization.projects.find_by_id(params[:id])	
  if !@project.blank? 
   if @project.active == true 
  flash[:notice] = "Task is Inactivated successfully"
  @project.active = 0
  elsif @project.active == nil
    flash[:notice] = "Task is Activated successfully"
     @project.active = 1    
  elsif @project.active == false
    flash[:notice] = "Task is Activated successfully"
     @project.active = 1       
  end
  if @project.update_attributes(params[:project_type])      
      redirect_to :action => :index,:page => params[:page]
    else
      flash[:notice] = "Unable to Active/Deactive Task" 
    end
else
   flash[:notice] = "Unable to Active/Deactive Task" 
  redirect_to :action => :index,:page => params[:page]
 end
end



 def status
  #render :text => "stop" and return
	@project_types = current_user.organization.project_types.find(:all)
  @project = current_user.organization.project_types.find(params[:id])	
   if @project.active == true 
  flash[:notice] = "Project is Inactivated successfully"
  @project.active = 0
  elsif @project.active == nil
    flash[:notice] = "Project is Activated successfully"
     @project.active = 1    
  elsif @project.active == false
    flash[:notice] = "Project is Activated successfully"
     @project.active = 1       
  end
  if @project.update_attributes(params[:project_type])      
      redirect_to :action => :index,:page => params[:page]
    else
      flash[:notice] = "Unable to Active/Deactive Project" 
    end
end
 

def search
    

        if params[:up]
          @secret = "up"
        end
        if params[:down]
          @secret = "down"
        end    
#change dateformat when search
  params[:q][:start_date_cont] = change_date_format(params[:q][:start_date_cont]) if !(params[:q][:start_date_cont]).blank?
   params[:q][:start_date_cont] =  params[:q][:start_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:start_date_cont]).blank?


  params[:q][:end_date_cont]=change_date_format(params[:q][:end_date_cont]) if !(params[:q][:end_date_cont]).blank?
  params[:q][:end_date_cont]=params[:q][:end_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:end_date_cont]).blank?

  params[:q][:date_created_cont]=change_date_format(params[:q][:date_created_cont]) if !(params[:q][:date_created_cont]).blank?
 params[:q][:date_created_cont]= params[:q][:date_created_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:date_created_cont]).blank?
 
      @q = current_user.organization.project_types.search(params[:q])

       if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @cntcts = current_user.organization.contacts
        @choosed = params[:mydata]  
       elsif !params[:mydata] 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
        @cntcts = current_user.organization.contacts
        @choosed = 50
       end 

    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end


  
  def destroy
    @project_type = current_user.organization.project_types.find(params[:id])
    @project_type.destroy

    respond_to do |format|
      format.html { redirect_to project_types_url, notice: 'Project was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
# for budget views 
 def over_budget_view 
   @projects = current_user.organization.project_types.find(:all)

  # for over budget expenses 
   @over_projct_expense = []
    @projects.each do |k| 
    @budget = Payment.find(:all ,:conditions => {:project_type_id => k.id }).sum(&:pay_amount) 
     if @budget > k.expense_budget
      @over_projct_expense << k
     end
     end 
  # for over budget hours 
   @projects1 = current_user.organization.project_types.find(:all)
   @over_projct_hours = []
    @projects1.each do |h| 
       cnt= 0 
             h.projects.each do |t|  
                 cnt +=  t.time_records.to_a.sum(&:total_hours)       
             end 
     
      if cnt > h.hours_budget
      @over_projct_hours << h
     end
     end 
   @active1 = current_user.organization.project_types.find(:first)
 end
 
def budget_view 
  @projects = current_user.organization.project_types.find(:all)
 @active1 = current_user.organization.project_types.find(:first)
end 

#for emailing the projects 
def email_projects

   myemails = Array.new
    params[:project_check_all].split(",").map do |can_id|
          if can_id == 'on' 
 		      next
	 	      end
    @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
       myemails.push(@contact.email)
    end
   @email_projects = Array.new
   params[:mailed_projects].split(",").map do |id|
   @email_projects << ProjectType.find_by_id(id)
      end
  emails = myemails.join(",") if myemails.any?
  StatusMailer.email_project_transactions(@email_projects,emails,params[:msg]).deliver
        render :partial => "success", :layout => false

end 

  def maillist
      @cntcts = current_user.organization.contacts
      @prjts = Array.new
      params[:ids].split(",").map do |id|
       @prjts << ProjectType.find_by_id(id)
      end
    @prjts_array =  params[:ids]
    render :partial => "maillist", :layout => false
 end


#end fro emailing the projects

 private
  
  def check_contacts_using( contact_id_array )
    checked_contacts = []
    checked_params = contact_id_array || []
    for check_box_id in checked_params
      contact = Contact.find(check_box_id)
      if not @project_type.contacts.include?(contact)
        @project_type.contacts << contact
      end
      checked_contacts << contact
    end
    return checked_contacts
  end
  
  def uncheck_missing_contacts( contacts, checked_contacts)
    missing_contacts = contacts- checked_contacts
    for contact in missing_contacts
      if @project_type.contacts.include?(contact)
         @project_type.contacts.delete(contact)
       end
    end
  end

end
