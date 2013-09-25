class IssuesController < ApplicationController
   skip_before_filter :verify_authenticity_token
  
  def maillist
      @cntcts = current_user.organization.contacts
      @iss = Array.new
      params[:ids].split(",").map do |id|
       @iss << Issue.find_by_id(id)
      end
    @iss_array =  params[:ids]
    render :partial => "maillist", :layout => false
  end
  #Sending mails of issues report to the prescribed contacts
    def email_issues
     mya= Array.new
     mycontacts=Array.new
     myemails = Array.new
  
     params[:issue_check_all].split(",").map do |can_id|
                  if can_id == 'on' 
 		    next
	 	    end
     @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
      #mycontacts.push(@contact.email)
      
       myemails.push(@contact.email)
     end
    
     #render :text => params[:project_format] and return 
     params[:issue_list] =params[:mailed_issues].split(",").map { |s| puts s.to_i }
		
               params[:mailed_issues].split(",").map do |can_id|
	                if can_id == 'on' 
 				next
			     end   
                  
               mya << Issue.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
               end
               @issues = mya.flatten
               
      StatusMailer.issue_email(myemails,mya,params[:msg]).deliver
        render :partial => "success", :layout => false       
    
               
    end

    def index
     @cntcts = current_user.organization.contacts
     if params[:FILTER] == "ALL"
        if current_user.admin == true
        @q = current_user.organization.issues.search(params[:q])
          if params[:sel]
              @issues = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
              @issues = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(50)
              @choosed = 50
          end   
        #@issues = @q.result(:distinct  => true).find(:all)
      
        else
       contact = Contact.find_by_user_id(current_user)
        @q = contact.issues.search(params[:q])
       #@issues = @q.result(:distinct  => true).find(:all)
          if params[:sel]
              @issues = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
             @issues = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(50)
             @choosed = 50
          end  
       end
        @chosen = "ALL"



   elsif params[:FILTER] == "Inactive"
       if current_user.admin == true
       @q = current_user.organization.issues.search(params[:q])

          if params[:sel]
               @issues = @q.result(:distinct => true).where(:active => 0).order("updated_at DESC").page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
              @issues = @q.result(:distinct => true).where(:active => 0).order("updated_at DESC").page(params[:page]).per(50)
             @choosed = 50
          end  


       #@issues = @q.result(:distinct  => true).find(:all, :conditions => {:active => '0'})
       
        else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.issues.search(params[:q])
       #@issues = @q.result(:distinct  => true).find(:all, :conditions => {:active => '0'})

          if params[:sel]
              @issues = @q.result(:distinct => true).where(:active => 0).order("updated_at DESC").page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
             @issues = @q.result(:distinct => true).where(:active => 0).order("updated_at DESC").page(params[:page]).per(50)
             @choosed = 50
          end  

      
       end
       @chosen = "Inactive"
  elsif params[:FILTER] == "Active"
             if current_user.admin == true
             @q = current_user.organization.issues.search(params[:q])

          if params[:sel]
                @issues = @q.result(:distinct => true).where(:active => 1).order("updated_at DESC").page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
               @issues = @q.result(:distinct => true).where(:active => 1).order("updated_at DESC").page(params[:page]).per(50)
             @choosed = 50
          end 

             #@issues = @q.result(:distinct  => true).find(:all, :conditions => {:active => '1'})
      
            else
             contact = Contact.find_by_user_id(current_user)
             @q = contact.issues.search(params[:q])

             if params[:sel]
                 @issues = @q.result(:distinct => true).where(:active => 1).order("updated_at DESC").page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
              else
                @issues = @q.result(:distinct => true).where(:active => 1).order("updated_at DESC").page(params[:page]).per(50)
             @choosed = 50
               end 


           end
      @chosen = "Active"
 elsif params[:FILTER] == "over_budget_project_issues"
      @projects = current_user.organization.project_types.find(:all)
      @q = current_user.organization.issues.search(params[:q])
  # for over budget expenses 
   @over_projct_expense = []
    @projects.each do |k| 
    @budget = Payment.find(:all ,:conditions => {:project_type_id => k.id }).sum(&:pay_amount) 
     if @budget > k.expense_budget
      @over_projct_expense << k
     end
     end
 
      @bug = []
   if @over_projct_expense.count !=0
     @over_projct_expense.each do |j|
      #@bug <<  @q.result(:distinct  => true).find(:all, :conditions => {:project_type_id => j.id})
   @bug <<  @q.result(:distinct  => true).where(:project_type_id => j.id)
    end
   else
   #@bug = 0
   end 
 
  @issue = @bug.flatten 

    
             if params[:sel]
              @issues = Kaminari.paginate_array(@issue).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
              else
               @issues = Kaminari.paginate_array(@issue).page(params[:page]).per(50)
               @choosed = 50
             end 




 elsif params[:id]
      #@issues = current_user.organization.issues.find(:all, :conditions => ["project_id LIKE ? AND active=?",params[:id],1])     
@issues = current_user.organization.issues.where(["project_id LIKE ? AND active=?",params[:id],1]).page(params[:page]).per(50)  
elsif params[:projectid]    
      #@issues = current_user.organization.issues.find(:all, :conditions => ["project_type_id LIKE ? AND active=?",params[:projectid],1])	 
 @issues = current_user.organization.issues.where(["project_type_id LIKE ? AND active=?",params[:projectid],1]).page(params[:page]).per(50)
       # from home stats
    elsif params[:FILTER] == "pas_due_projects_issues"  
              @q = current_user.organization.issues.search(params[:q])
             @past_due_projects = current_user.organization.project_types.find(:all, :conditions => ['status =? AND end_date < ?','Pending',Date.today])
             
             @issues= []
             @past_due_projects.each do |e|
              puts e.id
             #@issues << @q.result(:distinct  => true).find(:all, :conditions => {:project_type_id => e.id })
             @issues << @q.result(:distinct  => true).where(:project_type_id => e.id)
             end
              @issue = @issues.flatten

              
              if params[:sel]
              @issues = Kaminari.paginate_array(@issue).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
              else
                @issues = Kaminari.paginate_array(@issue).page(params[:page]).per(50)
               @choosed = 50
              end 




             
     #endhome stats



elsif params[:FILTER].blank? && params[:id].blank?
    
    if current_user.admin == true
       @q = current_user.organization.issues.search(params[:q])
       #@issues = @q.result(:distinct  => true).find(:all, :conditions => {:active => '1'})

        if params[:sel]
                @issues = @q.result(:distinct => true).where(:active => 1).order("updated_at DESC").page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
              else
               @issues = @q.result(:distinct => true).where(:active => 1).order("updated_at DESC").page(params[:page]).per(50)
              @choosed = 50
        end 

     
    else
       contact = Contact.find_by_user_id(current_user)
       @q = contact.issues.search(params[:q])
       #@issues = @q.result(:distinct  => true).find(:all, :conditions => {:active => '1'})
         if para @issues = @q.result(:distinct => true).where(:active => 1).order("updated_at DESC").page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
              else
               @issues = @q.result(:distinct => true).where(:active => 1).order("updated_at DESC").page(params[:page]).per(50)
              @choosed = 50
        end 

   end
@chosen = "Active"
end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end
     






 
  def status
	@issues = current_user.organization.issues.find(:all, :order => "created_at")
  @issue = current_user.organization.issues.find(params[:id])	
   if @issue.active == true 
  flash[:notice] = "Issue is Inactivated successfully"
  @issue.active = 0
  elsif @issue.active == false
    flash[:notice] = "Issue is activated successfully"
     @issue.active = 1         
  end
  if @issue.update_attributes(params[:issue])      
      redirect_to :action => :index,:page => params[:page]
    else
      flash[:notice] = "Unable to Active/Deactive Issue" 
    end
 end 



  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = current_user.organization.issues.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = Issue.new
    if params[:project_id]
      @project_type = current_user.organization.project_types.find(params[:project_id])
      @issue.project_type_id = @project_type.id
    end 
    if current_user.admin == true
     @tasks = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @tasks = contact.projects.find(:all, :order => "title")
     else
     @tasks = []  #user doesnot have the contact type
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = current_user.organization.issues.find(params[:id])
    @issue.project = @issue.project
    if current_user.admin == true
     @tasks = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @tasks = contact.projects.find(:all, :order => "title")
     else
     @tasks = []  #user doesnot have the contact type
    end
  end
  
    def show_category  
    
     #render :text => params.inspect and return
      if !params[:id].blank?
      @tasks = current_user.organization.projects.find(:all, :conditions => ["project_type_id LIKE ?",params[:id]])
      end 
      render :partial=> 'show_category'   
    end

   def show_category_edit
   
      if !params[:i].blank?
      @issue = current_user.organization.issues.find(params[:i])
      @issue.project_id=@issue.project_id 
     end
      if !params[:id].blank?
      @tasks = current_user.organization.projects.find(:all, :conditions => ["project_type_id LIKE ?",params[:id]])
      end 
      puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$" 
      render :partial=> 'show_category'   
    end
  # POST /issues
  # POST /issues.json
   # POST /issues.json
  def create
    
    @org_issues = current_user.organization.issues(:order=>'created_at ASC')
    @org_last_issue = @org_issues.find(:last)
    if !@org_issues.blank? && !@org_last_issue.blank?
    y = @org_last_issue.issue_number.gsub!("ISSUE-","")
    puts "###"
    m=y.to_i
    m = m +1
    x = ("ISSUE-%0.5d" %m.to_i).to_s
    puts x
    params[:issue][:issue_number] = x
    @issue = Issue.new(params[:issue])
    @issue.organization = current_user.organization
    else 
    m = 1
    x = ("ISSUE-%0.5d" %m.to_i).to_s
    puts x
    params[:issue][:issue_number] = x
    @issue = Issue.new(params[:issue])
    @issue.organization = current_user.organization
    
    end
    #ptid = ProjectType.find(params[:project][:project_name]).id
    #@project.project_type_id = ptid
   
    #for changing the default date format

    @issue.date_created = change_date_format(params[:issue][:date_created]) if !(params[:issue][:date_created]).blank?

    respond_to do |format|
      if @issue.save
        notification_mail(@issue)
        format.html { redirect_to issues_url, notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end


 def bulkissues_new
    @issue = Issue.new
    if current_user.admin == true
     @tasks = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @tasks = contact.projects.find(:all, :order => "title")
     else
     @tasks = []  #user doesnot have the contact type
    end
 end 
 
 def bulkissues_preview
    #render :text => "stop" and return
    @issue_preview = Array.new
    #render :text => "hello" and return
     issue_names=Array.new 
     issue_names=params[:issue][:description].split /[\r\n]+/
     issue_names.each do |name|  
      @org_issues= current_user.organization.issues(:order=>'created_at ASC')
      @org_last_issue=@org_issues.find(:last)
      if !@org_issues.blank? && !@org_last_issue.blank?
      y= @org_last_issue.issue_number.gsub!("ISSUE-","")
      puts "###"
      m=y.to_i
      m = m +1
      x = ("ISSUE-%0.5d" %m.to_i).to_s
      puts x
      params[:issue][:issue_number] = x
        format="/"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
      if !name.blank? && regex.match(name)
        name = name.split /[\/]+/  
        params[:issue][:title] = name[0]    
      else
        #params[:project][:notes] = name
        #params[:project][:title] = name[0..50]
      end
        format="{}"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
      if !name[1].blank? && regex.match(name[1])
         owner_body = name[1].split /\{|}/ 
         params[:issue][:owner] = owner_body[1] if !owner_body.nil?
         params[:issue][:description] = owner_body[0] if !owner_body.nil?
      else
        format="{}"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
            if name.kind_of?(Array)  
               params[:issue][:description] = name[1]
               params[:issue][:title] = name[0]  
            else 
                if regex.match(name)
                   owner_body = name.split /\{|}/
                    params[:issue][:owner] = owner_body[1] if !owner_body.nil?
                    params[:issue][:description] = owner_body[0] if !owner_body.nil?
                else 
                   params[:issue][:description] = name
                   params[:issue][:title] = name[0..50]                  
                end          
                    
          end
      end
      @issue1 = Issue.new(params[:issue])
      @issue1.organization = current_user.organization

      else 
      m = 1
      x = ("ISSUE-%0.5d" %m.to_i).to_s
      puts x
      params[:issue][:issue_number] = x
      params[:issue][:description] = name
      params[:issue][:title] = name[0..9]
      @issue1 = Issue.new(params[:issue])
      @issue1.organization = current_user.organization
      
      end
       @issue1.date_created = change_date_format(params[:issue][:date_created]) if !(params[:issue][:date_created]).blank?
       @issue_preview << @issue1 
  end
      render "bulkissues_preview", :layout => false
 end
 
 def bulkissues_creation
    #render :text => "stop" and return
    @issue_preview = Array.new
    #render :text => "hello" and return
     issue_names=Array.new 
     issue_names=params[:issue][:description].split /[\r\n]+/
     issue_names.each do |name|  
      @org_issues= current_user.organization.issues(:order=>'created_at ASC')
      @org_last_issue=@org_issues.find(:last)
      if !@org_issues.blank? && !@org_last_issue.blank?
      y= @org_last_issue.issue_number.gsub!("ISSUE-","")
      puts "###"
      m=y.to_i
      m = m +1
      x = ("ISSUE-%0.5d" %m.to_i).to_s
      puts x
      params[:issue][:issue_number] = x
        format="/"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
      if !name.blank? && regex.match(name)
        name = name.split /[\/]+/  
        params[:issue][:title] = name[0]    
      else
        #params[:project][:notes] = name
        #params[:project][:title] = name[0..50]
      end
        format="{}"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
      if !name[1].blank? && regex.match(name[1])
         owner_body = name[1].split /\{|}/ 
         params[:issue][:owner] = owner_body[1] if !owner_body.nil?
         params[:issue][:description] = owner_body[0] if !owner_body.nil?
      else
        format="{}"
        regex = /[#{format.gsub(/./){|char| "\\#{char}"}}]/
            if name.kind_of?(Array)  
               params[:issue][:description] = name[1]
               params[:issue][:title] = name[0]  
            else 
                if regex.match(name)
                   owner_body = name.split /\{|}/
                    params[:issue][:owner] = owner_body[1] if !owner_body.nil?
                    params[:issue][:description] = owner_body[0] if !owner_body.nil?
                else 
                   params[:issue][:description] = name
                   params[:issue][:title] = name[0..50]                  
                end          
                    
          end
      end
      @issue1 = Issue.new(params[:issue])
      @issue1.organization = current_user.organization

      else 
      m = 1
      x = ("ISSUE-%0.5d" %m.to_i).to_s
      puts x
      params[:issue][:issue_number] = x
      params[:issue][:description] = name
      params[:issue][:title] = name[0..9]
      @issue1 = Issue.new(params[:issue])
      @issue1.organization = current_user.organization
      
      end
      
       @issue1.date_created = change_date_format(params[:issue][:date_created]) if !(params[:issue][:date_created]).blank?
       if @issue1.save
       @issue_preview << @issue1 
       notification_mail(@issue1)
       end
  end
      #render :text => "nothing" and return
       flash[:notice] = "Quick Creation Successful "
      #render "bulk_creation_preview"
 end    
















  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = current_user.organization.issues.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to issues_url, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = current_user.organization.issues.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end
  
  
 
  
  def search
    @cntcts = current_user.organization.contacts
    #render :text => "stop" and return
     params[:q][:date_created_cont] = change_date_format(params[:q][:date_created_cont]) if !(params[:q][:date_created_cont]).blank?
    params[:q][:date_created_cont] = params[:q][:date_created_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:date_created_cont]).blank?

   if current_user.admin == true
    @q = current_user.organization.issues.search(params[:q])
      if !params[:mydata].blank? 
       @issues = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(params[:mydata])
       @choosed = params[:mydata]  
       elsif !params[:mydata]
       @issues = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(2)
       @choosed = 2
       end

    else
    contact = Contact.find_by_user_id(current_user)
       @q = contact.issues.search(params[:q])
        if !params[:mydata].blank? 
         @issues = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(params[:mydata])
         @choosed = params[:mydata]  
        elsif !params[:mydata]
         @issues = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(50)
         @choosed = 50
       end
    end
   
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

private 

def notification_mail(issue)
       # for notification mails when issue was created 
        @issue = issue 
        @project_type = ProjectType.find_by_id(@issue.project_type_id )
        emails = Array.new 
        contacts = @project_type.contacts
        contacts.each do |c|
           emails << c.email
        end 
        notification_contacts = emails.join(",") if emails.any?
         if !notification_contacts.blank?

            StatusMailer.notification_issue_mail(notification_contacts,@issue).deliver
           end 
        # end for notification emails 

end   
  
  
  
end
