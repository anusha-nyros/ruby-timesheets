class ProjectsController < ApplicationController
   before_filter :authorize#, :check_account_type_project
   #before_filter :update_prq_number,:only=>'index'
   #before_filter :fill_amount,:only=>'index'
  #before_filter :fill_actual,:only=>'index'
  #before_filter :update_variance,:only=>'index'
  #before_filter :update_all_prqs
  # before_filter :update_all_prq_line
  skip_before_filter  :verify_authenticity_token #for authentication
  # GET /projects
  # GET /projects.json

  def statistics
  @projects = current_user.organization.projects
  end
#************retrieving all details depend upon the week,day etc.,*************
 def index
    @cntcts = current_user.organization.contacts
    @project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')     
    if params[:FILTER] == "ALL"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])
       #@projects = @q.result(:distinct  => true).find(:all)
          if params[:sel]
            @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
            @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
          end       
       else
       contact = Contact.find_by_user_id(current_user) 
        @q = contact.projects.search(params[:q])
          if params[:sel]
            @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
            @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
          end   
       end
       @chosen = "ALL"



   elsif params[:FILTER] == "OPEN"
      if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])
     
         if params[:sel]
          @projects = @q.result(:distinct  => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
          @projects = @q.result(:distinct  => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end   
      else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])
          if params[:sel]
          @projects = @q.result(:distinct  => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
          else
          @projects = @q.result(:distinct  => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end   
      end
      @chosen = "OPEN"




  elsif params[:FILTER] == "CLOSED"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])
           if params[:sel]
           @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])   
              @choosed = params[:sel]
           else
              @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)   
              @choosed = 50
           end 
       else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])
          if params[:sel]
           @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])   
              @choosed = params[:sel]
           else
              @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)   
              @choosed = 50
           end 
       end
      @chosen = "CLOSED"

      #from home page stats


      elsif params[:due] == "past"   
        

   
       @q = current_user.organization.projects.search(params[:q])
      #@projects = @q.result(:distinct  => true).find(:all, :conditions => ['active = ? AND schedule_date < ? AND action_required =?',1,Date.today,'In Progress'])
           if params[:sel]
            @projects = @q.result(:distinct  => true).where(['active = ? AND schedule_date < ? AND action_required =?',1,Date.today,'In Progress']).page(params[:page]).per(params[:sel])  
              @choosed = params[:sel]
           else
              @projects = @q.result(:distinct  => true).where(['active = ? AND schedule_date < ? AND action_required =?',1,Date.today,'In Progress']).page(params[:page]).per(50) 
              @choosed = 50
           end 
  


       
       #from home stats





      elsif params[:scheduled] == "this_week"
        
      @q = current_user.organization.projects.search(params[:q])
      #@projects = @q.result(:distinct  => true).find(:all, :conditions=>{:schedule_date => DateTime.now.beginning_of_week..DateTime.now.end_of_week})

           if params[:sel]
             @projects = @q.result(:distinct  => true).where(:schedule_date => DateTime.now.beginning_of_week..DateTime.now.end_of_week).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
           else
               @projects = @q.result(:distinct  => true).where(:schedule_date => DateTime.now.beginning_of_week..DateTime.now.end_of_week).page(params[:page]).per(50)
              @choosed = 50
           end 


  

      elsif params[:scheduled] == "today"

      @q = current_user.organization.projects.search(params[:q])
      #@projects = @q.result(:distinct  => true).find(:all, :conditions => ['schedule_date = ?',Date.today])
         if params[:sel]
    @projects = @q.result(:distinct  => true).where(:schedule_date => Date.today).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
           else
    @projects = @q.result(:distinct  => true).where(:schedule_date => Date.today).page(params[:page]).per(50)
              @choosed = 50
           end 


     

      elsif params[:scheduled] == "this_month"
      @q = current_user.organization.projects.search(params[:q])


      #@projects = @q.result(:distinct  => true).find(:all,:conditions=>{:schedule_date => DateTime.now.beginning_of_month..DateTime.now.end_of_month})

          if params[:sel]
    @projects = @q.result(:distinct  => true).where(:schedule_date => DateTime.now.beginning_of_month..DateTime.now.end_of_month).page(params[:page]).per(params[:sel])

              @choosed = params[:sel]
           else
@projects = @q.result(:distinct  => true).where(:schedule_date => DateTime.now.beginning_of_month..DateTime.now.end_of_month).page(params[:page]).per(50)
              @choosed = 50
           end 

     




      elsif params[:scheduled] == "nxt_week"
      @q = current_user.organization.projects.search(params[:q])

        
           if params[:sel]
     @projects = @q.result(:distinct  => true).where(:schedule_date => DateTime.now.next_week.beginning_of_week..DateTime.now.next_week.end_of_week).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
           else
  @projects = @q.result(:distinct  => true).where(:schedule_date => DateTime.now.next_week.beginning_of_week..DateTime.now.next_week.end_of_week).page(params[:page]).per(50)
              @choosed = 50
           end 

      #@projects = @q.result(:distinct  => true).find(:all, :conditions=>{:schedule_date => DateTime.now.next_week.beginning_of_week..DateTime.now.next_week.end_of_week})
    





      elsif params[:scheduled] == "nxt_month"
      @q = current_user.organization.projects.search(params[:q])

           if params[:sel]
     @projects = @q.result(:distinct  => true).where(:schedule_date => DateTime.now.next_month.beginning_of_month..DateTime.now.next_month.end_of_month).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
           else
   @projects = @q.result(:distinct  => true).where(:schedule_date => DateTime.now.next_month.beginning_of_month..DateTime.now.next_month.end_of_month).page(params[:page]).per(50)
              @choosed = 50
           end 
     
     
       elsif params[:scheduled] == "last_week"
      @q = current_user.organization.projects.search(params[:q])
      #@projects = @q.result(:distinct  => true).find(:all, :conditions=>{:schedule_date => (DateTime.now - 1.week).beginning_of_week..(DateTime.now - 1.week).end_of_week})
       if params[:sel]
     @projects = @q.result(:distinct  => true).where(:schedule_date => (DateTime.now - 1.week).beginning_of_week..(DateTime.now - 1.week).end_of_week).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
           else
   @projects = @q.result(:distinct  => true).where(:schedule_date => (DateTime.now - 1.week).beginning_of_week..(DateTime.now - 1.week).end_of_week).page(params[:page]).per(50)
              @choosed = 50
           end        
      


      
      elsif params[:scheduled] == "last_month"
      @q = current_user.organization.projects.search(params[:q])
      #@projects = @q.result(:distinct  => true).find(:all, :conditions=>{:schedule_date => (DateTime.now - 1.month).beginning_of_month..(DateTime.now - 1.month).end_of_month}, :order => 'schedule_date')
      if params[:sel]
     @projects = @q.result(:distinct  => true).order('schedule_date').where(:schedule_date => (DateTime.now - 1.month).beginning_of_month..(DateTime.now - 1.month).end_of_month).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
           else
   @projects = @q.result(:distinct  => true).order('schedule_date').where(:schedule_date => (DateTime.now - 1.month).beginning_of_month..(DateTime.now - 1.month).end_of_month).page(params[:page]).per(50)
              @choosed = 50
           end        
      
               

      elsif params[:recent] == "recorded"
      @q = current_user.organization.projects.search(params[:q])
      
        
           if params[:sel]
       @projects = @q.result(:distinct  => true).joins([:time_records]).where(:schedule_date => DateTime.now.beginning_of_week..DateTime.now.end_of_week).page(params[:page]).per(params[:sel])

              @choosed = params[:sel]
           else
      @projects = @q.result(:distinct  => true).joins([:time_records]).where(:schedule_date => DateTime.now.beginning_of_week..DateTime.now.end_of_week).page(params[:page]).per(50)

              @choosed = 50
           end 
     

      #@projects = @q.result(:distinct  => true).find(:all, :joins => [:time_records], :conditions=>{:schedule_date => DateTime.now.beginning_of_week..DateTime.now.end_of_week}, :order => 'updated_at DESC')
   
      #end stats
      
   elsif params[:FILTER].blank?

    if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])

          if params[:sel]
       @projects = @q.result(:distinct  => true).where(:active=> 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
           else
     @projects = @q.result(:distinct  => true).where(:active=> 1).order('updated_at DESC').page(params[:page]).per(50)
              @choosed = 50
           end 
      @chosen = "CLOSED"
    else

      contact = Contact.find_by_user_id(current_user)
      if !contact.blank?
      @q = contact.projects.search(params[:q])

            if params[:sel]
        @projects = @q.result(:distinct  => true).where(:active=> 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
            else
      @projects = @q.result(:distinct  => true).where(:active=> 1).order('updated_at DESC').page(params[:page]).per(50)
              @choosed = 50
           end 
     
       @chosen = "CLOSED"
      end
    end
    end
#************retrieving all details depend upon the week,day etc.,************
  end
  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = current_user.organization.projects.find(params[:id])
	@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
    @project_changes  = ProjectChange.find_by_sql("select * from project_changes where project_id ='#{@project.id}' ")
    # for time records
    @pro= current_user.organization.projects.find(params[:id]).time_records
    @time_records = @pro.find(:all,:order => 'updated_at DESC')
    @total_hrs = current_user.organization.projects.find(params[:id]).time_records.sum(:total_hours)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
   if params[:project_type]
      @project_type = current_user.organization.project_types.find(params[:project_type])
      @project.project_type = @project_type
    end  
   ######for history
   @pro = Array.new
   @project_history = Array.new
    @project_id = @project.statusreports
    @project_id.each do |id|
    @pro << Statusreport.find(id)
   @project_history << LineItem.find_by_project_id_and_statusreport_id(@project,id)
    
	end
   #for history
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = current_user.organization.projects.find(params[:id])
    @project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
   ######for history
   @pro = Array.new
   @project_history = Array.new
    @project_id = @project.statusreports
    @project_id.each do |id|
    @pro << Statusreport.find(id)
   @project_history << LineItem.find_by_project_id_and_statusreport_id(@project,id)
    
	end
   #for history
  end

  # POST /projects
  # POST /projects.json
  def create
    @org_projs= current_user.organization.projects(:order=>'created_at ASC').with_deleted
    @org_last_proj=@org_projs.find(:last)
    if !@org_projs.blank? && !@org_last_proj.blank?
    y= @org_last_proj.prq_number.gsub!("TASK-","") 
    puts "###"
    m=y.to_i
    m = m +1
    x = ("TASK-%0.5d" %m.to_i).to_s
    puts x
    params[:project][:prq_number] = x
    @project = Project.new(params[:project])
    @project.organization = current_user.organization
    else 
    m = 1
    x = ("TASK-%0.5d" %m.to_i).to_s
    puts x
    params[:project][:prq_number] = x #*********** creation of system generated value
    @project = Project.new(params[:project])
    @project.organization = current_user.organization
    
    end
    #ptid = ProjectType.find(params[:project][:project_name]).id
    #@project.project_type_id = ptid
    if !params[:project][:project_type_id].blank?
    ptname =current_user.organization.project_types.find(params[:project][:project_type_id]).type_name
    @project.project_name = ptname
	end
    #for changing the default date format
    @project.schedule_date = change_date_format(params[:project][:schedule_date]) if !(params[:project][:schedule_date]).blank?
    @project.start_date = change_date_format(params[:project][:start_date]) if !(params[:project][:start_date]).blank?
    @project.end_date = change_date_format(params[:project][:end_date]) if !(params[:project][:end_date]).blank?
    @project.status_date = change_date_format(params[:project][:status_date]) if !(params[:project][:status_date]).blank?
    respond_to do |format|
      if @project.save
        notification_mail(@project)
        format.html { redirect_to @project, notice: 'Task  was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

def status #****************status of tasks **********
	@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
  @project = current_user.organization.projects.find(params[:id])	
   if @project.active == true 
  flash[:notice] = "Task is Inactivated successfully"
  @project.active = 0
  elsif @project.active == false
    flash[:notice] = "Task is activated successfully"
     @project.active = 1         
  end
  if @project.update_attributes(params[:project])      
      redirect_to :action => :index,:page => params[:page]
    else
      flash[:notice] = "Unable to Active/Deactive Task" 
    end
end


 def update

   if !params[:project][:project_type_id].blank?
    ptname =current_user.organization.project_types.find(params[:project][:project_type_id]).type_name
    #params[:project][:project_name]=ptname
	end



	@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
    @project = current_user.organization.projects.find(params[:id])
     #for chnage history 
   schedule_date = change_date_form(@project.schedule_date) if !@project.schedule_date.blank?
    start_date = change_date_form(@project.start_date) if !@project.start_date.blank?
    end_date = change_date_form(@project.end_date) if !@project.end_date.blank?
     status_date = change_date_form(@project.status_date) if !@project.status_date.blank?  
     active = change_active(@project.active) 
    @pj_name = @project.project_name
    val1 = Hash.new
   val1 = {"title"=>"#{@project.title}", "project_type_id"=>"#{@project.project_type_id}", "priority"=>"#{@project.priority}", "action_required"=>"#{@project.action_required}", "reference"=>"#{@project.reference}", "schedule_date"=> "#{schedule_date}" , "start_date"=>"#{start_date}", "amount"=>"#{@project.amount}", "end_date"=>"#{end_date}", "supplier_id"=>"#{@project.contact_id}", "owner"=>"#{@project.owner}","tasktype_id"=>"#{@project.tasktype_id}","analysis"=>"#{@project.analysis}", "notes"=>"#{@project.notes}", "status_date"=>"#{status_date}", "status_details"=>"#{@project.status_details}", "per_completed"=>"#{@project.per_completed}", "active"=> "#{active}"}
 supp_name = @project.supplier.try(:company)
 task_type = @project.tasktype_id#.try(:tasktype)
 @task_type1 = Tasktype.find_by_sql("select tasktype from tasktypes where id = '#{task_type}'")
        @task_type1.each do |tsk|
              @task_type1name = tsk.tasktype
            end
            task_type2 = @task_type1name.to_s
     params[:project][:entered_by] = '' if @project.entered_by.blank?
     params[:project][:entered_by] = @project.entered_by if @project.entered_by
     #for update time change date format params
    params[:project][:schedule_date] = change_date_format(params[:project][:schedule_date]) if !(params[:project][:schedule_date]).blank?
    params[:project][:start_date] = change_date_format(params[:project][:start_date]) if !(params[:project][:start_date]).blank?
    params[:project][:end_date] = change_date_format(params[:project][:end_date]) if !(params[:project][:end_date]).blank?
     params[:project][:status_date] = change_date_format(params[:project][:status_date]) if !(params[:project][:status_date]).blank? 
       
         
        
     

         if @project.update_attributes(params[:project])
            update_variance_new(@project.id)
           @project.project_name = current_user.organization.project_types.find(params[:project][:project_type_id]).type_name if !params[:project][:project_type_id].blank? 
           @project.save
        sample1 = params[:project]
        puts "@@@@@@@@@@@@@@"
        
        sample1.delete("attachments_attributes")
        sample1.delete("entered_by")
        puts sample1
        puts "############"
        puts val1
         if val1 != sample1
       
         @project_changes = ProjectChange.create
        @project_changes.title = params[:project][:title]  #title
           @project_changes.per_completed = params[:project][:per_completed] #per_completed
          @project_changes.project_id = @project.id  #id=>project_id 
	 
   
           @project_changes.project_type = ptname
           @project_changes.status_details = params[:project][:status_details] 
           @project_changes.notes = params[:project][:notes] 
           @project_changes.prq_number = params[:project][:prq_number] #prq_number     
           @project_changes.action_required = params[:project][:action_required]
           @project_changes.priority = params[:project][:priority] 
           @project_changes.analysis = params[:project][:analysis]  
           @project_changes.active = params[:project][:active] 
           @project_changes.schedule_date = params[:project][:schedule_date] 
           @project_changes.start_date = params[:project][:start_date] 
           @project_changes.end_date = params[:project][:end_date]  
           @project_changes.status_date = params[:project][:status_date]
           @project_changes.entered_by = params[:project][:entered_by] #enetered_by
           @project_changes.reference = params[:project][:reference] 
           @project_changes.owner = params[:project][:owner] 
           @project_changes.amount = params[:project][:amount]
           @project_changes.analysis = params[:project][:analysis]
           @project_changes.prq_number = @project.prq_number
           @supplierid = params[:project][:supplier_id].to_i 
           @supplier_name = Contact.find_by_sql("select company from contacts where id = '#{@supplierid}'")
           @supplier_name.each do |sup|
              @supplier_company = sup.company
            end
           @project_changes.suppliername = @supplier_company.to_s
           @project_changes.contact_id = params[:project][:supplier_id]
  
           @project_changes.organization_id = @project.organization_id  #ORGANIZATIONID
           @task_type_id = params[:project][:tasktype_id].to_i
           @tasktype_name = Tasktype.find_by_sql("select tasktype from tasktypes where id = '#{@task_type_id}'")
            @tasktype_name.each do |tsk|
              @tasktypename = tsk.tasktype
            end
           @project_changes.tasktype = @tasktypename.to_s
           @project_changes.updated_by = current_user.name
           @project_changes.save
           @project_changes.update_attributes(:prev_title => val1["title"],:prev_action_required => val1["action_required"],:prev_status_details => val1["status_details"],:prev_per_completed => val1["per_completed"],:prev_project_type => @pj_name,:prev_notes => val1["notes"],:prev_priority => val1["priority"],:prev_analysis => val1["analysis"],:prev_active => val1["active"],:prev_schedule_date => val1["schedule_date"],:prev_start_date => val1["start_date"],:prev_end_date => val1["end_date"],:prev_status_date => val1["status_date"],:prev_reference => val1["reference"],:prev_owner => val1["owner"],:prev_amount => val1["amount"],:prev_contact_id => val1["supplier_id"],:prev_suppliername => supp_name,:prev_tasktype => task_type2)
  
           redirect_to @project, notice: 'Task was successfully updated.' 
          else
          redirect_to @project, notice: 'Task was successfully updated.'
          end       
      else
         render action: "edit" 
       end
   end
  def destroy
    @project = current_user.organization.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

 def time_rec #for timerecords 
	@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
  @project = current_user.organization.projects.find(params[:id])
  #@time_records= TimeRecord.find(:all,:conditions=>{:project_id=>@project})
  @time_records = @project.time_records
#@pay_period = current_user.pay_periods.find(params[:id])
  end

 def search
@cntcts = current_user.organization.contacts
        if params[:up]
          @secret = "up"
        end
        if params[:down]
          @secret = "down"
        end   

@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
    #change dateformat when search
    params[:q][:schedule_date_cont] = change_date_format(params[:q][:schedule_date_cont]) if !(params[:q][:schedule_date_cont]).blank?
    params[:q][:schedule_date_cont] =  params[:q][:schedule_date_cont].to_date.strftime("%d/%Y/%m") if ! params[:q][:schedule_date_cont].blank?

    params[:q][:start_date_cont] = change_date_format(params[:q][:start_date_cont]) if !(params[:q][:start_date_cont]).blank?
     params[:q][:start_date_cont] = params[:q][:start_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:start_date_cont]).blank?
  

    params[:q][:end_date_cont] = change_date_format(params[:q][:end_date_cont]) if !(params[:q][:end_date_cont]).blank?
    params[:q][:end_date_cont] =  params[:q][:end_date_cont].to_date.strftime("%d/%Y/%m")  if !(params[:q][:end_date_cont]).blank?

  

    params[:q][:schedule_date_gteq] = change_date_format(params[:q][:schedule_date_gteq]) if !(params[:q][:schedule_date_gteq]).blank?
      params[:q][:schedule_date_gteq] =  params[:q][:schedule_date_gteq].to_date.strftime("%d/%Y/%m")  if !(params[:q][:schedule_date_gteq]).blank?


    params[:q][:schedule_date_lteq] = change_date_format(params[:q][:schedule_date_lteq]) if !(params[:q][:schedule_date_lteq]).blank?
    params[:q][:schedule_date_lteq] =  params[:q][:schedule_date_lteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:schedule_date_lteq]).blank?

    
    params[:q][:status_date_cont] = change_date_format(params[:q][:status_date_cont]) if !(params[:q][:status_date_cont]).blank?
    params[:q][:status_date_cont] =  params[:q][:status_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_cont]).blank?



    params[:q][:status_date_gteq] = change_date_format(params[:q][:status_date_gteq]) if !(params[:q][:status_date_gteq]).blank?
    params[:q][:status_date_gteq] =  params[:q][:status_date_gteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_gteq]).blank?
   

    params[:q][:status_date_lteq] = change_date_format(params[:q][:status_date_lteq]) if !(params[:q][:status_date_lteq]).blank?
     params[:q][:status_date_lteq] =  params[:q][:status_date_lteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_lteq]).blank?    



   if current_user.admin == true
    @q = current_user.organization.projects.search(params[:q])
       if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @choosed = params[:mydata]  
       elsif !params[:mydata] 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
        @choosed = 50
       end 
    else
    contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])
        if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @choosed = params[:mydata]  
        elsif !params[:mydata] 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
	 @choosed = 50
        end  
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end


  def status_view #for statusView
	@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')



   if params[:FILTER] == "ALL"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])

         if params[:sel]
            @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
             @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
          end  


       #@projects = @q.result(:distinct  => true).find(:all)
      
       else
       contact = Contact.find_by_user_id(current_user)
       
      @q = contact.projects.search(params[:q])
       #@projects = @q.result(:distinct  => true).find(:all)
          if params[:sel]
            @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
             @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
          end  
      
       end
       @chosen = "ALL"




   elsif params[:FILTER] == "OPEN"
      if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])
        
          if params[:sel]
            @projects = @q.result(:distinct  => true).where(:active=> 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
              @projects = @q.result(:distinct  => true).where(:active=> 0).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
          end  

        
      #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 0 })
     
      else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])
       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 0 })

         if params[:sel]
           @projects = @q.result(:distinct  => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
             @projects = @q.result(:distinct  => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
          end  
       
       end
      @chosen = "OPEN"






  elsif params[:FILTER] == "CLOSED"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])

       if params[:sel]
           @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
            @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
      end  


       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 })
      
       else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])

        
       if params[:sel]
           @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
          @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
      end  
   #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 })
       
       end
      @chosen = "CLOSED"

   elsif params[:FILTER].blank?
    if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])

         if params[:sel]
              @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
            @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
         end  
      #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 }, :order => 'updated_at DESC')
      @chosen = "CLOSED"

    else
      contact = Contact.find_by_user_id(current_user)
      if !contact.blank?
      @q = contact.projects.search(params[:q])

          if params[:sel]
              @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
          else
            @projects = @q.result(:distinct  => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
         end  


       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 }, :order => 'updated_at DESC')
       @chosen = "CLOSED"
      end
    end
    end
   end


  
  def search1 #for search
	 if params[:up]
          @secret = "up"
        end
        if params[:down]
          @secret = "down"
        end   

	@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
    #change dateformat when search (for status_view)
    params[:q][:schedule_date_cont] = change_date_format(params[:q][:schedule_date_cont]) if !(params[:q][:schedule_date_cont]).blank?
    params[:q][:schedule_date_cont] =  params[:q][:schedule_date_cont].to_date.strftime("%d/%Y/%m") if ! params[:q][:schedule_date_cont].blank?
 
    params[:q][:start_date_cont] = change_date_format(params[:q][:start_date_cont]) if !(params[:q][:start_date_cont]).blank?
    params[:q][:start_date_cont] = params[:q][:start_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:start_date_cont]).blank?



    params[:q][:end_date_cont] = change_date_format(params[:q][:end_date_cont]) if !(params[:q][:end_date_cont]).blank?
   
    params[:q][:end_date_cont] = params[:q][:end_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:end_date_cont]).blank?


 params[:q][:schedule_date_gteq] = change_date_format(params[:q][:schedule_date_gteq]) if !(params[:q][:schedule_date_gteq]).blank?
  params[:q][:schedule_date_gteq] = params[:q][:schedule_date_gteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:schedule_date_gteq]).blank?


    params[:q][:schedule_date_lteq] = change_date_format(params[:q][:schedule_date_lteq]) if !(params[:q][:schedule_date_lteq]).blank?
    params[:q][:schedule_date_lteq] = params[:q][:schedule_date_lteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:schedule_date_lteq]).blank?
  
    params[:q][:status_date_cont] = change_date_format(params[:q][:status_date_cont]) if !(params[:q][:status_date_cont]).blank?
     params[:q][:status_date_cont] =  params[:q][:status_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_cont]).blank?


    params[:q][:status_date_gteq] = change_date_format(params[:q][:status_date_gteq]) if !(params[:q][:status_date_gteq]).blank?
    params[:q][:status_date_gteq] = params[:q][:status_date_gteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_gteq]).blank?



    params[:q][:status_date_lteq] = change_date_format(params[:q][:status_date_lteq]) if !(params[:q][:status_date_lteq]).blank?   
    params[:q][:status_date_lteq] = params[:q][:status_date_lteq].to_date.strftime("%d/%Y/%m")  if !(params[:q][:status_date_lteq]).blank?    

    if current_user.admin == true
    @q = current_user.organization.projects.search(params[:q])

      if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @cntcts = current_user.organization.contacts  
        @choosed = params[:mydata]  
       elsif !params[:mydata] 
         @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
         @cntcts = current_user.organization.contacts
	  @choosed = 50
       end 

    else
    contact = Contact.find_by_user_id(current_user)
      @q = contact.projects.search(params[:q])
       if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @cntcts = current_user.organization.contacts          
        @choosed = params[:mydata]  
       elsif !params[:mydata] 
         @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
         @cntcts = current_user.organization.contacts
         @choosed = 50
       end 
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end


def searche #for bulk search
 
	 if params[:up]
          @secret = "up"
        end
        if params[:down]
          @secret = "down"
        end   
@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
    #change dateformat when search
    params[:q][:schedule_date_cont] = change_date_format(params[:q][:schedule_date_cont]) if !(params[:q][:schedule_date_cont]).blank?
    params[:q][:schedule_date_cont] =  params[:q][:schedule_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:schedule_date_cont]).blank?
    

    params[:q][:start_date_cont] = change_date_format(params[:q][:start_date_cont]) if !(params[:q][:start_date_cont]).blank?
     params[:q][:start_date_cont] = params[:q][:start_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:start_date_cont]).blank?

  
    params[:q][:end_date_cont] = change_date_format(params[:q][:end_date_cont]) if !(params[:q][:end_date_cont]).blank?
    params[:q][:end_date_cont] = params[:q][:end_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:end_date_cont]).blank?


    params[:q][:schedule_date_gteq] = change_date_format(params[:q][:schedule_date_gteq]) if !(params[:q][:schedule_date_gteq]).blank?
    params[:q][:schedule_date_gteq] =  params[:q][:schedule_date_gteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:schedule_date_gteq]).blank?




    params[:q][:schedule_date_lteq] = change_date_format(params[:q][:schedule_date_lteq]) if !(params[:q][:schedule_date_lteq]).blank?
     params[:q][:schedule_date_lteq] =  params[:q][:schedule_date_lteq].to_date.strftime("%d/%Y/%m")  if !(params[:q][:schedule_date_lteq]).blank?


    params[:q][:status_date_cont] = change_date_format(params[:q][:status_date_cont]) if !(params[:q][:status_date_cont]).blank?
      params[:q][:status_date_cont] =  params[:q][:status_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_cont]).blank?

    params[:q][:status_date_gteq] = change_date_format(params[:q][:status_date_gteq]) if !(params[:q][:status_date_gteq]).blank?
     params[:q][:status_date_gteq] =   params[:q][:status_date_gteq].to_date.strftime("%d/%Y/%m")  if !(params[:q][:status_date_gteq]).blank?
   

    params[:q][:status_date_lteq] = change_date_format(params[:q][:status_date_lteq]) if !(params[:q][:status_date_lteq]).blank? 
     params[:q][:status_date_lteq] =  params[:q][:status_date_lteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_lteq]).blank?



    if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])

		
	
	if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @choosed = params[:mydata]  
       elsif !params[:mydata]
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50) 
	 @choosed = 50
       end
     

    else
    contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])

       if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @choosed = params[:mydata]  
       elsif !params[:mydata]
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50) 
        @choosed = 50
       end

    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end


####for menu 
def estimate_actual 
@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
   if params[:FILTER] == "ALL"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])
       #@projects = @q.result(:distinct  => true).find(:all)
           if params[:sel]
            @projects = @q.result(:distinct => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
           else
            @projects = @q.result(:distinct => true).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
           end    
        
       
       else
       contact = Contact.find_by_user_id(current_user)
       
         @q = contact.projects.search(params[:q])
      
           if params[:sel]
            @projects = @q.result(:distinct => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
           else
            @projects = @q.result(:distinct => true).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
           end    
        
       
       end
       @chosen = "ALL"



   elsif params[:FILTER] == "OPEN"
      if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])

           if params[:sel]
      @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
           else
      @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
           end    
                


      #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 0 })
     
      else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])

          
           if params[:sel]
       @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
           else
       @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
           end   

      
       end
      @chosen = "OPEN"


  elsif params[:FILTER] == "CLOSED"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])

        if params[:sel]
      @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]
        else
       @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
        end   


       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 })
       
       else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])

          if params[:sel]
       @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
         @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(50)
              @choosed = 50
          end   

  
       end
      @chosen = "CLOSED"
   #from admin home stats count 09/12/2012
   elsif params[:budget] == "over"
        @q = current_user.organization.projects.search(params[:q])
          
          if params[:sel]
        @projects = @q.result(:distinct => true).where(['variance < ?',0]).order('updated_at DESC').page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
         @projects = @q.result(:distinct => true).where(['variance < ?',0]).order('updated_at DESC').page(params[:page]).per(50)
              @choosed = 50
          end   




        #@projects = @q.result(:distinct  => true).find(:all, :conditions => ['variance < ?',0])

     
   elsif params[:FILTER].blank?
#      @q = current_user.organization.projects.search(params[:q])
#      @projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 })
    if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])

            
          if params[:sel]
        @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
        @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
              @choosed = 50
          end   


      #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 }, :order => 'updated_at DESC')
     
      @chosen = "CLOSED"
    else
      contact = Contact.find_by_user_id(current_user)
      if !contact.blank?
      @q = contact.projects.search(params[:q])
       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 }, :order => 'updated_at DESC')
         if params[:sel]
         @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
         @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
              @choosed = 50
          end  

       @chosen = "CLOSED"
      end
    end
    end

end
# for status mail functionality-----------------------------------------------------------------------------
  def delete_check
  #session[:prjct]=params[:project_id_array]
   mya= Array.new
   mycontacts=Array.new
   myemails = Array.new
  
  params[:project_check_all].split(",").map do |can_id|
                  if can_id == 'on' 
 		    next
	 	    end
    @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
      #mycontacts.push(@contact.email)
       mycontacts.push(@contact.contact)
       myemails.push(@contact.email)
    end
    #render :text => params[:project_format] and return 
 params[:project_list] =params[:project_check].split(",").map { |s| puts s.to_i }
		
               params[:project_check].split(",").map do |can_id|
	                if can_id == 'on' 
 				next
			     end   
                  
               @project = Project.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
           if params[:project_format]== "Format1"             
mya.push(@project.project_name,@project.title,@project.prq_number,@project.action_required,@project.status_details,@project.per_completed)                
elsif params[:project_format]== "Format2"
mya.push(@project.reference,@project.title,@project.project_name,@project.schedule_date,@project.amount,@project.actual,@project.per_completed,@project.action_required,@project.status_details,)  
 end
                  end
                
                @cntcts = current_user.organization.contacts
                #emails = @cntcts.collect(&:email).join(",")
		emails = mycontacts.join(", ")
                myemails1 = myemails.join(", ")
				
                @status_report= Statusreport.create
		@status_report.searched_projects=params[:project_id_array]
                @status_report.report_date = Date.today
                @status_report.report_time = Time.now
                @status_report.report_user = current_user.name
                @status_report.organization_id = current_user.organization_id
                @org_reports= current_user.organization.statusreports(:order=>'created_at ASC')
    		@org_last_report=@org_reports.find(:last)
    		if !@org_reports.blank? && !@org_last_report.blank?
    		y= @org_last_report.report_number.gsub!("SR-","")
    		puts "###"
    		m=y.to_i
    		m = m +1
    		x = ("SR-%0.4d" %m.to_i).to_s
    		puts x
    		@status_report.report_number = x
    		else 
    		m = 1
    		x = ("SR-%0.4d" %m.to_i).to_s
    		puts x
    		@status_report.report_number  = x
    		end
                @status_report.send_to = myemails1
                @status_from = current_user.name
               
                @status_report.subject = "#{@status_report.report_number} - Status Report #{@status_report.report_date.strftime('%b-%d-%Y')}"
    		 checked_projects = check_projects_using(params[:project_check])
                 params[:project_id_array][1..-2].split(",").map do |can_id|
	          @project = Project.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
                  @line_item = LineItem.create
                  @line_item.statusreport_id = @status_report.id
                  @line_item.project_id = @project.id
                  @line_item.project_type = @project.project_name
                  @line_item.notes = @project.notes
                   @line_item.title = @project.title
                   @line_item.prq_number = @project.prq_number
                   @line_item.action_required = @project.action_required
                  @line_item.priority = @project.priority
                  @line_item.status_details = @project.status_details
                  @line_item.per_completed = @project.per_completed
                  @line_item.amount = @project.amount
		  @line_item.schedule_date = @project.schedule_date
		  @line_item.entered_by = @project.entered_by
		  @line_item.variance = @project.variance
   		  @line_item.percent_variance = @project.percent_variance
		  @line_item.actual = @project.actual
		  @line_item.owner = @project.owner
		  @line_item.start_date = @project.start_date
		  @line_item.end_date = @project.end_date
		  @line_item.status_date = @project.status_date
		  @line_item.reference = @project.reference
		  @line_item.contact_id = @project.contact_id
  		  @line_item.organization_id = @project.organization_id
                 @line_item.save
                 end
                 #@status_report.format = params[:project_format]
                @status_report.save
                
            #StatusMailer.send_email(mya,@status_report.send_to,@status_report.report_number,@status_from).deliver
        
         #flash[:notice] = "The task status view mail has sent successfully...."
        flash[:notice] = "The status report  created successfully...."
  redirect_to "/status_view"
end
# end for status mail functionality ----------------------------------------------------------------------------------
 #*********for detailed view of description of task**********************
 def expand       
    if params[:FILTER] == "ALL"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])
       @projects = @q.result(:distinct  => true).find(:all,:conditions => ['schedule_date!="" AND notes!="" '], :order => 'updated_at DESC')
       else
       contact = Contact.find_by_user_id(current_user)
       
      @q = contact.projects.search(params[:q])
       @projects = @q.result(:distinct  => true).find(:all,:conditions => ['schedule_date!="" AND notes!=""'], :order => 'updated_at DESC')
       end
       @chosen = "ALL"
   elsif params[:FILTER] == "OPEN"
      if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])
      @projects = @q.result(:distinct  => true).find(:all, :conditions => ['active="0" AND schedule_date!="" AND notes!=""'], :order => 'updated_at DESC')
      else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])
       @projects = @q.result(:distinct  => true).find(:all, :conditions => ['active="0" AND schedule_date!="" AND notes!=""'], :order => 'updated_at DESC')
       end
      @chosen = "OPEN"
  elsif params[:FILTER] == "CLOSED"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])
       @projects = @q.result(:distinct  => true).find(:all, :conditions => ['active="1" AND schedule_date!="" AND notes!=""'], :order => 'updated_at DESC')
       else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])
       @projects = @q.result(:distinct  => true).find(:all, :conditions => ['active="1" AND schedule_date!="" AND notes!=""'], :order => 'updated_at DESC')
       end
      @chosen = "CLOSED"
   elsif params[:FILTER].blank?
    if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])
      @projects = @q.result(:distinct  => true).find(:all, :conditions => ['active="1" AND schedule_date!="" AND notes!=""'], :order => 'updated_at DESC')
      
      @chosen = "CLOSED"
    else
      contact = Contact.find_by_user_id(current_user)
      if !contact.blank?
      @q = contact.projects.search(params[:q])
       @projects = @q.result(:distinct  => true).find(:all, :conditions => ['active="1" AND schedule_date!="" AND notes!=""'], :order => 'updated_at DESC')
       @chosen = "CLOSED"
      end
    end
    end

  end
 
 def esearch
    #change dateformat when search
    params[:q][:schedule_date_cont] = change_date_format(params[:q][:schedule_date_cont]) if !(params[:q][:schedule_date_cont]).blank?
    
    if current_user.admin == true
    @q = current_user.organization.projects.search(params[:q])
    if params[:q]
      @projects = @q.result(:distinct  => true).find(:all,:conditions => ['schedule_date!="" AND notes!="" '], :order => 'updated_at DESC')
      
    end
    else
    contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])
      if params[:q]
      @projects = @q.result(:distinct  => true).find(:all,:conditions => ['schedule_date!="" AND notes!="" '], :order => 'updated_at DESC')
      
    end
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

def start_end
   if params[:FILTER] == "ALL"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])

         if params[:sel]
          @projects = @q.result(:distinct => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
          @projects = @q.result(:distinct => true).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end   

       #@projects = @q.result(:distinct  => true).find(:all)
       
       else
       contact = Contact.find_by_user_id(current_user)
       
        @q = contact.projects.search(params[:q])
          
         if params[:sel]
           @projects = @q.result(:distinct => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
            @projects = @q.result(:distinct => true).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end   



       #@projects = @q.result(:distinct  => true).find(:all)
       
       end
       @chosen = "ALL"





   elsif params[:FILTER] == "OPEN"
      if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])
      #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 0 })
         if params[:sel]
           @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
            @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end 
      

    
      else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])

         if params[:sel]
            @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
           @projects = @q.result(:distinct => true).where(:active => 0).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end 


       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 0 })
     
       end
      @chosen = "OPEN"



  elsif params[:FILTER] == "CLOSED"
       if current_user.admin == true
       @q = current_user.organization.projects.search(params[:q])

         if params[:sel]
             @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
           @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end 


       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 })
     
       else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])
            
         if params[:sel]
             @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
             @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end 




       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 })
     
       end
      @chosen = "CLOSED"

   elsif params[:FILTER].blank?
#      @q = current_user.organization.projects.search(params[:q])
#      @projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 })
    if current_user.admin == true
      @q = current_user.organization.projects.search(params[:q])

         if params[:sel]
              @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
             @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end 


      #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 }, :order => 'updated_at DESC')
    
      @chosen = "CLOSED"
    else
      contact = Contact.find_by_user_id(current_user)
      if !contact.blank?
      @q = contact.projects.search(params[:q])

         if params[:sel]
           @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(params[:sel])
          @choosed = params[:sel]
         else
            @projects = @q.result(:distinct => true).where(:active => 1).order('updated_at DESC').page(params[:page]).per(50)
          @choosed = 50      

         end 
       #@projects = @q.result(:distinct  => true).find(:all, :conditions => {:active => 1 }, :order => 'updated_at DESC')
     
       @chosen = "CLOSED"
      end
    end
    end

end
#end start_end_module

#for start_end_search
def start_end_search

       if params[:up]
          @secret = "up"
        end
        if params[:down]
          @secret = "down"
        end   

  @project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
    #change dateformat when search
    params[:q][:schedule_date_cont] = change_date_format(params[:q][:schedule_date_cont]) if !(params[:q][:schedule_date_cont]).blank?
     params[:q][:schedule_date_cont] = params[:q][:schedule_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:schedule_date_cont]).blank?
    

    params[:q][:start_date_cont] = change_date_format(params[:q][:start_date_cont]) if !(params[:q][:start_date_cont]).blank?
    params[:q][:start_date_cont] = params[:q][:start_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:start_date_cont]).blank?




    params[:q][:end_date_cont] = change_date_format(params[:q][:end_date_cont]) if !(params[:q][:end_date_cont]).blank?
    params[:q][:end_date_cont] =  params[:q][:end_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:end_date_cont]).blank?
  


    params[:q][:schedule_date_gteq] = change_date_format(params[:q][:schedule_date_gteq]) if !(params[:q][:schedule_date_gteq]).blank?
    params[:q][:schedule_date_gteq] =  params[:q][:schedule_date_gteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:schedule_date_gteq]).blank?

    params[:q][:schedule_date_lteq] = change_date_format(params[:q][:schedule_date_lteq]) if !(params[:q][:schedule_date_lteq]).blank?
    params[:q][:schedule_date_lteq] =  params[:q][:schedule_date_lteq].to_date.strftime("%d/%Y/%m")  if !(params[:q][:schedule_date_lteq]).blank?


    params[:q][:status_date_cont] = change_date_format(params[:q][:status_date_cont]) if !(params[:q][:status_date_cont]).blank?
      params[:q][:status_date_cont] =  params[:q][:status_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_cont]).blank?


    params[:q][:status_date_gteq] = change_date_format(params[:q][:status_date_gteq]) if !(params[:q][:status_date_gteq]).blank?
     params[:q][:status_date_gteq] =  params[:q][:status_date_gteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_gteq]).blank?


    params[:q][:status_date_lteq] = change_date_format(params[:q][:status_date_lteq]) if !(params[:q][:status_date_lteq]).blank?
    params[:q][:status_date_lteq] =  params[:q][:status_date_lteq].to_date.strftime("%d/%Y/%m") if !(params[:q][:status_date_lteq]).blank?
    
    if current_user.admin == true
    @q = current_user.organization.projects.search(params[:q])
  
       if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @choosed = params[:mydata]  
       elsif !params[:mydata] 
         @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
        @choosed = 50
       end 

    else
    contact = Contact.find_by_user_id(current_user)
       @q = contact.projects.search(params[:q])

       if !params[:mydata].blank? 
        @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:mydata])
        @choosed = params[:mydata]  
       elsif !params[:mydata] 
          @projects = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
	   @choosed = 50
       end 

    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
# for projects tasks auto import


def bulk_creation_new
    @project1 = Project.new
    @project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')
    flash[:notice] = "Create Bulk"
 end
 
  
 def bulk_creation_preview

   @project_preview = Array.new
     prjts_names=Array.new 
     prjts_names=params[:project][:notes].split /[\r\n]+/
     prjts_names.each do |name|  
      @org_projs= current_user.organization.projects(:order=>'created_at ASC').with_deleted
      @org_last_proj=@org_projs.find(:last)
      if !@org_projs.blank? && !@org_last_proj.blank?
      y= @org_last_proj.prq_number.gsub!("TASK-","")
      puts "###"
      m=y.to_i
      m = m +1
      x = ("TASK-%0.5d" %m.to_i).to_s
      puts x
      params[:project][:prq_number] = x
        format="/"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
      if !name.blank? && regex.match(name)
        name = name.split /[\/]+/  
        params[:project][:title] = name[0]    
      else
        #params[:project][:notes] = name
        #params[:project][:title] = name[0..50]
      end
        format="{}"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
      if !name[1].blank? && regex.match(name[1])
         owner_body = name[1].split /\{|}/ 
         params[:project][:owner] = owner_body[1] if !owner_body.nil?
         params[:project][:notes] = owner_body[0] if !owner_body.nil?
      else
        format="{}"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
            if name.kind_of?(Array)  
               params[:project][:notes] = name[1]
               params[:project][:title] = name[0]  
            else 
                if regex.match(name)
                   owner_body = name.split /\{|}/
                    params[:project][:owner] = owner_body[1] if !owner_body.nil?
                    params[:project][:notes] = owner_body[0] if !owner_body.nil?
                else 
                   params[:project][:notes] = name
                   params[:project][:title] = name[0..50]                  
                end          
               
            # else  
            #params[:project][:notes] = name[1]       
          end
      end
      #name=name[1].split /\{|}/
      #params[:project][:owner] = name[1]
      @project1 = Project.new(params[:project])
      @project1.organization = current_user.organization
      if !params[:project][:project_type_id].blank?
      ptname =current_user.organization.project_types.find(params[:project][:project_type_id]).type_name
      @project1.project_name = ptname
      end
      else 
      m = 1
      x = ("TASK-%0.5d" %m.to_i).to_s
      puts x
      params[:project][:prq_number] = x
      params[:project][:notes] = name
      params[:project][:title] = name[0..9]
      @project1 = Project.new(params[:project])
      @project1.organization = current_user.organization
      if !params[:project][:project_type_id].blank?
      ptname =current_user.organization.project_types.find(params[:project][:project_type_id]).type_name
      @project1.project_name = ptname
      end
      end
    


      #for changing the default date format
      @project1.schedule_date = change_date_format(params[:project][:schedule_date]) if !(params[:project][:schedule_date]).blank?
       @project_preview << @project1
  end
      render "bulk_creation_preview", :layout => false
      #render :text => "nothing" and return
      #redirect_to :action=> "index"
      
 end
 

 def bulk_creation
     @project_preview = Array.new
    
    #render :text => "hello" and return
     prjts_names=Array.new 
     prjts_names=params[:project][:notes].split /[\r\n]+/
     prjts_names.each do |name|  
      @org_projs= current_user.organization.projects(:order=>'created_at ASC').with_deleted
      @org_last_proj=@org_projs.find(:last)
      if !@org_projs.blank? && !@org_last_proj.blank?
      y= @org_last_proj.prq_number.gsub!("TASK-","")
      puts "###"
      m=y.to_i
      m = m +1
      x = ("TASK-%0.5d" %m.to_i).to_s
      puts x
      params[:project][:prq_number] = x
        format="/"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
      if !name.blank? && regex.match(name)
        name = name.split /[\/]+/  
        params[:project][:title] = name[0]    
      else
        #params[:project][:notes] = name
        #params[:project][:title] = name[0..50]
      end
        format="{}"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
      if !name[1].blank? && regex.match(name[1])
         owner_body = name[1].split /\{|}/ 
         params[:project][:owner] = owner_body[1] if !owner_body.nil?
         params[:project][:notes] = owner_body[0] if !owner_body.nil?
      else
        format="{}"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
            if name.kind_of?(Array)  
               params[:project][:notes] = name[1]
               params[:project][:title] = name[0]  
            else 
                if regex.match(name)
                   owner_body = name.split /\{|}/
                    params[:project][:owner] = owner_body[1] if !owner_body.nil?
                    params[:project][:notes] = owner_body[0] if !owner_body.nil?
                else 
                   params[:project][:notes] = name
                   params[:project][:title] = name[0..50]                  
                end          
               
            # else  
            #params[:project][:notes] = name[1]       
          end
      end
      #name=name[1].split /\{|}/
      #params[:project][:owner] = name[1]
      @project1 = Project.new(params[:project])
      @project1.organization = current_user.organization
      if !params[:project][:project_type_id].blank?
      ptname =current_user.organization.project_types.find(params[:project][:project_type_id]).type_name
      @project1.project_name = ptname
      end
      else 
      m = 1
      x = ("TASK-%0.5d" %m.to_i).to_s
      puts x
      params[:project][:prq_number] = x
      params[:project][:notes] = name
      params[:project][:title] = name[0..9]
      @project1 = Project.new(params[:project])
      @project1.organization = current_user.organization
      if !params[:project][:project_type_id].blank?
      ptname =current_user.organization.project_types.find(params[:project][:project_type_id]).type_name
      @project1.project_name = ptname
      end
      
      end
    #ptid = ProjectType.find_by_type_name(params[:project][:project_name]).id
    #@project1.project_type_id = ptid
      #for changing the default date format
      @project1.schedule_date = change_date_format(params[:project][:schedule_date]) if !(params[:project][:schedule_date]).blank?
       if @project1.save
       @project_preview << @project1 
       notification_mail(@project1)
       end
  end
      #render :text => "nothing" and return
       flash[:notice] = "Quick Creation Successful "
      #render "bulk_creation_preview"
 end

# end for project task auto import
#for pdf report 

def pdf_report

#render :text => params[:project_check] and return 
# params[:project_check].split(",").map do |can_id|
# if can_id == 'on' 
# next
# end   
# @project = Project.find(:first,:conditions => ["id LIKE ?",can_id.to_i] ) 
      
#end
#@contents = Array.new
#params[:project_check].split(",").map do |id|
#   @contents << id
# end 
#render :text => @contents and return 
   @project_report= ProjectReport.create
   @project_report.report_user = current_user.name
   @project_report.organization_id = current_user.organization_id
    @prj_reports= current_user.organization.project_reports(:order=>'created_at ASC')
    @prj_last_report=@prj_reports.find(:last)
    if !@prj_reports.blank? && !@prj_last_report.blank?
    y= @prj_last_report.pdf_number.gsub!("SPEC-","")
    m=y.to_i
    m = m +1
    x = ("SPEC-%0.4d" %m.to_i).to_s
    @project_report.pdf_number = x
    else 
    m = 1
    x = ("SPEC-%0.4d" %m.to_i).to_s
    @project_report.pdf_number = x
    end
   checked_projects = check_report_projects_using(params[:project_check])
   @project_report.save
   @rep_projects = Array.new
   params[:project_check].split(",").map do |id|
   @rep_projects << Project.find_by_id(id)
end
#    html = render_to_string(:layout => false , :action => "pdf_report")
#    kit = PDFKit.new(html)
##    kit.bounding_box([kit.bounds.right - 50, kit.bounds.bottom], :width => 60, :height => 20) do
##    pagecount = kit.page_count
##    kit.text "Page #{pagecount}"
##    end
#    #kit = PDFKit.new(your_html_content_for_pdf, :footer_html => "#{path_to_a_footer_html_file}"
##    file= kit.to_pdf
##    project_filr = File.new("#{Rails.root}/public/reports/pdf_report_#{@project_report.pdf_number}.pdf",'wb')
##    project_filr.write(file)
#    #kit.stylesheets << "#{Rails.root}/public/stylesheets/screen.css"
#    send_data(kit.to_pdf, :filename => "pdf_report_#{@project_report.pdf_number}.pdf", :type => 'application/pdf')
#    return # to avoid double render call
 pdf = ReportPdf.new(@rep_projects,@project_report, view_context)

 
        send_data pdf.render, filename: "pdf_report_#{@project_report.pdf_number}.pdf",
                              type: "application/pdf",
                              disposition: "inline"

      

end


# end for pdf report
def email_tasks

            myemails = Array.new
            params[:project_check_all].split(",").map do |can_id|
                  if can_id == 'on' 
 		              next
	 	               end
            @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
          
            myemails.push(@contact.email)
            end
          
          
           # render :text => ne.inspect and return
          @email_tasks = Array.new
            params[:mailed_projects].split(",").map  do |id|
             @email_tasks << Project.find(id)    
            end
          emails = myemails.join(",") if myemails.any?
           
            #render :text => @email_tasks and return

        StatusMailer.email_task_transactions(@email_tasks,emails,params[:msg]).deliver
        render :partial => "success", :layout => false
end 
#end of email tasks ************************
 def maillist
      @cntcts = current_user.organization.contacts
      @tsks = Array.new
      params[:ids].split(",").map do |id|
       @tsks << Project.find_by_id(id)
      end
      @tsk_array =  params[:ids]
    render :partial => "maillist", :layout => false
 end
# for mass change of the records in the tasks module 
def bulk_change 
#render :text => "Here is the code you haver to write for the bulk edit changes in the tasks module" and return 
redirect_to "/projects" , notice: "You have succesfully updated the bulk of records"
end 

 def bulklist
      @tsks = Array.new
      params[:ids].split(",").map do |id|
       @tsks << Project.find_by_id(id)
      end
    @tsk_array =  params[:ids]
   @bulk_projects = @tsks
   render :partial => "bulklist", :layout => false
 end
def update_individual
         params[:project][:bulk_projects].each_pair do |k,v|
	 	@new_pj = Project.find_by_id(k.to_i)
                #@change_views = ProjectChange.find(:last,:conditions => ["project_id LIKE ?",k.to_i])
                #render :text => @change_views.inspect and return
                #@cur_val = Hash.new
                #@cur_val = {"schedule_date"=>@change_views.schedule_date,"project_name" =>"#{@change_views.project_type}","priority" =>  "#{@change_views.priority}"}
                new_sch_date = bulk_change_date_form(v["schedule_date"]) if !(v["schedule_date"]).blank?
                @new_pj.update_attributes(:schedule_date => new_sch_date , :project_name => v["project_name"] ,:priority => v["priority"])
                #@new_val = Hash.new
                #@new_val = {"schedule_date"=>"#{@new_pj.schedule_date}","project_name" =>"#{@new_pj.project_name}","priority" => "#{@new_pj.priority}"}
                #if @change_views
                #if @cur_val != @new_val
                #@new_change_rec= ProjectChange.create
                #@new_change_rec = @change_views.dup
                #@new_change_rec.save!
                  #@new_change_rec.update_attributes()
                #end 
                #end 
                #render :text => "#{@cur_val.inspect} -- #{@new_val.inspect}" and return 
               
	 end
     #render :partial => "bulk_success", :layout => false
   redirect_to "/projects" , notice: "You have succesfully updated the bulk of task records"
end 

# end for mass change 


private #-------------------------
  
  def check_projects_using( project_id_array )
     @project_id_array =  project_id_array.split(",").map { |s| s.to_i }
    checked_projects = @project_id_array
    checked_params = checked_projects 
    for check_box_id in checked_params
      project = Project.find(check_box_id)
      
        @status_report.projects << project
      
    end
    return checked_projects
  end
#for reports 


  def check_report_projects_using( project_id_array )
     @project_id_array =  project_id_array.split(",").map { |s| s.to_i }
    checked_projects = @project_id_array
    checked_params = checked_projects 
    for check_box_id in checked_params
      project = Project.find(check_box_id)
      
        @project_report.projects << project
      
    end
    return checked_projects
  end

#end for reports
#end for reports
def notification_mail(project)
       @project = project 
        if !@project.project_type_id.blank?
        # for notification mails when task was created 
        @project_type = ProjectType.find_by_id(@project.project_type_id )
        emails = Array.new 
        contacts = @project_type.contacts
        contacts.each do |c|
           emails << c.email
        end 
        notification_contacts = emails.join(",") if emails.any?
         if !notification_contacts.blank?

            StatusMailer.notification_task_mail(notification_contacts,@project).deliver
           end 
        # end for notification emails 
     end 
end 


end
