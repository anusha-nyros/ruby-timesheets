class StatusreportsController < ApplicationController
before_filter :authorize#, :check_account_type_project
skip_before_filter :verify_authenticity_token

  # GET /statusreports
  # GET /statusreports.json

  def maillist
      @report_id = params[:id]
      @project_format = params[:project_format]
      if params[:waiting_for] == 'sent'
      @q = current_user.organization.statusreports.search(params[:q])
      @statusreports = @q.result(:distinct  => true).find(:all,:conditions => ['sent_by IS ?',nil])
      else
      @q = current_user.organization.statusreports.search(params[:q])
      @statusreports = @q.result(:distinct  => true).find(:all,:order => 'updated_at DESC')
      end
     render :partial => "maillist", :layout => false
  end 
  def index
    
     #@statusreports = Statusreport.all
      if params[:waiting_for] == 'sent'
      @q = current_user.organization.statusreports.search(params[:q])
      @statusreports = @q.result(:distinct  => true).find(:all,:conditions => ['sent_by IS ?',nil])
      else
      @q = current_user.organization.statusreports.search(params[:q])
      @statusreports = @q.result(:distinct  => true).find(:all,:order => 'updated_at DESC')
      end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statusreports }
    end
  end

  # GET /statusreports/1
  # GET /statusreports/1.json
  def show
	@projects = Array.new
    @statusreport = current_user.organization.statusreports.find(params[:id])
   # @projects = @statusreport.projects(:order=>'priority ASC').with_deleted
    @project_id = @statusreport.projects(:order=>'priority').with_deleted

	@project_id.each do |id|
   @projects << LineItem.find_by_project_id_and_statusreport_id(id,@statusreport)

   @projects.sort! { |a,b| b.priority.to_s <=> a.priority.to_s }
	end
     respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statusreport }
    end
  end

    def show_maillist
  @project_format = params[:project_format]
	@projects = Array.new
    @statusreport = current_user.organization.statusreports.find(params[:id])
   # @projects = @statusreport.projects(:order=>'priority ASC').with_deleted
    @project_id = @statusreport.projects(:order=>'priority').with_deleted

	@project_id.each do |id|
   @projects << LineItem.find_by_project_id_and_statusreport_id(id,@statusreport)

   @projects.sort! { |a,b| b.priority.to_s <=> a.priority.to_s }
	end
     render :partial => 'show_maillist' ,:layout => false
  end


  # GET /statusreports/new
  # GET /statusreports/new.json
  def new
    @statusreport = Statusreport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statusreport }
    end
  end

  # GET /statusreports/1/edit
  def edit
    @statusreport = current_user.organization.statusreports.find(params[:id])
  end

  # POST /statusreports
  # POST /statusreports.json
  def create
    @org_reports= current_user.organization.statusreports(:order=>'created_at ASC')
    @org_last_report=@org_reports.find(:last)
    if !@org_reports.blank? && !@org_last_report.blank?
    y= @org_last_report.report_number.gsub!("SR-","")
    puts "###"
    m=y.to_i
    m = m +1
    x = ("SR-%0.4d" %m.to_i).to_s
    puts x
    params[:statusreport][:report_number] = x
    @statusreport = Statusreport.new(params[:statusreport])
    @statusreport.organization = current_user.organization
    else
    m = 1
    x = ("SR-%0.4d" %m.to_i).to_s
    puts x
    params[:statusreport][:report_number] = x
    @statusreport = Statusreport.new(params[:statusreport])
    @statusreport.organization = current_user.organization
    end
    #for changing the default date format
    @statusreport.report_date = change_date_format(params[:statusreport][:report_date]) if !(params[:statusreport][:report_date]).blank?
    respond_to do |format|
      if @statusreport.save
        format.html { redirect_to @statusreport, notice: 'Statusreport was successfully created.' }
        format.json { render json: @statusreport, status: :created, location: @statusreport }
      else
        format.html { render action: "new" }
        format.json { render json: @statusreport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statusreports/1
  # PUT /statusreports/1.json
  def update
     @statusreport = current_user.organization.statusreports.find(params[:id])
#for update time change date format params
    #params[:statusreport][:report_date] = change_date_format(params[:statusreport][:report_date]) if !(params[:statusreport][:report_date]).blank?


    respond_to do |format|
      if @statusreport.update_attributes(params[:statusreport])
        format.html { redirect_to @statusreport, notice: 'Statusreport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statusreport.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /statusreports/1
  # DELETE /statusreports/1.json
  def destroy
    @statusreport = current_user.organization.statusreports.find(params[:id])
    @statusreport.destroy
    respond_to do |format|
      format.html { redirect_to statusreports_url }
      format.json { head :no_content }
    end
  end


# for searching

  def search
    #change dateformat when search
    params[:q][:report_date_cont] = change_date_format(params[:q][:report_date_cont]) if !(params[:q][:report_date_cont]).blank?
     @q = current_user.organization.statusreports.search(params[:q])
    if params[:q]

      @statusreports = @q.result(:distinct  => true)#.find(:all,:order=>"updated_at DESC")

    end
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  def resend_mail
  @statusreport = current_user.organization.statusreports.find(params[:mailed_projects])
    #@projects = @statusreport.projects.with_deleted 
    @project_id = @statusreport.projects(:order=>'priority').with_deleted
    @statusreport.sent_by = current_user.name
    
    #@statusreport.report_date = Date.today
    #@statusreport.report_time = Time.now
    @statusreport.update_attribute("sent_by", @statusreport.sent_by)
    #@statusreport.update_attribute("report_date", @statusreport.report_date)
    #@statusreport.update_attribute("report_time", @statusreport.report_time)
    @statusreport.sent_date = DateTime.now
    @statusreport.update_attribute("sent_date", @statusreport.sent_date)
  mynewarr = Array.new
  mya = Array.new
  mya1 = Array.new
   @project_id.each do |id|
   mynewarr << LineItem.find_by_project_id_and_statusreport_id(id,@statusreport)
	end
  
   mynewarr.map do |can_id|
  @project = LineItem.find(:first,:conditions => ["id LIKE ?",can_id] )

             
mya.push(@project.project_type,@project.title,@project.prq_number,@project.action_required,@project.priority,@project.status_details,@project.per_completed)                

mya1.push(@project.reference,@project.title,@project.project_type,@project.status_date,@project.amount,@project.actual,@project.per_completed,@project.action_required,@project.status_details,)  

 end

#############for testting
@projects = Array.new
@project_id.each do |id|
   @projects << LineItem.find_by_project_id_and_statusreport_id(id,@statusreport)
    @projects.sort! { |a,b| b.priority.to_s <=> a.priority.to_s }
	end
##########################
#@custom_message = params[:custom_message]
if params[:project_format] == "Format1" 
  StatusMailer.send_email(@projects,@statusreport.send_to,@statusreport.report_number,current_user.name,@statusreport.custom_message,params[:msg]).deliver
 elsif params[:project_format] == "Format2"

 StatusMailer.send_email1(@projects,@statusreport.send_to,@statusreport.report_number,current_user.name,@statusreport.custom_message,params[:msg]).deliver
 end
   render :partial => "success" , :layout => false
  end

def new_lineitems
	@prev_projects = Array.new
        @statusrep = current_user.organization.statusreports.find(params[:id])
	@statusreport = current_user.organization.statusreports.find(params[:new_lineitems][:prev_projects])
    	@statusreport.projects.with_deleted.each{|proj|  @prev_projects.push(proj.id)}
		puts "================= #{@prev_projects.inspect} ===================="
	@projects = Array.new
	prjct=params[:new_lineitems][:searched_projects]
	projects=prjct[1..-2].split(',').collect! {|n| n.to_i}
	projects.each do |id|
	#@projects.push(Project.with_deleted.find(id))
        @projects.push(LineItem.find_by_project_id_and_statusreport_id(id,@statusrep))
	end
end
def update_lineitems
     @statusreport = current_user.organization.statusreports.find(params[:id])
	project_ids=params[:prev_projects][1..-2].split(',').collect! {|n| n.to_i} if !params[:prev_projects].blank?
	project_ids.each{|id| @statusreport.projects.delete(Project.with_deleted.find(id))}
#for update time change date format params
     #project_ids=@statusreport.projects
     
     #project_ids.each do |project_id|
	#p=Project.find(project_id.id)
	#@statusreport.projects.delete(p)
     #end
 #render :text => params[:project_list] and return
 params[:project_list].each{|id| Project.with_deleted.find(id).statusreports << Statusreport.find(@statusreport)} if !params[:project_list].blank?
       
	#render :text => "#{project_ids}"
  	redirect_to @statusreport, notice: 'Statusreport was successfully updated.'

  end

end
